// EFECTOS COMUNES DE LAS PRUEBAS: la sombra, la tension de los ultimos segundos, el goteo de exposicion,
// los textos flotantes, las monedas y el marcador de puntos (sirven para cualquier prueba)

// LA SOMBRA
int tipoReaccionSombra = 0;              // 1 = se esconde (acierto), 2 = se asoma de golpe (error)
int inicioReaccionSombra = -10000;       // millis() de la reaccion
boolean sonoSombraEntrada = false;       // la respiracion de la entrada ya sono (se reinicia en empezarTelon)

// MIRADA DE LA SOMBRA (opcional): una prueba le dice hacia donde mirar y que tan ansiosa esta
float sombraMiraX = -1;                  // punto que mira (medidas de 1920); -1 = no mira nada en especial
float sombraMiraY = 0;
float sombraAnsia = 0;                   // 0 a 1: con ansia se asoma de mas (por ejemplo, cuando la lupa caza)
float asomoMiraSombra = 0;               // lo que se asoma por mirar (suave)
float giroCabezaSombra = 0;              // inclinacion de la cabeza (suave)
float ojoSombraX = 0;                    // donde quedo el ojo (pixeles de pantalla), para unirlo con lo que mira
float ojoSombraY = 0;

// TENSION Y EXPOSICION
int ultimoLatido = -10000;               // millis() del ultimo latido de los ultimos 10 s
int ultimoGoteo = 0;                     // millis() de la ultima vez que la exposicion subio sola
boolean musicaBajada = false;            // true cuando la musica ya bajo para los ultimos 10 s

// TEXTOS FLOTANTES (+2, -2, racha...): texto, posicion, inicio y color; se reusan en circulo
String[] flotTexto = new String[12];
float[] flotX = new float[12];
float[] flotY = new float[12];
int[] flotInicio = new int[12];
color[] flotColor = new color[12];
int cantidadFlotantes = 12;
int siguienteFlotante = 0;

// MONEDAS que vuelan hasta el marcador
int[] monedaInicio = new int[10];
float[] monedaX = new float[10];
float[] monedaY = new float[10];
boolean[] monedaLlego = new boolean[10];
int cantidadMonedas = 10;
int siguienteMoneda = 0;
int llegadaMoneda = -10000;              // millis() de la ultima moneda que llego (el marcador late)

// TEXTO DE IMPACTO: palabra grande con contorno negro que salta, se queda y se va (para lo importante)
String textoImpacto = "";
float impactoX = 0;                      // centro (medidas de 1920)
float impactoY = 0;
float tamImpacto = 90;
color colorImpacto = color(255);
int inicioImpacto = -10000;

// RACHA junto al cursor (donde mira el jugador)
int rachaCursor = 0;
int inicioRachaCursor = -10000;
int ultimoCambioPuntos = -10000;         // millis() del ultimo cambio de puntos (el marcador late)


// TRAMA DE PUNTOS (estilo comic): puntos que crecen hacia los bordes de la pantalla, como en las imagenes del juego
// es una imagen blanca con fondo transparente; se arma una sola vez y se pinta del color que se quiera con tint
PImage tramaComic;


// arma la imagen de la trama (solo la primera vez que se pide)
void prepararTramaComic() {
  if (tramaComic == null) {
    int separacion = 14;
    tramaComic = createImage(width, height, ARGB);
    tramaComic.loadPixels();
    for (int fila = 0; fila < height; fila++) {
      for (int columna = 0; columna < width; columna++) {
        // que tan cerca del borde esta (0 en el centro, 1 en las esquinas)
        float haciaX = (columna - width / 2.0) / (width / 2.0);
        float haciaY = (fila - height / 2.0) / (height / 2.0);
        float borde = constrain(map(sqrt(haciaX * haciaX + haciaY * haciaY), 0.75, 1.35, 0, 1), 0, 1);
        // centro del punto de su casilla y su radio (mas grande cerca del borde)
        float centroX = (floor(columna / separacion) + 0.5) * separacion;
        float centroY = (floor(fila / separacion) + 0.5) * separacion;
        float radio = separacion * 0.48 * borde;
        if (borde > 0 && dist(columna, fila, centroX, centroY) < radio) {
          tramaComic.pixels[fila * width + columna] = color(255, 255);
        } else {
          tramaComic.pixels[fila * width + columna] = color(255, 0);
        }
      }
    }
    tramaComic.updatePixels();
  }
}


// pinta la trama encima de todo con el color y la opacidad que se pidan
void dibujarTramaComic(color colorTrama, float opacidad) {
  prepararTramaComic();
  tint(colorTrama, opacidad);
  image(tramaComic, 0, 0);
  noTint();
}


// al empezar una prueba: arranca la musica con fundido y reinicia la sombra, los latidos, los flotantes y las monedas
void empezarAmbientePrueba() {
  sonidosCargadosAmbiente[3].rewind();
  sonidosCargadosAmbiente[3].loop();
  sonidosCargadosAmbiente[3].shiftGain(-40, volumenAmbiente, 3000);
  musicaBajada = false;
  ultimoGoteo = millis();
  ultimoLatido = -10000;
  tipoReaccionSombra = 0;
  inicioReaccionSombra = -10000;
  llegadaMoneda = -10000;
  ultimoCambioPuntos = -10000;
  inicioImpacto = -10000;
  inicioRachaCursor = -10000;
  sombraMiraX = -1;
  sombraAnsia = 0;
  asomoMiraSombra = 0;
  giroCabezaSombra = 0;
  for (int f = 0; f < cantidadFlotantes; f++) {
    flotInicio[f] = -10000;
  }
  for (int m = 0; m < cantidadMonedas; m++) {
    monedaInicio[m] = -10000;
    monedaLlego[m] = true;
  }
}


// la sombra reacciona: 1 = se esconde (acierto), 2 = se asoma de golpe con un susurro (error)
void sombraReacciona(int tipo) {
  tipoReaccionSombra = tipo;
  inicioReaccionSombra = millis();
  if (tipo == 2) {
    sonidosCargadosSample[20].trigger();
  }
}


// tension de los ultimos 10 s: 0 antes, sube hasta 1 cuando se acaba el tiempo (no cuenta con el telon o la guia)
float calcularTension() {
  int restanteTension = duracionPrueba - (millis() - inicioPrueba);
  if (!guiaActiva && !telonActivo && restanteTension < 10000) {
    return constrain(1 - restanteTension / 10000.0, 0, 1);
  }
  return 0;
}


// la sombra detras del telon derecho, el telon recogido a los lados y la mano de la sombra encima de la tela
// entrada (desde que empezo a abrirse el telon): a 2,3 s se asoma, a 2,9 s agarra el telon y a 3,1 s abre el ojo
void dibujarSombraYTelon(float tension) {
  float e = width / 1920.0;

  int pasadoEntrada = millis() - inicioTelon;
  float entradaSombra = -230 * (1 - reboteTelon((pasadoEntrada - 2300) / 900.0));
  float entradaMano = constrain((pasadoEntrada - 2900) / 300.0, 0, 1);
  float aperturaOjo = constrain((pasadoEntrada - 3100) / 250.0, 0, 1);
  if (!sonoSombraEntrada && pasadoEntrada >= 2300) {
    sonidosCargadosSample[18].trigger();   // respiracion de la sombra al asomarse
    sonoSombraEntrada = true;
  }

  // reaccion: al acertar se esconde 70 px y vuelve despacio; al fallar se asoma 110 px de golpe (1,5 s)
  float reaccion = 0;
  float enojo = 0;   // 0 a 1: el ojo se pone rojo y grande al fallar
  int pasadoReaccion = millis() - inicioReaccionSombra;
  if (pasadoReaccion < 1500) {
    float vuelta = 1 - constrain((pasadoReaccion - 300) / 1200.0, 0, 1);   // se queda 0,3 s y regresa
    if (tipoReaccionSombra == 1) {
      reaccion = -70 * constrain(pasadoReaccion / 250.0, 0, 1) * vuelta;
    }
    if (tipoReaccionSombra == 2) {
      reaccion = 110 * reboteTelon(pasadoReaccion / 180.0) * vuelta;
      enojo = vuelta;
    }
  }

  // MIRADA: si una prueba le indica un punto, se asoma mas cuanto mas lejos esta (se estira para ver),
  // mas aun con ansia, e inclina la cabeza hacia arriba o abajo; todo suave
  float metaAsomoMira = 0;
  float metaGiroCabeza = 0;
  if (sombraMiraX >= 0) {
    metaAsomoMira = constrain(map(1722 - sombraMiraX, 300, 1400, 0, 40), 0, 40) + 35 * sombraAnsia;
    metaGiroCabeza = -constrain((sombraMiraY - 420) / 1000.0, -0.3, 0.3);
  }
  asomoMiraSombra = lerp(asomoMiraSombra, metaAsomoMira, 0.08);
  giroCabezaSombra = lerp(giroCabezaSombra, metaGiroCabeza, 0.08);

  // con mas exposicion se asoma mas; con tension se acerca y respira mas rapido
  float asomo = map(exposicion, 0, 100, 0, 90) + entradaSombra + reaccion + 70 * tension + asomoMiraSombra;
  float respiro = sin(millis() * (0.002 + 0.006 * tension)) * (6 + 6 * tension);
  float sombraX = 1722 - asomo;            // centro de la cabeza (medidas de 1920)
  float sombraY = 410 + respiro;

  // la sombra (imagen de 221 x 1000): el centro de la cabeza esta en (82, 100) de la imagen; se dibuja 11 px corrida a la izquierda para que el ojo quede en sombraX - 28
  // se inclina entera hacia lo que mira, girando desde la cintura
  pushMatrix();
  translate(sombraX * e, (sombraY + 500) * e);
  rotate(giroCabezaSombra * 0.3);
  translate(-sombraX * e, -(sombraY + 500) * e);
  image(imagenesCargadas[69], (sombraX - 93) * e, (sombraY - 100) * e, 221 * e, 1000 * e);

  // un ojo que brilla encima del ojo izquierdo de la imagen; cada 4 s parpadea; al fallar y al final se enrojece y crece
  float altoOjo = 1.5 + 7.5 * aperturaOjo;
  if (millis() % 4000 < 130) {
    altoOjo = 1.5;
  }
  float rojoOjo = max(enojo, tension * 0.7);
  noStroke();
  fill(255, 60, 60, (45 + 150 * rojoOjo) * aperturaOjo);
  ellipse((sombraX - 28) * e, (sombraY + 45) * e, (44 + 40 * rojoOjo) * e, (30 + 24 * rojoOjo) * e);
  fill(lerpColor(color(240, 225, 225), color(255, 40, 40), rojoOjo));
  ellipse((sombraX - 28) * e, (sombraY + 45) * e, (16 + 8 * rojoOjo) * e, altoOjo * (1 + 0.6 * rojoOjo) * e);

  // pupila que apunta hacia lo que mira (solo si mira algo y el ojo esta abierto)
  if (sombraMiraX >= 0 && altoOjo > 5) {
    float corrimientoPupila = constrain((sombraMiraY - sombraY) / 120.0, -3, 3);
    fill(60, 0, 5);
    ellipse((sombraX - 32) * e, (sombraY + 45 + corrimientoPupila) * e, 6 * e, 6 * e);
  }
  ojoSombraX = (sombraX - 30) * e;
  ojoSombraY = (sombraY + 45) * e;
  popMatrix();

  // LA MANO va con el cuerpo: se mueve cuando la sombra se asoma, salta, respira o se inclina
  // y como tiene agarrado el borde del telon, lo jala hacia la izquierda (si la sombra se esconde, la mano se queda en el borde)
  float manoX = min(1708, sombraX - 14 + 320 * sin(giroCabezaSombra * 0.3));
  float manoY = sombraY + 180;
  float jalon = (1708 - manoX) * entradaMano;   // mientras la mano aparece, todavia no jala
  jalonTelon = jalon * e;
  alturaJalonTelon = (manoY + 50) * e;          // el borde se dobla a la altura de los dedos

  // el telon recogido a los lados: es el mismo que se abrio al empezar
  dibujarCortinas(1, 1, 0);

  // la mano agarrando el borde del telon desde atras: solo se ven los cuatro dedos doblados sobre la tela
  // (de la imagen de 221 x 180 se usa la parte de los dedos, de x = 120 a 221; la palma queda escondida detras del borde)
  if (entradaMano > 0) {
    tint(255, 255 * entradaMano);
    image(imagenesCargadas[70], (1708 - jalon) * e, manoY * e, 56 * e, 99 * e, 120, 0, 221, 180);
    noTint();
  }
  strokeWeight(1);
}


// la sombra sigue mirando: mientras se juega, la exposicion sube 1 % cada 4 s
// (la exposicion es de TODO el juego: se acumula entre pruebas y cuenta en la evaluacion final)
void gotearExposicionPrueba() {
  if (guiaActiva || telonActivo) {
    ultimoGoteo = millis();
  }
  if (millis() - ultimoGoteo >= 4000) {
    gotearExposicion(1);
    ultimoGoteo = millis();
  }
}


// ULTIMOS 10 SEGUNDOS: la musica baja, latidos cada vez mas seguidos y bordes rojos que laten
void dibujarTension(float tension) {
  if (tension > 0) {
    float e = width / 1920.0;

    if (!musicaBajada) {
      sonidosCargadosAmbiente[3].shiftGain(volumenAmbiente, volumenAmbiente - 12, 1500);
      musicaBajada = true;
    }
    int intervaloLatido = int(lerp(900, 420, tension));
    if (millis() - ultimoLatido >= intervaloLatido) {
      sonidosCargadosSample[21].trigger();
      ultimoLatido = millis();
    }
    float pulsoLatido = max(0, 1 - (millis() - ultimoLatido) / 300.0);

    noFill();
    for (int borde = 0; borde < 12; borde++) {
      stroke(150, 0, 15, (110 * tension + 70 * pulsoLatido * tension) * (1 - borde / 12.0));
      strokeWeight(16 * e);
      rect(borde * 14 * e, borde * 14 * e, width - borde * 28 * e, height - borde * 28 * e);
    }
    noStroke();
    strokeWeight(1);
  }
}


// MARCADOR: pastilla oscura con borde dorado, una estrella y el numero; late cuando llega una moneda o cambian los puntos
void dibujarMarcador(int puntos) {
  float e = width / 1920.0;
  float latidoMoneda = max(0, 1 - (millis() - llegadaMoneda) / 250.0);
  float latidoCambio = max(0, 1 - (millis() - ultimoCambioPuntos) / 200.0);
  float latidoMarcador = 1 + 0.18 * max(latidoMoneda, latidoCambio);

  pushMatrix();
  translate(1735 * e, 137 * e);
  scale(latidoMarcador);

  // brillo detras cuando llega una moneda
  noStroke();
  fill(255, 210, 90, 120 * latidoMoneda);
  rect(-160 * e, -44 * e, 320 * e, 88 * e, 44 * e);

  fill(20, 10, 12, 235);
  stroke(255, 210, 90);
  strokeWeight(3 * e);
  rect(-145 * e, -32 * e, 290 * e, 64 * e, 32 * e);

  // la estrella (imagen de 94 x 110, dibujada a la mitad)
  noStroke();
  image(imagenesCargadas[78], -131 * e, -28 * e, 47 * e, 55 * e);

  fill(200);
  textFont(fuenteTexto);
  textAlign(LEFT, CENTER);
  textSize(24 * e);
  text("Puntos", -78 * e, -2 * e);
  fill(255, 210, 90);
  textAlign(RIGHT, CENTER);
  textSize(44 * e);
  text(puntos, 125 * e, -4 * e);
  popMatrix();
  strokeWeight(1);
}


// guarda un texto flotante (en medidas de 1920); si se llenan los 12 lugares, reemplaza el mas viejo
void agregarFlotante(String texto, float x, float y, color colorTexto) {
  flotTexto[siguienteFlotante] = texto;
  flotX[siguienteFlotante] = x;
  flotY[siguienteFlotante] = y;
  flotInicio[siguienteFlotante] = millis();
  flotColor[siguienteFlotante] = colorTexto;
  siguienteFlotante = (siguienteFlotante + 1) % cantidadFlotantes;
}


// los textos flotantes: aparecen creciendo con rebote, suben 90 px y se desvanecen (1,2 s), con sombra para que se lean
void dibujarFlotantes() {
  for (int f = 0; f < cantidadFlotantes; f++) {
    int pasadoFlotante = millis() - flotInicio[f];
    if (pasadoFlotante < 1200) {
      float avanceFlotante = pasadoFlotante / 1200.0;
      float crece = reboteTelon(pasadoFlotante / 300.0);
      float opacidadFlotante = 255 * (1 - avanceFlotante * avanceFlotante);
      float flotanteY = flotY[f] - 90 * avanceFlotante;
      fill(0, opacidadFlotante * 0.7);
      textoConSigno(flotTexto[f], flotX[f] + 3, flotanteY + 4, 64 * crece);
      fill(flotColor[f], opacidadFlotante);
      textoConSigno(flotTexto[f], flotX[f], flotanteY, 64 * crece);
    }
  }
}


// lanza una moneda desde (x, y) hacia el marcador (medidas de 1920)
void agregarMoneda(float x, float y) {
  monedaInicio[siguienteMoneda] = millis();
  monedaX[siguienteMoneda] = x;
  monedaY[siguienteMoneda] = y;
  monedaLlego[siguienteMoneda] = false;
  siguienteMoneda = (siguienteMoneda + 1) % cantidadMonedas;
}


// monedas: estallido de chispas al salir, vuelo en arco girando y llegada al marcador (0,15 s de espera + 0,7 s de vuelo)
void dibujarMonedas() {
  float e = width / 1920.0;

  for (int m = 0; m < cantidadMonedas; m++) {
    int pasadoMoneda = millis() - monedaInicio[m];

    // chispas que salen del lugar del acierto (0,4 s)
    if (pasadoMoneda >= 0 && pasadoMoneda < 400) {
      float avanceChispa = pasadoMoneda / 400.0;
      noStroke();
      fill(255, 230, 140, 255 * (1 - avanceChispa));
      for (int chispa = 0; chispa < 10; chispa++) {
        float anguloChispa = chispa * TWO_PI / 10;
        float distanciaChispa = 20 + 70 * avanceChispa;
        float chispaX = (monedaX[m] + cos(anguloChispa) * distanciaChispa) * e;
        float chispaY = (monedaY[m] + sin(anguloChispa) * distanciaChispa) * e;
        float tamChispa = 9 * (1 - avanceChispa) * e;
        quad(chispaX, chispaY - tamChispa, chispaX + tamChispa * 0.5, chispaY, chispaX, chispaY + tamChispa, chispaX - tamChispa * 0.5, chispaY);
      }
    }

    // vuelo: curva que sube y baja hasta el marcador
    float avanceMoneda = (pasadoMoneda - 150) / 700.0;
    if (avanceMoneda > 0 && avanceMoneda < 1) {
      float suaveMoneda = avanceMoneda * avanceMoneda * (3 - 2 * avanceMoneda);
      float destinoX = 1627;
      float destinoY = 137;
      float controlX = (monedaX[m] + destinoX) / 2;
      float controlY = min(monedaY[m], destinoY) - 260;
      float vueloX = sq(1 - suaveMoneda) * monedaX[m] + 2 * (1 - suaveMoneda) * suaveMoneda * controlX + sq(suaveMoneda) * destinoX;
      float vueloY = sq(1 - suaveMoneda) * monedaY[m] + 2 * (1 - suaveMoneda) * suaveMoneda * controlY + sq(suaveMoneda) * destinoY;

      // la moneda gira: se angosta y se ensancha
      float tamMoneda = 40 * (1 - 0.3 * suaveMoneda) * e;
      float giroMoneda = 0.25 + 0.75 * (0.5 + 0.5 * cos(millis() * 0.025 + m));

      noStroke();
      fill(255, 230, 140, 90);
      ellipse(vueloX * e, vueloY * e, tamMoneda * 1.6, tamMoneda * 1.6);
      image(imagenesCargadas[77], vueloX * e - tamMoneda * giroMoneda / 2, vueloY * e - tamMoneda / 2, tamMoneda * giroMoneda, tamMoneda);
    }

    // llego: el marcador late y suena
    if (avanceMoneda >= 1 && !monedaLlego[m]) {
      monedaLlego[m] = true;
      llegadaMoneda = millis();
      sonidosCargadosSample[17].trigger();
    }
  }
}


// lanza un texto de impacto (x, y en medidas de 1920; tam = tamano de letra)
void agregarImpacto(String texto, float x, float y, float tam, color colorTexto) {
  textoImpacto = texto;
  impactoX = x;
  impactoY = y;
  tamImpacto = tam;
  colorImpacto = colorTexto;
  inicioImpacto = millis();
}


// el texto de impacto: salta creciendo con rebote (0,25 s), se queda temblando y se desvanece (1,2 s en total)
void dibujarImpacto() {
  int pasado = millis() - inicioImpacto;
  if (pasado < 1200) {
    float e = width / 1920.0;
    float crece = reboteTelon(pasado / 250.0);
    float opacidad = 255 * (1 - constrain((pasado - 900) / 300.0, 0, 1));
    float tamLetra = tamImpacto * e;   // fijo; el salto se hace con scale (mas rapido)
    float x = impactoX * e;
    float y = (impactoY - 25 * pasado / 1200.0) * e;

    pushMatrix();
    translate(x, y);
    rotate(-0.06 + sin(millis() * 0.03) * 0.015);
    scale(0.4 + 0.6 * crece);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(tamLetra);

    // contorno negro grueso: el texto se dibuja corrido en 8 direcciones
    fill(0, opacidad);
    float grosor = tamLetra * 0.06;
    for (int k = 0; k < 8; k++) {
      text(textoImpacto, cos(k * PI / 4) * grosor, sin(k * PI / 4) * grosor);
    }
    fill(colorImpacto, opacidad);
    text(textoImpacto, 0, 0);
    popMatrix();
  }
}


// muestra la racha junto al cursor durante 1,3 s
void mostrarRachaCursor(int racha) {
  rachaCursor = racha;
  inicioRachaCursor = millis();
}


// pastilla con la racha al lado del mouse: salta al subir y se desvanece
void dibujarRachaCursor() {
  int pasado = millis() - inicioRachaCursor;
  if (pasado < 1300 && rachaCursor >= 2) {
    float e = width / 1920.0;
    float crece = reboteTelon(pasado / 220.0);
    float opacidad = 255 * (1 - constrain((pasado - 1000) / 300.0, 0, 1));

    pushMatrix();
    translate(mouseX + 70 * e, mouseY + 45 * e);
    scale(0.5 + 0.5 * crece);
    noStroke();
    fill(0, 200 * opacidad / 255);
    rect(-85 * e, -30 * e, 170 * e, 60 * e, 30 * e);
    stroke(127, 212, 255, opacidad);
    strokeWeight(3 * e);
    noFill();
    rect(-85 * e, -30 * e, 170 * e, 60 * e, 30 * e);
    noStroke();
    fill(127, 212, 255, opacidad);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(36 * e);
    text("Racha " + rachaCursor, 0, -3 * e);
    popMatrix();
    strokeWeight(1);
  }
}
