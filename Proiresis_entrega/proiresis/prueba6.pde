// PRUEBA 6 - ACTO II - PRUEBA 2: TERMINOS TRAMPOSOS (pantallas 30 juego, 31 perdida, 32 superada)
// para instalar Aporia 2.0 hay que aceptar unos terminos que vienen con casi todo activado:
// desactiva lo que te expone y deja activado lo que no, mientras las trampas de la app (patrones oscuros)
// tratan de que aceptes todo: manos que reactivan opciones, un boton "Acepto" que te persigue y una ventana de presion

// LAS 12 OPCIONES
String[] letraP6 = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"};
String[] opcionP6 = {
  "Permitir que otros compartan tus publicaciones",
  "Permitir etiquetas",
  "Permitir que desconocidos te encuentren",
  "Permitir recomendaciones de perfil",
  "Mostrar públicamente tus publicaciones anteriores",
  "Guardar automáticamente tus borradores",
  "Permitir respuestas de cualquier persona",
  "Sincronizar tus fotografías privadas",
  "No ocultar cuándo estás conectado",
  "Permitir que otros vean tu ubicación",
  "Ajustar el brillo de la pantalla solo",
  "Ocultar publicaciones antiguas"
};
// lo que de verdad hace cada una (se ve al pasar el mouse)
String[] letraChicaP6 = {
  "Cualquiera puede reenviar lo que subes, aunque tu cuenta sea privada.",
  "Otras personas pueden etiquetarte en sus fotos sin pedirte permiso.",
  "Tu perfil aparece cuando un desconocido busca tu nombre o tu número.",
  "Aporía le muestra tu perfil a gente que no conoces.",
  "Todo lo que subiste desde que abriste tu cuenta se vuelve público.",
  "Tus borradores se guardan solo para ti. Nadie más los ve.",
  "Cualquier desconocido puede escribirte y comentar lo que subes.",
  "Las fotos de tu galería se suben a los servidores de Aporía.",
  "Doble negación: si no lo ocultas, todos ven cuándo te conectas y cuándo te vas.",
  "Tus amigos y los amigos de tus amigos ven dónde estás en tiempo real.",
  "Ajusta la luz de la pantalla según el lugar. No comparte nada.",
  "Lo que subiste hace mucho deja de verse en tu perfil."
};
boolean[] exponeP6 = {true, true, true, true, true, false, true, true, true, true, false, false};
boolean[] marcadaP6 = new boolean[12];
float[] perillaP6 = new float[12];          // donde esta la perilla del interruptor (0 apagado, 1 encendido): se desliza suave
int[] destelloP6 = new int[12];             // millis() en que una mano la reactivo (destello amarillo)
int cantidadOpcionesP6 = 12;
boolean[] revisadaP6 = new boolean[12];     // ya se leyo su letra chica (para la guia del protagonista)

// LAS MANOS TRAMPOSAS: entran por la derecha del celular y reactivan una opcion
int cantidadManosP6 = 4;
boolean[] manoActivaP6 = new boolean[4];
int[] manoFilaP6 = new int[4];
int[] manoInicioP6 = new int[4];
boolean[] manoVuelveP6 = new boolean[4];   // ya la activo y se va
int[] manoVueltaP6 = new int[4];           // millis() en que empezo a irse
float[] manoXP6 = new float[4];            // posicion calculada (para el clic)
float[] manoYP6 = new float[4];
int ultimaManoP6 = 0;
int manosAtrapadasP6 = 0;

// EL BOTON "ACEPTO" QUE PERSIGUE
float botonXP6 = 765;
float botonYP6 = 980;

// LA VENTANA DE PRESION
boolean ventanaP6 = false;
boolean ventanaSalioP6 = false;
int inicioVentanaP6 = 0;
boolean noGraciasEscapoP6 = false;          // el boton chiquito ya se escapo una vez
float noGraciasXP6 = 1080;

// ESTADO
int faseP6 = -1;                            // -1 = telon y guia, 1 = jugando, 3 = cierre
int inicioJuegoP6 = 0;
int erroresP6 = 0;
int inicioErrorP6 = -10000;                 // al entregar mal, las equivocadas se ven en rojo 2 s
int inicioCierreP6 = 0;
boolean cierreGanoP6 = false;
int motivoDerrotaP6 = 0;
int puntosGanadosP6 = 0;
int filaEncimaP6 = -1;
String pensamientoP6 = "";                   // lo que piensa el protagonista
int inicioPensamientoP6 = -10000;
int expresionP6 = -1;                        // -1 normal, 0 alegre, 1 enojado, 2 sorprendido, 3 triste, 4 pensativo, 5 cansado
int expresionHastaP6 = 0;                    // hasta cuando dura la expresion de una reaccion
int inicioExpresionP6 = 0;

// GUIA DE LA PRUEBA 6
String[] titulosGuiaP6 = {
  "Tu cordura",
  "El tiempo",
  "Exposición",
  "Tus puntos",
  "La instalación",
  "La letra chica",
  "Las manos",
  "El botón Acepto",
  "Guardar",
  "A jugar"
};
String[] textosGuiaP6 = {
  "Estos palitos son tu cordura. Si cometes un error, pierdes uno. Si se acaban, pierdes la prueba.",
  "Lo que te queda para terminar. En los últimos 10 segundos la barra se pone roja.",
  "Cuánto de tu vida pueden ver los desconocidos. Sube sola mientras la sombra mira.",
  "Cada acierto suma puntos. Al final hay bonos por no equivocarte y por terminar rápido.",
  "Para instalar Aporía 2.0 tienes que revisar estas 12 opciones. Casi todas vienen activadas. Haz clic en una fila para activarla o desactivarla.",
  "Al pasar el mouse por una opción, aquí ves lo que de verdad hace. Léela: algunas están escritas para confundirte.",
  "Las manos de la app entran por aquí para volver a activar lo que apagaste. Haz clic en ellas para espantarlas antes de que lleguen.",
  "Este botón quiere que aceptes sin leer y te va a perseguir. Si lo tocas, se activan más opciones y pierdes un palito.",
  "Cuando todo esté como quieres, guarda aquí o con ENTER. Si queda algo que te expone, pierdes un palito.",
  "Apaga todo lo que te expone, deja encendido lo que no y guarda antes de que se acabe el tiempo. Pulsa ENTER para empezar."
};
float[][] zonasGuiaP6 = {
  {20, 8, 330, 80},
  {690, 22, 540, 100},
  {1385, 8, 490, 78},
  {1580, 98, 310, 80},
  {585, 105, 750, 960},
  {1360, 230, 340, 400},
  {1230, 230, 200, 760},
  {740, 960, 440, 110},
  {1370, 880, 320, 120},
  {960, 540, 0, 0}
};
int cantidadPasosGuiaP6 = 10;


// prepara la prueba (se llama al terminar el contexto)
void iniciarP6() {
  duracionPrueba = 60000;
  inicioPrueba = millis();
  palitos = 5;

  for (int i = 0; i < cantidadOpcionesP6; i++) {
    marcadaP6[i] = i < 10;          // las 10 primeras vienen activadas; K y L no
    perillaP6[i] = 0;
    if (marcadaP6[i]) {
      perillaP6[i] = 1;
    }
    destelloP6[i] = -10000;
    revisadaP6[i] = false;
  }
  for (int m = 0; m < cantidadManosP6; m++) {
    manoActivaP6[m] = false;
  }
  botonXP6 = 765;
  botonYP6 = 980;
  ventanaP6 = false;
  ventanaSalioP6 = false;
  noGraciasEscapoP6 = false;
  noGraciasXP6 = 1080;
  faseP6 = -1;
  erroresP6 = 0;
  inicioErrorP6 = -10000;
  manosAtrapadasP6 = 0;
  motivoDerrotaP6 = 0;
  pensamientoP6 = "";
  expresionP6 = -1;
  expresionHastaP6 = 0;
  mensajePrueba = "";

  prepararArteP5();                 // el publico (siluetas) de la prueba 5

  empezarAmbientePrueba();
  empezarTelon();
  empezarGuia(titulosGuiaP6, textosGuiaP6, zonasGuiaP6, cantidadPasosGuiaP6);
}


// la fila de una opcion (y en medidas de 1920)
float filaYP6(int i) {
  return 250 + i * 60;
}


// fila bajo el mouse (dentro del celular), o -1
int filaBajoMouseP6() {
  float e = width / 1920.0;
  float mx = mouseX / e;
  float my = mouseY / e;
  if (mx < 605 || mx > 1315) {
    return -1;
  }
  for (int i = 0; i < cantidadOpcionesP6; i++) {
    if (my > filaYP6(i) && my < filaYP6(i) + 54) {
      return i;
    }
  }
  return -1;
}


// el mouse esta sobre el boton "Acepto"?
boolean botonBajoMouseP6() {
  float e = width / 1920.0;
  return mouseX / e > botonXP6 && mouseX / e < botonXP6 + 390 && mouseY / e > botonYP6 && mouseY / e < botonYP6 + 84;
}


// el mouse esta sobre "Guardar y continuar"?
boolean guardarBajoMouseP6() {
  float e = width / 1920.0;
  return mouseX / e > 1380 && mouseX / e < 1680 && mouseY / e > 900 && mouseY / e < 980;
}


// cuantas opciones estan como deben (las que exponen apagadas, las otras encendidas)
int correctasP6() {
  int bien = 0;
  for (int i = 0; i < cantidadOpcionesP6; i++) {
    if (marcadaP6[i] != exponeP6[i]) {
      bien++;
    }
  }
  return bien;
}


// el protagonista piensa algo y pone una cara por un rato
void reaccionP6(String frase, int expresion, int duracion) {
  pensamientoP6 = frase;
  inicioPensamientoP6 = millis();
  expresionP6 = expresion;
  expresionHastaP6 = millis() + duracion;
  inicioExpresionP6 = millis();
}


// una mano nueva va hacia una opcion que te expone y que apagaste
void crearManoP6() {
  // elige al azar entre las opciones que exponen y estan apagadas (y que ninguna otra mano esta buscando)
  int candidatas = 0;
  for (int i = 0; i < cantidadOpcionesP6; i++) {
    if (exponeP6[i] && !marcadaP6[i] && !filaBuscadaP6(i)) {
      candidatas++;
    }
  }
  if (candidatas == 0) {
    return;
  }
  int elegida = int(random(candidatas));
  int fila = -1;
  for (int i = 0; i < cantidadOpcionesP6; i++) {
    if (exponeP6[i] && !marcadaP6[i] && !filaBuscadaP6(i)) {
      if (elegida == 0) {
        fila = i;
      }
      elegida--;
    }
  }
  for (int m = 0; m < cantidadManosP6; m++) {
    if (!manoActivaP6[m] && fila >= 0) {
      manoActivaP6[m] = true;
      manoFilaP6[m] = fila;
      manoInicioP6[m] = millis();
      manoVuelveP6[m] = false;
      fila = -1;
    }
  }
}


// ya hay una mano yendo a esa fila?
boolean filaBuscadaP6(int fila) {
  for (int m = 0; m < cantidadManosP6; m++) {
    if (manoActivaP6[m] && !manoVuelveP6[m] && manoFilaP6[m] == fila) {
      return true;
    }
  }
  return false;
}


// activa 3 opciones que te exponen (al tocar "Acepto")
void activarAlgunasP6(int cuantas) {
  for (int k = 0; k < cuantas; k++) {
    for (int i = 0; i < cantidadOpcionesP6; i++) {
      if (exponeP6[i] && !marcadaP6[i]) {
        marcadaP6[i] = true;
        destelloP6[i] = millis();
        i = cantidadOpcionesP6;   // solo una por vuelta
      }
    }
  }
}


// 30 - ACTO II - PRUEBA 2 - TERMINOS TRAMPOSOS
void dibujarTerminosP6() {
  float e = width / 1920.0;

  // FASES: al terminar el telon y la guia empieza (el reloj corre desde ahi)
  if (faseP6 == -1 && !telonActivo && !guiaActiva) {
    faseP6 = 1;
    inicioJuegoP6 = millis();
    inicioPrueba = millis();
    ultimaManoP6 = millis() + 3000;
    mensajeP5("Instalando Aporía 2.0. Acepta los términos para continuar.", 0);
    reaccionP6("Primero voy a leer qué dice.", 4, 2500);
  }
  if (faseP6 == -1) {
    inicioPrueba = millis();
  }
  float segundos = (millis() - inicioJuegoP6) / 1000.0;

  // LOGICA
  if (faseP6 == 1) {
    // la ventana de presion sale a los 30 s
    if (!ventanaSalioP6 && segundos >= 30) {
      ventanaP6 = true;
      ventanaSalioP6 = true;
      inicioVentanaP6 = millis();
      sonidosCargadosSample[45].trigger();
      reaccionP6("Y ahora esto?", 2, 1500);
    }

    // el boton "Acepto" persigue al mouse (mas rapido desde los 40 s)
    if (segundos > 4 && !ventanaP6) {
      float rapidez = 0.025;
      if (segundos > 40) {
        rapidez = 0.045;
      }
      botonXP6 = constrain(lerp(botonXP6, mouseX / e - 195, rapidez), 605, 1315 - 390);
      botonYP6 = constrain(lerp(botonYP6, mouseY / e - 42, rapidez), 240, 1050 - 84);
    }

    // manos: una cada 4 s (cada 3 s desde los 40 s)
    int ritmo = 4000;
    if (segundos > 40) {
      ritmo = 3000;
    }
    if (millis() - ultimaManoP6 > ritmo && !ventanaP6) {
      crearManoP6();
      ultimaManoP6 = millis();
    }
    for (int m = 0; m < cantidadManosP6; m++) {
      if (manoActivaP6[m] && !manoVuelveP6[m] && millis() - manoInicioP6[m] > 1600) {
        int fila = manoFilaP6[m];
        manoVuelveP6[m] = true;
        manoVueltaP6[m] = millis();
        if (!marcadaP6[fila]) {
          marcadaP6[fila] = true;
          destelloP6[fila] = millis();
          sonidosCargadosSample[20].trigger();
          mensajeP5("Una opción se volvió a activar sola.", -1);
          reaccionP6("Oye! Yo la había apagado.", 1, 1500);
        }
      }
      if (manoActivaP6[m] && manoVuelveP6[m] && millis() - manoVueltaP6[m] > 600) {
        manoActivaP6[m] = false;
      }
    }

    if (palitos <= 0) {
      perderP6(2);
    }
    gotearExposicionPrueba();
  }

  // los interruptores se deslizan suave
  for (int i = 0; i < cantidadOpcionesP6; i++) {
    float meta = 0;
    if (marcadaP6[i]) {
      meta = 1;
    }
    perillaP6[i] = lerp(perillaP6[i], meta, 0.25);
  }

  filaEncimaP6 = -1;
  if (faseP6 == 1 && !ventanaP6 && !botonBajoMouseP6()) {
    filaEncimaP6 = filaBajoMouseP6();
  }
  if (filaEncimaP6 >= 0) {
    revisadaP6[filaEncimaP6] = true;
  }

  // cursor de mano sobre lo que se puede tocar
  cursor(ARROW);
  if (faseP6 == 1 && (filaEncimaP6 >= 0 || botonBajoMouseP6() || guardarBajoMouseP6() || manoBajoMouseP6() >= 0)) {
    cursor(HAND);
  }

  // DIBUJO
  background(28, 22, 5);
  noStroke();
  fill(242, 194, 48, 16 + 4 * sin(millis() * 0.002));
  triangle(960 * e, 90 * e, 300 * e, 1080 * e, 1620 * e, 1080 * e);
  dibujarTramaComic(color(242, 194, 48), 8);

  float tension = calcularTension();
  dibujarSombraYTelon(tension);

  // el publico de la primera fila (detras del celular)
  for (int k = 0; k < 13; k++) {
    image(siluetaArteP5[k % 5], (180 + k * 115) * e, (1000 + sin(millis() * 0.004 + k) * 4) * e);
  }
  dibujarCelularP6(e);
  dibujarManosP6(e);
  dibujarBotonAceptoP6(e);
  dibujarLetraChicaP6(e);
  dibujarProtagonistaP6(e);
  dibujarPopsP5(e);
  if (ventanaP6) {
    dibujarVentanaP6(e);
  }

  dibujarTension(tension);
  dibujarBarraSuperior(color(242, 194, 48));
  dibujarMarcador(correctasP6() * 2);
  dibujarMonedas();
  dibujarFlotantes();
  dibujarImpacto();
  dibujarMensajeP5(e);

  // cierre: un momento para ver el final y pasa a la pantalla de resultado
  if (faseP6 == 3 && millis() - inicioCierreP6 > 1800) {
    llenarResultadoP6(cierreGanoP6);
    empezarResultado(cierreGanoP6);
    if (cierreGanoP6) {
      pantalla = 32;
    } else {
      pantalla = 31;
    }
  }
}


// el celular con los terminos: titulo, barra de instalacion detenida y las 12 filas con interruptores
void dibujarCelularP6(float e) {
  noStroke();
  fill(0, 120);
  rect(599 * e, 121 * e, 750 * e, 960 * e);
  fill(8, 6, 2);
  rect(585 * e, 105 * e, 750 * e, 960 * e, 40 * e);
  fill(245, 242, 250);
  rect(600 * e, 120 * e, 720 * e, 930 * e, 30 * e);

  // encabezado de la app
  fill(72, 58, 128);
  rect(600 * e, 120 * e, 720 * e, 110 * e, 30 * e);
  rect(600 * e, 170 * e, 720 * e, 60 * e);
  image(imagenesCargadas[138], 626 * e, 130 * e, 50 * e, 50 * e);
  fill(245, 235, 215);
  textFont(fuenteTitulo);
  textAlign(LEFT, CENTER);
  textSize(30 * e);
  text("Aporía 2.0   Términos y condiciones", 690 * e, 155 * e);

  // barra de instalacion: se queda en 99 % y tiembla un poco, impaciente
  float tiembla = sin(millis() * 0.03) * 1.5;
  fill(255, 255, 255, 40);
  rect(630 * e, 190 * e, 560 * e, 20 * e);
  fill(215, 180, 110);
  rect(630 * e, 190 * e, (554 + tiembla) * e, 20 * e);
  fill(245, 235, 215);
  textFont(fuenteTexto);
  textSize(20 * e);
  text("99 %", 1205 * e, 199 * e);

  // las filas
  for (int i = 0; i < cantidadOpcionesP6; i++) {
    float y = filaYP6(i);
    boolean encima = filaEncimaP6 == i;
    int pasadoDestello = millis() - destelloP6[i];
    boolean mal = millis() - inicioErrorP6 < 2000 && marcadaP6[i] == exponeP6[i];

    noStroke();
    fill(232, 228, 240);
    if (i % 2 == 1) {
      fill(238, 235, 245);
    }
    if (encima) {
      fill(226, 218, 246);
    }
    rect(610 * e, y * e, 700 * e, 54 * e);
    if (pasadoDestello < 700) {
      fill(232, 120, 110, 170 * (1 - pasadoDestello / 700.0));
      rect(610 * e, y * e, 700 * e, 54 * e);
    }
    if (mal) {
      noFill();
      stroke(225, 50, 60);
      strokeWeight(4 * e);
      rect(612 * e, (y + 2) * e, 696 * e, 50 * e);
      noStroke();
    }

    // la letra y el texto
    fill(110, 90, 160);
    textFont(fuenteTitulo);
    textAlign(LEFT, CENTER);
    textSize(24 * e);
    text(letraP6[i], 628 * e, (y + 26) * e);
    fill(30, 22, 34);
    textFont(fuenteTexto);
    textSize(21 * e);
    text(opcionP6[i], 660 * e, (y + 26) * e);

    // el interruptor: verde y a la derecha encendido, gris a la izquierda apagado
    float sx = 1228;
    float sy = y + 10;
    fill(20, 14, 30);
    rect((sx - 3) * e, (sy - 3) * e, 76 * e, 40 * e, 20 * e);
    fill(lerpColor(color(170, 165, 185), color(116, 182, 146), perillaP6[i]));
    rect(sx * e, sy * e, 70 * e, 34 * e, 17 * e);
    fill(255);
    ellipse((sx + 17 + 36 * perillaP6[i]) * e, (sy + 17) * e, 28 * e, 28 * e);
  }
  strokeWeight(1);
}


// las manos tramposas: entran desde la derecha hasta el interruptor; al irse, se van rapido
int manoBajoMouseP6() {
  float e = width / 1920.0;
  for (int m = 0; m < cantidadManosP6; m++) {
    if (manoActivaP6[m] && !manoVuelveP6[m] && dist(mouseX / e, mouseY / e, manoXP6[m], manoYP6[m]) < 55) {
      return m;
    }
  }
  return -1;
}

void dibujarManosP6(float e) {
  for (int m = 0; m < cantidadManosP6; m++) {
    if (manoActivaP6[m]) {
      float metaX = 1300;
      float y = filaYP6(manoFilaP6[m]) + 27;
      float avance = constrain((millis() - manoInicioP6[m]) / 1600.0, 0, 1);
      float x = lerp(1440, metaX, avance * avance * (3 - 2 * avance));
      if (manoVuelveP6[m]) {
        x = lerp(metaX, 1460, constrain((millis() - manoVueltaP6[m]) / 600.0, 0, 1));
      }
      y += sin(millis() * 0.012 + m) * 5;
      manoXP6[m] = x;
      manoYP6[m] = y;
      boolean encima = manoBajoMouseP6() == m;
      pushMatrix();
      translate(x * e, y * e);
      if (encima) {
        scale(1.15);
      }
      rotate(sin(millis() * 0.01 + m) * 0.08);
      // el guante viene senalando la opcion; cuando se va (o lo espantas) abre la mano
      if (manoVuelveP6[m]) {
        image(imagenesCargadas[137], -75 * e, -64 * e, 150 * e, 127 * e);
      } else {
        image(imagenesCargadas[136], -75 * e, -54 * e, 150 * e, 108 * e);
      }
      popMatrix();
    }
  }
}


// el boton "Acepto los terminos": amarillo, brillante, con una flecha que salta y una sonrisa tramposa
void dibujarBotonAceptoP6(float e) {
  float x = botonXP6;
  float y = botonYP6;
  float late = 1 + sin(millis() * 0.008) * 0.03;
  pushMatrix();
  translate((x + 195) * e, (y + 42) * e);
  scale(late);
  noStroke();
  fill(230, 190, 110, 35);
  rect(-215 * e, -60 * e, 430 * e, 120 * e, 60 * e);
  fill(0, 120);
  rect(-188 * e, -34 * e, 390 * e, 84 * e, 42 * e);
  fill(20, 14, 4);
  rect(-199 * e, -46 * e, 398 * e, 92 * e, 46 * e);
  fill(228, 188, 106);
  rect(-195 * e, -42 * e, 390 * e, 84 * e, 42 * e);
  fill(245, 220, 160);
  rect(-170 * e, -34 * e, 340 * e, 18 * e, 9 * e);
  fill(30, 22, 6);
  textFont(fuenteTitulo);
  textAlign(CENTER, CENTER);
  textSize(32 * e);
  text("ACEPTO LOS TÉRMINOS", 0, 0);
  popMatrix();

  // la flecha que salta: "Toca aqui!"
  float salta = sin(millis() * 0.01) * 8;
  fill(235, 205, 145);
  textFont(fuenteTitulo);
  textSize(26 * e);
  textAlign(CENTER, BOTTOM);
  text("Toca aquí!", (x + 195) * e, (y - 22 + salta) * e);
  triangle((x + 180) * e, (y - 18 + salta) * e, (x + 210) * e, (y - 18 + salta) * e, (x + 195) * e, (y - 2 + salta) * e);
}


// el panel de la derecha: la letra chica de la opcion bajo el mouse, las manos atrapadas y el boton de guardar
void dibujarLetraChicaP6(float e) {
  noStroke();
  fill(0, 120);
  rect(1378 * e, 242 * e, 320 * e, 380 * e);
  fill(20, 14, 4);
  rect(1366 * e, 230 * e, 324 * e, 384 * e);
  fill(255, 248, 225);
  rect(1370 * e, 234 * e, 316 * e, 376 * e);

  // lupa y titulo
  stroke(30, 22, 6);
  strokeWeight(5 * e);
  noFill();
  ellipse(1404 * e, 266 * e, 30 * e, 30 * e);
  line(1415 * e, 277 * e, 1428 * e, 290 * e);
  noStroke();
  fill(30, 22, 6);
  textFont(fuenteTitulo);
  textAlign(LEFT, CENTER);
  textSize(30 * e);
  text("Letra chica", 1440 * e, 264 * e);

  textFont(fuenteTexto);
  textAlign(LEFT, TOP);
  if (filaEncimaP6 >= 0) {
    fill(110, 90, 160);
    textSize(22 * e);
    text(letraP6[filaEncimaP6] + "   " + opcionP6[filaEncimaP6], 1390 * e, 300 * e, 280 * e, 80 * e);
    fill(30, 22, 34);
    textSize(26 * e);
    text(letraChicaP6[filaEncimaP6], 1390 * e, 390 * e, 280 * e, 210 * e);
  } else {
    fill(120, 110, 100);
    textSize(24 * e);
    text("Pasa el mouse por una opción para ver lo que de verdad hace.", 1390 * e, 310 * e, 280 * e, 200 * e);
  }

  // manos atrapadas
  fill(255, 225, 150);
  textAlign(LEFT, CENTER);
  textSize(24 * e);
  text("Manos espantadas  " + manosAtrapadasP6, 1372 * e, 650 * e);

  // boton de guardar (gris y discreto, como en las apps)
  boolean encima = guardarBajoMouseP6();
  fill(20, 14, 4);
  rect(1376 * e, 896 * e, 308 * e, 88 * e, 14 * e);
  fill(200, 196, 210);
  if (encima) {
    fill(230, 226, 240);
  }
  rect(1380 * e, 900 * e, 300 * e, 80 * e, 12 * e);
  fill(40, 34, 50);
  textAlign(CENTER, CENTER);
  textSize(26 * e);
  text("Guardar y continuar", 1530 * e, 930 * e);
  textSize(18 * e);
  text("o pulsa ENTER", 1530 * e, 960 * e);
}


// lo que piensa el protagonista: un globo de pensamiento a la izquierda del celular (sin su cara)
void dibujarProtagonistaP6(float e) {
  noStroke();
  if (millis() - inicioPensamientoP6 < 3000 && pensamientoP6.length() > 0) {
    float opacidad = 255 * (1 - constrain((millis() - inicioPensamientoP6 - 2500) / 500.0, 0, 1));
    float entra = reboteTelon((millis() - inicioPensamientoP6) / 300.0);
    pushMatrix();
    translate(400 * e, 560 * e);
    scale(0.6 + 0.4 * entra);
    fill(20, 14, 4, opacidad);
    rect(-166 * e, -66 * e, 332 * e, 120 * e, 40 * e);
    fill(255, opacidad);
    rect(-160 * e, -60 * e, 320 * e, 108 * e, 36 * e);
    ellipse(-40 * e, 70 * e, 24 * e, 24 * e);
    ellipse(-56 * e, 96 * e, 14 * e, 14 * e);
    fill(30, 22, 6, opacidad);
    textFont(fuenteTexto);
    textAlign(CENTER, CENTER);
    textSize(24 * e);
    text(pensamientoP6, -150 * e, -56 * e, 300 * e, 100 * e);
    popMatrix();
  }
}


// la ventana de presion: el 92 % de tus amigos ya activo todo; "No, gracias" es chiquito y se escapa una vez
void dibujarVentanaP6(float e) {
  float entra = reboteTelon((millis() - inicioVentanaP6) / 400.0);
  noStroke();
  fill(0, 160);
  rect(0, 0, width, height);
  pushMatrix();
  translate(960 * e, 540 * e);
  scale(0.5 + 0.5 * entra);
  fill(0, 120);
  rect(-290 * e, -155 * e, 600 * e, 330 * e);
  fill(20, 14, 4);
  rect(-306 * e, -171 * e, 612 * e, 342 * e, 20 * e);
  fill(255, 248, 225);
  rect(-300 * e, -165 * e, 600 * e, 330 * e, 16 * e);

  fill(30, 22, 6);
  textFont(fuenteTitulo);
  textAlign(CENTER, CENTER);
  textSize(40 * e);
  text("Seguro?", 0, -120 * e);
  textFont(fuenteTexto);
  textSize(28 * e);
  text("El 92 % de tus amigos ya activó todas estas opciones. No te quedes atrás.", -260 * e, -95 * e, 520 * e, 110 * e);

  // "Activar todo": grande, amarillo, brillante
  boolean encimaActivar = ventanaActivarBajoMouseP6();
  fill(20, 14, 4);
  rect(-204 * e, 22 * e, 408 * e, 88 * e, 44 * e);
  fill(228, 188, 106);
  if (encimaActivar) {
    fill(242, 208, 138);
  }
  rect(-200 * e, 26 * e, 400 * e, 80 * e, 40 * e);
  fill(30, 22, 6);
  textFont(fuenteTitulo);
  textSize(34 * e);
  text("ACTIVAR TODO", 0, 64 * e);
  popMatrix();

  // "No, gracias": chiquito y gris abajo (fuera del pushMatrix para poder moverlo)
  if (entra > 0.9) {
    fill(140, 130, 120);
    if (ventanaNoBajoMouseP6()) {
      fill(80, 70, 60);
    }
    textFont(fuenteTexto);
    textAlign(CENTER, CENTER);
    textSize(19 * e);
    text("No, gracias", noGraciasXP6 * e, 680 * e);
    // la primera vez que lo tocas, se escapa al otro lado
    if (ventanaNoBajoMouseP6() && !noGraciasEscapoP6) {
      noGraciasEscapoP6 = true;
      noGraciasXP6 = 840;
      reaccionP6("Ni el botón me deja decir que no.", 1, 1800);
    }
  }
}

boolean ventanaActivarBajoMouseP6() {
  float e = width / 1920.0;
  return mouseX / e > 760 && mouseX / e < 1160 && mouseY / e > 566 && mouseY / e < 646;
}

boolean ventanaNoBajoMouseP6() {
  float e = width / 1920.0;
  return mouseX / e > noGraciasXP6 - 60 && mouseX / e < noGraciasXP6 + 60 && mouseY / e > 665 && mouseY / e < 695;
}


// clic en la pantalla 30
void clicP6() {
  if (faseP6 != 1) {
    return;
  }
  float e = width / 1920.0;

  // con la ventana abierta solo sirven sus botones
  if (ventanaP6) {
    if (ventanaActivarBajoMouseP6()) {
      ventanaP6 = false;
      for (int i = 0; i < cantidadOpcionesP6; i++) {
        if (exponeP6[i] && !marcadaP6[i]) {
          marcadaP6[i] = true;
          destelloP6[i] = millis();
        }
      }
      erroresP6++;
      perderPalito();
      sombraReacciona(2);
      mensajeP5("Activaste todo para no quedarte atrás. Eso es presión.", -1);
      reaccionP6("Lo hice solo porque los demás lo hicieron.", 3, 2500);
    }
    if (ventanaNoBajoMouseP6() && noGraciasEscapoP6) {
      ventanaP6 = false;
      sombraReacciona(1);
      agregarPopP5(noGraciasXP6, 680, color(120, 225, 130));
      mensajeP5("Te presionaron con lo que hacen otros. Tú decides.", 1);
      reaccionP6("Lo que hagan los demás no decide por mí.", 0, 2200);
    }
    return;
  }

  // una mano: se espanta
  int m = manoBajoMouseP6();
  if (m >= 0) {
    manoVuelveP6[m] = true;
    manoVueltaP6[m] = millis();
    manosAtrapadasP6++;
    sonidosCargadosSample[43].trigger();
    agregarPopP5(manoXP6[m], manoYP6[m], color(255, 225, 90));
    if (manosAtrapadasP6 <= 5) {
      agregarFlotante("+1", manoXP6[m], manoYP6[m] - 40, color(255, 210, 90));
    }
    reaccionP6("Fuera de mi configuración!", 0, 1200);
    return;
  }

  // el boton "Acepto": la trampa
  if (botonBajoMouseP6()) {
    erroresP6++;
    perderPalito();
    activarAlgunasP6(3);
    sombraReacciona(2);
    agregarImpacto("ACEPTASTE SIN LEER", 960, 540, 70, color(255, 110, 110));
    mensajeP5("Aceptaste sin leer. Se activaron 3 opciones más.", -1);
    reaccionP6("No... ese botón me persiguió.", 2, 1800);
    botonXP6 = 765;
    botonYP6 = 980;
    return;
  }

  // guardar
  if (guardarBajoMouseP6()) {
    entregarP6();
    return;
  }

  // una fila: se activa o desactiva
  int fila = filaBajoMouseP6();
  if (fila >= 0) {
    marcadaP6[fila] = !marcadaP6[fila];
    sonidosCargadosSample[17].trigger();
    if (exponeP6[fila] && !marcadaP6[fila]) {
      reaccionP6("Eso no tiene por qué verlo nadie.", 0, 1200);
    }
  }
}


// teclas en la pantalla 30: ENTER guarda
void teclaP6() {
  if (faseP6 == 1 && !ventanaP6 && (keyCode == ENTER || key == ENTER || key == RETURN)) {
    entregarP6();
  }
}


// revisa la configuracion: si todo esta bien, gana; si no, marca en rojo lo equivocado
void entregarP6() {
  if (correctasP6() == cantidadOpcionesP6) {
    ganarP6();
  } else {
    erroresP6++;
    inicioErrorP6 = millis();
    perderPalito();
    sombraReacciona(2);
    mensajeP5("Todavía hay opciones que te exponen. Revisa las rojas.", -1);
    reaccionP6("Algo se me pasó. Mejor vuelvo a leer.", 3, 2000);
  }
}


// gana: opciones bien puestas (24) + manos espantadas (5) + sin errores (3) + tiempo (3) = 35
void ganarP6() {
  if (faseP6 == 3) {
    return;
  }
  int puntosOpciones = correctasP6() * 2;
  int puntosManos = min(manosAtrapadasP6, 5);
  int puntosSinErrores = 0;
  if (erroresP6 == 0) {
    puntosSinErrores = 3;
  }
  int restanteMs = duracionPrueba - (millis() - inicioPrueba);
  int puntosTiempo = constrain(restanteMs / 8000, 0, 3);

  lineaTexto[0] = "Opciones bien puestas";
  lineaPuntos[0] = puntosOpciones;
  lineaTexto[1] = "Manos espantadas";
  lineaPuntos[1] = puntosManos;
  lineaTexto[2] = "Sin errores";
  lineaPuntos[2] = puntosSinErrores;
  lineaTexto[3] = "Tiempo que sobró";
  lineaPuntos[3] = puntosTiempo;
  cantidadLineas = 4;

  puntosGanadosP6 = puntosOpciones + puntosManos + puntosSinErrores + puntosTiempo;
  puntosJugador += puntosGanadosP6;
  subirExposicion(-5);
  resultadoActo2[1] = 1;
  if (erroresP6 == 0) {
    ganarLogro(5);
  }
  revisarLogrosActos();
  if (pruebasCompletadasActo2 == 1) {
    pruebasCompletadasActo2 = 2;
  }
  empezarCierreP6(true);
}


// pierde: se filtra el dato; 1 punto por opcion bien puesta; cada opcion que expone y quedo activada sube la exposicion
void perderP6(int motivo) {
  if (faseP6 == 3) {
    return;
  }
  motivoDerrotaP6 = motivo;
  puntosGanadosP6 = correctasP6();
  lineaTexto[0] = "Opciones bien puestas";
  lineaPuntos[0] = puntosGanadosP6;
  cantidadLineas = 1;
  puntosJugador += puntosGanadosP6;
  int expuestas = 0;
  for (int i = 0; i < cantidadOpcionesP6; i++) {
    if (exponeP6[i] && marcadaP6[i]) {
      expuestas++;
    }
  }
  subirExposicion(expuestas * 3);

  resultadoActo2[1] = 2;
  if (pruebasCompletadasActo2 == 1) {
    pruebasCompletadasActo2 = 2;
  }
  filtrarDato(6);
  empezarCierreP6(false);
}


// el tiempo se acabo (lo llama el contador)
void tiempoAgotadoP6() {
  perderP6(0);
}


// empieza el cierre: la barra llega al 100 % (o la app se instala con todo abierto)
void empezarCierreP6(boolean gano) {
  faseP6 = 3;
  cierreGanoP6 = gano;
  inicioCierreP6 = millis();
  ventanaP6 = false;
  for (int m = 0; m < cantidadManosP6; m++) {
    manoActivaP6[m] = false;
  }
  if (gano) {
    agregarImpacto("INSTALADO A TU MANERA", 960, 540, 80, color(120, 225, 130));
    sonidosCargadosSample[45].trigger();
    reaccionP6("Ahora sí. Solo muestro lo que yo decido.", 0, 3000);
  } else {
    agregarImpacto("INSTALADO CON TODO ABIERTO", 960, 540, 70, color(255, 110, 110));
    sombraReacciona(2);
    reaccionP6("Ahora todos pueden ver dónde estoy...", 3, 3000);
  }
}


// textos de la pantalla de resultado
void llenarResultadoP6(boolean gano) {
  tituloResultado = "Se acabó el tiempo";
  if (motivoDerrotaP6 == 2) {
    tituloResultado = "Te quedaste sin palitos";
  }
  subtituloResultado = "Aporía se instaló con lo que venía activado de fábrica.";
  selloIlustracion = "ACEPTADO";
  if (gano) {
    tituloResultado = "Prueba superada";
    subtituloResultado = "Instalación completa. Tu cuenta muestra solo lo que tú decidiste.";
    selloIlustracion = "REVISADO";
  }
  explicacionIlustracion = "Lo que viene activado de fábrica\nno significa que lo necesites.";
  fraseVidaReal = "Las apps esconden opciones, las reactivan solas y te presionan para que aceptes todo. Eso se llama patrón oscuro.";
  consejoVidaReal = "Antes de aceptar, revisa la privacidad: desactiva la ubicación, las etiquetas y que desconocidos te encuentren.";
  datoResultado = 6;
  ilustracionResultado = 6;
  puntosResultado = puntosGanadosP6;
}


// la ilustracion del resultado: un celular con interruptores apagados y un candado (se dibuja alrededor de 0, 0)
void dibujarIlustracionResultadoP6() {
  float e = width / 1920.0;
  noStroke();
  fill(0, 110);
  rect(-125 * e, -175 * e, 260 * e, 380 * e);
  fill(8, 6, 2);
  rect(-130 * e, -190 * e, 260 * e, 380 * e, 24 * e);
  fill(245, 242, 250);
  rect(-118 * e, -176 * e, 236 * e, 352 * e, 16 * e);
  fill(72, 58, 128);
  rect(-118 * e, -176 * e, 236 * e, 46 * e, 16 * e);
  for (int f = 0; f < 5; f++) {
    float y = -110 + f * 50;
    fill(220, 216, 230);
    rect(-104 * e, y * e, 140 * e, 14 * e);
    fill(170, 165, 185);
    if (f == 2) {
      fill(116, 182, 146);
    }
    rect(56 * e, (y - 6) * e, 44 * e, 24 * e, 12 * e);
    fill(255);
    float px = 68;
    if (f == 2) {
      px = 88;
    }
    ellipse(px * e, (y + 6) * e, 18 * e, 18 * e);
  }
}


// 31 - ACTO II - PRUEBA 2 - PRUEBA PERDIDA
void dibujarPerdidaP6() {
  dibujarResultado(false);
}


// 32 - ACTO II - PRUEBA 2 - PRUEBA SUPERADA
void dibujarSuperadaP6() {
  dibujarResultado(true);
}
