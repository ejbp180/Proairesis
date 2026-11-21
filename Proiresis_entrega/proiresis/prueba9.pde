// PANTALLAS 40 A 42 - ACTO III - PRUEBA 9: LA CADENA
// ronda 1: eres el Desconocido (una serpiente); comete los 5 datos en el orden en que se encuentran
// ronda 2: vuelves a ser tu; con un solo corte rompes la cadena lo mas temprano posible

// LOS DATOS DE LA CADENA (en su orden correcto)
String[] elementoP9 = {"Publicación", "Etiqueta", "Perfil", "Fotografía", "Ubicación"};
int[] iconoElementoP9 = {0, 4, 10, 2, 3};
String[] fraseP9 = {
  "Una publicación tuya es pública.",
  "Dentro de la publicación aparece una etiqueta.",
  "La etiqueta lleva a tu perfil.",
  "En tu perfil hay una fotografía pública.",
  "La fotografía tiene tu ubicación."
};
int cantidadElementosP9 = 5;
int[] comidaXP9 = new int[5];               // casilla de cada dato en el tablero
int[] comidaYP9 = new int[5];
boolean[] comidoP9 = new boolean[5];
int[] aparecioP9 = new int[5];              // millis() en que aparecio en su casilla (entra creciendo)
int[] errorComidaP9 = new int[5];           // millis() del ultimo mordisco fuera de orden (tiembla en rojo)
int siguienteP9 = 0;                        // el dato que toca comer
int[] ordenPanelP9 = {3, 0, 4, 1, 2};       // las frases del panel empiezan desordenadas
float[] panelYP9 = new float[5];            // donde se dibuja cada frase (se acomoda suave)

// EL TABLERO
int columnasP9 = 24;
int filasP9 = 15;
float casillaP9 = 46;
float tableroXP9 = 240;
float tableroYP9 = 220;

// LA SERPIENTE (el Desconocido)
int cantidadCuerpoP9 = 40;
int[] cuerpoXP9 = new int[40];
int[] cuerpoYP9 = new int[40];
int[] antesXP9 = new int[40];               // casilla de cada parte en el paso anterior (para moverse suave)
int[] antesYP9 = new int[40];
int largoP9 = 3;
int crecerP9 = 0;                           // partes que todavia le faltan por crecer
int dirXP9 = 1;
int dirYP9 = 0;
int[] colaDirXP9 = new int[2];              // giros pedidos con las flechas (se guardan hasta 2)
int[] colaDirYP9 = new int[2];
int cantidadColaP9 = 0;
int ultimoPasoP9 = 0;
int intervaloP9 = 170;                      // ms entre pasos (baja 10 % con cada dato)
int choqueP9 = -10000;                      // millis() del ultimo choque
int pausaHastaP9 = 0;                       // despues de chocar espera antes de volver a moverse
String textoCabezaP9 = "";
int inicioTextoCabezaP9 = -10000;
int sacudidaP9 = -10000;                    // la pantalla tiembla (error o choque)

// LAS MIGAS DEL RASTRO: likes y comentarios sueltos; cada 5 se ilumina la frase del dato que sigue (una pista)
int cantidadMigasP9 = 10;
int[] migaXP9 = new int[10];
int[] migaYP9 = new int[10];
int[] migaNaceP9 = new int[10];             // millis() en que aparece (si es mayor que ahora, todavia no salio)
boolean[] migaActivaP9 = new boolean[10];
int migasComidasP9 = 0;
int migasPistaP9 = 0;                       // migas juntadas para la proxima pista (de 0 a 5)
int pistaHastaP9 = 0;                       // hasta cuando se ve la pista (millis)
int inicioPistaP9 = -10000;

// LA CONSTELACION: donde se comio cada dato; se unen con lineas brillantes (asi se ve la cadena)
float[] comidoEnXP9 = new float[5];
float[] comidoEnYP9 = new float[5];
int ondaCuerpoP9 = -10000;                  // millis() en que comio un dato: una onda de luz recorre la serpiente

// LA CASA Y LA CADENA (ronda 2): el Desconocido camina por la cadena y hay que cortarla antes de que pase
int casaXP9 = 0;
int casaYP9 = 0;
int corteP9 = -1;                           // eslabon que se corto
int eslabonEncimaP9 = -1;
float desconocidoXP9 = 180;                 // donde va el Desconocido sobre la cadena (medidas de 1920)
float rapidezDesconocidoP9 = 125;           // pixeles por segundo
int ultimoCuadroP9 = 0;
int ultimoPasoSonidoP9 = 0;                 // millis() del ultimo paso que sono
int yaPasoP9 = -10000;                      // millis() del aviso "ya paso por ahi"
int vistosP9 = 0;                           // eslabones por los que ya paso (ya sabe esos datos)
int[] vistoEnP9 = new int[5];               // millis() en que paso por cada uno (destello rojo)
int cantidadRastroP9 = 12;                  // el tajo del mouse
float[] rastroXP9 = new float[12];
float[] rastroYP9 = new float[12];
int[] rastroTiempoP9 = new int[12];
int siguienteRastroP9 = 0;

// ESTADO DE LA PRUEBA
int faseP9 = -1;                            // -1 telon y guia, 1 serpiente, 2 llega a la casa, 3 la cadena, 4 cayendo, 5 cierre
int inicioFaseP9 = 0;
int erroresP9 = 0;                          // datos comidos fuera de orden
int choquesP9 = 0;
int motivoDerrotaP9 = 0;                    // 0 = tiempo, 2 = sin palitos, 3 = corte tarde
int puntosGanadosP9 = 0;
int inicioCierreP9 = 0;
boolean cierreGanoP9 = false;

// GUIA DE LA PRUEBA 9
String[] titulosGuiaP9 = {
  "Tu cordura",
  "El tiempo",
  "Exposición",
  "Tus puntos",
  "Eres el Desconocido",
  "Los datos",
  "La cadena",
  "Las migas",
  "A jugar"
};
String[] textosGuiaP9 = {
  "Estos palitos son tu cordura. Si cometes un error, pierdes uno. Si se acaban, pierdes la prueba.",
  "Lo que te queda para terminar. En los últimos 10 segundos la barra se pone roja.",
  "Cuánto de tu vida pueden ver los desconocidos. Sube sola mientras la sombra mira.",
  "Cada acierto suma puntos. Al final hay bonos por no equivocarte y por terminar rápido.",
  "Esta vez juegas del otro lado. Muévete con las flechas. Si chocas con un borde o contigo, pierdes 3 segundos.",
  "Cómete los datos en el orden en que un desconocido los va encontrando. Si te comes uno que no toca, pierdes un palito.",
  "Estas frases dicen cómo se llega de un dato al siguiente. Léelas para saber cuál va primero.",
  "Los corazoncitos y globitos son migas del rastro. Junta 5 y se enciende la frase del dato que va ahora.",
  "Sigue el rastro hasta la casa. Después tendrás que romper la cadena. Pulsa ENTER para empezar."
};
float[][] zonasGuiaP9 = {
  {20, 8, 330, 80},
  {690, 22, 540, 100},
  {1385, 8, 490, 78},
  {1580, 98, 310, 80},
  {230, 210, 1124, 710},
  {230, 210, 1124, 710},
  {1370, 180, 340, 740},
  {1370, 930, 340, 60},
  {960, 540, 0, 0}
};
int cantidadPasosGuiaP9 = 9;


// prepara la prueba (se llama al terminar el contexto)
void iniciarP9() {
  duracionPrueba = 70000;
  inicioPrueba = millis();
  palitos = 5;

  reiniciarSerpienteP9();
  intervaloP9 = 170;
  siguienteP9 = 0;
  for (int i = 0; i < cantidadElementosP9; i++) {
    comidoP9[i] = false;
    comidaXP9[i] = -10;
    comidaYP9[i] = -10;
    errorComidaP9[i] = -10000;
  }
  for (int i = 0; i < cantidadElementosP9; i++) {
    colocarComidaP9(i);
  }
  for (int slot = 0; slot < cantidadElementosP9; slot++) {
    panelYP9[ordenPanelP9[slot]] = 230 + slot * 138;
  }
  corteP9 = -1;
  eslabonEncimaP9 = -1;
  desconocidoXP9 = 180;
  vistosP9 = 0;
  for (int r = 0; r < cantidadRastroP9; r++) {
    rastroTiempoP9[r] = -10000;
  }
  migasComidasP9 = 0;
  migasPistaP9 = 0;
  pistaHastaP9 = 0;
  for (int m = 0; m < cantidadMigasP9; m++) {
    colocarMigaP9(m, 0);
  }
  faseP9 = -1;
  erroresP9 = 0;
  choquesP9 = 0;
  motivoDerrotaP9 = 0;
  textoCabezaP9 = "";
  mensajePrueba = "";
  ultimoCuadroP9 = millis();
  reiniciarEfectosA3();

  empezarAmbientePrueba();
  empezarTelon();
  empezarGuia(titulosGuiaP9, textosGuiaP9, zonasGuiaP9, cantidadPasosGuiaP9);
}


// la serpiente vuelve al inicio con 3 partes, mirando a la derecha
void reiniciarSerpienteP9() {
  largoP9 = 3;
  crecerP9 = 0;
  for (int s = 0; s < largoP9; s++) {
    cuerpoXP9[s] = 4 - s;
    cuerpoYP9[s] = 7;
    antesXP9[s] = cuerpoXP9[s];
    antesYP9[s] = cuerpoYP9[s];
  }
  dirXP9 = 1;
  dirYP9 = 0;
  cantidadColaP9 = 0;
  ultimoPasoP9 = millis();
}


// pone un dato en una casilla libre al azar, lejos de la cabeza (hasta 60 intentos)
void colocarComidaP9(int i) {
  for (int intento = 0; intento < 60; intento++) {
    int x = 1 + int(random(columnasP9 - 2));
    int y = 1 + int(random(filasP9 - 2));
    boolean libre = true;
    for (int s = 0; s < largoP9; s++) {
      if (cuerpoXP9[s] == x && cuerpoYP9[s] == y) {
        libre = false;
      }
    }
    for (int j = 0; j < cantidadElementosP9; j++) {
      if (j != i && !comidoP9[j] && dist(x, y, comidaXP9[j], comidaYP9[j]) < 3) {
        libre = false;
      }
    }
    if (y == 7 && x < 9) {
      libre = false;                        // la fila donde reaparece la serpiente queda libre
    }
    if (dist(x, y, cuerpoXP9[0], cuerpoYP9[0]) < 5 && intento < 50) {
      libre = false;
    }
    if (libre || intento == 59) {
      comidaXP9[i] = x;
      comidaYP9[i] = y;
      aparecioP9[i] = millis();
      return;
    }
  }
}


// pone una miga en una casilla libre (sale despues de "espera" ms)
void colocarMigaP9(int m, int espera) {
  for (int intento = 0; intento < 40; intento++) {
    int x = int(random(columnasP9));
    int y = int(random(filasP9));
    boolean libre = true;
    for (int s = 0; s < largoP9; s++) {
      if (cuerpoXP9[s] == x && cuerpoYP9[s] == y) {
        libre = false;
      }
    }
    for (int j = 0; j < cantidadElementosP9; j++) {
      if (!comidoP9[j] && comidaXP9[j] == x && comidaYP9[j] == y) {
        libre = false;
      }
    }
    if (libre || intento == 39) {
      migaXP9[m] = x;
      migaYP9[m] = y;
      migaNaceP9[m] = millis() + espera;
      migaActivaP9[m] = true;
      return;
    }
  }
}


// come una miga: chispita y llena el medidor de pista; con 5 se ilumina la frase del dato que sigue
void comerMigaP9(int m) {
  float x = casillaCentroXP9(migaXP9[m]);
  float y = casillaCentroYP9(migaYP9[m]);
  migasComidasP9++;
  migasPistaP9++;
  sonidosCargadosSample[17].trigger();
  lanzarChispasA3(x, y, 7, color(255, 150, 200), 260, 1);
  if (migasPistaP9 >= 5) {
    migasPistaP9 = 0;
    if (siguienteP9 < cantidadElementosP9) {
      pistaHastaP9 = millis() + 4500;
      inicioPistaP9 = millis();
      agregarImpacto("PISTA", 1540, 175, 64, doradoA3);
      lanzarChispasA3(1540, panelYP9[siguienteP9] + 60, 24, doradoA3, 600, 1);
      golpeA3(doradoA3);
      sonidosCargadosSample[53].trigger();
    }
  }
  colocarMigaP9(m, 900);
}


// centro de una casilla en medidas de 1920
float casillaCentroXP9(float c) {
  return tableroXP9 + c * casillaP9 + casillaP9 / 2;
}

float casillaCentroYP9(float f) {
  return tableroYP9 + f * casillaP9 + casillaP9 / 2;
}


// un paso de la serpiente: toma el giro pedido, avanza y revisa choques y datos
void pasoSerpienteP9() {
  if (cantidadColaP9 > 0) {
    int nuevaX = colaDirXP9[0];
    int nuevaY = colaDirYP9[0];
    // no puede dar media vuelta
    if (!(nuevaX == -dirXP9 && nuevaY == -dirYP9)) {
      dirXP9 = nuevaX;
      dirYP9 = nuevaY;
    }
    colaDirXP9[0] = colaDirXP9[1];
    colaDirYP9[0] = colaDirYP9[1];
    cantidadColaP9--;
  }
  int cabezaX = cuerpoXP9[0] + dirXP9;
  int cabezaY = cuerpoYP9[0] + dirYP9;
  boolean choca = cabezaX < 0 || cabezaY < 0 || cabezaX >= columnasP9 || cabezaY >= filasP9;
  // con su propio cuerpo (la punta de la cola se va a mover, por eso no cuenta)
  for (int s = 0; s < largoP9 - 1; s++) {
    if (cuerpoXP9[s] == cabezaX && cuerpoYP9[s] == cabezaY) {
      choca = true;
    }
  }
  if (choca) {
    chocarP9();
    return;
  }

  // guarda donde estaba cada parte y la mueve a la casilla de la anterior
  for (int s = 0; s < largoP9; s++) {
    antesXP9[s] = cuerpoXP9[s];
    antesYP9[s] = cuerpoYP9[s];
  }
  boolean crecio = false;
  if (crecerP9 > 0 && largoP9 < cantidadCuerpoP9) {
    largoP9++;
    crecerP9--;
    crecio = true;
  }
  for (int s = largoP9 - 1; s > 0; s--) {
    cuerpoXP9[s] = cuerpoXP9[s - 1];
    cuerpoYP9[s] = cuerpoYP9[s - 1];
  }
  if (crecio) {
    antesXP9[largoP9 - 1] = cuerpoXP9[largoP9 - 1];
    antesYP9[largoP9 - 1] = cuerpoYP9[largoP9 - 1];
  }
  cuerpoXP9[0] = cabezaX;
  cuerpoYP9[0] = cabezaY;

  for (int i = 0; i < cantidadElementosP9; i++) {
    if (!comidoP9[i] && comidaXP9[i] == cabezaX && comidaYP9[i] == cabezaY) {
      comerP9(i);
    }
  }
  for (int m = 0; m < cantidadMigasP9; m++) {
    if (migaActivaP9[m] && millis() > migaNaceP9[m] && migaXP9[m] == cabezaX && migaYP9[m] == cabezaY) {
      comerMigaP9(m);
    }
  }
}


// choca: vuelve al inicio con 3 partes y pierde 3 segundos (sin perder palitos)
void chocarP9() {
  choquesP9++;
  choqueP9 = millis();
  sacudidaP9 = millis();
  agregarFlotante("-3 s", casillaCentroXP9(cuerpoXP9[0]), casillaCentroYP9(cuerpoYP9[0]) - 40, rojoA3);
  // la serpiente se desarma en pedazos antes de volver al inicio
  for (int s = 0; s < largoP9; s++) {
    lanzarChispasA3(casillaCentroXP9(cuerpoXP9[s]), casillaCentroYP9(cuerpoYP9[s]), 3, rojoA3, 420, 0);
  }
  lanzarChispasA3(casillaCentroXP9(cuerpoXP9[0]), casillaCentroYP9(cuerpoYP9[0]), 10, color(255, 240, 200), 500, 1);
  golpeA3(rojoA3);
  reiniciarSerpienteP9();
  inicioPrueba -= 3000;
  pausaHastaP9 = millis() + 700;
  sonidosCargadosSample[48].trigger();
  mensajeP5("Te perdiste. Pierdes 3 segundos.", -1);
}


// come un dato: si es el que toca, crece 2 partes y va 10 % mas rapido; si no, error y el dato salta
void comerP9(int i) {
  float x = casillaCentroXP9(comidaXP9[i]);
  float y = casillaCentroYP9(comidaYP9[i]);
  if (i == siguienteP9) {
    comidoP9[i] = true;
    siguienteP9++;
    crecerP9 += 2;
    intervaloP9 = max(95, int(intervaloP9 * 0.9));
    textoCabezaP9 = elementoP9[i];
    inicioTextoCabezaP9 = millis();
    sonidosCargadosSample[19].trigger();
    sonidosCargadosSample[16].trigger();
    agregarMoneda(x, y);
    mostrarRachaCursor(siguienteP9);
    // queda marcado en la constelacion; estallido, golpe, una onda por el cuerpo y un congelado corto
    comidoEnXP9[i] = x;
    comidoEnYP9[i] = y;
    ondaCuerpoP9 = millis();
    pausaHastaP9 = millis() + 90;
    golpeA3(celesteA3);
    lanzarChispasA3(x, y, 26, celesteA3, 650, 1);
    lanzarChispasA3(x, y, 14, color(255), 500, 0);
    if (siguienteP9 == cantidadElementosP9) {
      // llego a la ubicacion: aparece la casa justo adelante
      faseP9 = 2;
      inicioFaseP9 = millis();
      casaXP9 = constrain(cuerpoXP9[0] + dirXP9 * 3, 1, columnasP9 - 2);
      casaYP9 = constrain(cuerpoYP9[0] + dirYP9 * 3, 1, filasP9 - 2);
      sonidosCargadosSample[40].trigger();
      sombraReacciona(2);
    }
  } else {
    perderPalito();
    erroresP9++;
    errorComidaP9[i] = millis();
    sacudidaP9 = millis();
    golpeA3(rojoA3);
    lanzarChispasA3(x, y, 16, rojoA3, 450, 0);
    sonidosCargadosSample[9].trigger();
    mensajeP5("Así no se llega. Qué se encuentra primero?", -1);
    colocarComidaP9(i);
  }
}


// 40 - ACTO III - PRUEBA 9 - LA CADENA
void dibujarCadenaP9() {
  float e = width / 1920.0;

  // FASES: al terminar el telon y la guia empieza (el reloj corre desde ahi)
  if (faseP9 == -1 && !telonActivo && !guiaActiva) {
    faseP9 = 1;
    inicioPrueba = millis();
    ultimoPasoP9 = millis() + 600;
    pausaHastaP9 = millis() + 600;
    mensajeP5("Eres el Desconocido. Sigue el rastro en orden.", 0);
    musicaA3(7);
  }
  if (faseP9 == -1) {
    inicioPrueba = millis();
  }

  // LOGICA
  if (faseP9 == 1) {
    if (millis() >= pausaHastaP9 && millis() - ultimoPasoP9 >= intervaloP9) {
      ultimoPasoP9 = millis();
      pasoSerpienteP9();
    }
    if (palitos <= 0) {
      perderP9(2);
    }
  }
  if (faseP9 == 2 && millis() - inicioFaseP9 > 2600) {
    faseP9 = 3;
    inicioFaseP9 = millis();
    desconocidoXP9 = 180;
    vistosP9 = 0;
    sonidosCargadosSample[5].trigger();
    mensajeP5("Ahora eres tú. Córtala antes de que llegue a tu casa.", 0);
    musicaA3(8);
  }
  float dt = constrain((millis() - ultimoCuadroP9) / 1000.0, 0, 0.05);
  ultimoCuadroP9 = millis();
  if (faseP9 == 3) {
    actualizarCadenaP9(dt);
  }
  if (faseP9 == 4 && corteP9 >= 0 && corteP9 < 5) {
    desconocidoXP9 = min(desconocidoXP9 + rapidezDesconocidoP9 * dt, eslabonXP9(corteP9) - 125);
  }
  if (faseP9 == 4 && millis() - inicioFaseP9 > 2600) {
    if (corteP9 <= 1) {
      ganarP9();
    } else {
      perderP9(3);
    }
  }
  if (faseP9 >= 1 && faseP9 <= 4) {
    gotearExposicionPrueba();
  }

  // las frases del panel se acomodan: primero las encontradas en orden, despues las que faltan (desordenadas)
  int lugar = 0;
  for (int i = 0; i < siguienteP9; i++) {
    panelYP9[i] = lerp(panelYP9[i], 230 + lugar * 138, 0.12);
    lugar++;
  }
  for (int slot = 0; slot < cantidadElementosP9; slot++) {
    int f = ordenPanelP9[slot];
    if (f >= siguienteP9) {
      panelYP9[f] = lerp(panelYP9[f], 230 + lugar * 138, 0.12);
      lugar++;
    }
  }

  // DIBUJO
  dibujarFondoActo3();
  pushMatrix();
  zoomGolpeA3(e);
  int pasadoSacudida = millis() - sacudidaP9;
  if (pasadoSacudida < 300) {
    float fuerza = 10 * (1 - pasadoSacudida / 300.0);
    translate(random(-fuerza, fuerza) * e, random(-fuerza, fuerza) * e);
  }
  if (faseP9 <= 2) {
    dibujarTableroP9(e);
    dibujarPanelP9(e);
    dibujarRutaP9(e);
  } else {
    dibujarEslabonesP9(e);
  }
  dibujarChispasA3(e);
  popMatrix();
  dibujarCortinas(1, 1, 0);
  dibujarBordesGolpeA3(e);

  cursor(ARROW);
  if (faseP9 == 3) {
    cursor(CROSS);
  }

  float tension = calcularTension();
  dibujarTension(tension);
  dibujarBarraSuperior(azulA3);
  int puntosVivos = siguienteP9 * 5;
  if (corteP9 == 0) {
    puntosVivos += 15;
  }
  if (corteP9 == 1) {
    puntosVivos += 10;
  }
  dibujarMarcador(puntosVivos);
  dibujarMonedas();
  dibujarFlotantes();
  dibujarImpacto();
  dibujarRachaCursor();
  dibujarMensajeP5(e);

  // cierre: un momento para ver el final y pasa a la pantalla de resultado
  if (faseP9 == 5 && millis() - inicioCierreP9 > 1500) {
    llenarResultadoP9(cierreGanoP9);
    empezarResultado(cierreGanoP9);
    if (cierreGanoP9) {
      pantalla = 42;
    } else {
      pantalla = 41;
    }
  }
}


// EL TABLERO: el mapa de conexiones con los datos y la serpiente
void dibujarTableroP9(float e) {
  float ancho = columnasP9 * casillaP9;
  float alto = filasP9 * casillaP9;
  noStroke();
  fill(0, 120);
  rect((tableroXP9 + 12) * e, (tableroYP9 + 14) * e, ancho * e, alto * e);
  fill(tintaA3);
  rect((tableroXP9 - 8) * e, (tableroYP9 - 8) * e, (ancho + 16) * e, (alto + 16) * e);
  fill(6, 12, 32);
  rect(tableroXP9 * e, tableroYP9 * e, ancho * e, alto * e);

  // lineas de la cuadricula muy tenues
  stroke(46, 107, 230, 40);
  strokeWeight(1);
  for (int c = 1; c < columnasP9; c++) {
    line((tableroXP9 + c * casillaP9) * e, tableroYP9 * e, (tableroXP9 + c * casillaP9) * e, (tableroYP9 + alto) * e);
  }
  for (int f = 1; f < filasP9; f++) {
    line(tableroXP9 * e, (tableroYP9 + f * casillaP9) * e, (tableroXP9 + ancho) * e, (tableroYP9 + f * casillaP9) * e);
  }
  // borde que brilla (rojo un momento al chocar)
  noFill();
  color colorBorde = celesteA3;
  if (millis() - choqueP9 < 500) {
    colorBorde = rojoA3;
  }
  stroke(colorBorde, 60 + 30 * sin(millis() * 0.004));
  strokeWeight(10 * e);
  rect(tableroXP9 * e, tableroYP9 * e, ancho * e, alto * e);
  stroke(colorBorde);
  strokeWeight(3 * e);
  rect(tableroXP9 * e, tableroYP9 * e, ancho * e, alto * e);
  noStroke();

  // LA CONSTELACION: lineas brillantes entre los datos ya encontrados (con una luz que viaja por ellas)
  for (int i = 0; i < siguienteP9; i++) {
    float ax = comidoEnXP9[i];
    float ay = comidoEnYP9[i];
    fill(celesteA3, 90 + 50 * sin(millis() * 0.006 + i));
    ellipse(ax * e, ay * e, 44 * e, 44 * e);
    fill(255);
    ellipse(ax * e, ay * e, 16 * e, 16 * e);
    if (i + 1 < siguienteP9) {
      float bx = comidoEnXP9[i + 1];
      float by = comidoEnYP9[i + 1];
      stroke(celesteA3, 70);
      strokeWeight(14 * e);
      line(ax * e, ay * e, bx * e, by * e);
      stroke(220, 245, 255, 200);
      strokeWeight(4 * e);
      line(ax * e, ay * e, bx * e, by * e);
      noStroke();
      float viaja = ((millis() * 0.0012) + i * 0.3) % 1;
      fill(255);
      ellipse(lerp(ax, bx, viaja) * e, lerp(ay, by, viaja) * e, 12 * e, 12 * e);
    }
  }

  // LAS MIGAS: corazoncitos y globitos que laten (salen creciendo)
  for (int m = 0; m < cantidadMigasP9; m++) {
    if (migaActivaP9[m] && millis() > migaNaceP9[m]) {
      float mx = casillaCentroXP9(migaXP9[m]);
      float my = casillaCentroYP9(migaYP9[m]);
      float crece = reboteTelon((millis() - migaNaceP9[m]) / 300.0) * (1 + 0.15 * sin(millis() * 0.008 + m));
      fill(255, 150, 200, 50);
      ellipse(mx * e, my * e, 34 * crece * e, 34 * crece * e);
      fill(255, 150, 200);
      if (m % 2 == 0) {
        ellipse((mx - 4 * crece) * e, (my - 2 * crece) * e, 10 * crece * e, 10 * crece * e);
        ellipse((mx + 4 * crece) * e, (my - 2 * crece) * e, 10 * crece * e, 10 * crece * e);
        triangle((mx - 9 * crece) * e, my * e, (mx + 9 * crece) * e, my * e, mx * e, (my + 9 * crece) * e);
      } else {
        fill(255, 220, 120);
        ellipse(mx * e, my * e, 14 * crece * e, 12 * crece * e);
        triangle((mx - 2 * crece) * e, (my + 4 * crece) * e, (mx + 4 * crece) * e, (my + 4 * crece) * e, (mx - 5 * crece) * e, (my + 10 * crece) * e);
      }
    }
  }

  for (int i = 0; i < cantidadElementosP9; i++) {
    if (!comidoP9[i]) {
      dibujarComidaP9(i, e);
    }
  }

  // la casa al final del rastro (con una linea punteada desde la cabeza)
  if (faseP9 == 2) {
    float pasado = millis() - inicioFaseP9;
    float cx = casillaCentroXP9(casaXP9);
    float cy = casillaCentroYP9(casaYP9);
    float crece = reboteTelon(pasado / 500.0);
    float hx = casillaCentroXP9(cuerpoXP9[0]);
    float hy = casillaCentroYP9(cuerpoYP9[0]);
    stroke(doradoA3, 180);
    strokeWeight(4 * e);
    for (int k = 0; k < 10; k += 2) {
      line(lerp(hx, cx, k / 10.0) * e, lerp(hy, cy, k / 10.0) * e, lerp(hx, cx, (k + 1) / 10.0) * e, lerp(hy, cy, (k + 1) / 10.0) * e);
    }
    noStroke();
    fill(doradoA3, 60 + 40 * sin(millis() * 0.01));
    ellipse(cx * e, cy * e, 150 * crece * e, 150 * crece * e);
    image(imagenesCargadas[150], (cx - 60 * crece) * e, (cy - 47 * crece) * e, 120 * crece * e, 95 * crece * e);

    // el texto grande en el centro
    float entra = reboteTelon((pasado - 400) / 500.0);
    if (pasado > 400) {
      pushMatrix();
      translate(792 * e, 840 * e);
      scale(0.5 + 0.5 * entra);
      fill(0, 190);
      rect(-440 * e, -60 * e, 880 * e, 120 * e);
      fill(doradoA3);
      rect(-440 * e, -60 * e, 880 * e, 6 * e);
      fill(255);
      textFont(fuente);
      textAlign(CENTER, CENTER);
      textSize(56 * e);
      text("Así de fácil te encontró.", 0, -4 * e);
      popMatrix();
    }
  }

  dibujarSerpienteP9(e);

  // el nombre del dato sube sobre la cabeza al comerlo
  int pasadoTexto = millis() - inicioTextoCabezaP9;
  if (pasadoTexto < 1000) {
    float hx = casillaCentroXP9(cuerpoXP9[0]);
    float hy = casillaCentroYP9(cuerpoYP9[0]);
    float sube = pasadoTexto * 0.05;
    float crece = reboteTelon(pasadoTexto / 250.0);
    pushMatrix();
    translate(hx * e, (hy - 50 - sube) * e);
    scale(0.5 + 0.5 * crece);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(40 * e);
    fill(0, 200 * (1 - pasadoTexto / 1000.0));
    text(textoCabezaP9, 3 * e, 3 * e);
    fill(celesteA3, 255 * (1 - pasadoTexto / 1000.0));
    text(textoCabezaP9, 0, 0);
    popMatrix();
  }
}


// UN DATO DEL TABLERO: una ficha con su icono y su nombre (no dice en que lugar va)
void dibujarComidaP9(int i, float e) {
  float cx = casillaCentroXP9(comidaXP9[i]);
  float cy = casillaCentroYP9(comidaYP9[i]) + sin(millis() * 0.004 + i * 1.3) * 3;
  float crece = reboteTelon((millis() - aparecioP9[i]) / 400.0);
  int pasadoError = millis() - errorComidaP9[i];
  if (pasadoError < 400) {
    cx += sin(millis() * 0.08) * 6;
  }
  pushMatrix();
  translate(cx * e, cy * e);
  scale(crece);
  noStroke();
  fill(celesteA3, 35 + 20 * sin(millis() * 0.005 + i));
  ellipse(0, 0, 76 * e, 76 * e);
  fill(tintaA3);
  rect(-25 * e, -25 * e, 50 * e, 50 * e);
  fill(232, 238, 252);
  if (pasadoError < 400) {
    fill(255, 140, 140);
  }
  rect(-21 * e, -21 * e, 42 * e, 42 * e);
  popMatrix();
  dibujarIconoA3(iconoElementoP9[i], cx, cy, 30 * crece, azulA3);

  // nombre debajo en una etiqueta oscura
  textFont(fuenteTexto);
  textSize(19 * e);
  float anchoNombre = textWidth(elementoP9[i]) / e + 16;
  fill(0, 170);
  rect((cx - anchoNombre / 2) * e, (cy + 30) * e, anchoNombre * e, 26 * e);
  fill(220, 232, 255);
  textAlign(CENTER, CENTER);
  text(elementoP9[i], cx * e, (cy + 41) * e);
}


// LA SERPIENTE: el cuerpo son eslabones oscuros con borde rojo; la cabeza es la capucha del Desconocido
void dibujarSerpienteP9(float e) {
  // despues de chocar parpadea
  if (millis() < pausaHastaP9 && millis() - choqueP9 < 700 && millis() % 160 < 80) {
    return;
  }
  float avance = constrain((millis() - ultimoPasoP9) / (float) intervaloP9, 0, 1);
  if (faseP9 != 1 || millis() < pausaHastaP9) {
    avance = 1;
  }
  noStroke();
  // la onda de luz: despues de comer un dato, recorre el cuerpo de la cabeza a la cola
  float ondaPos = (millis() - ondaCuerpoP9) / 35.0;
  for (int s = largoP9 - 1; s >= 1; s--) {
    float x = casillaCentroXP9(lerp(antesXP9[s], cuerpoXP9[s], avance));
    float y = casillaCentroYP9(lerp(antesYP9[s], cuerpoYP9[s], avance));
    float tam = 38 - s * 0.4;
    float luz = 0;
    if (ondaPos - s > 0 && ondaPos - s < 3) {
      luz = 1 - (ondaPos - s) / 3.0;
      tam += 10 * luz;
    }
    fill(tintaA3);
    ellipse(x * e, y * e, (tam + 8) * e, (tam + 8) * e);
    fill(lerpColor(rojoA3, celesteA3, luz));
    ellipse(x * e, y * e, tam * e, tam * e);
    fill(lerpColor(color(24, 12, 26), color(255), luz * 0.8));
    ellipse(x * e, y * e, (tam - 10) * e, (tam - 10) * e);
  }

  // cabeza (con un brillo detras que deja estela)
  float hx = casillaCentroXP9(lerp(antesXP9[0], cuerpoXP9[0], avance));
  float hy = casillaCentroYP9(lerp(antesYP9[0], cuerpoYP9[0], avance));
  fill(rojoA3, 40);
  ellipse((hx - dirXP9 * 18) * e, (hy - dirYP9 * 18) * e, 90 * e, 90 * e);
  fill(rojoA3, 50 + 30 * sin(millis() * 0.01));
  ellipse(hx * e, hy * e, 74 * e, 74 * e);
  // la cabeza (imagen que mira a la derecha) gira hacia donde va
  pushMatrix();
  translate(hx * e, hy * e);
  rotate(atan2(dirYP9, dirXP9));
  image(imagenesCargadas[155], -29 * e, -28 * e, 60 * e, 58 * e);
  popMatrix();

  // el perfil vacio con "?" que flota encima (el Desconocido no tiene cara)
  float flota = sin(millis() * 0.004) * 4;
  fill(tintaA3);
  ellipse(hx * e, (hy - 52 + flota) * e, 36 * e, 36 * e);
  fill(150, 155, 170);
  ellipse(hx * e, (hy - 52 + flota) * e, 30 * e, 30 * e);
  fill(255);
  textFont(fuenteTexto);
  textAlign(CENTER, CENTER);
  textSize(24 * e);
  text("?", hx * e, (hy - 55 + flota) * e);
}


// EL PANEL: las 5 frases que explican como se llega de un dato al otro
void dibujarPanelP9(float e) {
  fill(255);
  textFont(fuenteTexto);
  textAlign(CENTER, CENTER);
  textSize(30 * e);
  text("Cómo te encontró", 1540 * e, 195 * e);

  for (int i = 0; i < cantidadElementosP9; i++) {
    float y = panelYP9[i];
    boolean encontrada = i < siguienteP9;
    // la pista: la frase del dato que sigue se enciende en dorado (con las migas)
    boolean pista = i == siguienteP9 && millis() < pistaHastaP9;
    color tono = color(120, 130, 160);
    if (encontrada) {
      tono = celesteA3;
    }
    if (pista) {
      tono = doradoA3;
    }
    noStroke();
    if (pista) {
      float salto = reboteTelon((millis() - inicioPistaP9) / 400.0);
      fill(doradoA3, (70 + 50 * sin(millis() * 0.012)) * salto);
      rect(1362 * e, (y - 18) * e, 356 * e, 162 * e);
    }
    fill(tintaA3);
    rect(1374 * e, (y - 6) * e, 332 * e, 138 * e);
    fill(12, 20, 46);
    if (encontrada) {
      fill(20, 48, 100);
    }
    if (pista) {
      fill(70, 54, 14);
    }
    rect(1380 * e, y * e, 320 * e, 126 * e);

    // numero (solo si ya se encontro) o un "?"
    fill(tono);
    ellipse(1412 * e, (y + 30) * e, 38 * e, 38 * e);
    fill(tintaA3);
    textAlign(CENTER, CENTER);
    textSize(24 * e);
    if (encontrada) {
      text(i + 1, 1412 * e, (y + 27) * e);
      dibujarIconoA3(iconoElementoP9[i], 1456, y + 30, 30, tono);
      fill(tono);
      textAlign(LEFT, CENTER);
      textSize(25 * e);
      text(elementoP9[i], 1480 * e, (y + 27) * e);
    } else {
      text("?", 1412 * e, (y + 27) * e);
      if (pista) {
        fill(doradoA3);
        textAlign(LEFT, CENTER);
        textSize(25 * e);
        text("Este va ahora", 1442 * e, (y + 27) * e);
      }
    }
    fill(235, 240, 255);
    if (!encontrada && !pista) {
      fill(175, 185, 210);
    }
    textAlign(LEFT, TOP);
    textSize(21 * e);
    text(fraseP9[i], 1396 * e, (y + 56) * e, 296 * e, 70 * e);
  }

  // el medidor de migas: 5 casillas; al llenarse sale la pista
  textFont(fuenteTexto);
  textAlign(LEFT, CENTER);
  textSize(24 * e);
  fill(255, 190, 220);
  text("Pista", 1380 * e, 958 * e);
  for (int k = 0; k < 5; k++) {
    float cx = 1470 + k * 46;
    fill(tintaA3);
    ellipse(cx * e, 960 * e, 34 * e, 34 * e);
    fill(40, 30, 50);
    if (k < migasPistaP9) {
      fill(255, 150, 200);
    }
    ellipse(cx * e, 960 * e, 26 * e, 26 * e);
  }
}


// LA RUTA: debajo del tablero, el camino recorrido con flechas dibujadas
void dibujarRutaP9(float e) {
  textFont(fuenteTexto);
  textAlign(LEFT, CENTER);
  textSize(28 * e);
  fill(255);
  text("Ruta", 240 * e, 970 * e);
  float x = 320;
  for (int i = 0; i < siguienteP9; i++) {
    fill(celesteA3);
    text(elementoP9[i], x * e, 970 * e);
    x += textWidth(elementoP9[i]) / e + 14;
    stroke(celesteA3);
    strokeWeight(3 * e);
    line(x * e, 972 * e, (x + 30) * e, 972 * e);
    line((x + 30) * e, 972 * e, (x + 20) * e, 963 * e);
    line((x + 30) * e, 972 * e, (x + 20) * e, 981 * e);
    noStroke();
    x += 44;
  }
  if (siguienteP9 < cantidadElementosP9) {
    fill(doradoA3, 150 + 100 * sin(millis() * 0.008));
    text("?", x * e, 970 * e);
  } else {
    fill(doradoA3);
    text("Tu casa", x * e, 970 * e);
  }
}


// posicion de cada eslabon de la ronda 2 (medidas de 1920); la cadena se mece apenas
float eslabonXP9(int i) {
  return 330 + i * 230;
}

float eslabonYP9(int i) {
  return 600 + sin(millis() * 0.003 + i * 0.9) * 10;
}


// RONDA 2: el Desconocido camina por la cadena hacia tu casa; un tajo con el mouse corta un eslabon que tenga adelante
void actualizarCadenaP9(float dt) {
  float e = width / 1920.0;
  int pasado = millis() - inicioFaseP9;
  if (pasado > 1600) {
    desconocidoXP9 += rapidezDesconocidoP9 * dt;
    // un paso cada medio segundo (el sonido del Desconocido acercandose)
    if (millis() - ultimoPasoSonidoP9 > 520) {
      ultimoPasoSonidoP9 = millis();
      sonidosCargadosSample[50].trigger();
    }
  }
  // cada eslabon que pasa queda en rojo: ya sabe ese dato
  if (vistosP9 < cantidadElementosP9 && desconocidoXP9 > eslabonXP9(vistosP9)) {
    vistoEnP9[vistosP9] = millis();
    lanzarChispasA3(eslabonXP9(vistosP9), eslabonYP9(vistosP9), 10, rojoA3, 350, 0);
    sonidosCargadosSample[20].trigger();
    vistosP9++;
  }
  // llego a tu casa sin que cortaras
  if (desconocidoXP9 >= 1400) {
    corteP9 = 5;
    faseP9 = 4;
    inicioFaseP9 = millis();
    sonidosCargadosSample[40].trigger();
    golpeA3(rojoA3);
    sacudidaP9 = millis();
    agregarImpacto("LLEGÓ A TU CASA", 960, 800, 80, color(255, 110, 110));
    sombraReacciona(2);
    mensajeP5("Muy tarde: ya sabía todo de ti.", -1);
    return;
  }
  // el tajo: con el mouse apretado y moviendose
  if (mousePressed) {
    float ax = pmouseX / e;
    float ay = pmouseY / e;
    float bx = mouseX / e;
    float by = mouseY / e;
    if (dist(ax, ay, bx, by) > 6) {
      rastroXP9[siguienteRastroP9] = bx;
      rastroYP9[siguienteRastroP9] = by;
      rastroTiempoP9[siguienteRastroP9] = millis();
      siguienteRastroP9 = (siguienteRastroP9 + 1) % cantidadRastroP9;
      for (int i = 0; i < cantidadElementosP9; i++) {
        if (distSegmentoA3(eslabonXP9(i), eslabonYP9(i), ax, ay, bx, by) < 75) {
          if (eslabonXP9(i) > desconocidoXP9 + 40) {
            cortarEslabonP9(i);
            return;
          }
          if (millis() - yaPasoP9 > 900) {
            yaPasoP9 = millis();
            agregarFlotante("Ya pasó por aquí", eslabonXP9(i), eslabonYP9(i) - 100, color(255, 140, 140));
            sonidosCargadosSample[9].trigger();
          }
        }
      }
    }
  }
}


// corta el eslabon i: los que siguen se caen y el Desconocido se queda sin camino
void cortarEslabonP9(int i) {
  corteP9 = i;
  faseP9 = 4;
  inicioFaseP9 = millis();
  sacudidaP9 = millis();
  sonidosCargadosSample[51].trigger();
  sonidosCargadosSample[46].trigger();
  sonidosCargadosSample[44].trigger();
  lanzarChispasA3(eslabonXP9(i), eslabonYP9(i), 30, color(255, 240, 200), 750, 1);
  lanzarChispasA3(eslabonXP9(i), eslabonYP9(i), 16, color(200, 210, 230), 600, 0);
  if (i == 0) {
    golpeA3(celesteA3);
    mensajeP5("Cadena rota desde el principio. Nadie llega a tu casa.", 1);
    agregarImpacto("CORTADA", 960, 800, 90, celesteA3);
  }
  if (i == 1) {
    golpeA3(celesteA3);
    mensajeP5("Bien, pero la publicación ya era pública.", 0);
    agregarImpacto("CORTADA", 960, 800, 90, celesteA3);
  }
  if (i >= 2) {
    golpeA3(rojoA3);
    mensajeP5("Muy tarde: ya sabía mucho de ti.", -1);
    agregarImpacto("DEMASIADO TARDE", 960, 800, 70, color(255, 110, 110));
    sombraReacciona(2);
  }
}


// RONDA 2: la cadena que se mece, el Desconocido caminando encima, la casa al final y el tajo
void dibujarEslabonesP9(float e) {
  int pasado = millis() - inicioFaseP9;
  float entra = reboteTelon(pasado / 700.0);

  fill(255);
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(46 * e);
  text("Córtala antes de que llegue", 960 * e, 270 * e);
  textFont(fuenteTexto);
  textSize(28 * e);
  fill(200, 220, 255);
  text("Pasa el mouse apretado por un eslabón. Cuanto antes, menos sabe de ti.", 960 * e, 330 * e);

  // despues del corte, los eslabones que siguen caen con aceleracion y giran
  float tiempoCaida = 0;
  if (faseP9 >= 4 && corteP9 >= 0 && corteP9 < 5) {
    tiempoCaida = millis() - inicioFaseP9;
  }
  float caida = 0.0004 * tiempoCaida * tiempoCaida;

  // las uniones entre eslabones (y hasta la casa)
  for (int i = 0; i < cantidadElementosP9; i++) {
    boolean cae = corteP9 >= 0 && corteP9 < 5 && i >= corteP9;
    if (!cae) {
      float x = lerp(eslabonXP9(i) - 1200, eslabonXP9(i), entra);
      float xSiguiente = lerp(eslabonXP9(i) + 230 - 1200, eslabonXP9(i) + 230, entra);
      float ySiguiente = 600;
      if (i < 4) {
        ySiguiente = eslabonYP9(i + 1);
      }
      if (i == 4) {
        xSiguiente = lerp(1480 - 1200, 1480, entra);
      }
      noFill();
      stroke(tintaA3);
      strokeWeight(22 * e);
      ellipse(((x + xSiguiente) / 2) * e, ((eslabonYP9(i) + ySiguiente) / 2) * e, 80 * e, 36 * e);
      stroke(170, 180, 200);
      strokeWeight(10 * e);
      ellipse(((x + xSiguiente) / 2) * e, ((eslabonYP9(i) + ySiguiente) / 2) * e, 80 * e, 36 * e);
      noStroke();
    }
  }

  // el eslabon que se puede cortar y esta cerca del mouse se ilumina
  int cerca = -1;
  if (faseP9 == 3) {
    for (int i = 0; i < cantidadElementosP9; i++) {
      if (eslabonXP9(i) > desconocidoXP9 + 40 && dist(mouseX / e, mouseY / e, eslabonXP9(i), eslabonYP9(i)) < 110) {
        cerca = i;
      }
    }
  }

  for (int i = 0; i < cantidadElementosP9; i++) {
    float x = lerp(eslabonXP9(i) - 1200, eslabonXP9(i), entra);
    float y = eslabonYP9(i);
    float giro = 0;
    color colorEslabon = color(190, 200, 220);
    if (i < vistosP9) {
      colorEslabon = color(170, 60, 70);
    }
    // destello rojo al pasar el Desconocido
    int pasadoVisto = millis() - vistoEnP9[i];
    if (i < vistosP9 && pasadoVisto < 400) {
      colorEslabon = lerpColor(color(170, 60, 70), color(255, 120, 120), 1 - pasadoVisto / 400.0);
    }
    if (i == cerca) {
      colorEslabon = celesteA3;
      y -= 6;
    }
    if (corteP9 >= 0 && corteP9 < 5 && i > corteP9) {
      y += caida;
      giro = tiempoCaida * 0.002 * (1 + i % 2);
    }
    if (i == corteP9) {
      colorEslabon = color(255, 240, 200);
    }
    pushMatrix();
    translate(x * e, y * e);
    rotate(giro);
    noFill();
    if (i == corteP9) {
      // el eslabon cortado se parte en dos mitades que se separan y caen
      float separa = min(tiempoCaida * 0.05, 60);
      stroke(tintaA3);
      strokeWeight(30 * e);
      arc(-separa * e, caida * 0.6 * e, 200 * e, 120 * e, HALF_PI + 0.3, PI + HALF_PI - 0.3);
      arc(separa * e, caida * e, 200 * e, 120 * e, -HALF_PI + 0.3, HALF_PI - 0.3);
      stroke(colorEslabon);
      strokeWeight(16 * e);
      arc(-separa * e, caida * 0.6 * e, 200 * e, 120 * e, HALF_PI + 0.3, PI + HALF_PI - 0.3);
      arc(separa * e, caida * e, 200 * e, 120 * e, -HALF_PI + 0.3, HALF_PI - 0.3);
    } else {
      if (i == cerca) {
        stroke(celesteA3, 70 + 40 * sin(millis() * 0.012));
        strokeWeight(44 * e);
        ellipse(0, 0, 200 * e, 120 * e);
      }
      stroke(tintaA3);
      strokeWeight(30 * e);
      ellipse(0, 0, 200 * e, 120 * e);
      stroke(colorEslabon);
      strokeWeight(16 * e);
      ellipse(0, 0, 200 * e, 120 * e);
      stroke(255, 120);
      strokeWeight(4 * e);
      arc(0, 0, 186 * e, 106 * e, PI + 0.4, PI + 1.4);
    }
    noStroke();
    popMatrix();
    if (i != corteP9) {
      dibujarIconoA3(iconoElementoP9[i], x, y - 4, 50, colorEslabon);
      fill(colorEslabon);
      textFont(fuenteTexto);
      textAlign(CENTER, CENTER);
      textSize(27 * e);
      text(elementoP9[i], x * e, (y + 96) * e);
    }
  }

  // la casa al final: protegida (luz celeste) si se corto a tiempo; roja si llego
  float casaX = lerp(1480 - 1200, 1480, entra);
  color colorCasa = doradoA3;
  if (faseP9 >= 4 && corteP9 <= 1) {
    colorCasa = celesteA3;
    float escudo = reboteTelon((millis() - inicioFaseP9 - 500) / 500.0);
    fill(celesteA3, 50 * escudo);
    ellipse(casaX * e, 602 * e, 280 * escudo * e, 280 * escudo * e);
  }
  // la casa (imagen); si el Desconocido llego, late en rojo
  if (faseP9 >= 4 && corteP9 >= 5) {
    colorCasa = rojoA3;
    tint(255, 130 + 40 * sin(millis() * 0.02), 130 + 40 * sin(millis() * 0.02));
  }
  image(imagenesCargadas[150], (casaX - 115) * e, 512 * e, 230 * e, 181 * e);
  noTint();
  fill(colorCasa);
  textAlign(CENTER, CENTER);
  textSize(27 * e);
  text("Tu casa", casaX * e, 730 * e);

  dibujarDesconocidoCadenaP9(e);
  dibujarTajoP9(e);
}


// EL DESCONOCIDO caminando sobre la cadena: capucha, ojos blancos y el perfil vacio con "?" encima
void dibujarDesconocidoCadenaP9(float e) {
  float x = desconocidoXP9;
  boolean camina = faseP9 == 3 && millis() - inicioFaseP9 > 1600;
  // despues del corte camina hasta el hueco y se queda sin camino
  boolean varado = faseP9 >= 4 && corteP9 >= 0 && corteP9 < 5;
  float salto = 0;
  float paso = 0;
  if (camina) {
    salto = sq(sin(millis() * 0.012)) * 8;
    paso = sin(millis() * 0.012) * 14;
  }
  float tiembla = 0;
  if (varado) {
    tiembla = sin(millis() * 0.06) * 4;
  }
  float desvanece = 1;
  if (varado) {
    desvanece = 1 - constrain((millis() - inicioFaseP9 - 1600) / 900.0, 0, 1);
  }
  float y = 600 - 70 - salto;
  pushMatrix();
  translate((x + tiembla) * e, y * e);
  fill(0, 90 * desvanece);
  ellipse(0, 74 * e, 90 * e, 20 * e);
  // el cuerpo (imagenes): quieto, dos pasos que se alternan al caminar, o con los brazos abiertos al quedar varado
  // (los pies quedan en y 74)
  tint(255, 255 * desvanece);
  if (varado) {
    image(imagenesCargadas[153], -53.1 * e, -106.2 * e, 106.2 * e, 180.2 * e);
  }
  if (camina && paso >= 0) {
    image(imagenesCargadas[151], -36.4 * e, -85.4 * e, 72.9 * e, 159.4 * e);
  }
  if (camina && paso < 0) {
    image(imagenesCargadas[152], -38.4 * e, -96.3 * e, 76.7 * e, 170.3 * e);
  }
  if (!varado && !camina) {
    image(imagenesCargadas[154], -41 * e, -106 * e, 82 * e, 180 * e);
  }
  noTint();
  // el perfil vacio que flota encima; al quedar varado, un "?" grande
  float flota = sin(millis() * 0.004) * 4;
  fill(tintaA3, 255 * desvanece);
  ellipse(0, (-128 + flota) * e, 44 * e, 44 * e);
  fill(150, 155, 170, 255 * desvanece);
  ellipse(0, (-128 + flota) * e, 36 * e, 36 * e);
  fill(255, 255 * desvanece);
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(30 * e);
  text("?", 0, (-132 + flota) * e);
  float creceDuda = reboteTelon((millis() - inicioFaseP9 - 500) / 400.0);
  if (varado && creceDuda > 0.05) {
    float crece = creceDuda;
    textSize(80 * crece * e);
    fill(255, 220, 120, 255 * desvanece);
    text("?", 60 * e, -150 * e);
  }
  popMatrix();
}


// EL TAJO: una estela blanca y celeste por donde paso el mouse apretado (dura 0,18 s)
void dibujarTajoP9(float e) {
  for (int k = 1; k < cantidadRastroP9; k++) {
    int actual = (siguienteRastroP9 - k + cantidadRastroP9) % cantidadRastroP9;
    int anterior = (actual - 1 + cantidadRastroP9) % cantidadRastroP9;
    int edad = millis() - rastroTiempoP9[actual];
    int edadAnterior = millis() - rastroTiempoP9[anterior];
    if (edad < 180 && edadAnterior < 180) {
      float fuerza = 1 - edad / 180.0;
      stroke(celesteA3, 140 * fuerza);
      strokeWeight(26 * fuerza * e);
      line(rastroXP9[anterior] * e, rastroYP9[anterior] * e, rastroXP9[actual] * e, rastroYP9[actual] * e);
      stroke(255, 255 * fuerza);
      strokeWeight(10 * fuerza * e);
      line(rastroXP9[anterior] * e, rastroYP9[anterior] * e, rastroXP9[actual] * e, rastroYP9[actual] * e);
    }
  }
  noStroke();
  strokeWeight(1);
}


// clic: en la ronda 2 se corta con el tajo (mouse apretado), asi que el clic no hace nada
void clicP9() {
}


// teclas: flechas o WASD (se guardan hasta 2 giros para que se sienta rapido)
void teclaP9() {
  if (faseP9 != 1) {
    return;
  }
  int nuevaX = 0;
  int nuevaY = 0;
  if (keyCode == UP || key == 'w' || key == 'W') {
    nuevaY = -1;
  }
  if (keyCode == DOWN || key == 's' || key == 'S') {
    nuevaY = 1;
  }
  if (keyCode == LEFT || key == 'a' || key == 'A') {
    nuevaX = -1;
  }
  if (keyCode == RIGHT || key == 'd' || key == 'D') {
    nuevaX = 1;
  }
  // si es la misma direccion que ya lleva (o que ya pidio), no se guarda: asi mantener la tecla no llena la cola
  int ultimaX = dirXP9;
  int ultimaY = dirYP9;
  if (cantidadColaP9 > 0) {
    ultimaX = colaDirXP9[cantidadColaP9 - 1];
    ultimaY = colaDirYP9[cantidadColaP9 - 1];
  }
  if (nuevaX == ultimaX && nuevaY == ultimaY) {
    return;
  }
  if ((nuevaX != 0 || nuevaY != 0) && cantidadColaP9 < 2) {
    colaDirXP9[cantidadColaP9] = nuevaX;
    colaDirYP9[cantidadColaP9] = nuevaY;
    cantidadColaP9++;
  }
}


// gana (corto en la publicacion o en la etiqueta): rastro (5 x 5 = 25) + sin errores (10) + corte (15 o 10) = 50
void ganarP9() {
  if (faseP9 == 5) {
    return;
  }
  int puntosRastro = siguienteP9 * 5;
  int puntosSinErrores = 0;
  if (erroresP9 == 0 && choquesP9 == 0) {
    puntosSinErrores = 10;
  }
  int puntosCorte = 10;
  if (corteP9 == 0) {
    puntosCorte = 15;
  }

  lineaTexto[0] = "Rastro seguido";
  lineaPuntos[0] = puntosRastro;
  lineaTexto[1] = "Sin errores ni choques";
  lineaPuntos[1] = puntosSinErrores;
  lineaTexto[2] = "Corte de la cadena";
  lineaPuntos[2] = puntosCorte;
  cantidadLineas = 3;

  puntosGanadosP9 = puntosRastro + puntosSinErrores + puntosCorte;
  puntosJugador += puntosGanadosP9;
  subirExposicion(-5);
  resultadoActo3[1] = 1;
  if (corteP9 == 0) {
    ganarLogro(9);
  }
  revisarLogrosActos();
  if (pruebasCompletadasActo3 == 1) {
    pruebasCompletadasActo3 = 2;
  }
  empezarCierreP9(true);
}


// pierde: 0 = tiempo, 2 = sin palitos, 3 = corto tarde; se filtra su direccion
void perderP9(int motivo) {
  if (faseP9 == 5) {
    return;
  }
  motivoDerrotaP9 = motivo;
  lineaTexto[0] = "Rastro seguido";
  lineaPuntos[0] = siguienteP9 * 5;
  cantidadLineas = 1;
  if (motivo != 3) {
    lineaPuntos[0] = siguienteP9 * 2;
  }
  puntosGanadosP9 = lineaPuntos[0];
  puntosJugador += puntosGanadosP9;
  if (motivo == 3) {
    subirExposicion(5);                     // cortar tarde: +15 % en total (con el dato filtrado)
  }
  resultadoActo3[1] = 2;
  if (pruebasCompletadasActo3 == 1) {
    pruebasCompletadasActo3 = 2;
  }
  filtrarDato(10);
  empezarCierreP9(false);
}


// el tiempo se acabo (lo llama el contador): en la cadena cuenta como cortar tarde
void tiempoAgotadoP9() {
  if (faseP9 == 3) {
    corteP9 = 4;
    perderP9(3);
  } else {
    perderP9(0);
  }
}


void empezarCierreP9(boolean gano) {
  faseP9 = 5;
  cierreGanoP9 = gano;
  inicioCierreP9 = millis();
  cursor(ARROW);
  if (!gano && motivoDerrotaP9 != 3) {
    agregarImpacto("TE ENCONTRÓ", 960, 540, 80, color(255, 110, 110));
    sombraReacciona(2);
  }
}


// textos de la pantalla de resultado
void llenarResultadoP9(boolean gano) {
  tituloResultado = "Se acabó el tiempo";
  subtituloResultado = "El rastro llegó hasta tu puerta.";
  if (motivoDerrotaP9 == 2) {
    tituloResultado = "Te quedaste sin palitos";
  }
  if (motivoDerrotaP9 == 3) {
    tituloResultado = "Cortaste muy tarde";
    subtituloResultado = "Cuando rompiste la cadena, ya sabía mucho de ti.";
  }
  selloIlustracion = "COMPLETA";
  if (gano) {
    tituloResultado = "Prueba superada";
    subtituloResultado = "Cadena rota desde el principio. Nadie llega a tu casa.";
    if (corteP9 == 1) {
      subtituloResultado = "Cadena rota a tiempo, aunque la publicación ya era pública.";
    }
    selloIlustracion = "CORTADA";
  }
  explicacionIlustracion = "Cada dato que publicas\nes un eslabón.";
  fraseVidaReal = "A un desconocido no le hace falta tu dirección: le basta con unir una publicación, una etiqueta, tu perfil y una foto.";
  consejoVidaReal = "No hace falta esconderlo todo: corta la cadena temprano, con publicaciones para amigos y etiquetas con revisión.";
  datoResultado = 10;
  ilustracionResultado = 9;
  puntosResultado = puntosGanadosP9;
}


// la ilustracion del resultado: tres eslabones con el primero cortado y una tijera (alrededor de 0, 0)
void dibujarIlustracionResultadoP9() {
  float e = width / 1920.0;
  noFill();
  for (int i = 0; i < 3; i++) {
    float x = -110 + i * 110;
    float y = -40 + i * 50;
    stroke(tintaA3);
    strokeWeight(26 * e);
    ellipse(x * e, y * e, 150 * e, 90 * e);
    stroke(190, 200, 220);
    if (i == 0) {
      stroke(rojoA3);
    }
    strokeWeight(14 * e);
    ellipse(x * e, y * e, 150 * e, 90 * e);
  }
  dibujarIconoA3(ICONO_TIJERA, -60, -120, 110, color(235, 240, 250));
  noStroke();
}


// 41 - ACTO III - PRUEBA 9 - PRUEBA PERDIDA
void dibujarPerdidaP9() {
  dibujarResultado(false);
}


// 42 - ACTO III - PRUEBA 9 - PRUEBA SUPERADA
void dibujarSuperadaP9() {
  dibujarResultado(true);
}
