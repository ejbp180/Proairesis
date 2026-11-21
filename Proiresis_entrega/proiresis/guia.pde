// GUIA EN PANTALLA: oscurece todo menos una zona, la senala con un marco y la explica con un texto que se va escribiendo
// sirve para cualquier prueba: se llama a empezarGuia() con sus pasos; ENTER o clic pasan al siguiente

boolean guiaActiva = false;      // true mientras se esta explicando (el juego espera)
int pasoGuia = 0;                // paso que se esta explicando
int inicioPasoGuia = 0;          // millis() en que empezo el paso
int letrasSonadasGuia = 0;       // letras que ya sonaron con la maquina de escribir

String[] titulosGuia;            // titulo de cada paso
String[] textosGuia;             // explicacion de cada paso
float[][] zonasGuia;             // zona que se senala en cada paso: x, y, ancho, alto (medidas de 1920; ancho 0 = sin zona)
int cantidadPasosGuia = 0;

// PASOS GENERALES: se explican una sola vez en todo el juego; en las otras pruebas la guia los salta
// (se reconocen por el titulo del paso)
String[] titulosGenerales = {"Tu cordura", "El tiempo", "Exposición", "Tus puntos"};
boolean[] generalExplicado = new boolean[4];   // true = ese paso general ya se explico en alguna prueba
int cantidadGenerales = 4;

// zona que se ve ahora: se desliza suave hacia la del paso (medidas de 1920)
float guiaX = 960;
float guiaY = 540;
float guiaAncho = 0;
float guiaAlto = 0;


// empieza la guia: el hueco nace cerrado en el centro y se abre hacia la primera zona
// los pasos generales que ya se explicaron antes se saltan; los nuevos se explican y quedan marcados
void empezarGuia(String[] titulos, String[] textos, float[][] zonas, int cantidad) {
  titulosGuia = new String[cantidad];
  textosGuia = new String[cantidad];
  zonasGuia = new float[cantidad][];
  cantidadPasosGuia = 0;

  for (int paso = 0; paso < cantidad; paso++) {
    boolean saltar = false;
    for (int g = 0; g < cantidadGenerales; g++) {
      if (titulos[paso].equals(titulosGenerales[g])) {
        if (generalExplicado[g]) {
          saltar = true;
        } else {
          generalExplicado[g] = true;
        }
      }
    }
    if (!saltar) {
      titulosGuia[cantidadPasosGuia] = titulos[paso];
      textosGuia[cantidadPasosGuia] = textos[paso];
      zonasGuia[cantidadPasosGuia] = zonas[paso];
      cantidadPasosGuia++;
    }
  }
  pasoGuia = 0;
  inicioPasoGuia = millis();
  letrasSonadasGuia = 0;
  guiaX = 960;
  guiaY = 540;
  guiaAncho = 0;
  guiaAlto = 0;
  guiaActiva = true;
}


// se dibuja encima de todo (al final de draw)
void dibujarGuia() {
  // mientras el telon se abre la guia espera (su texto empieza a escribirse despues)
  if (guiaActiva && telonActivo) {
    inicioPasoGuia = millis();
  }

  if (guiaActiva && !telonActivo) {

    float e = width / 1920.0;
    inicioPrueba = millis();   // el reloj de la prueba no corre mientras se explica

    float[] zona = zonasGuia[pasoGuia];

    // el hueco se desliza hacia la zona del paso
    guiaX = lerp(guiaX, zona[0], 0.15);
    guiaY = lerp(guiaY, zona[1], 0.15);
    guiaAncho = lerp(guiaAncho, zona[2], 0.15);
    guiaAlto = lerp(guiaAlto, zona[3], 0.15);

    float huecoX = guiaX * e;
    float huecoY = guiaY * e;
    float huecoAncho = guiaAncho * e;
    float huecoAlto = guiaAlto * e;

    // oscuro alrededor del hueco: cuatro rectangulos (arriba, abajo, izquierda, derecha)
    noStroke();
    fill(0, 190);
    rect(0, 0, width, huecoY);
    rect(0, huecoY + huecoAlto, width, height - huecoY - huecoAlto);
    rect(0, huecoY, huecoX, huecoAlto);
    rect(huecoX + huecoAncho, huecoY, width - huecoX - huecoAncho, huecoAlto);

    // marco amarillo que late alrededor de la zona
    if (zona[2] > 0) {
      float latido = sin(millis() * 0.006);
      noFill();
      stroke(255, 200, 0, 90);
      strokeWeight((10 + 4 * latido) * e);
      rect(huecoX, huecoY, huecoAncho, huecoAlto, 14 * e);
      stroke(255, 200, 0);
      strokeWeight(3 * e);
      rect(huecoX, huecoY, huecoAncho, huecoAlto, 14 * e);
    }

    // RECUADRO DEL TEXTO: debajo de la zona si cabe; si no, encima; si tampoco, al costado (derecha o izquierda);
    // sin zona, en el centro
    float cajaAncho = 600;
    // el recuadro crece con el largo del texto (Whimsical es ancha: unos 35 caracteres por linea)
    int largoTextoGuia = textosGuia[pasoGuia].length();
    float cajaAlto = 230;
    if (largoTextoGuia > 125) {
      cajaAlto = 290;
    }
    if (largoTextoGuia > 185) {
      cajaAlto = 350;
    }
    float cajaX = 960 - cajaAncho / 2;
    float cajaY = 540 - cajaAlto / 2;
    int ladoCaja = 0;   // donde quedo el recuadro respecto a la zona: 0 abajo, 1 arriba, 2 derecha, 3 izquierda

    if (zona[2] > 0) {
      cajaX = constrain(zona[0] + zona[2] / 2 - cajaAncho / 2, 40, 1880 - cajaAncho);
      if (zona[1] + zona[3] + 40 + cajaAlto < 1060) {
        cajaY = zona[1] + zona[3] + 40;
      } else {
        if (zona[1] - 40 - cajaAlto > 100) {
          cajaY = zona[1] - 40 - cajaAlto;
          ladoCaja = 1;
        } else {
          // no cabe ni abajo ni arriba: al costado, a la altura del centro de la zona
          cajaY = constrain(zona[1] + zona[3] / 2 - cajaAlto / 2, 110, 1060 - cajaAlto);
          if (zona[0] + zona[2] + 40 + cajaAncho < 1880) {
            cajaX = zona[0] + zona[2] + 40;
            ladoCaja = 2;
          } else {
            cajaX = max(40, zona[0] - 40 - cajaAncho);
            ladoCaja = 3;
          }
        }
      }
    }

    // entrada del recuadro: aparece subiendo y aclarandose (0,35 s)
    float entrada = constrain((millis() - inicioPasoGuia) / 350.0, 0, 1);
    entrada = entrada * entrada * (3 - 2 * entrada);
    cajaY = cajaY + 20 * (1 - entrada);

    // flecha del recuadro apuntando a la zona
    if (zona[2] > 0) {
      float puntaX = constrain(zona[0] + zona[2] / 2, cajaX + 40, cajaX + cajaAncho - 40);
      float puntaY = cajaY + cajaAlto / 2;
      noStroke();
      fill(255, 200, 0, 255 * entrada);
      if (ladoCaja == 0) {
        triangle((puntaX - 16) * e, cajaY * e, (puntaX + 16) * e, cajaY * e, puntaX * e, (cajaY - 20) * e);
      }
      if (ladoCaja == 1) {
        triangle((puntaX - 16) * e, (cajaY + cajaAlto) * e, (puntaX + 16) * e, (cajaY + cajaAlto) * e, puntaX * e, (cajaY + cajaAlto + 20) * e);
      }
      if (ladoCaja == 2) {
        triangle(cajaX * e, (puntaY - 16) * e, cajaX * e, (puntaY + 16) * e, (cajaX - 20) * e, puntaY * e);
      }
      if (ladoCaja == 3) {
        triangle((cajaX + cajaAncho) * e, (puntaY - 16) * e, (cajaX + cajaAncho) * e, (puntaY + 16) * e, (cajaX + cajaAncho + 20) * e, puntaY * e);
      }
    }

    fill(25, 12, 18, 240 * entrada);
    stroke(255, 200, 0, 255 * entrada);
    strokeWeight(3 * e);
    rect(cajaX * e, cajaY * e, cajaAncho * e, cajaAlto * e, 18 * e);

    // titulo del paso
    noStroke();
    textFont(fuenteTexto);
    textAlign(LEFT, CENTER);
    fill(255, 200, 0, 255 * entrada);
    textSize(30 * e);
    text(titulosGuia[pasoGuia], (cajaX + 28) * e, (cajaY + 38) * e);

    // texto que se va escribiendo, letra por letra, con el sonido de la maquina de escribir
    String textoPaso = textosGuia[pasoGuia];
    int letras = constrain((millis() - inicioPasoGuia - 250) / 22, 0, textoPaso.length());
    if (letras - letrasSonadasGuia >= 2) {
      sonidosCargadosSample[4].trigger();
      letrasSonadasGuia = letras;
    }

    fill(255, 255 * entrada);
    textAlign(LEFT, TOP);
    textSize(24 * e);
    text(textoPaso.substring(0, letras), (cajaX + 28) * e, (cajaY + 64) * e, (cajaAncho - 56) * e, (cajaAlto - 110) * e);

    // puntos de avance: uno por paso, el actual en amarillo
    for (int i = 0; i < cantidadPasosGuia; i++) {
      if (i == pasoGuia) {
        fill(255, 200, 0, 255 * entrada);
      } else {
        fill(255, 70 * entrada);
      }
      ellipse((cajaX + 36 + i * 20) * e, (cajaY + cajaAlto - 28) * e, 10 * e, 10 * e);
    }

    // aviso para seguir, parpadeando, solo cuando el texto ya termino de escribirse
    if (letras >= textoPaso.length()) {
      fill(255, 200, 0, (170 + 85 * sin(millis() * 0.008)) * entrada);
      textAlign(RIGHT, CENTER);
      textSize(22 * e);
      text("ENTER para seguir", (cajaX + cajaAncho - 28) * e, (cajaY + cajaAlto - 28) * e);
    }

    strokeWeight(1);
  }
}


// ENTER o clic: si el texto aun se escribe, lo completa; si ya termino, pasa al siguiente paso
void avanzarGuia() {
  int letras = (millis() - inicioPasoGuia - 250) / 22;

  if (letras < textosGuia[pasoGuia].length()) {
    inicioPasoGuia = millis() - 250 - textosGuia[pasoGuia].length() * 22 - 400;   // completa el texto (y la entrada del recuadro)
    letrasSonadasGuia = textosGuia[pasoGuia].length();
  } else {
    pasoGuia++;
    if (pasoGuia >= cantidadPasosGuia) {
      guiaActiva = false;
      pasoGuia = 0;
    } else {
      inicioPasoGuia = millis();
      letrasSonadasGuia = 0;
    }
  }
}
