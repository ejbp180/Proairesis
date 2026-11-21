// PRUEBA 4 - LA FOTOGRAFIA QUE NO EXISTE: "EL PASILLO" (pantallas 21, 22 y 23)
// la sombra te persigue por el pasillo siguiendo tus publicaciones con ubicacion. Recoge las 3 pruebas
// (el 17 del espejo, la placa de tu puerta y la foto de tu cuarto), esquiva sus cartas y llega al final;
// alli unes las pruebas en un tablero de corcho. Se pierde si la sombra te alcanza, sin tiempo o sin palitos

// ESTILO COMIC: todos los contornos van en tinta (cafe muy oscuro, como en las imagenes del juego)
color tintaP4 = color(28, 22, 54);

// EL PASILLO (medidas de 1920; las x son del pasillo completo, que mide 5400)
float largoPasilloP4 = 5400;
float pisoP4 = 900;                    // y del piso (donde pisa el jugador)
float finPasilloP4 = 5250;             // al pasar de aqui con las 3 pruebas empieza el tablero
float camaraP4 = 0;                    // x del pasillo que queda en el borde izquierdo de la pantalla

// EL JUGADOR
float jugadorXP4 = 650;
float jugadorYP4 = 900;
float velYP4 = 0;
boolean enSueloP4 = true;
int mirandoP4 = 1;                     // 1 = mira a la derecha, -1 = a la izquierda
boolean izquierdaP4 = false;           // flechas apretadas (tambien en: teclado)
boolean derechaP4 = false;
float pasoP4 = 0;                      // avance de la animacion de correr
int aturdidoHastaP4 = 0;               // millis() hasta el que queda aturdido por una carta
// TIEMPO POR CUADRO: todo se mueve segun el tiempo que paso (si el juego va lento, igual avanza a la misma velocidad real)
float dtP4 = 1;                        // 1 = un cuadro normal (60 por segundo); 2 = paso el doble de tiempo
int ultimoCuadroP4 = 0;                // millis() del cuadro anterior

// LA SOMBRA
float sombraXP4 = 60;
float velSombraP4 = 4.9;               // pixeles por cuadro (baja un 5 % con cada pin borrado)
int inicioLanzaP4 = -10000;            // millis() de la ultima carta lanzada (el brazo se estira)
int ultimoLatidoP4 = 0;                // latido que se acelera cuando la sombra esta cerca

// PUERTAS
float[] puertaXP4 = {1650, 2175, 2700, 3450, 4125, 4575, 5025};
int[] numeroPuertaP4 = {12, 14, 15, 17, 19, 21, 23};
int cantidadPuertasP4 = 7;
int[] inicioPuertaP4 = new int[7];     // millis() en que se abrio (la puerta se abre y se cierra)
int dentroPuertaP4 = -1;               // puerta equivocada en la que entro (-1 = ninguna): cuarto vacio 1 s
int inicioDentroP4 = 0;

// PINES DE UBICACION (fotos publicadas con ubicacion, colgadas en la pared)
float[] pinXP4 = {880, 1425, 1950, 2475, 3075, 3900};
float[] pinYP4 = {760, 680, 610, 700, 610, 760};   // altura a la que flota cada pin (los altos hay que saltarlos)
boolean[] pinBorradoP4 = new boolean[6];
int[] inicioPinP4 = new int[6];
int cantidadPinesP4 = 6;
int pinesBorradosP4 = 0;

// VUELTAS: el pasillo se repite 3 veces; en cada vuelta hay una sola prueba
// (vuelta 1 el espejo, vuelta 2 la puerta 17 con los numeros cambiados, vuelta 3 la foto de tu cuarto en el apagon)
int vueltaP4 = 1;
int repeticionesP4 = 0;
boolean avisoPasoP4 = false;

// PUERTAS DE VECINOS: a veces, al acercarte, sale luz por debajo de una puerta y despues se abre de golpe
// hacia el pasillo y te cierra el paso un momento (si estas justo delante, te golpea)
int[] inicioVecinoP4 = new int[7];       // millis() en que empezo el aviso de luz (-10000 = nada)
boolean[] vecinoUsadoP4 = new boolean[7];  // ya se decidio si esa puerta se abre en esta vuelta
float[] probVecinoP4 = {0.10, 0.15, 0.20}; // probabilidad en cada vuelta

// ENTRADA: el jugador mira hacia atras, la primera lampara revienta y aparece la sombra
boolean lamparaRotaP4 = false;
boolean sonoRevientaP4 = false;

// FINAL: la foto que la sombra te tomo desde el techo aparece en el tablero
boolean sonoFotoP4 = false;
boolean sonoSelloFotoP4 = false;

// AL PERDER: la mano de la sombra te agarra
boolean agarroP4 = false;

// PASOS DE LA SOMBRA (suenan mas fuerte y seguido cuanto mas cerca esta)
int ultimoPasoSombraP4 = 0;           // ya dijo "Esa era la 17" en esta vuelta

// GLOBO: lo que piensa el jugador sale encima de su cabeza (ahi es donde mira quien juega)
String globoP4 = "";
int inicioGloboP4 = -10000;                // veces que llego al final sin la prueba (la vuelta se repite y la sombra se acerca)
int inicioVueltaP4 = -10000;           // millis() en que empezo la vuelta (la pantalla sale del negro)
float[] lugaresFotoP4 = {1350, 1912, 2437, 3200, 4350, 4800};   // donde puede aparecer la foto en la vuelta 3 (en lugar de un cuadro)
int cantidadLugaresFotoP4 = 6;
float[] velSombraVueltaP4 = {5.2, 5.7, 6.3};                   // la sombra es mas rapida en cada vuelta (el jugador corre a 7,5)
boolean rafagaP4 = false;               // la proxima carta sale enseguida (dos seguidas)
boolean ultimaAltaP4 = false;           // la ultima carta fue alta

// LAS 3 PRUEBAS: 0 = el 17 reflejado (espejo), 1 = la placa 17, 2 = la foto de la habitacion
float[] fragmentoXP4 = {1050, 3450, 3690};    // donde se recoge
float[] fragmentoYP4 = {525, 528, 518};       // centro del objeto (desde ahi vuela al indicador)
float[] camaraFotoXP4 = {900, 3300, 3825};    // camara del techo desde donde la sombra tomo cada foto
boolean[] fragmentoP4 = new boolean[3];
int[] inicioFragmentoP4 = new int[3];
float[] origenVueloXP4 = new float[3];        // x en pantalla donde se recogio
int fragmentosP4 = 0;
int inicioFlashP4 = -10000;
int camaraFlashP4 = 0;

// CARTAS DE AMOR (las lanza la sombra; bajas = saltar, altas = quedarse en el piso)
float[] cartaXP4 = new float[10];
float[] cartaYP4 = new float[10];
boolean[] cartaActivaP4 = new boolean[10];
int cantidadCartasP4 = 10;
int siguienteCartaP4 = 0;
int ultimaCartaP4 = 0;
int golpesP4 = 0;
boolean[] cartaContadaP4 = new boolean[10];   // ya conto como esquivada
boolean[] cartaPorPocoP4 = new boolean[10];   // la saltaste rozandola

// ESQUIVAS (dan puntos y racha)
int esquivasP4 = 0;                    // cartas esquivadas en total (1 punto cada una, hasta 6)
int rachaP4 = 0;                       // esquivas seguidas sin que te golpeen
int inicioRachaP4 = -10000;            // millis() de la ultima esquiva (el cartel de racha salta)

// CAJAS en el piso: hay que saltarlas; encima de ellas las cartas bajas no te alcanzan
float[] cajaXP4 = {1300, 1900, 2450, 3000, 3950, 4350, 4800};
int cantidadCajasP4 = 7;
float altoCajaP4 = 70;

// CUADROS de la pared: retratos cuyos ojos te siguen
float[] cuadroXP4 = {300, 1350, 1912, 2437, 3200, 4350, 4800};
int cantidadCuadrosP4 = 7;

// MOVIMIENTO DEL JUGADOR (para que se sienta)
boolean corriendoP4 = false;
int pasoContadoP4 = 0;                 // ultimo paso que sono
int inicioSaltoP4 = -10000;            // se estira al saltar
int inicioAterrizaP4 = -10000;         // se aplasta al caer

// PARTICULAS (polvo, chispas, corazones): posicion en el pasillo, velocidad, vida, tamano y color
float[] partXP4 = new float[60];
float[] partYP4 = new float[60];
float[] partVXP4 = new float[60];
float[] partVYP4 = new float[60];
int[] partInicioP4 = new int[60];
int[] partVidaP4 = new int[60];
float[] partTamP4 = new float[60];
color[] partColorP4 = new color[60];
int cantidadPartP4 = 60;
int siguientePartP4 = 0;

// GRITO Y APAGON
int inicioGritoP4 = -10000;            // al recoger una prueba la sombra grita y acelera 1,8 s
boolean apagadoP4 = false;             // en el tramo final se apagan las luces
int inicioApagonP4 = -10000;
float luzP4 = 1;                       // brillo de las lamparas (baja con el apagon)
// la oscuridad del apagon es una imagen: negra con un circulo transparente de borde suave
// (se dibuja una sola vez; dibujarla con figuras en cada cuadro era muy lento)
PImage oscuridadP4;
int ladoOscuridadP4 = 1000;            // lado de la imagen (medidas de 1920)
float radioLuzP4 = 380;                // radio del circulo de luz

// ESTADO
int faseP4 = -1;     // -1 telon y guia, 0 la sombra aparece (1,6 s), 1 correr, 2 tablero, 3 cierre al perder, 4 el telon cae al ganar
int inicioFaseP4 = 0;
int inicioSacudidaP4 = -10000;
int inicioBloqueoP4 = -10000;          // llego al final sin las 3 pruebas (aviso)
boolean sonoCorreP4 = false;
int segundosSobrantesP4 = 0;           // segundos que quedaban al llegar al final

// TABLERO DE CORCHO
float[] tableroXP4 = new float[3];               // centro actual de cada pieza
float[] tableroYP4 = new float[3];
float[] origenTableroXP4 = {1290, 690, 990};     // abajo y desordenadas
float origenTableroYP4 = 960;
float[] siluetaXP4 = {630, 960, 1290};
float siluetaYP4 = 450;
boolean[] encajadoP4 = new boolean[3];
int[] inicioEncajeP4 = new int[3];
int[] inicioRebotaP4 = new int[3];
int arrastrandoP4 = -1;                          // pieza que se arrastra (-1 = ninguna)
float agarreXP4 = 0;                             // donde se agarro la pieza respecto a su centro
float agarreYP4 = 0;
int inicioTableroP4 = 0;
int inicioFraseP4 = -1;                          // millis() en que encajaron las tres (-1 = todavia no)

int motivoDerrotaP4 = 0;               // 0 = tiempo, 1 = la sombra te alcanzo, 2 = sin palitos
int puntosGanadosP4 = 0;
int inicioCierreP4 = 0;

// GUIA DE LA PRUEBA 4
String[] titulosGuiaP4 = {
  "Tu cordura",
  "El tiempo",
  "Exposición",
  "Tus puntos",
  "Tú",
  "La sombra",
  "Las cartas",
  "Las pruebas",
  "Los pines",
  "A jugar"
};
String[] textosGuiaP4 = {
  "Estos palitos son tu cordura. Cada carta que te golpea te quita uno. Si se acaban, pierdes la prueba.",
  "Lo que te queda para salir del pasillo. Entrar por una puerta equivocada te quita 5 segundos.",
  "Cuánto de tu vida pueden ver los desconocidos. Sube sola mientras la sombra te sigue.",
  "Cada prueba suma 10 puntos y cada carta que esquivas suma 1, hasta 6. Si llegas al final con tiempo de sobra, ganas hasta 4 más.",
  "Corres con las flechas izquierda y derecha, saltas con la de arriba y recoges o entras por una puerta con la de abajo. Las cajas hay que saltarlas.",
  "Te sigue usando tus publicaciones con ubicación. Si te alcanza, pierdes. Cada vez que recoges una prueba, grita y acelera.",
  "La sombra te lanza cartas. Las bajas se saltan y con las altas quédate en el piso. Encima de una caja, las bajas no te alcanzan.",
  "El pasillo se repite 3 veces y en cada vuelta hay una prueba: un 17 en un espejo, la placa de tu puerta y una foto de tu cuarto. Los números de las puertas cambian.",
  "Son fotos que publicaste con tu ubicación. Su pin flota en el pasillo: tócalo, corriendo o saltando, y la sombra irá más lento.",
  "Recoge las 3 pruebas y llega al final del pasillo antes de que la sombra te alcance. Pulsa ENTER para empezar."
};
float[][] zonasGuiaP4 = {
  {20, 8, 330, 80},        // plato de zanahorias
  {690, 22, 540, 100},     // contador
  {1385, 8, 490, 78},      // exposicion
  {1580, 98, 310, 80},     // marcador
  {570, 715, 160, 205},    // el jugador
  {0, 660, 170, 260},      // la sombra
  {40, 670, 600, 250},     // por donde vuelan las cartas
  {45, 100, 280, 100},     // indicador de las pruebas
  {800, 250, 160, 560},    // el primer pin (la foto y su pin flotando)
  {960, 540, 0, 0}         // sin zona: recuadro en el centro
};
int cantidadPasosGuiaP4 = 10;


// prepara la prueba (se llama al terminar el contexto)
void iniciarP4() {
  duracionPrueba = 70000;
  inicioPrueba = millis();
  palitos = 5;

  jugadorXP4 = 650;
  jugadorYP4 = pisoP4;
  velYP4 = 0;
  enSueloP4 = true;
  mirandoP4 = 1;
  izquierdaP4 = false;
  derechaP4 = false;
  pasoP4 = 0;
  aturdidoHastaP4 = 0;
  camaraP4 = 0;

  sombraXP4 = 60;
  velSombraP4 = 4.9;
  ultimoCuadroP4 = millis();
  esquivasP4 = 0;
  rachaP4 = 0;
  inicioRachaP4 = -10000;
  corriendoP4 = false;
  pasoContadoP4 = 0;
  inicioSaltoP4 = -10000;
  inicioAterrizaP4 = -10000;
  for (int k = 0; k < cantidadPartP4; k++) {
    partInicioP4[k] = -10000;
    partVidaP4[k] = 1;
  }
  inicioGritoP4 = -10000;
  apagadoP4 = false;
  inicioApagonP4 = -10000;
  luzP4 = 1;

  prepararTramaComic();   // la trama de puntos tambien se arma ahora (mientras se abre el telon)

  // la imagen de la oscuridad se arma una sola vez: cada pixel es negro y su transparencia depende
  // de que tan lejos esta del centro (adentro del circulo se ve, en el borde se va oscureciendo)
  if (oscuridadP4 == null) {
    int lado = int(ladoOscuridadP4 * width / 1920.0);
    float radio = radioLuzP4 * width / 1920.0;
    float suave = 140 * width / 1920.0;
    oscuridadP4 = createImage(lado, lado, ARGB);
    oscuridadP4.loadPixels();
    for (int fila = 0; fila < lado; fila++) {
      for (int columna = 0; columna < lado; columna++) {
        float distancia = dist(columna, fila, lado / 2, lado / 2);
        float opacidad = constrain(map(distancia, radio - suave, radio, 0, 240), 0, 240);
        oscuridadP4.pixels[fila * lado + columna] = color(0, opacidad);
      }
    }
    oscuridadP4.updatePixels();
  }
  inicioLanzaP4 = -10000;
  ultimoLatidoP4 = 0;

  for (int d = 0; d < cantidadPuertasP4; d++) {
    inicioPuertaP4[d] = -10000;
  }
  dentroPuertaP4 = -1;
  for (int p = 0; p < cantidadPinesP4; p++) {
    pinBorradoP4[p] = false;
    inicioPinP4[p] = -10000;
  }
  pinesBorradosP4 = 0;
  for (int f = 0; f < 3; f++) {
    fragmentoP4[f] = false;
    inicioFragmentoP4[f] = -10000;
    tableroXP4[f] = origenTableroXP4[f];
    tableroYP4[f] = origenTableroYP4;
    encajadoP4[f] = false;
    inicioEncajeP4[f] = -10000;
    inicioRebotaP4[f] = -10000;
  }
  fragmentosP4 = 0;
  inicioFlashP4 = -10000;
  for (int c = 0; c < cantidadCartasP4; c++) {
    cartaActivaP4[c] = false;
  }
  siguienteCartaP4 = 0;
  ultimaCartaP4 = 0;
  golpesP4 = 0;

  vueltaP4 = 1;
  repeticionesP4 = 0;
  avisoPasoP4 = false;
  for (int d = 0; d < cantidadPuertasP4; d++) {
    inicioVecinoP4[d] = -10000;
    vecinoUsadoP4[d] = false;
  }
  lamparaRotaP4 = false;
  sonoRevientaP4 = false;
  sonoFotoP4 = false;
  sonoSelloFotoP4 = false;
  agarroP4 = false;
  ultimoPasoSombraP4 = 0;
  // zumbido de tension: arranca en silencio y sube en las vueltas 2 y 3
  sonidosCargadosAmbiente[4].rewind();
  sonidosCargadosAmbiente[4].loop();
  sonidosCargadosAmbiente[4].setGain(-60);
  inicioGloboP4 = -10000;
  inicioVueltaP4 = -10000;
  velSombraP4 = velSombraVueltaP4[0];
  rafagaP4 = false;
  barajarPuertasP4();                // los numeros de las puertas cambian en cada partida
  fragmentoXP4[2] = lugaresFotoP4[0];
  fragmentoYP4[2] = 470;

  faseP4 = -1;
  inicioSacudidaP4 = -10000;
  inicioBloqueoP4 = -10000;
  sonoCorreP4 = false;
  arrastrandoP4 = -1;
  inicioFraseP4 = -1;
  mensajePrueba = "";

  empezarAmbientePrueba();
  empezarTelonCompleto();   // el pasillo ocupa toda la pantalla: el telon sale del todo
  empezarGuia(titulosGuiaP4, textosGuiaP4, zonasGuiaP4, cantidadPasosGuiaP4);
}


// 21 - ACTO I - PRUEBA 4 - EL PASILLO
void dibujarPasilloP4() {
  float e = width / 1920.0;

  // cuanto tiempo paso desde el cuadro anterior, medido en "cuadros normales" (entre 0,5 y 3)
  dtP4 = constrain((millis() - ultimoCuadroP4) / 16.67, 0.5, 3);
  ultimoCuadroP4 = millis();

  // FASES: al terminar el telon y la guia empieza la entrada (2,4 s) y despues se corre (el reloj corre desde ahi)
  // entrada: 0,3 s el jugador mira hacia atras y se pregunta que fue eso; 0,9 s la primera lampara revienta;
  // 1 s la sombra sube desde la oscuridad y grita; 1,8 s "CORRE" y el jugador se da vuelta
  if (faseP4 == -1 && !telonActivo && !guiaActiva) {
    faseP4 = 0;
    inicioFaseP4 = millis();
  }
  if (faseP4 <= 0) {
    inicioPrueba = millis();
  }
  int pasadoEntrada = millis() - inicioFaseP4;
  if (faseP4 == 0 && pasadoEntrada >= 300 && pasadoEntrada < 1800) {
    mirandoP4 = -1;
    if (millis() - inicioGloboP4 > 3000) {
      mostrarGloboP4("Qué fue eso?");
    }
  }
  if (faseP4 == 0 && !sonoRevientaP4 && pasadoEntrada >= 900) {
    sonoRevientaP4 = true;
    lamparaRotaP4 = true;
    sonidosCargadosSample[41].trigger();   // la lampara revienta
    sonidosCargadosSample[18].trigger();   // respiracion de la sombra
    for (int chispa = 0; chispa < 20; chispa++) {
      agregarParticulaP4(300 + random(-20, 20), 137, random(-4, 4), random(-2, 4), 900, random(5, 10), color(255, 220, 140));
    }
  }
  if (faseP4 == 0 && pasadoEntrada >= 1100 && inicioGritoP4 < inicioFaseP4) {
    inicioGritoP4 = millis();
    sonidosCargadosSample[40].trigger();   // grito
  }
  if (faseP4 == 0 && !sonoCorreP4 && pasadoEntrada >= 1800) {
    sonoCorreP4 = true;
    mirandoP4 = 1;
    agregarImpacto("CORRE", 960, 470, 130, color(255, 70, 70));
    sonidosCargadosSample[20].trigger();
  }
  if (faseP4 == 0 && pasadoEntrada >= 2400) {
    faseP4 = 1;
    inicioPrueba = millis();
    ultimaCartaP4 = millis();
  }

  if (faseP4 == 1) {
    moverP4();
  }

  // la camara sigue al jugador (suave) y se adelanta hacia donde corre, sin salirse del pasillo
  float metaCamara = jugadorXP4 - 960 + mirandoP4 * 260;
  camaraP4 = lerp(camaraP4, constrain(metaCamara, 0, largoPasilloP4 - 1920), 0.08);

  // las luces: con el apagon parpadean 0,6 s y quedan casi apagadas
  float metaLuz = 1;
  if (apagadoP4) {
    metaLuz = 0.12;
    if (millis() - inicioApagonP4 < 600) {
      metaLuz = random(0, 1);
    }
  }
  luzP4 = lerp(luzP4, metaLuz, 0.2);

  // la pantalla se sacude cuando te golpea una carta (0,3 s) o cuando la sombra grita (0,4 s)
  pushMatrix();
  if (millis() - inicioSacudidaP4 < 300) {
    translate(random(-8, 8) * e, random(-8, 8) * e);
  }
  if (millis() - inicioGritoP4 < 400) {
    translate(random(-6, 6) * e, random(-6, 6) * e);
  }

  dibujarFondoPasilloP4(e);
  dibujarObjetosP4(e);
  dibujarSombraP4(e);
  dibujarCartasP4(e);
  dibujarParticulasP4(e);
  dibujarJugadorP4(e);
  dibujarHojasVecinoP4(e);
  dibujarOscuridadP4(e);
  dibujarObjetivoEnPasilloP4(e);
  dibujarAyudaAccionP4(e);
  dibujarGloboP4(e);
  dibujarRachaP4(e);
  dibujarFlashP4(e);
  popMatrix();

  // trama de puntos en los bordes (estilo comic)
  dibujarTramaComic(color(22, 16, 56), 70);

  dibujarCuartoVacioP4(e);

  // vuelta nueva: la pantalla sale del negro
  int pasadoVuelta = millis() - inicioVueltaP4;
  if (pasadoVuelta < 900) {
    noStroke();
    fill(10, 8, 22, 255 * (1 - pasadoVuelta / 900.0));
    rect(0, 0, width, height);
  }

  if (faseP4 == 1) {
    gotearExposicionPrueba();
  dibujarPeligroP4(e);
    dibujarTension(calcularTension());
  }
  if (faseP4 >= 0 && faseP4 <= 1) {
  dibujarMinimapaP4(e);
  }

  // TABLERO (y el telon que cae al ganar)
  if (faseP4 == 2 || faseP4 == 4) {
    dibujarTableroP4(e);
  }
  if (faseP4 == 4) {
    float cierra = suaveTelon((millis() - inicioCierreP4) / 1000.0);
    dibujarCortinas(1 - cierra, 1 - suaveTelon((millis() - inicioCierreP4 - 120) / 1000.0), 0);
    if (millis() - inicioCierreP4 > 1400) {
      ganarP4();
    }
  }

  // CIERRE AL PERDER: la oscuridad se traga el pasillo
  if (faseP4 == 3) {
    dibujarCierreP4(e);
  }

  // barra de arriba, indicador de pruebas, puntos y mensajes
  dibujarBarraSuperior(color(200, 30, 50));
  dibujarIndicadorP4(e);
  dibujarMarcador(fragmentosP4 * 10 + min(esquivasP4, 6));
  dibujarMonedas();
  dibujarFlotantes();
  dibujarImpacto();
  dibujarMensajePrueba();
}


// JUGADOR, SOMBRA Y CARTAS (solo mientras se corre)
void moverP4() {
  // cuarto vacio de una puerta equivocada: el jugador espera 1 s adentro (la sombra no espera)
  if (dentroPuertaP4 >= 0 && millis() - inicioDentroP4 >= 1000) {
    dentroPuertaP4 = -1;
    sonidosCargadosSample[1].trigger();   // puerta que se cierra
  }

  boolean aturdido = millis() < aturdidoHastaP4;
  float velocidad = 7.5 * dtP4;
  if (aturdido) {
    velocidad = 3 * dtP4;
  }

  boolean corriendo = false;
  float xAntes = jugadorXP4;
  if (dentroPuertaP4 < 0) {
    if (izquierdaP4 && !derechaP4) {
      jugadorXP4 -= velocidad;
      mirandoP4 = -1;
      corriendo = true;
    }
    if (derechaP4 && !izquierdaP4) {
      jugadorXP4 += velocidad;
      mirandoP4 = 1;
      corriendo = true;
    }
  }
  jugadorXP4 = constrain(jugadorXP4, 40, largoPasilloP4 - 60);

  // CAJAS de lado: si estas mas abajo que la tapa, la caja te frena (hay que saltarla)
  for (int k = 0; k < cantidadCajasP4; k++) {
    float bordeIzquierdo = cajaXP4[k] - 58;
    float bordeDerecho = cajaXP4[k] + 58;
    if (jugadorYP4 > pisoP4 - altoCajaP4 + 2 && jugadorXP4 > bordeIzquierdo && jugadorXP4 < bordeDerecho) {
      if (xAntes <= bordeIzquierdo) {
        jugadorXP4 = bordeIzquierdo;
      }
      if (xAntes >= bordeDerecho) {
        jugadorXP4 = bordeDerecho;
      }
    }
  }

  // PINES: se borran tocandolos, corriendo o saltando a traves de ellos; la sombra va un 5 % mas lento
  for (int p = 0; p < cantidadPinesP4; p++) {
    float pinY = pinYP4[p] + sin(millis() * 0.004 + p) * 12;
    boolean tocaX = jugadorXP4 - pinXP4[p] < 44 && pinXP4[p] - jugadorXP4 < 44;
    boolean tocaY = pinY > jugadorYP4 - 180 && pinY < jugadorYP4 + 10;
    if (!pinBorradoP4[p] && dentroPuertaP4 < 0 && tocaX && tocaY) {
      pinBorradoP4[p] = true;
      inicioPinP4[p] = millis();
      pinesBorradosP4++;
      velSombraP4 = velSombraP4 * 0.95;
      mostrarGloboP4("Ubicación borrada!");
      agregarFlotante("-5 %", pinXP4[p] - camaraP4, pinY - 70, color(127, 212, 255));
      sonidosCargadosSample[10].trigger();
      sonidosCargadosSample[39].trigger();
      for (int chispa = 0; chispa < 18; chispa++) {
        float anguloChispa = random(TWO_PI);
        float fuerzaChispa = random(3, 9);
        agregarParticulaP4(pinXP4[p], pinY, cos(anguloChispa) * fuerzaChispa, sin(anguloChispa) * fuerzaChispa - 2, 700, random(7, 13), color(255, 70, 80));
      }
      for (int chispa = 0; chispa < 10; chispa++) {
        agregarParticulaP4(pinXP4[p] + random(-50, 50), 330 + random(-50, 50), random(-2, 2), random(-4, -1), 700, random(6, 11), color(127, 212, 255));
      }
    }
  }

  // PUERTAS DE VECINOS: al acercarte (entre 300 y 380 px antes), a veces una se va a abrir
  for (int d = 0; d < cantidadPuertasP4; d++) {
    float falta = puertaXP4[d] - jugadorXP4;
    if (!vecinoUsadoP4[d] && numeroPuertaP4[d] != 17 && falta > 300 && falta < 380) {
      vecinoUsadoP4[d] = true;
      if (random(1) < probVecinoP4[vueltaP4 - 1]) {
        inicioVecinoP4[d] = millis();
      }
    }
    int pasadoVecino = millis() - inicioVecinoP4[d];
    if (pasadoVecino >= 550 && pasadoVecino - int(dtP4 * 17) - 1 < 550) {
      sonidosCargadosSample[0].trigger();   // se abre de golpe
    }
    if (pasadoVecino >= 1700 && pasadoVecino - int(dtP4 * 17) - 1 < 1700) {
      sonidosCargadosSample[1].trigger();   // se cierra
    }
    // abierta, la hoja sale hacia el pasillo (de x + 80 a x + 170) y no deja pasar
    if (pasadoVecino >= 550 && pasadoVecino < 1700) {
      float hojaIzquierda = puertaXP4[d] + 80 - 20;
      float hojaDerecha = puertaXP4[d] + 170 + 20;
      if (jugadorXP4 > hojaIzquierda && jugadorXP4 < hojaDerecha) {
        if (xAntes <= hojaIzquierda) {
          jugadorXP4 = hojaIzquierda;
        } else {
          if (xAntes >= hojaDerecha) {
            jugadorXP4 = hojaDerecha;
          } else {
            // estaba justo delante cuando se abrio: la puerta lo golpea y lo empuja hacia atras
            jugadorXP4 = hojaIzquierda - 10;
            if (millis() > aturdidoHastaP4) {
              aturdidoHastaP4 = millis() + 600;
              inicioSacudidaP4 = millis();
              mostrarGloboP4("Auch! Un vecino!");
              sonidosCargadosSample[28].trigger();
            }
          }
        }
      }
    }
  }

  // PASOS DE LA SOMBRA: mas fuertes y seguidos cuanto mas cerca esta
  float distanciaSombra = jugadorXP4 - sombraXP4;
  if (distanciaSombra < 900) {
    int intervaloPaso = int(constrain(map(distanciaSombra, 900, 150, 950, 300), 300, 950));
    if (millis() - ultimoPasoSombraP4 >= intervaloPaso) {
      ultimoPasoSombraP4 = millis();
      sonidosCargadosSample[42].setGain(volumenEfectos + constrain(map(distanciaSombra, 900, 150, -20, 0), -20, 0));
      sonidosCargadosSample[42].trigger();
    }
  }

  // si pasa de largo por la 17 en la vuelta 2, el jugador se da cuenta (todavia puede devolverse)
  if (vueltaP4 == 2 && !fragmentoP4[1] && !avisoPasoP4 && jugadorXP4 > fragmentoXP4[1] + 200) {
    avisoPasoP4 = true;
    mostrarGloboP4("Espera... esa era la 17!");
    sonidosCargadosSample[12].trigger();
  }

  // EL FINAL DEL PASILLO: el pasillo vuelve a empezar. Con la prueba de esta vuelta pasas a la siguiente;
  // sin ella, se repite la MISMA vuelta (asi la prueba nunca queda detras de la sombra). En la vuelta 3,
  // con las 3 pruebas, empieza el tablero
  if (jugadorXP4 > finPasilloP4) {
    if (!fragmentoP4[vueltaP4 - 1]) {
      empezarVueltaP4(vueltaP4);
    } else {
      if (vueltaP4 < 3) {
        empezarVueltaP4(vueltaP4 + 1);
      } else {
        empezarTableroP4();
      }
    }
  }

  // salto: la gravedad lo baja hasta el piso o hasta la tapa de una caja
  boolean estabaEnSuelo = enSueloP4;
  float yAntes = jugadorYP4;
  velYP4 += 1.35 * dtP4;
  jugadorYP4 += velYP4 * dtP4;
  enSueloP4 = false;
  if (jugadorYP4 >= pisoP4) {
    jugadorYP4 = pisoP4;
    velYP4 = 0;
    enSueloP4 = true;
  }
  float tapaCaja = pisoP4 - altoCajaP4;
  for (int k = 0; k < cantidadCajasP4; k++) {
    if (velYP4 >= 0 && yAntes <= tapaCaja + 0.5 && jugadorYP4 >= tapaCaja && jugadorXP4 > cajaXP4[k] - 58 && jugadorXP4 < cajaXP4[k] + 58) {
      jugadorYP4 = tapaCaja;
      velYP4 = 0;
      enSueloP4 = true;
    }
  }

  // al caer: se aplasta, suena y levanta polvo
  if (enSueloP4 && !estabaEnSuelo) {
    inicioAterrizaP4 = millis();
    sonidosCargadosSample[35].trigger();
    for (int polvo = 0; polvo < 6; polvo++) {
      agregarParticulaP4(jugadorXP4, jugadorYP4 - 4, random(-3, 3), random(-2.5, -0.5), 450, random(10, 20), color(160, 140, 130, 170));
    }
  }

  // piernas: se mueven al correr; en cada paso suena y sale polvo de los pies
  corriendoP4 = corriendo;
  if (corriendo && enSueloP4) {
    pasoP4 += 0.3 * dtP4;
    int pasoAhora = floor(pasoP4 / PI);
    if (pasoAhora != pasoContadoP4) {
      pasoContadoP4 = pasoAhora;
      sonidosCargadosSample[33].trigger();
      for (int polvo = 0; polvo < 2; polvo++) {
        agregarParticulaP4(jugadorXP4 - mirandoP4 * 14, jugadorYP4 - 4, -mirandoP4 * random(1, 2.5), random(-2.5, -1), 400, random(10, 18), color(150, 130, 120, 150));
      }
    }
  }
  if (!corriendo) {
    pasoP4 = lerp(pasoP4, round(pasoP4 / PI) * PI, 0.2);
  }

  // LA SOMBRA avanza siempre; en el tramo final acelera un 20 %; si se queda muy atras, recupera el rastro
  float velSombra = velSombraP4;
  if (jugadorXP4 > 3750) {
    velSombra = velSombra * 1.2;
  }
  if (jugadorXP4 - sombraXP4 > 850) {
    velSombra = velSombra * 2.2;
  }
  if (millis() - inicioGritoP4 < 1800) {
    velSombra = velSombra * 1.6;   // grito: acelera un momento
  }
  sombraXP4 += velSombra * dtP4;

  // LANZA CARTAS: vuelta 1 solo bajas; vuelta 2 mezcladas y mas seguidas; vuelta 3 igual pero a oscuras
  int intervaloCarta = 2200;
  if (vueltaP4 == 2) {
    intervaloCarta = 1800;
  }
  if (vueltaP4 == 3) {
    intervaloCarta = 1600;
  }
  // nunca mas de 3 cartas en el aire a la vez
  int cartasEnElAire = 0;
  for (int c = 0; c < cantidadCartasP4; c++) {
    if (cartaActivaP4[c]) {
      cartasEnElAire++;
    }
  }
  if (millis() - ultimaCartaP4 >= intervaloCarta && cartasEnElAire < 3) {
    ultimaCartaP4 = millis();
    int nueva = siguienteCartaP4;
    cartaActivaP4[nueva] = true;
    cartaXP4[nueva] = sombraXP4 + 50;
    boolean alta = vueltaP4 >= 2 && random(1) < 0.45;
    if (rafagaP4) {
      alta = !ultimaAltaP4;                      // la segunda de la rafaga va a la otra altura
      rafagaP4 = false;
    } else {
      // desde la vuelta 2, 3 de cada 10 veces lanza dos seguidas (la segunda sale a los 0,42 s)
      if (vueltaP4 >= 2 && random(1) < 0.2) {
        rafagaP4 = true;
        ultimaCartaP4 = millis() - intervaloCarta + 420;
      }
    }
    ultimaAltaP4 = alta;
    cartaYP4[nueva] = 855;                       // baja: a la altura de los pies
    if (alta) {
      cartaYP4[nueva] = 705;                     // alta: por encima de la cabeza (solo pega si saltas)
    }
    cartaContadaP4[nueva] = false;
    cartaPorPocoP4[nueva] = false;
    siguienteCartaP4 = (nueva + 1) % cantidadCartasP4;
    inicioLanzaP4 = millis();
    sonidosCargadosSample[36].trigger();         // la carta sale silbando
  }

  for (int c = 0; c < cantidadCartasP4; c++) {
    if (cartaActivaP4[c]) {
      cartaXP4[c] += 14 * dtP4;
      if (cartaXP4[c] > camaraP4 + 2020) {
        cartaActivaP4[c] = false;
      }

      // la saltaste rozandola: pasa por debajo de tus pies muy cerca
      if (cartaXP4[c] - 14 * dtP4 < jugadorXP4 && cartaXP4[c] >= jugadorXP4 && cartaYP4[c] > 800 && !enSueloP4) {
        float rozando = (cartaYP4[c] - 15) - jugadorYP4;
        if (rozando > 0 && rozando < 40) {
          cartaPorPocoP4[c] = true;
        }
      }

      // ESQUIVADA: paso de largo sin golpearte (1 punto, hasta 6) y la racha sube
      if (!cartaContadaP4[c] && cartaXP4[c] > jugadorXP4 + 40) {
        cartaContadaP4[c] = true;
        if (!aturdido && dentroPuertaP4 < 0) {
          esquivasP4++;
          rachaP4++;
          inicioRachaP4 = millis();
          if (esquivasP4 <= 6) {
            agregarFlotante("+1", jugadorXP4 - camaraP4 + 50, jugadorYP4 - 200, color(255, 210, 90));
            ultimoCambioPuntos = millis();
          }
          if (rachaP4 == 1) {
            sonidosCargadosSample[37].trigger();
          }
          if (rachaP4 == 2) {
            sonidosCargadosSample[38].trigger();
          }
          if (rachaP4 >= 3) {
            sonidosCargadosSample[39].trigger();
          }
          for (int chispa = 0; chispa < 6; chispa++) {
            agregarParticulaP4(cartaXP4[c] - 20, cartaYP4[c], random(-4, 2), random(-4, 2), 500, random(6, 11), color(255, 150, 190));
          }
          if (cartaPorPocoP4[c]) {
            agregarImpacto("POR POCO", jugadorXP4 - camaraP4, jugadorYP4 - 290, 64, color(127, 212, 255));
            sonidosCargadosSample[19].trigger();
            for (int chispa = 0; chispa < 12; chispa++) {
              agregarParticulaP4(jugadorXP4, jugadorYP4, random(-6, 6), random(-7, -1), 600, random(6, 12), color(127, 212, 255));
            }
          }
        }
      }
      // choque con el jugador (rectangulo de 80 x 150 contra la carta de 45 x 30)
      boolean chocaX = cartaXP4[c] > jugadorXP4 - 40 && cartaXP4[c] < jugadorXP4 + 40;
      boolean chocaY = cartaYP4[c] + 15 > jugadorYP4 - 150 && cartaYP4[c] - 15 < jugadorYP4;
      if (cartaActivaP4[c] && !aturdido && chocaX && chocaY) {
        cartaActivaP4[c] = false;
        golpesP4++;
        perderPalito();
        aturdidoHastaP4 = millis() + 650;
        inicioSacudidaP4 = millis();
        velYP4 = min(velYP4, -8);                // un saltito por el golpe
        enSueloP4 = false;
        sonidosCargadosSample[28].trigger();     // golpe de papel
        mostrarGloboP4("Auch!");
        rachaP4 = 0;
        for (int corazon = 0; corazon < 10; corazon++) {
          agregarParticulaP4(jugadorXP4, jugadorYP4 - 90, random(-6, 6), random(-8, -2), 700, random(10, 18), color(235, 50, 90));
        }
      }
    }
  }

  // LATIDO: mientras mas cerca la sombra, mas rapido
  float distancia = jugadorXP4 - sombraXP4;
  if (distancia < 700) {
    int intervaloLatido = int(constrain(map(distancia, 700, 100, 950, 330), 330, 950));
    if (millis() - ultimoLatidoP4 >= intervaloLatido) {
      sonidosCargadosSample[21].trigger();
      ultimoLatidoP4 = millis();
    }
  }

  // se pierde si la sombra te alcanza o sin palitos
  if (sombraXP4 + 35 >= jugadorXP4 - 20) {
    perderP4(1);
  }
  if (palitos <= 0) {
    perderP4(2);
  }
}


// FONDO: pared vino con papel tapiz, zocalo, piso de tablas y lamparas cada 600 px (las cercanas a la sombra parpadean)
void dibujarFondoPasilloP4(float e) {
  background(12, 10, 26);
  noStroke();

  // PARED Y PISO: la imagen (1920 de ancho) se repite; una normal y la siguiente en espejo, asi los bordes encajan
  // en cada vuelta se pone mas oscura y roja: el pasillo se va "danando"
  if (vueltaP4 == 2) {
    tint(225, 190, 205);
  }
  if (vueltaP4 == 3) {
    tint(195, 150, 165);
  }
  int primeraPared = floor(camaraP4 / 1920);
  for (int pared = primeraPared; pared < primeraPared + 2; pared++) {
    float paredX = (pared * 1920 - camaraP4) * e;
    if (pared % 2 == 0) {
      image(imagenesCargadas[97], paredX, 0, 1920 * e, 1080 * e);
    } else {
      pushMatrix();
      translate(paredX + 1920 * e, 0);
      scale(-1, 1);
      image(imagenesCargadas[97], 0, 0, 1920 * e, 1080 * e);
      popMatrix();
    }
  }
  noTint();

  // manchas de luz calida en la pared, debajo de cada lampara (dos tonos, como en las imagenes)
  for (int lampara = 0; lampara < 9; lampara++) {
    float pantallaX = (300 + lampara * 600 - camaraP4) * e;
    if (pantallaX > -400 * e && pantallaX < width + 400 * e) {
      float brillo = luzP4;
      if (300 + lampara * 600 - sombraXP4 < 350 && sombraXP4 - 300 - lampara * 600 < 350) {
        brillo = luzP4 * random(0.15, 1);   // la sombra hace parpadear la luz
      }
      if (vueltaP4 == 2 && lampara == 3) {
        brillo = luzP4 * random(0, 1);
      }
      if ((vueltaP4 >= 2 && lampara == 5) || (lampara == 0 && lamparaRotaP4)) {
        brillo = 0;
      }
      fill(255, 160, 80, 55 * brillo);
      ellipse(pantallaX, 175 * e, 380 * e, 230 * e);
      fill(255, 210, 140, 70 * brillo);
      ellipse(pantallaX, 155 * e, 190 * e, 110 * e);
    }
  }

  // lamparas del techo: cono de luz de borde definido, charco de luz en el piso y polvo
  for (int lampara = 0; lampara < 9; lampara++) {
    float lamparaX = 300 + lampara * 600;
    float pantallaX = (lamparaX - camaraP4) * e;
    if (pantallaX > -400 * e && pantallaX < width + 400 * e) {
      float brillo = luzP4;
      if (lamparaX - sombraXP4 < 350 && sombraXP4 - lamparaX < 350) {
        brillo = luzP4 * random(0.15, 1);
      }
      if (vueltaP4 == 2 && lampara == 3) {
        brillo = luzP4 * random(0, 1);   // parpadea siempre
      }
      if ((vueltaP4 >= 2 && lampara == 5) || (lampara == 0 && lamparaRotaP4)) {
        brillo = 0;                      // apagada o rota
      }
      noStroke();
      fill(255, 170, 85, 46 * brillo);
      quad(pantallaX - 26 * e, 130 * e, pantallaX + 26 * e, 130 * e, pantallaX + 250 * e, 900 * e, pantallaX - 250 * e, 900 * e);
      fill(255, 205, 135, 46 * brillo);
      quad(pantallaX - 14 * e, 130 * e, pantallaX + 14 * e, 130 * e, pantallaX + 130 * e, 900 * e, pantallaX - 130 * e, 900 * e);
      fill(255, 175, 85, 120 * brillo);
      ellipse(pantallaX, 960 * e, 520 * e, 70 * e);
      for (int mota = 0; mota < 7; mota++) {
        float motaY = 160 + (millis() * 0.02 * (1 + mota % 3) + mota * 113) % 730;
        float motaX = pantallaX + sin(millis() * 0.0006 + mota * 2.1) * 200 * e * (motaY / 900);
        fill(255, 235, 190, 90 * brillo);
        ellipse(motaX, motaY * e, (3 + mota % 3) * e, (3 + mota % 3) * e);
      }

      // el bombillo: se oscurece cuando la luz baja (apagado queda gris)
      tint(110 + 145 * brillo);
      image(imagenesCargadas[99], pantallaX - 18 * e, 90 * e, 36 * e, 60 * e);
      noTint();
    }
  }
  strokeWeight(1);
}


// LO QUE HAY EN LA PARED: pines, espejo, puertas, foto de la habitacion, camaras y la salida
void dibujarObjetosP4(float e) {
  noStroke();

  // CUADROS: retratos torcidos cuyos ojos siguen al jugador (con el apagon brillan rojos)
  for (int k = 0; k < cantidadCuadrosP4; k++) {
    float cuadroPantalla = (cuadroXP4[k] - camaraP4) * e;
    boolean esLaFoto = vueltaP4 == 3 && cuadroXP4[k] == fragmentoXP4[2];   // en la vuelta 3 la foto ocupa su lugar
    if (!esLaFoto && cuadroPantalla > -150 * e && cuadroPantalla < width + 150 * e) {
      pushMatrix();
      translate(cuadroPantalla, 470 * e);
      rotate((k % 3 - 1) * 0.06);
      if (vueltaP4 >= 2 && k % 2 == 1) {
        rotate(PI);   // de cabeza
      }
      noStroke();
      if (vueltaP4 == 3) {
        // tu retrato, teñido de rojo
        tint(255, 185, 185);
        image(imagenesCargadas[103], -48 * e, -54 * e, 96 * e, 109 * e);
        noTint();
      } else {
        // marco de madera con una figura oscura de cara crema, cuyos ojos te siguen
        image(imagenesCargadas[102], -58 * e, -47 * e, 116 * e, 93 * e);
        fill(25, 18, 22);
        ellipse(0, 4 * e, 44 * e, 50 * e);
        fill(225, 205, 180);
        ellipse(0, 8 * e, 30 * e, 36 * e);
        float mira = constrain((jugadorXP4 - cuadroXP4[k]) / 400.0, -1, 1) * 3;
        if (apagadoP4) {
          fill(255, 40, 40);
        } else {
          fill(255);
        }
        ellipse(-7 * e, 5 * e, 9 * e, 6 * e);
        ellipse(7 * e, 5 * e, 9 * e, 6 * e);
        fill(0);
        ellipse((-7 + mira) * e, 5 * e, 4 * e, 4 * e);
        ellipse((7 + mira) * e, 5 * e, 4 * e, 4 * e);
      }
      popMatrix();
    }
  }

  // PINES: marco con una foto y un pin rojo que late; borrado, el pin se cae y la foto queda tachada
  for (int p = 0; p < cantidadPinesP4; p++) {
    float pinPantalla = (pinXP4[p] - camaraP4) * e;
    if (pinPantalla > -200 * e && pinPantalla < width + 200 * e) {
      // la polaroid ya trae su chincheta
      noStroke();
      image(imagenesCargadas[104], pinPantalla - 58 * e, 262 * e, 116 * e, 118 * e);

      if (pinBorradoP4[p]) {
        fill(0, 120);
        rect(pinPantalla - 46 * e, 276 * e, 92 * e, 80 * e);
        stroke(127, 212, 255);
        strokeWeight(6 * e);
        line(pinPantalla - 38 * e, 284 * e, pinPantalla + 38 * e, 348 * e);
        line(pinPantalla + 38 * e, 284 * e, pinPantalla - 38 * e, 348 * e);
        noStroke();
      }

      // EL PIN FLOTANTE: sube y baja, manda ondas como una senal de GPS y una linea punteada lo une con su foto
      if (!pinBorradoP4[p]) {
        float pinY = pinYP4[p] + sin(millis() * 0.004 + p) * 12;
        stroke(225, 40, 55, 150);
        strokeWeight(3 * e);
        for (float punto = 400; punto < pinY - 40; punto += 22) {
          line(pinPantalla, punto * e, pinPantalla, (punto + 10) * e);
        }
        // ondas de senal: circulos rellenos y transparentes que crecen y se apagan
        // (un circulo con contorno que cambia de tamano en cada cuadro es lento en P2D)
        noStroke();
        for (int onda = 0; onda < 2; onda++) {
          float avanceOnda = ((millis() + onda * 600) % 1200) / 1200.0;
          fill(255, 70, 80, 90 * (1 - avanceOnda));
          ellipse(pinPantalla, pinY * e, (40 + 100 * avanceOnda) * e, (40 + 100 * avanceOnda) * e);
        }
        // el pin (el centro del circulo queda en pinY)
        image(imagenesCargadas[105], pinPantalla - 26 * e, (pinY - 26) * e, 52 * e, 66 * e);
      }
    }
  }

  // ESCRITOS EN LA PARED con pintura roja (aparecen en las vueltas 2 y 3)
  if (vueltaP4 == 2) {
    dibujarEscritoP4("17?", 2950, 310, 70, -0.08, e);
    dibujarEscritoP4("te veo", 4300, 310, 60, 0.06, e);
  }
  if (vueltaP4 == 3) {
    dibujarEscritoP4("te veo", 1270, 700, 58, -0.05, e);
    dibujarEscritoP4("17", 2210, 300, 96, 0.1, e);
    dibujarEscritoP4("ya sé dónde vives", 3500, 300, 54, -0.04, e);
    dibujarEscritoP4("corre", 4620, 300, 72, 0.07, e);
  }

  // ESPEJO (prueba A): marco dorado, vidrio celeste con "71" y tu reflejo si pasas por delante
  float espejoX = (fragmentoXP4[0] - camaraP4) * e;
  if (espejoX > -200 * e && espejoX < width + 200 * e) {
    if (!fragmentoP4[0]) {
      fill(255, 220, 120, 40 + 30 * sin(millis() * 0.005));
      rect(espejoX - 135 * e, 440 * e, 270 * e, 170 * e);
    }
    noStroke();
    image(imagenesCargadas[106], espejoX - 115 * e, 459 * e, 230 * e, 132 * e);

    // tu reflejo (al reves) cuando pasas por delante (solo dentro del vidrio)
    if (jugadorXP4 - fragmentoXP4[0] < 160 && fragmentoXP4[0] - jugadorXP4 < 160) {
      clip(espejoX - 85 * e, 470 * e, 170 * e, 108 * e);
      float reflejoX = espejoX - (jugadorXP4 - fragmentoXP4[0]) * 0.5 * e;
      fill(40, 60, 80, 150);
      ellipse(reflejoX, 520 * e, 34 * e, 34 * e);
      rect(reflejoX - 18 * e, 540 * e, 36 * e, 80 * e);
      noClip();
    }

    if (!fragmentoP4[0]) {
      fill(40, 60, 90);
      textFont(fuente);
      textAlign(CENTER, CENTER);
      textSize(72 * e);
      text("71", espejoX, 520 * e);
    }
  }

  // PUERTAS: al abrirse se ve lo oscuro de adentro; la placa con el numero va arriba, en la pared
  for (int d = 0; d < cantidadPuertasP4; d++) {
    float puertaPantalla = (puertaXP4[d] - camaraP4) * e;
    if (puertaPantalla > -200 * e && puertaPantalla < width + 200 * e) {
      float abierta = 0;
      int pasadoPuerta = millis() - inicioPuertaP4[d];
      if (pasadoPuerta < 1200) {
        abierta = sin(PI * pasadoPuerta / 1200.0);
      }
      noStroke();
      fill(50, 40, 74);
      rect(puertaPantalla - 102 * e, 556 * e, 204 * e, 344 * e);
      fill(10, 8, 22);
      rect(puertaPantalla - 90 * e, 570 * e, 180 * e, 330 * e);

      // la hoja de la puerta: al abrirse se angosta (parece que gira hacia adentro)
      float anchoHoja = 180 * (1 - 0.75 * abierta);
      image(imagenesCargadas[110], puertaPantalla - 90 * e, 570 * e, anchoHoja * e, 330 * e);
      // vecino: luz por debajo (aviso) y despues la puerta abierta de golpe hacia el pasillo
      int pasadoVecino = millis() - inicioVecinoP4[d];
      if (pasadoVecino >= 0 && pasadoVecino < 550) {
        fill(255, 200, 120, 160 + 90 * sin(millis() * 0.04));
        rect(puertaPantalla - 88 * e, 893 * e, 176 * e, 8 * e);
        fill(255, 190, 110, 70);
        ellipse(puertaPantalla, 908 * e, 260 * e, 30 * e);
      }
      if (pasadoVecino >= 550 && pasadoVecino < 1700) {
        // el cuarto con luz y el vecino que mira
        image(imagenesCargadas[111], puertaPantalla - 90 * e, 570 * e, 180 * e, 330 * e);
        image(imagenesCargadas[113], puertaPantalla - 50 * e, 660 * e, 84 * e, 240 * e);
      }

      // placa dorada grande (la de la 17 desaparece al recogerla); crece y se inclina cuando el jugador se acerca
      if (numeroPuertaP4[d] == 17 && fragmentoP4[1]) {
        fill(35, 20, 15);
        rect(puertaPantalla - 52 * e, 496 * e, 104 * e, 52 * e);
        fill(120);
        ellipse(puertaPantalla - 42 * e, 522 * e, 7 * e, 7 * e);
        ellipse(puertaPantalla + 42 * e, 522 * e, 7 * e, 7 * e);
      } else {
        float cercaPlaca = constrain(1 - (jugadorXP4 - puertaXP4[d]) / 320.0, 0, 1);
        if (jugadorXP4 < puertaXP4[d]) {
          cercaPlaca = constrain(1 - (puertaXP4[d] - jugadorXP4) / 320.0, 0, 1);
        }
        pushMatrix();
        translate(puertaPantalla, 522 * e);
        scale(1 + 0.35 * cercaPlaca);
        rotate(sin(millis() * 0.01 + d) * 0.06 * cercaPlaca);
        fill(255, 220, 120, 90 * cercaPlaca);
        ellipse(0, 0, 150 * e, 80 * e);
        image(imagenesCargadas[107], -52 * e, -27 * e, 104 * e, 54 * e);
        fill(50, 32, 20);
        textFont(fuente);
        textAlign(CENTER, CENTER);
        textSize(42 * e);
        text(numeroPuertaP4[d], 0, -2 * e);
        popMatrix();
      }
    }
  }

  // FOTO DE LA HABITACION (prueba C): solo en la vuelta 3, pegada con cinta donde antes habia un cuadro
  float fotoX = (fragmentoXP4[2] - camaraP4) * e;
  if (vueltaP4 == 3 && fotoX > -200 * e && fotoX < width + 200 * e) {
    if (!fragmentoP4[2]) {
      fill(255, 220, 120, 40 + 30 * sin(millis() * 0.005));
      ellipse(fotoX, fragmentoYP4[2] * e, 150 * e, 130 * e);
      dibujarFragmentoP4(2, fotoX, fragmentoYP4[2] * e, 90 * e, false);
    }
    fill(240, 230, 180, 210);
    rect(fotoX - 50 * e, (fragmentoYP4[2] - 48) * e, 30 * e, 12 * e);
    rect(fotoX + 20 * e, (fragmentoYP4[2] - 48) * e, 30 * e, 12 * e);
  }

  // CAMARAS de la sombra en el techo, con la luz roja que parpadea
  for (int c = 0; c < 3; c++) {
    float camX = (camaraFotoXP4[c] - camaraP4) * e;
    if (camX > -100 * e && camX < width + 100 * e) {
      noStroke();
      image(imagenesCargadas[109], camX - 25 * e, 92 * e, 50 * e, 50 * e);
      if ((millis() / 500) % 2 == 0) {
        fill(255, 40, 40);
      } else {
        fill(90, 10, 10);
      }
      ellipse(camX + 15 * e, 110 * e, 7 * e, 7 * e);
    }
  }

  // CAJAS de carton con cinta (hay que saltarlas)
  for (int k = 0; k < cantidadCajasP4; k++) {
    float cajaPantalla = (cajaXP4[k] - camaraP4) * e;
    if (cajaPantalla > -100 * e && cajaPantalla < width + 100 * e) {
      fill(0, 90);
      ellipse(cajaPantalla, 903 * e, 100 * e, 14 * e);
      image(imagenesCargadas[100], cajaPantalla - 42 * e, (pisoP4 - altoCajaP4 - 3) * e, 84 * e, (altoCajaP4 + 3) * e);
    }
  }

  // SALIDA al final: oscura con las pruebas incompletas, con luz dorada cuando tienes las 3
  float salidaX = (5330 - camaraP4) * e;
  if (salidaX < width + 200 * e) {
    // con las 3 pruebas la puerta se enciende y su luz late
    if (fragmentosP4 == 3) {
      fill(255, 220, 140, 70 + 40 * sin(millis() * 0.006));
      ellipse(salidaX, 720 * e, 300 * e, 420 * e);
      image(imagenesCargadas[111], salidaX - 80 * e, 540 * e, 160 * e, 360 * e);
    } else {
      image(imagenesCargadas[112], salidaX - 80 * e, 540 * e, 160 * e, 360 * e);
    }
    fill(40, 30, 64);
    rect(salidaX - 70 * e, 488 * e, 140 * e, 40 * e);
    if (fragmentosP4 == 3) {
      fill(255, 210, 90);
    } else {
      fill(225, 40, 55);
    }
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(26 * e);
    text("Salida", salidaX, 506 * e);
  }
  strokeWeight(1);
}


// LA SOMBRA: silueta que flota, con estela de humo, ojos que se ponen rojos cuando esta cerca y la oscuridad detras
void dibujarSombraP4(float e) {
  float sombraPantalla = (sombraXP4 - camaraP4) * e;
  float flota = sin(millis() * 0.008) * 5;
  float cercania = constrain(map(jugadorXP4 - sombraXP4, 600, 150, 0, 1), 0, 1);

  // al aparecer (fase 0) sube desde el piso
  float aparece = 1;
  if (faseP4 == 0) {
    aparece = reboteTelon((millis() - inicioFaseP4 - 950) / 700.0);
  }

  // la oscuridad que la sigue: todo lo que queda detras se apaga
  noStroke();
  if (sombraPantalla > -60 * e) {
    fill(0, 210);
    rect(0, 90 * e, max(0, sombraPantalla - 80 * e), 990 * e);
    for (int franja = 0; franja < 6; franja++) {
      fill(0, 180 - franja * 30);
      rect(sombraPantalla - 80 * e + franja * 16 * e, 90 * e, 16 * e, 990 * e);
    }
  }

  // estela de humo
  for (int humo = 0; humo < 7; humo++) {
    float desfase = (millis() * 0.08 + humo * 37) % 60;
    fill(10, 3, 6, 140 - humo * 18);
    ellipse(sombraPantalla - (humo * 28 + desfase) * e, (820 - humo * 8 + sin(millis() * 0.004 + humo) * 14) * e, (80 - humo * 8) * e, (70 - humo * 7) * e);
  }

  // grito (1,8 s despues de recoger una prueba): crece, abre la boca y brilla rojo
  float grito = constrain(1 - (millis() - inicioGritoP4) / 1800.0, 0, 1);
  float crece = 1 + 0.2 * cercania + 0.2 * grito;

  pushMatrix();
  translate(sombraPantalla, (pisoP4 + flota) * e);
  scale(crece, aparece * crece);

  // aura roja cuando esta cerca o grita
  fill(200, 20, 30, 70 * max(cercania, grito));
  ellipse(0, -110 * e, 220 * e, 320 * e);

  // (imagenes armadas: el origen es el borde de abajo del cuerpo, al centro; mira a la derecha)
  // cuerpo
  image(imagenesCargadas[121], -41.4 * e, -182.8 * e, 83 * e, 183.4 * e);

  // brazo que lanza la carta: gira desde el hombro hacia adelante
  float lanza = constrain(1 - (millis() - inicioLanzaP4) / 350.0, 0, 1);
  pushMatrix();
  translate(12.3 * e, -159.8 * e);
  rotate(-1.4 * lanza);
  image(imagenesCargadas[122], -23.8 * e, -8.7 * e, 40.4 * e, 140.8 * e);
  popMatrix();

  // capucha
  image(imagenesCargadas[123], -26.8 * e, -248.1 * e, 75.1 * e, 100.2 * e);

  // ojo: blanco lejos, rojo cerca (con un brillo detras); cada 3 s parpadea
  float altoOjo = 1;
  if (millis() % 3000 < 120) {
    altoOjo = 0.15;
  }
  fill(255, 40, 40, 120 * cercania);
  ellipse(33 * e, -209 * e, 50 * e, 34 * e);
  tint(lerpColor(color(255), color(255, 40, 40), cercania));
  image(imagenesCargadas[124], 29.5 * e, (-209 - 8.3 * altoOjo) * e, 7.6 * e, 16.6 * altoOjo * e);
  noTint();

  // boca: sonrie siempre; al gritar se abre mas
  image(imagenesCargadas[125], 18.9 * e, -200.1 * e, 24.4 * e, 15.8 * (1 + grito) * e);
  popMatrix();
  strokeWeight(1);
}


// CARTAS DE AMOR: sobres rosados que vuelan tambaleandose, con una estela
void dibujarCartasP4(float e) {
  for (int c = 0; c < cantidadCartasP4; c++) {
    if (cartaActivaP4[c]) {
      float cartaPantalla = (cartaXP4[c] - camaraP4) * e;
      noStroke();
      fill(255, 150, 180, 70);
      rect(cartaPantalla - 70 * e, (cartaYP4[c] - 4) * e, 50 * e, 8 * e);
      pushMatrix();
      translate(cartaPantalla, cartaYP4[c] * e);
      rotate(sin(millis() * 0.02 + c) * 0.25);
      image(imagenesCargadas[101], -22 * e, -22 * e, 44 * e, 45 * e);
      popMatrix();
    }
  }
  strokeWeight(1);
}


// EL JUGADOR: camiseta negra y la pulsera roja; corre, salta y queda aturdido (parpadea con estrellitas)
void dibujarJugadorP4(float e) {
  float jugadorPantalla = (jugadorXP4 - camaraP4) * e;
  boolean aturdido = millis() < aturdidoHastaP4;

  // sombra en el piso (mas chica cuando salta)
  float altura = pisoP4 - jugadorYP4;
  noStroke();
  fill(0, 90);
  ellipse(jugadorPantalla, 903 * e, 56 * e * (1 - altura / 500), 12 * e);

  // dentro de una puerta equivocada no se ve; aturdido parpadea
  boolean visible = dentroPuertaP4 < 0;
  if (aturdido && (millis() / 70) % 2 == 0) {
    visible = false;
  }

  if (visible) {
    float balanceo = sin(pasoP4);

    // se estira al saltar, se aplasta al caer y se inclina hacia adelante al correr
    float estiraX = 1;
    float estiraY = 1;
    int pasadoSalto = millis() - inicioSaltoP4;
    if (pasadoSalto < 200) {
      float fuerza = 1 - pasadoSalto / 200.0;
      estiraX = 1 - 0.15 * fuerza;
      estiraY = 1 + 0.2 * fuerza;
    }
    int pasadoCae = millis() - inicioAterrizaP4;
    if (pasadoCae < 160) {
      float fuerza = 1 - pasadoCae / 160.0;
      estiraX = 1 + 0.25 * fuerza;
      estiraY = 1 - 0.22 * fuerza;
    }
    float inclina = 0;
    if (corriendoP4 && enSueloP4) {
      inclina = 0.12;
    }

    pushMatrix();
    translate(jugadorPantalla, jugadorYP4 * e);
    scale(mirandoP4 * estiraX, estiraY);
    rotate(inclina);

    // (imagenes armadas: el origen son los pies; mira a la derecha)
    // las piernas giran desde la cadera y los brazos desde el hombro; brazo y pierna del mismo lado van al reves
    float giroPiernaAdelante = -balanceo * 0.45;
    float giroPiernaAtras = balanceo * 0.45;
    float giroBrazoAdelante = balanceo * 0.55;
    float giroBrazoAtras = -balanceo * 0.55;
    if (!enSueloP4) {
      giroPiernaAdelante = -0.5;
      giroPiernaAtras = 0.3;
      giroBrazoAdelante = -0.9;
      giroBrazoAtras = 0.5;
    }
    noStroke();

    // lo de atras, un poco mas oscuro
    tint(185, 175, 205);
    dibujarParteP4(119, 0, -103.8, giroBrazoAtras, -8.3, -4.9, 16.7, 47.9, e);
    dibujarParteP4(118, -2, -64.8, giroPiernaAtras, -10.5, -2.5, 21.1, 67.3, e);
    noTint();

    // pierna de adelante, torso, cabeza y el brazo de adelante con la pulsera
    dibujarParteP4(118, 2, -64.8, giroPiernaAdelante, -10.5, -2.5, 21.1, 67.3, e);
    image(imagenesCargadas[117], -13.8 * e, -119.1 * e, 31 * e, 54 * e);
    image(imagenesCargadas[116], -22 * e, -164.6 * e, 49 * e, 50 * e);
    dibujarParteP4(120, 3, -103.8, giroBrazoAdelante, -8.3, -4.9, 16.7, 47.9, e);
    popMatrix();
  }

  // estrellitas que giran alrededor de la cabeza mientras esta aturdido
  if (aturdido) {
    fill(255, 220, 90);
    for (int estrella = 0; estrella < 3; estrella++) {
      float anguloEstrella = millis() * 0.012 + estrella * TWO_PI / 3;
      ellipse(jugadorPantalla + cos(anguloEstrella) * 30 * e, (jugadorYP4 - 168) * e + sin(anguloEstrella) * 8 * e, 10 * e, 10 * e);
    }
  }
  strokeWeight(1);
}


// dibuja una parte del chico (imagen) girada desde su articulacion (pivoteX, pivoteY)
// x, y, ancho y alto: donde queda la imagen medida desde la articulacion (medidas de 1920)
void dibujarParteP4(int imagen, float pivoteX, float pivoteY, float giro, float x, float y, float ancho, float alto, float e) {
  pushMatrix();
  translate(pivoteX * e, pivoteY * e);
  rotate(giro);
  image(imagenesCargadas[imagen], x * e, y * e, ancho * e, alto * e);
  popMatrix();
}


// AYUDA: cuando hay algo para hacer con la flecha de abajo, sale un globito encima del jugador
void dibujarAyudaAccionP4(float e) {
  if (faseP4 == 1 && dentroPuertaP4 < 0 && millis() - inicioGloboP4 > 2600) {
    String accion = "";
    if (vueltaP4 == 1 && !fragmentoP4[0] && jugadorXP4 - fragmentoXP4[0] < 90 && fragmentoXP4[0] - jugadorXP4 < 90) {
      accion = "Recoger";
    }
    if (vueltaP4 == 3 && !fragmentoP4[2] && jugadorXP4 - fragmentoXP4[2] < 70 && fragmentoXP4[2] - jugadorXP4 < 70) {
      accion = "Recoger";
    }
    for (int d = 0; d < cantidadPuertasP4; d++) {
      if (accion.equals("") && jugadorXP4 - puertaXP4[d] < 80 && puertaXP4[d] - jugadorXP4 < 80) {
        accion = "Entrar";
      }
    }

    if (!accion.equals("")) {
      float globoX = (jugadorXP4 - camaraP4) * e;
      float globoY = (jugadorYP4 - 215 + sin(millis() * 0.008) * 4) * e;
      textFont(fuenteTexto);
      textSize(24 * e);
      float anchoGlobo = textWidth(accion) + 80 * e;
      noStroke();
      fill(0, 200);
      rect(globoX - anchoGlobo / 2, globoY - 24 * e, anchoGlobo, 48 * e);
      triangle(globoX - 10 * e, globoY + 23 * e, globoX + 10 * e, globoY + 23 * e, globoX, globoY + 36 * e);

      // tecla con una flecha hacia abajo
      float teclaX = globoX - anchoGlobo / 2 + 14 * e;
      stroke(255, 200, 0);
      strokeWeight(2 * e);
      noFill();
      rect(teclaX, globoY - 15 * e, 30 * e, 30 * e);
      noStroke();
      fill(255, 200, 0);
      triangle(teclaX + 7 * e, globoY - 5 * e, teclaX + 23 * e, globoY - 5 * e, teclaX + 15 * e, globoY + 8 * e);

      fill(255);
      textAlign(LEFT, CENTER);
      text(accion, teclaX + 40 * e, globoY - 3 * e);
      strokeWeight(1);
    }
  }
}


// FLASH: al recoger una prueba, la camara de la sombra dispara desde el techo (0,6 s)
void dibujarFlashP4(float e) {
  int pasadoFlash = millis() - inicioFlashP4;
  if (pasadoFlash < 600) {
    float apaga = 1 - pasadoFlash / 600.0;
    float camX = (camaraFotoXP4[camaraFlashP4] - camaraP4) * e;
    float destinoX = (fragmentoXP4[camaraFlashP4] - camaraP4) * e;
    noStroke();
    fill(255, 255, 235, 150 * apaga);
    triangle(camX, 125 * e, destinoX - 140 * e, 900 * e, destinoX + 140 * e, 900 * e);
    fill(255, 255, 240, 230 * apaga);
    ellipse(camX, 125 * e, 90 * e * apaga, 90 * e * apaga);
    fill(255, 210 * apaga * apaga);
    rect(0, 0, width, height);
  }
}


// CUARTO VACIO: al entrar por una puerta equivocada se ve 1 s un cuarto con un foco que se mece
void dibujarCuartoVacioP4(float e) {
  if (dentroPuertaP4 >= 0) {
    int pasado = millis() - inicioDentroP4;
    float opacidad = 255 * min(1, min(pasado / 150.0, (1000 - pasado) / 150.0));
    noStroke();
    tint(255, opacidad);
    image(imagenesCargadas[98], 0, 0, width, height);
    noTint();

    fill(255, opacidad);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(90 * e);
    text("Aquí no es", width / 2, 560 * e);
    fill(200, opacidad);
    textSize(34 * e);
    text("Puerta " + numeroPuertaP4[dentroPuertaP4], width / 2, 650 * e);
    strokeWeight(1);
  }
}


// INDICADOR: tres casillas arriba a la izquierda; cada prueba recogida vuela hasta la suya
void dibujarIndicadorP4(float e) {
  for (int f = 0; f < 3; f++) {
    float casillaX = 60 + f * 88;
    float casillaY = 113;
    noStroke();
    fill(0, 170);
    if (fragmentoP4[f]) {
      stroke(255, 200, 0);
    } else {
      stroke(255, 80);
    }
    strokeWeight(4 * e);
    rect(casillaX * e, casillaY * e, 75 * e, 75 * e);
    noStroke();

    int pasadoFragmento = millis() - inicioFragmentoP4[f];
    if (fragmentoP4[f]) {
      if (pasadoFragmento < 650) {
        float avance = pasadoFragmento / 650.0;
        float suave = avance * avance * (3 - 2 * avance);
        float vueloX = lerp(origenVueloXP4[f], casillaX + 37.5, suave);
        float vueloY = lerp(fragmentoYP4[f], casillaY + 37.5, suave) - 200 * sin(PI * avance);
        dibujarFragmentoP4(f, vueloX * e, vueloY * e, lerp(150, 62, suave) * e, false);
      } else {
        float aparece = reboteTelon((pasadoFragmento - 650) / 300.0);
        dibujarFragmentoP4(f, (casillaX + 37.5) * e, (casillaY + 37.5) * e, 62 * e * aparece, false);
      }
    } else {
      dibujarFragmentoP4(f, (casillaX + 37.5) * e, (casillaY + 37.5) * e, 52 * e, true);
    }
  }
  strokeWeight(1);
}


// dibuja una prueba centrada en (x, y) en pixeles de pantalla; tam = lado del cuadro donde cabe
// silueta = true la dibuja oscura y sin detalles (casilla vacia o hueco del tablero)
void dibujarFragmentoP4(int f, float x, float y, float tam, boolean silueta) {
  pushMatrix();
  translate(x, y);
  scale(tam / 100.0);
  stroke(tintaP4);
  strokeWeight(3);
  if (silueta) {
    noStroke();
    fill(0, 90);
  }

  // las imagenes en silueta se tiñen de negro transparente
  if (silueta) {
    tint(0, 90);
  }
  if (f == 0) {
    // el espejo con el 71
    image(imagenesCargadas[106], -48, -28, 96, 55);
    if (!silueta) {
      fill(40, 60, 90);
      textFont(fuente);
      textAlign(CENTER, CENTER);
      textSize(30);
      text("71", 0, -3);
    }
  }
  if (f == 1) {
    // la placa dorada de la puerta
    image(imagenesCargadas[108], -48, -25, 96, 50);
    if (!silueta) {
      fill(60, 40, 20);
      textFont(fuente);
      textAlign(CENTER, CENTER);
      textSize(38);
      text("17", 0, 2);
    }
  }
  if (f == 2) {
    // la foto de tu habitacion: cama y lampara
    if (!silueta) {
      fill(245, 240, 228);
    }
    rect(-44, -40, 88, 80);
    if (!silueta) {
      noStroke();
      fill(40, 45, 80);
      rect(-37, -33, 74, 56);
      fill(255, 220, 120, 70);
      ellipse(22, -10, 40, 40);
      fill(200, 80, 90);
      rect(-31, 2, 42, 14);
      fill(240);
      rect(-31, -4, 13, 8);
      stroke(230);
      strokeWeight(2);
      line(22, -10, 22, 16);
      noStroke();
      fill(255, 220, 120);
      triangle(14, -10, 30, -10, 22, -22);
    }
  }
  noTint();
  popMatrix();
  strokeWeight(1);
}


// FLECHA DE ABAJO: recoge una prueba, borra un pin o entra por una puerta (lo que este delante)
void accionP4() {
  if (faseP4 == 1 && dentroPuertaP4 < 0) {
    boolean hizoAlgo = false;

    // pruebas en la pared: el espejo (A) y la foto (C)
    if (vueltaP4 == 1 && !fragmentoP4[0] && jugadorXP4 - fragmentoXP4[0] < 90 && fragmentoXP4[0] - jugadorXP4 < 90) {
      recogerFragmentoP4(0);
      hizoAlgo = true;
    }
    if (!hizoAlgo && vueltaP4 == 3 && !fragmentoP4[2] && jugadorXP4 - fragmentoXP4[2] < 70 && fragmentoXP4[2] - jugadorXP4 < 70) {
      recogerFragmentoP4(2);
      hizoAlgo = true;
    }

    // puertas: la 17 da la placa; las demas son un cuarto vacio y cuestan 5 s
    for (int d = 0; d < cantidadPuertasP4; d++) {
      if (!hizoAlgo && enSueloP4 && millis() - inicioVecinoP4[d] > 1800 && jugadorXP4 - puertaXP4[d] < 80 && puertaXP4[d] - jugadorXP4 < 80) {
        hizoAlgo = true;
        inicioPuertaP4[d] = millis();
        sonidosCargadosSample[0].trigger();   // puerta que se abre
        if (numeroPuertaP4[d] == 17) {
          if (vueltaP4 == 1) {
            mostrarGloboP4("Es mi puerta, pero está cerrada.");
          } else {
            if (!fragmentoP4[1]) {
              recogerFragmentoP4(1);
            } else {
              mostrarGloboP4("Ya tengo la placa.");
            }
          }
        } else {
          dentroPuertaP4 = d;
          inicioDentroP4 = millis();
          inicioPrueba -= 5000;
          agregarFlotante("-5 s", 960, 760, color(255, 90, 90));
          sombraReaccionaP4();
        }
      }
    }
  }
}


// la sombra aprovecha el error: susurro
void sombraReaccionaP4() {
  sonidosCargadosSample[20].trigger();
}


// recoge una prueba: flash desde la camara de la sombra, moneda, +12 y su frase
void recogerFragmentoP4(int f) {
  fragmentoP4[f] = true;
  fragmentosP4++;
  inicioFragmentoP4[f] = millis();
  origenVueloXP4[f] = fragmentoXP4[f] - camaraP4;
  inicioFlashP4 = millis();
  camaraFlashP4 = f;
  sonidosCargadosSample[29].trigger();   // obturador
  sonidosCargadosSample[19].trigger();   // acierto
  agregarFlotante("+10", fragmentoXP4[f] - camaraP4, fragmentoYP4[f] - 110, color(255, 210, 90));
  agregarMoneda(fragmentoXP4[f] - camaraP4, fragmentoYP4[f]);
  ultimoCambioPuntos = millis();
  for (int chispa = 0; chispa < 24; chispa++) {
    float anguloChispa = random(TWO_PI);
    float fuerzaChispa = random(3, 10);
    agregarParticulaP4(fragmentoXP4[f], fragmentoYP4[f], cos(anguloChispa) * fuerzaChispa, sin(anguloChispa) * fuerzaChispa - 3, 800, random(7, 14), color(255, 210, 90));
  }

  // la sombra se da cuenta: grita y acelera 1,8 s
  inicioGritoP4 = millis();
  sonidosCargadosSample[40].trigger();
  if (f == 0) {
    mostrarGloboP4("Un 17 al revés... mi cuarto es el 17.");
  }
  if (f == 1) {
    mostrarGloboP4("La placa de mi puerta. La conocía.");
  }
  if (f == 2) {
    mostrarGloboP4("Una foto de mi cuarto... desde afuera.");
  }
  if (fragmentosP4 == 3) {
    agregarImpacto("A LA SALIDA", 960, 470, 100, color(255, 210, 90));
  }
}


// llego al final con las 3 pruebas: el tiempo se detiene y aparece el tablero
void empezarTableroP4() {
  faseP4 = 2;
  inicioTableroP4 = millis();
  segundosSobrantesP4 = ceil((duracionPrueba - (millis() - inicioPrueba)) / 1000.0);
  izquierdaP4 = false;
  derechaP4 = false;
  for (int c = 0; c < cantidadCartasP4; c++) {
    cartaActivaP4[c] = false;
  }
  sonidosCargadosSample[6].trigger();
  sonidosCargadosAmbiente[3].shiftGain(sonidosCargadosAmbiente[3].getGain(), volumenAmbiente - 8, 600);
  sonidosCargadosAmbiente[4].shiftGain(sonidosCargadosAmbiente[4].getGain(), -60, 800);
}


// TABLERO DE CORCHO: arrastra cada prueba a su silueta; hilos rojos las unen como en un tablero de detective
void dibujarTableroP4(float e) {
  int pasado = millis() - inicioTableroP4;
  float baja = reboteTelon(pasado / 600.0);   // el tablero baja desde arriba
  float desliz = (1 - baja) * -900;

  noStroke();
  fill(0, 170 * min(1, pasado / 400.0));
  rect(0, 0, width, height);

  // corcho con su marco de madera
  noStroke();
  image(imagenesCargadas[114], 435 * e, (210 + desliz) * e, 1050 * e, 600 * e);

  fill(60, 30, 15);
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(50 * e);
  text("Une las pruebas", 960 * e, (265 + desliz) * e);

  // hilos rojos entre las siluetas (se encienden cuando las dos puntas estan encajadas)
  noFill();
  for (int hilo = 0; hilo < 2; hilo++) {
    boolean encendido = encajadoP4[hilo] && encajadoP4[hilo + 1];
    if (encendido) {
      stroke(235, 40, 50);
      strokeWeight(5 * e);
    } else {
      stroke(150, 30, 40, 160);
      strokeWeight(4 * e);
    }
    float desdeX = siluetaXP4[hilo] * e;
    float hastaX = siluetaXP4[hilo + 1] * e;
    float hiloY = (siluetaYP4 - 105 + desliz) * e;
    bezier(desdeX, hiloY, desdeX + 80 * e, hiloY + 60 * e, hastaX - 80 * e, hiloY + 60 * e, hastaX, hiloY);
  }
  noStroke();

  // siluetas con su chincheta
  for (int f = 0; f < 3; f++) {
    stroke(90, 55, 30, 150);
    strokeWeight(4 * e);
    fill(170, 125, 80);
    rect((siluetaXP4[f] - 120) * e, (siluetaYP4 - 120 + desliz) * e, 240 * e, 240 * e);
    noStroke();
    dibujarFragmentoP4(f, siluetaXP4[f] * e, (siluetaYP4 + desliz) * e, 190 * e, true);
    fill(225, 40, 55);
    ellipse(siluetaXP4[f] * e, (siluetaYP4 - 105 + desliz) * e, 20 * e, 20 * e);
  }

  // las piezas: la que se arrastra sigue al mouse; las encajadas van a su silueta; las demas vuelven a su lugar
  for (int f = 0; f < 3; f++) {
    if (arrastrandoP4 == f) {
      tableroXP4[f] = mouseX / e - agarreXP4;
      tableroYP4[f] = mouseY / e - agarreYP4;
    } else {
      if (encajadoP4[f]) {
        tableroXP4[f] = lerp(tableroXP4[f], siluetaXP4[f], 0.3);
        tableroYP4[f] = lerp(tableroYP4[f], siluetaYP4, 0.3);
      } else {
        tableroXP4[f] = lerp(tableroXP4[f], origenTableroXP4[f], 0.18);
        tableroYP4[f] = lerp(tableroYP4[f], origenTableroYP4, 0.18);
      }
    }
  }
  for (int orden = 0; orden < 4; orden++) {
    // primero las que no se arrastran; la arrastrada al final, encima de todo
    int f = orden;
    if (orden == 3) {
      f = arrastrandoP4;
    }
    if (f >= 0 && (orden == 3 || f != arrastrandoP4)) {
      float temblor = 0;
      int pasadoRebota = millis() - inicioRebotaP4[f];
      if (pasadoRebota < 300) {
        temblor = sin(pasadoRebota * 0.08) * 14 * (1 - pasadoRebota / 300.0);
      }
      float tamPieza = 180;
      if (arrastrandoP4 == f) {
        tamPieza = 196;
      }
      int pasadoEncaje = millis() - inicioEncajeP4[f];
      if (pasadoEncaje < 300) {
        tamPieza = 190 + 30 * sin(PI * pasadoEncaje / 300.0);
      }
      float piezaY = tableroYP4[f];
      if (!encajadoP4[f]) {
        piezaY = piezaY + desliz * 0.4;
      }
      noStroke();
      fill(0, 80);
      ellipse((tableroXP4[f] + temblor + 8) * e, (piezaY + 10) * e, tamPieza * 0.95 * e, tamPieza * 0.8 * e);
      dibujarFragmentoP4(f, (tableroXP4[f] + temblor) * e, piezaY * e, tamPieza * e, false);
    }
  }

  // LA FRASE FINAL se escribe letra por letra; despues cae el telon
  if (inicioFraseP4 >= 0) {
    String frase = "Sabía dónde estaba tu habitación.";
    int letras = constrain((millis() - inicioFraseP4 - 400) / 45, 0, frase.length());
    noStroke();
    fill(20, 10, 12, 220);
    rect(560 * e, 670 * e, 800 * e, 70 * e);
    fill(255, 220, 140);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(39 * e);
    text(frase.substring(0, letras), 960 * e, 702 * e);

    // a los 2,4 s la foto que la sombra te tomo desde el techo cae sobre el tablero
    int pasadoFoto = millis() - inicioFraseP4 - 2400;
    if (pasadoFoto >= 0) {
      dibujarFotoReveladaP4(pasadoFoto, e);
    }
    if (faseP4 == 2 && millis() - inicioFraseP4 > 6600) {
      faseP4 = 4;
      inicioCierreP4 = millis();
      sonidosCargadosSample[5].trigger();   // tela del telon
    }
  }
  strokeWeight(1);
}


// clic sostenido en el tablero: agarra una pieza
void presionarP4() {
  if (faseP4 == 2 && arrastrandoP4 == -1 && inicioFraseP4 < 0 && millis() - inicioTableroP4 > 600) {
    float e = width / 1920.0;
    for (int f = 0; f < 3; f++) {
      if (arrastrandoP4 == -1 && !encajadoP4[f] && dist(mouseX / e, mouseY / e, tableroXP4[f], tableroYP4[f]) < 95) {
        arrastrandoP4 = f;
        agarreXP4 = mouseX / e - tableroXP4[f];
        agarreYP4 = mouseY / e - tableroYP4[f];
        sonidosCargadosSample[7].trigger();
      }
    }
  }
}


// suelta la pieza: en su silueta encaja; en otra silueta rebota; en cualquier otro lado vuelve a su lugar
void soltarP4() {
  if (arrastrandoP4 >= 0) {
    int f = arrastrandoP4;
    arrastrandoP4 = -1;
    if (dist(tableroXP4[f], tableroYP4[f], siluetaXP4[f], siluetaYP4) < 120) {
      encajadoP4[f] = true;
      inicioEncajeP4[f] = millis();
      sonidosCargadosSample[8].trigger();    // queda clavada
      sonidosCargadosSample[19].trigger();
      if (encajadoP4[0] && encajadoP4[1] && encajadoP4[2]) {
        inicioFraseP4 = millis();
        sonidosCargadosSample[16].trigger();
      }
    } else {
      for (int otra = 0; otra < 3; otra++) {
        if (otra != f && dist(tableroXP4[f], tableroYP4[f], siluetaXP4[otra], siluetaYP4) < 120) {
          inicioRebotaP4[f] = millis();
          sonidosCargadosSample[9].trigger();
          mostrarMensaje("Esa no va ahí");
        }
      }
    }
  }
}


// CIERRE AL PERDER: la oscuridad se traga el pasillo desde la izquierda y quedan los ojos de la sombra (2,2 s)
void dibujarCierreP4(float e) {
  int pasado = millis() - inicioCierreP4;

  // si te alcanzo: su mano se estira y te agarra (0,45 s), te arrastra hacia ella y despues cae la oscuridad
  int retraso = 0;
  if (motivoDerrotaP4 == 1) {
    retraso = 800;
    float estira = suaveTelon(pasado / 450.0);
    float hombroX = (sombraXP4 - camaraP4 + 20) * e;
    float hombroY = (pisoP4 - 140) * e;
    float manoX = lerp(hombroX, (jugadorXP4 - camaraP4) * e, estira);
    float manoY = lerp(hombroY, (jugadorYP4 - 100) * e, estira);
    stroke(10, 3, 6);
    strokeWeight(24 * e);
    line(hombroX, hombroY, manoX, manoY);
    noStroke();
    fill(10, 3, 6);
    ellipse(manoX, manoY, 56 * e, 50 * e);
    stroke(10, 3, 6);
    strokeWeight(9 * e);
    for (int dedo = 0; dedo < 4; dedo++) {
      float anguloDedo = -0.9 + dedo * 0.6;
      line(manoX, manoY, manoX + cos(anguloDedo) * 40 * e, manoY + sin(anguloDedo) * 40 * e);
    }
    noStroke();
    if (pasado > 450) {
      if (!agarroP4) {
        agarroP4 = true;
        inicioSacudidaP4 = millis();
        sonidosCargadosSample[40].trigger();
      }
      jugadorXP4 = lerp(jugadorXP4, sombraXP4 + 70, 0.12);   // lo arrastra hacia ella
    }
  }
  pasado = pasado - retraso;
  float cubre = suaveTelon(pasado / 900.0);

  noStroke();
  fill(0);
  rect(0, 0, width * cubre, height);
  for (int borde = 0; borde < 8; borde++) {
    fill(0, 200 - borde * 25);
    rect(width * cubre + borde * 18 * e, 0, 18 * e, height);
  }

  if (pasado > 800) {
    float ojos = constrain((pasado - 800) / 300.0, 0, 1);
    fill(255, 40, 40, 90 * ojos);
    ellipse(960 * e, 470 * e, 300 * e, 110 * e);
    fill(255, 60, 60, 255 * ojos);
    ellipse(920 * e, 470 * e, 50 * e, 26 * e * ojos);
    ellipse(1000 * e, 470 * e, 50 * e, 26 * e * ojos);

    String fraseCierre = "Te encontró.";
    if (motivoDerrotaP4 == 0) {
      fraseCierre = "Se acabó el tiempo.";
    }
    if (motivoDerrotaP4 == 2) {
      fraseCierre = "Ya no puedes seguir corriendo.";
    }
    fill(255, 255 * ojos);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(70 * e);
    text(fraseCierre, width / 2, 640 * e);
  }

  if (pasado > 2400) {
    llenarResultadoP4(false);
    empezarResultado(false);
    pantalla = 22;
  }
}


// gana: 10 por cada prueba (30) + 1 por carta esquivada (hasta 6) + hasta 4 por el tiempo que sobro (maximo 40)
void ganarP4() {
  int puntosTiempo = 0;
  if (segundosSobrantesP4 >= 15) {
    puntosTiempo = 2;
  }
  if (segundosSobrantesP4 >= 30) {
    puntosTiempo = 4;
  }
  int puntosEsquivas = min(esquivasP4, 6);
  lineaTexto[0] = "Pruebas reunidas";
  lineaPuntos[0] = 30;
  lineaTexto[1] = "Cartas esquivadas";
  lineaPuntos[1] = puntosEsquivas;
  lineaTexto[2] = "Tiempo de sobra";
  lineaPuntos[2] = puntosTiempo;
  cantidadLineas = 3;

  puntosGanadosP4 = 30 + puntosEsquivas + puntosTiempo;
  puntosJugador += puntosGanadosP4;
  subirExposicion(-5);
  resultadoActo1[3] = 1;
  ganarLogro(3);
  revisarLogrosActos();
  if (pruebasCompletadasActo1 == 3) {
    pruebasCompletadasActo1 = 4;
  }
  llenarResultadoP4(true);
  empezarResultado(true);
  pantalla = 23;
}


// pierde: se filtra el dato y la exposicion sube 20 % en total (10 del dato + 10 mas, como dice el documento)
// 3 puntos por prueba recogida; sin palitos, 0
void perderP4(int motivo) {
  if (faseP4 == 1) {
    motivoDerrotaP4 = motivo;
    puntosGanadosP4 = 0;
    lineaTexto[0] = "Sin palitos";
    lineaPuntos[0] = 0;
    if (motivo != 2) {
      puntosGanadosP4 = fragmentosP4 * 3;
      lineaTexto[0] = "Pruebas recogidas";
      lineaPuntos[0] = puntosGanadosP4;
    }
    cantidadLineas = 1;
    puntosJugador += puntosGanadosP4;

    resultadoActo1[3] = 2;
    if (pruebasCompletadasActo1 == 3) {
      pruebasCompletadasActo1 = 4;
    }
    filtrarDato(3);
    subirExposicion(10);

    faseP4 = 3;
    inicioCierreP4 = millis();
    izquierdaP4 = false;
    derechaP4 = false;
    dentroPuertaP4 = -1;
    if (motivo == 1) {
      sonidosCargadosSample[25].trigger();   // golpe grave
    }
    sonidosCargadosAmbiente[3].shiftGain(sonidosCargadosAmbiente[3].getGain(), -40, 1500);
    sonidosCargadosAmbiente[4].shiftGain(sonidosCargadosAmbiente[4].getGain(), -60, 1500);
  }
}


// el tiempo se acabo (lo llama el contador)
void tiempoAgotadoP4() {
  perderP4(0);
}


// textos de la pantalla de resultado de la prueba 4
void llenarResultadoP4(boolean gano) {
  tituloResultado = "Se acabó el tiempo";
  if (motivoDerrotaP4 == 1) {
    tituloResultado = "Te encontró";
  }
  if (motivoDerrotaP4 == 2) {
    tituloResultado = "Te quedaste sin palitos";
  }
  subtituloResultado = "La sombra siguió tus publicaciones hasta tu puerta.";
  selloIlustracion = "ENCONTRADA";
  if (gano) {
    tituloResultado = "Prueba superada";
    subtituloResultado = "Juntaste las pruebas: ahora sabes cómo te encontró.";
    selloIlustracion = "PROTEGIDA";
  }
  explicacionIlustracion = "La puerta 17: el número salió\nen el fondo de tus fotos.";
  fraseVidaReal = "El número de tu puerta, la vista desde tu ventana o la fachada de tu casa son datos de ubicación, aunque tengas el GPS apagado.";
  consejoVidaReal = "Desactiva la ubicación en tus publicaciones y revisa el fondo de tus fotos antes de subirlas.";
  datoResultado = 3;
  ilustracionResultado = 4;
  puntosResultado = puntosGanadosP4;
}


// la puerta 17 para la pantalla de resultado (dentro del pushMatrix del resultado, centrada en 0, 0)
void dibujarPuertaResultadoP4() {
  float e = width / 1920.0;
  pushMatrix();
  translate(0, 20 * e);
  scale(0.85);
  noStroke();
  image(imagenesCargadas[110], -96 * e, -180 * e, 192 * e, 350 * e);
  image(imagenesCargadas[108], -50 * e, -242 * e, 100 * e, 52 * e);
  fill(60, 40, 20);
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(40 * e);
  text("17", 0, -218 * e);
  popMatrix();
  strokeWeight(1);
}


// 22 - ACTO I - PRUEBA 4 - PRUEBA PERDIDA
void dibujarPerdidaP4() {
  dibujarResultado(false);
}


// 23 - ACTO I - PRUEBA 4 - PRUEBA SUPERADA
void dibujarSuperadaP4() {
  dibujarResultado(true);
}


// teclas en la pantalla 21 (al soltar, soltarTeclaP4)
void teclaP4() {
  if (keyCode == LEFT || key == 'a' || key == 'A') {
    izquierdaP4 = true;
  }
  if (keyCode == RIGHT || key == 'd' || key == 'D') {
    derechaP4 = true;
  }
  if (keyCode == UP || key == 'w' || key == 'W' || key == ' ') {
    if (faseP4 == 1 && enSueloP4 && dentroPuertaP4 < 0) {
      velYP4 = -23;
      enSueloP4 = false;
      inicioSaltoP4 = millis();
      sonidosCargadosSample[34].trigger();
      for (int polvo = 0; polvo < 4; polvo++) {
        agregarParticulaP4(jugadorXP4, jugadorYP4 - 4, random(-2.5, 2.5), random(-1.5, 0), 350, random(8, 14), color(160, 140, 130, 150));
      }
    }
  }
  if (keyCode == DOWN || key == 's' || key == 'S') {
    accionP4();
  }
}


void soltarTeclaP4() {
  if (keyCode == LEFT || key == 'a' || key == 'A') {
    izquierdaP4 = false;
  }
  if (keyCode == RIGHT || key == 'd' || key == 'D') {
    derechaP4 = false;
  }
}


// guarda una particula (x, y en el pasillo; vida en ms); si se llenan las 60, reemplaza la mas vieja
void agregarParticulaP4(float x, float y, float vx, float vy, int vida, float tam, color colorParticula) {
  partXP4[siguientePartP4] = x;
  partYP4[siguientePartP4] = y;
  partVXP4[siguientePartP4] = vx;
  partVYP4[siguientePartP4] = vy;
  partInicioP4[siguientePartP4] = millis();
  partVidaP4[siguientePartP4] = vida;
  partTamP4[siguientePartP4] = tam;
  partColorP4[siguientePartP4] = colorParticula;
  siguientePartP4 = (siguientePartP4 + 1) % cantidadPartP4;
}


// las particulas se mueven, caen un poco, se achican y se apagan
void dibujarParticulasP4(float e) {
  noStroke();
  for (int k = 0; k < cantidadPartP4; k++) {
    int pasado = millis() - partInicioP4[k];
    if (pasado < partVidaP4[k]) {
      float vida = 1 - pasado / (float) partVidaP4[k];
      partXP4[k] += partVXP4[k] * dtP4;
      partYP4[k] += partVYP4[k] * dtP4;
      partVYP4[k] += 0.15 * dtP4;
      fill(partColorP4[k], alpha(partColorP4[k]) * vida);
      float tam = partTamP4[k] * (0.4 + 0.6 * vida) * e;
      ellipse((partXP4[k] - camaraP4) * e, partYP4[k] * e, tam, tam);
    }
  }
}


// APAGON: todo queda a oscuras menos un circulo de luz alrededor del jugador; los ojos de la sombra brillan en lo oscuro
void dibujarOscuridadP4(float e) {
  float oscuro = constrain((1 - luzP4) / 0.88, 0, 1);
  if (oscuro > 0.01) {
    // la luz va un poco adelante, hacia donde miras, y respira
    float centroX = (jugadorXP4 - camaraP4 + mirandoP4 * 120) * e;
    float centroY = (jugadorYP4 - 90) * e;
    float lado = ladoOscuridadP4 * e * (1 + sin(millis() * 0.004) * 0.03);
    float izquierda = centroX - lado / 2;
    float arriba = centroY - lado / 2;

    // la imagen con el circulo, y cuatro rectangulos negros alrededor para tapar el resto
    tint(255, 255 * oscuro);
    image(oscuridadP4, izquierda, arriba, lado, lado);
    noTint();
    noStroke();
    fill(0, 240 * oscuro);
    rect(0, 0, width, max(0, arriba));
    rect(0, arriba + lado, width, max(0, height - arriba - lado));
    rect(0, arriba, max(0, izquierda), lado);
    rect(izquierda + lado, arriba, max(0, width - izquierda - lado), lado);

    // las cartas brillan en lo oscuro (para que no te pegue algo que no viste)
    for (int c = 0; c < cantidadCartasP4; c++) {
      if (cartaActivaP4[c]) {
        fill(255, 120, 170, 120 * oscuro);
        ellipse((cartaXP4[c] - camaraP4) * e, cartaYP4[c] * e, 80 * e, 54 * e);
      }
    }
    dibujarCartasP4(e);

    // los ojos de la sombra se ven en la oscuridad
    float sombraPantalla = (sombraXP4 - camaraP4) * e;
    // (la sombra esta de perfil: un solo ojo)
    fill(255, 40, 40, 230 * oscuro);
    ellipse(sombraPantalla + 33 * e, 691 * e, 9 * e, 16 * e);
    fill(255, 40, 40, 50 * oscuro);
    ellipse(sombraPantalla + 33 * e, 691 * e, 60 * e, 40 * e);

    // la salida brilla a lo lejos cuando ya tienes las 3 pruebas
    if (fragmentosP4 == 3) {
      float salidaX = (5330 - camaraP4) * e;
      fill(255, 220, 140, 120 * oscuro);
      rect(salidaX - 66 * e, 554 * e, 132 * e, 346 * e);
    }
    strokeWeight(1);
  }
}


// OBJETIVO: dice que buscar ahora y una flecha dorada lo senala (en el borde de la pantalla si esta lejos)
void dibujarObjetivoEnPasilloP4(float e) {
  if (faseP4 == 1) {
    String objetivo = "Corre al final del pasillo";
    float metaX = 5330;
    float metaY = 450;
    boolean conFlecha = true;
    if (vueltaP4 == 1 && !fragmentoP4[0]) {
      objetivo = "Busca el espejo";
      metaX = fragmentoXP4[0];
      metaY = 380;
    }
    if (vueltaP4 == 2 && !fragmentoP4[1]) {
      objetivo = "Entra por la puerta 17";
      conFlecha = false;   // hay que leer las placas
    }
    if (vueltaP4 == 3 && !fragmentoP4[2]) {
      objetivo = "Busca la foto de tu cuarto";
      conFlecha = false;   // esta escondida en la oscuridad
    }
    if (vueltaP4 == 3 && fragmentoP4[2]) {
      objetivo = "Corre a la salida";
    }

    // cartel del objetivo, al lado de las casillas
    textFont(fuenteTexto);
    textSize(26 * e);
    float anchoObjetivo = textWidth(objetivo) + 40 * e;
    noStroke();
    fill(0, 170);
    rect(330 * e, 113 * e, anchoObjetivo, 75 * e);
    fill(255, 200, 0);
    textAlign(LEFT, CENTER);
    textSize(20 * e);
    text("Vuelta " + vueltaP4 + " de 3", 350 * e, 135 * e);
    fill(255);
    textSize(26 * e);
    text(objetivo, 350 * e, 165 * e);

    // flecha
    if (!conFlecha) {
      metaX = -100000;   // sin flecha
    }
    float flechaX = (metaX - camaraP4) * e;
    float rebote = sin(millis() * 0.008) * 10 * e;
    fill(255, 200, 0);
    if (!conFlecha) {
      noFill();   // sin flecha: la 17 y la foto hay que buscarlas
    }
    if (flechaX > width - 80 * e) {
      // a la derecha, fuera de la pantalla
      float x = width - 60 * e + rebote;
      triangle(x + 30 * e, metaY * e, x - 10 * e, (metaY - 28) * e, x - 10 * e, (metaY + 28) * e);
    } else {
      if (flechaX < 80 * e) {
        // a la izquierda: hay que volver
        float x = 60 * e - rebote;
        triangle(x - 30 * e, metaY * e, x + 10 * e, (metaY - 28) * e, x + 10 * e, (metaY + 28) * e);
      } else {
        // en pantalla: una flecha que rebota encima
        float y = (metaY - 40) * e + rebote;
        triangle(flechaX - 22 * e, y - 30 * e, flechaX + 22 * e, y - 30 * e, flechaX, y);
      }
    }
  }
}


// RACHA de esquivas al lado del jugador: salta al subir y se desvanece
void dibujarRachaP4(float e) {
  int pasado = millis() - inicioRachaP4;
  if (rachaP4 >= 2 && pasado < 1200) {
    float crece = reboteTelon(pasado / 220.0);
    float opacidad = 255 * (1 - constrain((pasado - 900) / 300.0, 0, 1));
    pushMatrix();
    translate((jugadorXP4 - camaraP4 + 120) * e, (jugadorYP4 - 120) * e);
    scale(0.5 + 0.5 * crece);
    rotate(-0.08);
    noStroke();
    fill(0, 200 * opacidad / 255);
    rect(-80 * e, -28 * e, 160 * e, 56 * e);
    fill(255, 150, 190, opacidad);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(34 * e);
    text("Racha " + rachaP4, 0, -3 * e);
    popMatrix();
  }
}


// PELIGRO: bordes rojos que laten con el corazon cuando la sombra esta cerca, y un destello rojo cuando grita
void dibujarPeligroP4(float e) {
  float cercania = constrain(map(jugadorXP4 - sombraXP4, 600, 150, 0, 1), 0, 1);
  float pulso = max(0, 1 - (millis() - ultimoLatidoP4) / 300.0);
  if (cercania > 0) {
    noFill();
    for (int borde = 0; borde < 8; borde++) {
      stroke(170, 0, 20, (90 * cercania + 90 * pulso * cercania) * (1 - borde / 8.0));
      strokeWeight(18 * e);
      rect(borde * 16 * e, borde * 16 * e, width - borde * 32 * e, height - borde * 32 * e);
    }
    noStroke();
  }
  int pasadoGrito = millis() - inicioGritoP4;
  if (pasadoGrito < 350) {
    fill(255, 0, 0, 70 * (1 - pasadoGrito / 350.0));
    rect(0, 0, width, height);
  }
  strokeWeight(1);
}


// MINIMAPA abajo: el pasillo entero con tu punto, el de la sombra, las pruebas que faltan y la salida
void dibujarMinimapaP4(float e) {
  float mapaX = 580;
  float mapaAncho = 760;
  float mapaY = 1045;

  noStroke();
  fill(0, 170);
  rect((mapaX - 24) * e, (mapaY - 20) * e, (mapaAncho + 48) * e, 40 * e);
  fill(255, 50);
  rect(mapaX * e, (mapaY - 3) * e, mapaAncho * e, 6 * e);

  // lo que ya se trago la oscuridad (detras de la sombra)
  float sombraMapa = mapaX + constrain(sombraXP4 / largoPasilloP4, 0, 1) * mapaAncho;
  fill(150, 0, 20, 160);
  rect(mapaX * e, (mapaY - 3) * e, (sombraMapa - mapaX) * e, 6 * e);

  // pruebas que faltan (rombos dorados) y la salida
  for (int f = 0; f < 3; f++) {
    if (!fragmentoP4[f] && f == 0 && vueltaP4 == 1) {
      float pruebaMapa = (mapaX + fragmentoXP4[f] / largoPasilloP4 * mapaAncho) * e;
      fill(255, 210, 90);
      quad(pruebaMapa, (mapaY - 9) * e, pruebaMapa + 7 * e, mapaY * e, pruebaMapa, (mapaY + 9) * e, pruebaMapa - 7 * e, mapaY * e);
    }
  }
  float salidaMapa = (mapaX + 5330 / largoPasilloP4 * mapaAncho) * e;
  if (fragmentosP4 == 3) {
    fill(255, 210, 90);
  } else {
    fill(150);
  }
  rect(salidaMapa - 2 * e, (mapaY - 12) * e, 4 * e, 24 * e);
  triangle(salidaMapa + 2 * e, (mapaY - 12) * e, salidaMapa + 16 * e, (mapaY - 7) * e, salidaMapa + 2 * e, (mapaY - 2) * e);

  // la sombra (late) y tu
  float latido = 1 + 0.3 * max(0, 1 - (millis() - ultimoLatidoP4) / 300.0);
  fill(235, 40, 50);
  ellipse(sombraMapa * e, mapaY * e, 14 * e * latido, 14 * e * latido);
  float jugadorMapa = (mapaX + jugadorXP4 / largoPasilloP4 * mapaAncho) * e;
  stroke(255, 200, 0);
  strokeWeight(4 * e);
  fill(255);
  ellipse(jugadorMapa, mapaY * e, 14 * e, 14 * e);
  noStroke();
  strokeWeight(1);
}

// cambia de lugar los numeros de las puertas (intercambia cada una con otra al azar)
// y deja anotado donde quedo la 17 (ahi esta la placa de la vuelta 2)
void barajarPuertasP4() {
  for (int i = cantidadPuertasP4 - 1; i > 0; i--) {
    int otra = int(random(i + 1));
    int guardado = numeroPuertaP4[i];
    numeroPuertaP4[i] = numeroPuertaP4[otra];
    numeroPuertaP4[otra] = guardado;
  }
  for (int d = 0; d < cantidadPuertasP4; d++) {
    if (numeroPuertaP4[d] == 17) {
      fragmentoXP4[1] = puertaXP4[d];
      camaraFotoXP4[1] = puertaXP4[d] - 150;
    }
  }
}


// EMPIEZA UNA VUELTA NUEVA: vuelves al principio del mismo pasillo, pero algo cambio
void empezarVueltaP4(int vuelta) {
  boolean repite = vuelta == vueltaP4;   // llego al final sin la prueba
  if (repite) {
    repeticionesP4++;
  }
  vueltaP4 = vuelta;
  inicioVueltaP4 = millis();

  jugadorXP4 = 650;
  jugadorYP4 = pisoP4;
  velYP4 = 0;
  enSueloP4 = true;
  camaraP4 = 0;
  sombraXP4 = 60;
  // cada vez que te saltas una prueba, la sombra vuelve mas rapida (pero nunca mas que 7,2: el jugador corre a 7,5)
  velSombraP4 = min(velSombraVueltaP4[vuelta - 1] + 0.3 * repeticionesP4, 7.2);
  rafagaP4 = false;
  dentroPuertaP4 = -1;
  inicioGritoP4 = -10000;
  for (int c = 0; c < cantidadCartasP4; c++) {
    cartaActivaP4[c] = false;
  }
  ultimaCartaP4 = millis() + 600;   // un respiro al empezar
  // los pines vuelven a aparecer: la sombra publico otra vez tu ubicacion
  for (int p = 0; p < cantidadPinesP4; p++) {
    pinBorradoP4[p] = false;
  }

  // los numeros de las puertas cambian
  barajarPuertasP4();
  for (int d = 0; d < cantidadPuertasP4; d++) {
    inicioVecinoP4[d] = -10000;
    vecinoUsadoP4[d] = false;
  }
  // el zumbido de tension sube en cada vuelta
  float volumenZumbido = volumenAmbiente - 10;
  if (vuelta == 3) {
    volumenZumbido = volumenAmbiente - 3;
  }
  sonidosCargadosAmbiente[4].shiftGain(sonidosCargadosAmbiente[4].getGain(), volumenZumbido, 1500);

  avisoPasoP4 = false;
  if (repite) {
    agregarImpacto("OTRA VEZ", 960, 430, 130, color(255, 90, 90));
    sonidosCargadosSample[40].trigger();   // la sombra grita
    mostrarGloboP4("Me la salté. Otra vez el mismo pasillo.");
  } else {
    agregarImpacto("VUELTA " + vuelta, 960, 430, 130, color(255, 210, 90));
    sonidosCargadosSample[20].trigger();   // susurro
    mostrarGloboP4("Mi cuarto es el 17. Los números cambiaron.");
  }
  sonidosCargadosSample[12].trigger();

  // vuelta 3: se va la luz y la foto se esconde en el lugar de uno de los cuadros
  if (vuelta == 3) {
    apagadoP4 = true;
    inicioApagonP4 = millis();
    sonidosCargadosSample[41].trigger();
    int lugar = int(random(cantidadLugaresFotoP4));
    fragmentoXP4[2] = lugaresFotoP4[lugar];
    fragmentoYP4[2] = 470;
    camaraFotoXP4[2] = lugaresFotoP4[lugar] + 150;
    if (!repite) {
      mostrarGloboP4("Se fue la luz. La foto tiene que estar aquí.");
    }
  }
}


// el jugador piensa algo: sale en un globo encima de su cabeza (2,6 s)
void mostrarGloboP4(String texto) {
  globoP4 = texto;
  inicioGloboP4 = millis();
  sonidosCargadosSample[17].trigger();
}


// GLOBO DE COMIC: pildora blanca (un rectangulo con dos circulos en las puntas) con contorno grueso de tinta,
// colita hacia la cabeza y una sombrita; salta al aparecer y se apaga al final. Las frases largas van en dos lineas
// (se arma con figuras rapidas: primero todo en tinta un poco mas grande y encima lo mismo en blanco, asi no quedan rayas por dentro)
void dibujarGloboP4(float e) {
  int pasado = millis() - inicioGloboP4;
  if (pasado < 2600 && (faseP4 == 1 || faseP4 == 0)) {
    float aparece = reboteTelon(pasado / 260.0);
    float opacidad = 255 * (1 - constrain((pasado - 2200) / 400.0, 0, 1));

    textFont(fuente);
    textSize(30 * e);
    float anchoTexto = textWidth(globoP4);
    float anchoMaximo = 400 * e;
    int lineas = 1;
    if (anchoTexto > anchoMaximo) {
      lineas = 2;
      anchoTexto = anchoTexto / 2 + 40 * e;   // cada linea queda mas o menos a la mitad
    }
    float ancho = anchoTexto + 20 * e;          // largo de la parte recta
    float alto = (30 + 38 * lineas) * e;        // alto de la pildora (y diametro de las puntas)
    float borde = 5 * e;                        // grosor del contorno

    float cabezaX = (jugadorXP4 - camaraP4) * e;
    float globoX = constrain(cabezaX + 60 * e, ancho / 2 + alto / 2 + 20 * e, width - ancho / 2 - alto / 2 - 20 * e);
    float globoY = (jugadorYP4 - 250) * e - alto / 2;
    float colitaX = cabezaX - globoX;           // donde esta la cabeza, visto desde el centro del globo

    pushMatrix();
    translate(globoX, globoY);
    scale(0.3 + 0.7 * aparece);
    rotate(-0.035);
    noStroke();

    // sombrita debajo
    fill(10, 8, 30, 70 * opacidad / 255);
    rect(-ancho / 2, -alto / 2 + 8 * e, ancho, alto);
    ellipse(-ancho / 2, 8 * e, alto, alto);
    ellipse(ancho / 2, 8 * e, alto, alto);

    // TINTA: colita y pildora un poco mas grandes
    fill(tintaP4, opacidad);
    triangle(colitaX - 26 * e, alto / 2 - 14 * e, colitaX + 4 * e, alto / 2 - 14 * e, colitaX - 18 * e, alto / 2 + 42 * e);
    rect(-ancho / 2, -alto / 2 - borde, ancho, alto + borde * 2);
    ellipse(-ancho / 2, 0, alto + borde * 2, alto + borde * 2);
    ellipse(ancho / 2, 0, alto + borde * 2, alto + borde * 2);

    // BLANCO: lo mismo un poco mas chico, encima
    fill(252, 249, 240, opacidad);
    triangle(colitaX - 20 * e, alto / 2 - 18 * e, colitaX - 2 * e, alto / 2 - 18 * e, colitaX - 16 * e, alto / 2 + 31 * e);
    rect(-ancho / 2, -alto / 2, ancho, alto);
    ellipse(-ancho / 2, 0, alto, alto);
    ellipse(ancho / 2, 0, alto, alto);

    // brillo arriba a la izquierda
    fill(255, 255, 255, opacidad);
    ellipse(-ancho / 2 + 4 * e, -alto / 4, alto * 0.35, alto * 0.18);

    // el texto
    fill(28, 22, 54, opacidad);
    textAlign(CENTER, CENTER);
    if (lineas == 1) {
      text(globoP4, 0, -4 * e);
    } else {
      text(globoP4, -ancho / 2 - alto / 4, -alto / 2, ancho + alto / 2, alto - 6 * e);
    }
    popMatrix();
  }
}


// ESCRITO EN LA PARED: palabras en pintura roja con chorreados (x, y en el pasillo; solo si se ve en pantalla)
void dibujarEscritoP4(String texto, float x, float y, float tam, float giro, float e) {
  float escritoX = (x - camaraP4) * e;
  if (escritoX > -400 * e && escritoX < width + 400 * e) {
    pushMatrix();
    translate(escritoX, y * e);
    rotate(giro);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(tam * e);
    noStroke();
    fill(70, 8, 20, 160);
    text(texto, 3 * e, 3 * e);
    fill(200, 28, 48, 225);
    text(texto, 0, 0);
    // chorreados que bajan de las letras
    float ancho = textWidth(texto);
    for (int gota = 0; gota < 5; gota++) {
      float gotaX = -ancho / 2 + ancho * (gota * 0.21 + 0.08);
      float largo = (18 + (gota * 37) % 40) * e;
      rect(gotaX, tam * 0.3 * e, 4 * e, largo);
      ellipse(gotaX + 2 * e, tam * 0.3 * e + largo, 7 * e, 8 * e);
    }
    popMatrix();
  }
}


// la hoja de la puerta del vecino, abierta hacia el pasillo (se dibuja delante del jugador)
void dibujarHojasVecinoP4(float e) {
  for (int d = 0; d < cantidadPuertasP4; d++) {
    int pasadoVecino = millis() - inicioVecinoP4[d];
    if (pasadoVecino >= 550 && pasadoVecino < 1700) {
      float puertaPantalla = (puertaXP4[d] - camaraP4) * e;
      // se abre de golpe con un rebote
      float abre = reboteTelon((pasadoVecino - 550) / 180.0);
      if (pasadoVecino > 1500) {
        abre = 1 - (pasadoVecino - 1500) / 200.0;
      }
      float borde = puertaPantalla + 90 * e;
      float punta = borde + 80 * e * abre;
      stroke(tintaP4);
      strokeWeight(4 * e);
      fill(124, 88, 104);
      quad(borde, 570 * e, punta, 548 * e, punta, 926 * e, borde, 900 * e);
      noStroke();
      fill(90, 62, 86);
      quad(borde + (punta - borde) * 0.55, 560 * e, punta, 548 * e, punta, 926 * e, borde + (punta - borde) * 0.55, 914 * e);
      fill(225, 180, 70);
      ellipse(borde + (punta - borde) * 0.8, 748 * e, 12 * e, 12 * e);
    }
  }
}


// LA FOTO QUE NO EXISTE: la sombra te fotografio desde la camara del techo mientras corrias por el pasillo
// (pasado = ms desde que empezo a caer; cae desde grande con rebote, flash, y despues le cae un sello)
void dibujarFotoReveladaP4(int pasado, float e) {
  if (!sonoFotoP4) {
    sonoFotoP4 = true;
    sonidosCargadosSample[29].trigger();   // obturador
  }
  // fondo oscuro y destello al aparecer
  noStroke();
  fill(0, 150 * constrain(pasado / 300.0, 0, 1));
  rect(0, 0, width, height);

  float cae = reboteTelon(pasado / 450.0);
  pushMatrix();
  translate(960 * e, 500 * e);
  rotate(-0.05);
  scale(lerp(2.4, 1, cae));

  // la polaroid: el pasillo con el jugador corriendo, de espaldas
  noStroke();
  image(imagenesCargadas[115], -290 * e, -207 * e, 580 * e, 414 * e);
  // REC y la hora, como una camara de vigilancia
  fill(230, 40, 40);
  ellipse(-235 * e, -165 * e, 14 * e, 14 * e);
  fill(255);
  textFont(fuenteTexto);
  textAlign(LEFT, CENTER);
  textSize(22 * e);
  text("REC", -220 * e, -166 * e);
  textAlign(RIGHT, CENTER);
  text("23:52", 250 * e, -166 * e);
  // escrito a mano en el borde blanco
  fill(60, 45, 40);
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(34 * e);
  text("Pasillo, desde el techo", 0, 162 * e);
  popMatrix();

  // destello del flash
  if (pasado < 250) {
    fill(255, 230 * (1 - pasado / 250.0));
    rect(0, 0, width, height);
  }

  // sello
  if (pasado > 1100 && !sonoSelloFotoP4) {
    sonoSelloFotoP4 = true;
    sonidosCargadosSample[16].trigger();
  }
  pushMatrix();
  translate(960 * e, 820 * e);
  scale(0.8);
  translate(-960 * e, -820 * e);
  dibujarSello("LA FOTO QUE NO EXISTE", 960, 820, color(225, 40, 55), pasado - 1100, -0.08);
  popMatrix();
}
