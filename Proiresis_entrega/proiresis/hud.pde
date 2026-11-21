// HUD COMUN DE LAS PRUEBAS (plato de zanahorias, exposicion, notificacion, mensajes y tarjeta "en la vida real")

PFont fuenteTexto;              // fuente de la interfaz de las pruebas: Whimsical (se crea en setup)

int palitos = 5;                // cordura: palitos de zanahoria que quedan (se restablecen a 5 al empezar cada prueba)
float exposicion = 0;           // de 0 a 100: cuanto pueden ver los desconocidos de la vida del jugador

// un dato personal en juego por prueba (0 a 3 acto 1, 4 a 7 acto 2, 8 a 11 acto 3)
String[] datoEnJuego = {
  "Su cámara apunta a su cama",
  "Se duerme después de las 23:45",
  "Usa una pulsera con un triángulo",
  "Vive en la habitación 17",
  "Su contraseña",
  "Cambia por likes",
  "Su ubicación en tiempo real",
  "Publica lo que le piden",
  "Su lista de amigos",
  "Sus contactos",
  "Su dirección",
  "Acceso a su cuenta"
};
int cantidadDatos = 12;
boolean[] datoFiltrado = new boolean[12];   // true = la sombra ya sabe ese dato

float exposicionMostrada = 0;               // lo que muestra la barra: se acerca suave a la exposicion real
float ultimoCambioExposicion = 0;           // cuanto cambio la ultima vez (positivo = subio)
int inicioCambioExposicion = -10000;        // millis() del ultimo cambio (destello y numero flotante)
int palitoPerdido = 0;                      // cual palito se perdio (para la animacion)
int inicioPalitoPerdido = -10000;           // millis() en que se perdio

String mensajePrueba = "";                  // frase corta que sale abajo (acierto, error...)
int inicioMensajePrueba = -10000;           // millis() en que salio


// pierde un palito (nunca baja de 0)
void perderPalito() {
  if (palitos > 0) {
    palitoPerdido = palitos - 1;
    inicioPalitoPerdido = millis();
  }
  palitos = max(0, palitos - 1);
  sonidosCargadosSample[9].trigger();   // zumbido de error
}


// sube (o baja si es negativo) la exposicion entre 0 y 100
void subirExposicion(float cantidad) {
  float antes = exposicion;
  exposicion = constrain(exposicion + cantidad, 0, 100);
  if (exposicion != antes) {
    ultimoCambioExposicion = exposicion - antes;
    inicioCambioExposicion = millis();
  }
}


// sube la exposicion sin destello ni numero (el goteo lento mientras la sombra mira)
void gotearExposicion(float cantidad) {
  exposicion = constrain(exposicion + cantidad, 0, 100);
}


// la sombra se entera de un dato: queda filtrado y sube la exposicion
void filtrarDato(int numeroDato) {
  datoFiltrado[numeroDato] = true;
  subirExposicion(10);
}


// saca una frase corta abajo durante 2,5 s
void mostrarMensaje(String frase) {
  mensajePrueba = frase;
  inicioMensajePrueba = millis();
}


// barra de arriba: plato con los palitos de zanahoria a la izquierda y medidor de exposicion a la derecha
void dibujarBarraSuperior(color colorActo) {
  float e = width / 1920.0;

  noStroke();
  fill(0, 200);
  rect(0, 0, width, 90 * e);
  stroke(colorActo);
  strokeWeight(3);
  line(0, 90 * e, width, 90 * e);

  // el plato (imagen un poco aplastada para que quepa en la barra)
  noStroke();
  image(imagenesCargadas[75], 35 * e, 7 * e, 290 * e, 86 * e);

  // un palito de zanahoria por cada uno que queda (la imagen ya viene un poco inclinada; se gira un poco mas)
  for (int i = 0; i < palitos; i++) {
    float palitoX = (90 + i * 30) * e;
    float palitoY = (60 - (i % 2) * 8) * e;
    pushMatrix();
    translate(palitoX + 17 * e, palitoY - 12 * e);
    rotate(-0.35);
    image(imagenesCargadas[76], -32 * e, -13 * e, 64 * e, 26 * e);
    popMatrix();
  }

  // el palito que se perdio sale volando girando y suelta migas (0,8 s)
  int pasadoPalito = millis() - inicioPalitoPerdido;
  if (pasadoPalito < 800) {
    float avancePalito = pasadoPalito / 800.0;
    float salidaX = (107 + palitoPerdido * 30) * e;
    float salidaY = (48 - (palitoPerdido % 2) * 8) * e;

    pushMatrix();
    translate(salidaX + 120 * avancePalito * e, salidaY - 60 * avancePalito * e + 160 * avancePalito * avancePalito * e);
    rotate(avancePalito * 6 - 0.35);
    tint(255, 255 * (1 - avancePalito));
    image(imagenesCargadas[76], -32 * e, -13 * e, 64 * e, 26 * e);
    noTint();
    popMatrix();

    noStroke();
    for (int miga = 0; miga < 8; miga++) {
      float angulo = miga * TWO_PI / 8 + 0.4;
      float distancia = 70 * avancePalito;
      fill(255, 150, 40, 255 * (1 - avancePalito));
      ellipse(salidaX + cos(angulo) * distancia * e, salidaY + sin(angulo) * distancia * e + 60 * avancePalito * avancePalito * e, 6 * e, 6 * e);
    }
  }

  // MEDIDOR DE EXPOSICION: de celeste (0 %) a rojo (100 %); la barra se acerca suave al valor real
  exposicionMostrada = lerp(exposicionMostrada, exposicion, 0.08);

  // destello de 0,6 s al cambiar: rojo y temblando si subio, celeste si bajo
  int pasadoCambio = millis() - inicioCambioExposicion;
  float destello = max(0, 1 - pasadoCambio / 600.0);
  float temblorBarra = 0;
  color colorDestello = color(127, 212, 255);
  if (ultimoCambioExposicion > 0) {
    colorDestello = color(255, 70, 70);
    temblorBarra = random(-4, 4) * destello * e;
  }

  fill(255);
  noStroke();
  textFont(fuenteTexto);
  textAlign(LEFT, CENTER);
  textSize(24 * e);
  text("Exposición  " + round(exposicionMostrada) + " %", 1400 * e + temblorBarra, 30 * e);

  // brillo alrededor de la barra mientras dura el destello
  if (destello > 0) {
    fill(colorDestello, 140 * destello);
    rect(1392 * e + temblorBarra, 45 * e, 476 * e, 36 * e, 18 * e);
  }
  fill(255, 50);
  rect(1400 * e + temblorBarra, 52 * e, 460 * e, 22 * e, 11 * e);
  fill(lerpColor(color(127, 212, 255), color(224, 64, 64), exposicionMostrada / 100));
  rect(1400 * e + temblorBarra, 52 * e, 460 * e * exposicionMostrada / 100, 22 * e, 11 * e);

  // el cambio sale flotando desde la punta de la barra (1 s)
  if (pasadoCambio < 1000) {
    float avanceCambio = pasadoCambio / 1000.0;
    String textoCambio = round(ultimoCambioExposicion) + " %";
    if (ultimoCambioExposicion > 0) {
      textoCambio = "+" + textoCambio;
    }
    float puntaBarra = 1400 + 460 * exposicion / 100;
    fill(0, 180 * (1 - avanceCambio));
    textoConSigno(textoCambio, constrain(puntaBarra, 1450, 1820) + 2, 100 - 30 * avanceCambio + 3, 34);
    fill(colorDestello, 255 * (1 - avanceCambio));
    textoConSigno(textoCambio, constrain(puntaBarra, 1450, 1820), 100 - 30 * avanceCambio, 34);
  }
  strokeWeight(1);
}


// frase corta con fondo oscuro, abajo en el centro
void dibujarMensajePrueba() {
  float e = width / 1920.0;
  int pasado = millis() - inicioMensajePrueba;

  if (pasado < 2500) {

    float opacidadMensaje = 255;
    if (pasado > 1800) {
      opacidadMensaje = map(pasado, 1800, 2500, 255, 0);
    }

    textFont(fuenteTexto);
    textSize(30 * e);
    textAlign(CENTER, CENTER);

    float anchoMensaje = textWidth(mensajePrueba);

    noStroke();
    fill(0, opacidadMensaje * 0.7);
    rect(width/2 - anchoMensaje/2 - 24 * e, 985 * e, anchoMensaje + 48 * e, 56 * e, 14 * e);

    fill(255, opacidadMensaje);
    text(mensajePrueba, width/2, 1013 * e);
  }
}


// escribe un texto centrado en (x, y) (medidas de 1920) con el color de relleno actual;
// Whimsical no tiene + ni -, asi que si el texto empieza con uno, el signo se dibuja con rectangulos
// (el tamano de letra es siempre 64 y se agranda o achica con scale: cambiar textSize en cada cuadro es muy lento)
void textoConSigno(String texto, float x, float y, float tam) {
  float e = width / 1920.0;
  pushMatrix();
  translate(x * e, y * e);
  scale(tam / 64.0);
  textFont(fuente);
  textSize(64 * e);
  textAlign(LEFT, CENTER);
  tam = 64;
  x = 0;
  y = 0;

  String signo = "";
  String resto = texto;
  if (texto.length() > 0 && (texto.substring(0, 1).equals("+") || texto.substring(0, 1).equals("-"))) {
    signo = texto.substring(0, 1);
    resto = texto.substring(1);
  }

  float anchoSigno = 0;
  if (!signo.equals("")) {
    anchoSigno = tam * 0.45 * e;
  }
  float anchoTotal = anchoSigno + textWidth(resto);
  float inicioX = x * e - anchoTotal / 2;

  noStroke();
  if (!signo.equals("")) {
    float grosor = tam * 0.09 * e;
    float largo = tam * 0.34 * e;
    rect(inicioX, y * e - grosor / 2, largo, grosor, grosor / 2);
    if (signo.equals("+")) {
      rect(inicioX + largo / 2 - grosor / 2, y * e - largo / 2, grosor, largo, grosor / 2);
    }
  }
  text(resto, inicioX + anchoSigno, y * e - tam * 0.06 * e);
  popMatrix();
}
