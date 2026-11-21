// PRUEBA 3 - EL SIMBOLO: "ETIQUETADO" (pantallas 18, 19 y 20)
// nueve fotos donde te etiquetaron; de ellas salen brazos con pulseras. Clic en el brazo con TU pulsera para quitar
// la etiqueta antes de que la lupa de la sombra lo encuentre. Se gana con 4 etiquetas quitadas; se pierde con 3 "encontrado"

// LAS NUEVE FOTOS (cuadricula de 3 x 3, cada foto es una polaroid de 250 x 250)
String[] amigoP3 = {"vale.23", "juanchoo", "mafe.r", "santi.j", "lau.m", "dani99", "cata", "pipe.g", "majo"};
int cantidadFotosP3 = 9;
char[] otrasVariantesP3 = {'A', 'C', 'D', 'E', 'F', 'G', 'H'};   // todas menos la B (la del jugador)
int cantidadOtrasVariantesP3 = 7;
char[] trampasP3 = {'A', 'G', 'H', 'E'};   // las que mas se parecen a la B (salen mas desde la ronda 2)
int cantidadTrampasP3 = 4;
// color de la manga de cada brazo (cada amigo tiene su ropa)
color[] mangaP3 = {#3B5BA5, #2E8B57, #8E44AD, #C0392B, #D68910, #1ABC9C, #34495E, #E84393, #7F8C8D};

int[] estadoBrazoP3 = new int[9];          // 0 escondido, 1 subiendo, 2 arriba, 3 bajando
int[] inicioBrazoP3 = new int[9];          // millis() en que empezo ese estado
char[] varianteP3 = new char[9];           // simbolo de la pulsera de cada brazo
boolean[] etiquetadoP3 = new boolean[9];   // true = el jugador sigue etiquetado en esa foto
boolean[] encontradoP3 = new boolean[9];   // true = la lupa ya encontro la pulsera en esa foto
int[] inicioEncontradoP3 = new int[9];     // millis() en que cayo el sello ENCONTRADO
int[] inicioEtiquetaCaeP3 = new int[9];    // millis() en que se quito la etiqueta (sale volando)
int[] inicioErrorP3 = new int[9];          // millis() del clic equivocado (X roja)
int[] cubiertaHastaP3 = new int[9];        // millis() hasta el que una carta del mago tapa la foto
int[] inicioCartaP3 = new int[9];          // millis() en que el mago lanzo la carta a esa foto
float[] origenCartaYP3 = new float[9];     // altura desde la que sale (detras del telon izquierdo)
boolean[] cartaSonoP3 = new boolean[9];    // la carta ya sono al estamparse

// ESTADO DE LA PRUEBA
int faseP3 = -1;                       // -1 = telon y guia, 0 = ver tu simbolo (3 s), 1 = jugar, 2 = cierre (antes del resultado)
int inicioFaseP3 = 0;                  // millis() en que empezo la fase 0
int inicioJuegoP3 = 0;                 // millis() en que empezo a jugar
int rondaP3 = 1;                       // ronda actual (para avisar cuando cambia)
int inicioCambioRondaP3 = -10000;      // millis() del cartel de la ronda nueva
int quitadasP3 = 0;                    // etiquetas quitadas en TODA la prueba (para los puntos)
int quitadasRondaP3 = 0;               // etiquetas quitadas en la ronda actual (se reinicia en cada ronda)
int[] metaRondaP3 = {2, 3, 4};         // etiquetas que hay que quitar en cada ronda
int[] duracionRondaP3 = {20000, 22000, 25000};   // tiempo de cada ronda (ms)
float[] probabilidadBP3 = {0.35, 0.28, 0.25};     // que tan seguido sale TU pulsera en cada ronda
int[] seguroBP3 = {2, 3, 4};                      // despues de tantos brazos sin tu pulsera, sale seguro
int pausaRondaHastaP3 = 0;             // millis() hasta el que dura la pausa entre rondas (no salen brazos)
int[] inicioEtiquetaPoneP3 = new int[9];   // millis() en que la etiqueta vuelve a caer sobre la foto (ronda nueva)
int encontradasP3 = 0;                 // veces que la lupa encontro la pulsera (se pierde con 3)
int erroresP3 = 0;                     // clics en pulseras ajenas (para el bono "sin errores")
int sinBP3 = 0;                        // brazos seguidos sin la B (para que la B no tarde demasiado)
int ultimoBrazoP3 = 0;                 // millis() del ultimo brazo que subio
int ultimaCartaP3 = 0;                 // millis() de la ultima carta del mago
float lupaXP3 = 0;                     // centro de la lupa (medidas de 1920)
float lupaYP3 = 0;
int lupaCeldaP3 = 4;                   // foto a la que va la lupa
int cambioLupaP3 = 0;                  // millis() del ultimo cambio de foto de la lupa
int inicioSacudidaP3 = -10000;         // millis() en que la lupa te encontro (la pantalla se sacude)
float velLupaXP3 = 0;                  // velocidad de la lupa (se lanza, se pasa un poco y rebota)
float velLupaYP3 = 0;
boolean cazandoP3 = false;             // true cuando la lupa va directo hacia tu pulsera
boolean llegoLupaP3 = true;            // true cuando ya llego a su foto y la esta escaneando
int inicioEscaneoP3 = 0;               // millis() en que empezo a escanear
int inicioGolpeLupaP3 = -10000;        // millis() en que te encontro (golpe y onda roja)
float[] rastroXP3 = new float[6];      // ultimas posiciones de la lupa (estela)
float[] rastroYP3 = new float[6];
int cantidadRastroP3 = 6;
int ultimoRastroP3 = 0;                // millis() de la ultima posicion guardada en la estela

// MOMENTOS DE TENSION Y PREMIOS
int rachaP3 = 0;                       // etiquetas seguidas sin errores
int inicioPorPocoP3 = -10000;           // millis() del ultimo "por poco" (la foto da un destello blanco)
int celdaPorPocoP3 = 0;
int porPocoP3 = 0;                     // etiquetas quitadas cuando la lupa ya venia por ellas (+1 cada una, hasta 4)
int[] inicioEscapoP3 = new int[9];     // millis() en que tu pulsera bajo sin que la tocaras (la foto parpadea)
int ultimoLatidoUltimaP3 = 0;          // latido extra de la "ultima oportunidad" (2 veces encontrado)

// AYUDA DE LA PRIMERA VEZ: el juego se detiene y te muestra tu primera pulsera
boolean ayudaVistaP3 = false;          // true cuando ya se mostro
int ayudaHastaP3 = 0;                  // millis() hasta el que dura la ayuda
int ayudaCeldaP3 = 0;                  // foto donde esta esa primera pulsera
int transcurridoAyudaP3 = 0;           // tiempo de la ronda que habia pasado (el reloj se detiene ahi)

// CELEBRACION ENTRE RONDAS: sello "RONDA SUPERADA" y chispas
int inicioRondaSuperadaP3 = -10000;
boolean sonoCartelP3 = true;           // el whoosh del cartel de la ronda nueva ya sono
float[] chispaXP3 = new float[40];
float[] chispaYP3 = new float[40];
float[] chispaVXP3 = new float[40];
float[] chispaVYP3 = new float[40];
int cantidadChispasP3 = 40;

// FONDOS GUARDADOS: los 9 lugares se dibujan una sola vez y se guardan como imagen (dibujarlos en cada cuadro es lento)
PImage[] fondoGuardadoP3 = new PImage[9];
boolean fondosListosP3 = false;

// CIERRE (fase 2, antes del resultado): al ganar las fotos se dan vuelta; al perder vuelan hacia la sombra
boolean cierreGanoP3 = false;
int inicioCierreP3 = 0;
boolean[] cierreSonoP3 = new boolean[9];   // cada foto suena una sola vez al empezar su animacion
boolean[] vuelaP3 = new boolean[9];        // al perder: fotos que se lleva la sombra
int[] ordenVueloP3 = new int[9];           // en que turno sale volando cada una
int cantidadVuelanP3 = 0;
boolean sonoFinalCierreP3 = false;

int motivoDerrotaP3 = 0;               // 0 = tiempo, 1 = la lupa te encontro 3 veces, 2 = sin palitos (tambien en: contador)
int puntosGanadosP3 = 0;               // puntos de la prueba para la pantalla de resultado

// GUIA DE LA PRUEBA 3
String[] titulosGuiaP3 = {
  "Tu cordura",
  "El tiempo",
  "Exposición",
  "Tus puntos",
  "Las fotos",
  "Tu pulsera",
  "Los brazos",
  "La lupa",
  "La sombra",
  "A jugar"
};
String[] textosGuiaP3 = {
  "Estos palitos son tu cordura. Si haces clic en una pulsera que no es la tuya, pierdes uno. Si se acaban, pierdes la prueba.",
  "Lo que te queda para terminar. En los últimos 10 segundos la barra se pone roja.",
  "Cuánto de tu vida pueden ver los desconocidos. Sube sola mientras la sombra busca, y mucho más cada vez que te encuentra.",
  "Cada etiqueta suma 2 puntos. Si la quitas justo cuando la lupa venía por ella, ganas 1 extra. Al final hay bonos por no equivocarte y si la lupa nunca te encuentra.",
  "Tus amigos te etiquetaron en estas 9 fotos. La etiqueta blanca de la esquina dice que apareces ahí.",
  "Este es el símbolo de tu pulsera: un triángulo con la línea en el centro y una pequeña abertura en el lado izquierdo. Las demás pulseras se le parecen, pero siempre tienen una diferencia.",
  "De las fotos van a salir brazos con pulseras. Haz clic en el brazo que lleve TU pulsera para quitar la etiqueta, antes de que baje.",
  "Es la sombra buscándote. Si pasa por encima de tu pulsera mientras sigues etiquetado, te encuentra. Si la foto late en rojo, apúrate. Con 3 veces, pierdes.",
  "Está esperando que te equivoques. Cada vez que te encuentra, sabe un poco más de ti.",
  "Son 3 rondas, cada una con su tiempo: quita 2 etiquetas, después 3 y al final 4. Pierdes un palito si haces clic en una pulsera ajena, y pierdes si la lupa te encuentra 3 veces. Pulsa ENTER para empezar."
};
float[][] zonasGuiaP3 = {
  {20, 8, 330, 80},        // plato de zanahorias
  {690, 22, 540, 100},     // contador
  {1385, 8, 490, 78},      // exposicion
  {1580, 98, 310, 80},     // marcador
  {245, 135, 816, 816},    // la cuadricula
  {1090, 200, 580, 410},   // panel con tu pulsera
  {245, 135, 816, 816},    // la cuadricula otra vez (brazos)
  {565, 400, 280, 280},    // la lupa (empieza en la foto del centro)
  {1560, 290, 340, 520},   // la sombra
  {960, 540, 0, 0}         // sin zona: recuadro en el centro
};
int cantidadPasosGuiaP3 = 10;


// esquina de cada foto (medidas de 1920)
float celdaXP3(int i) {
  return 260 + (i % 3) * 268;
}
float celdaYP3(int i) {
  return 150 + (i / 3) * 268;
}


// prepara la prueba (se llama al terminar el contexto)
void iniciarP3() {
  duracionPrueba = duracionRondaP3[0];
  inicioPrueba = millis();
  palitos = 5;

  for (int i = 0; i < cantidadFotosP3; i++) {
    estadoBrazoP3[i] = 0;
    etiquetadoP3[i] = true;
    encontradoP3[i] = false;
    inicioEncontradoP3[i] = -10000;
    inicioEtiquetaCaeP3[i] = -10000;
    inicioErrorP3[i] = -10000;
    cubiertaHastaP3[i] = 0;
    inicioCartaP3[i] = -10000;
    cartaSonoP3[i] = true;
    inicioEtiquetaPoneP3[i] = -10000;
  }

  faseP3 = -1;
  rondaP3 = 1;
  inicioCambioRondaP3 = -10000;
  quitadasP3 = 0;
  quitadasRondaP3 = 0;
  pausaRondaHastaP3 = 0;
  encontradasP3 = 0;
  erroresP3 = 0;
  sinBP3 = 0;
  ultimoBrazoP3 = 0;
  ultimaCartaP3 = 0;
  lupaCeldaP3 = 4;
  lupaXP3 = celdaXP3(4) + 125;      // empieza en la foto del centro
  lupaYP3 = celdaYP3(4) + 110;
  cambioLupaP3 = 0;
  inicioSacudidaP3 = -10000;
  velLupaXP3 = 0;
  velLupaYP3 = 0;
  cazandoP3 = false;
  llegoLupaP3 = true;
  inicioGolpeLupaP3 = -10000;
  for (int r = 0; r < cantidadRastroP3; r++) {
    rastroXP3[r] = lupaXP3;
    rastroYP3[r] = lupaYP3;
  }
  rachaP3 = 0;
  porPocoP3 = 0;
  for (int i = 0; i < cantidadFotosP3; i++) {
    inicioEscapoP3[i] = -10000;
  }
  ayudaVistaP3 = false;
  ayudaHastaP3 = 0;
  inicioRondaSuperadaP3 = -10000;
  sonoCartelP3 = true;
  mensajePrueba = "";

  prepararAroLupaP3();   // aros de la lupa como imagenes (una sola vez)

  empezarAmbientePrueba();
  empezarTelon();
  empezarGuia(titulosGuiaP3, textosGuiaP3, zonasGuiaP3, cantidadPasosGuiaP3);
}


// dibuja el simbolo de la pulsera: triangulo con una linea; "variante" va de A a H (la B es la del jugador)
// con contorno negro detras para que se vea en estilo comic
void dibujarSimbolo(float centroX, float centroY, float tam, char variante) {
  for (int capa = 0; capa < 2; capa++) {

    pushMatrix();
    translate(centroX, centroY);

    // D y F son el triangulo invertido
    if (variante == 'D' || variante == 'F') {
      rotate(PI);
    }

    float alto = tam * 0.87;
    noFill();
    if (capa == 0) {
      stroke(0);
      strokeWeight(max(4, tam * 0.13));   // contorno negro grueso
    } else {
      stroke(235, 45, 60);
      strokeWeight(max(2, tam * 0.06));
    }

    line(0, -alto/2, tam/2, alto/2);        // lado derecho
    line(tam/2, alto/2, -tam/2, alto/2);    // base

    // lado izquierdo: la B tiene una pequena abertura
    if (variante == 'B') {
      line(-tam/2, alto/2, -tam * 0.35, alto * 0.2);
      line(-tam * 0.19, -alto * 0.12, 0, -alto/2);
    } else {
      line(-tam/2, alto/2, 0, -alto/2);
    }

    // la linea del centro, segun la variante
    if (variante == 'A') {
      line(-tam * 0.175, -alto * 0.15, tam * 0.175, -alto * 0.15);   // un poco arriba del centro
    }
    if (variante == 'C') {
      line(-tam * 0.3, alto * 0.15, tam * 0.12, -alto * 0.12);       // diagonal que no toca el borde derecho
    }
    if (variante == 'D') {
      line(-tam * 0.325, alto * 0.15, tam * 0.325, alto * 0.15);     // un poco debajo del centro
    }
    if (variante == 'G') {
      line(-tam * 0.25, 0, tam * 0.1, 0);                            // linea con una interrupcion en el extremo
      line(tam * 0.18, 0, tam * 0.25, 0);
    }
    if (variante == 'B' || variante == 'E' || variante == 'F' || variante == 'H') {
      line(-tam * 0.25, 0, tam * 0.25, 0);                           // linea exactamente en el centro
    }
    if (variante == 'E') {
      line(-tam * 0.06, alto * 0.3, tam * 0.06, alto * 0.3);         // segunda linea corta abajo
    }
    if (variante == 'H') {
      if (capa == 0) {
        fill(0);
      } else {
        fill(235, 45, 60);
      }
      ellipse(0, alto/2 + tam * 0.14, tam * 0.1, tam * 0.1);         // punto debajo del vertice inferior
    }

    popMatrix();
  }
  strokeWeight(1);
}


// que tiene de distinto cada pulsera ajena (se muestra al equivocarse)
String diferenciaP3(char variante) {
  if (variante == 'A') {
    return "Esa no: la línea está más arriba.";
  }
  if (variante == 'C') {
    return "Esa no: la línea va en diagonal.";
  }
  if (variante == 'D') {
    return "Esa no: está al revés y la línea más abajo.";
  }
  if (variante == 'E') {
    return "Esa no: tiene una rayita de más abajo.";
  }
  if (variante == 'F') {
    return "Esa no: está al revés.";
  }
  if (variante == 'G') {
    return "Esa no: la línea está cortada en la punta.";
  }
  if (variante == 'H') {
    return "Esa no: tiene un punto abajo.";
  }
  return "Esa no era tu pulsera.";
}


// un brazo con su mano, la pulsera y la manga; centroX y arriba en pixeles de pantalla, esc ya incluye la escala de pantalla
// giroSimbolo: cuanto gira el simbolo en la pulsera (radianes); desde la ronda 2 se balancea
// (imagenes: el brazo mide 140 x 274 y su muneca, de unos 82 de ancho, queda a 148 de arriba;
// la pulsera mide 112 x 60 y su cara esta al 47 % de su ancho)
void dibujarBrazoP3(float centroX, float arriba, float esc, char variante, color manga, float giroSimbolo) {
  noStroke();

  // antebrazo y puno
  image(imagenesCargadas[88], centroX - 70 * esc, arriba - 6 * esc, 140 * esc, 274 * esc);

  // la pulsera en la muneca, con el simbolo en su cara
  // (en el dibujo la muneca no esta en el centro del brazo: esta 13 px a la derecha)
  image(imagenesCargadas[89], centroX - 40 * esc, arriba + 118 * esc, 112 * esc, 60 * esc);
  pushMatrix();
  translate(centroX + 13 * esc, arriba + 148 * esc);
  rotate(giroSimbolo);
  dibujarSimbolo(0, 0, 40 * esc, variante);
  popMatrix();

  // manga de la ropa del amigo: la imagen es gris y se pinta del color de cada amigo
  tint(manga);
  image(imagenesCargadas[90], centroX - 70 * esc, arriba + 225 * esc, 140 * esc, 86 * esc);
  noTint();
  strokeWeight(1);
}


// carta de amor del mago (sobre rosado con un corazon), centrada en (x, y) en pixeles de pantalla
void dibujarCartaP3(float x, float y, float giro, float escala, float opacidad, float e) {
  pushMatrix();
  translate(x, y);
  rotate(giro);
  scale(escala);
  noStroke();
  tint(255, opacidad);
  image(imagenesCargadas[91], -120 * e, -91 * e, 240 * e, 182 * e);
  noTint();
  popMatrix();
  strokeWeight(1);
}


// guante blanco de mago que se asoma desde el telon izquierdo (x, y en pixeles de pantalla)
// (la imagen tiene los dedos a la izquierda: se dibuja en espejo para que apunten a las fotos)
void dibujarGuanteP3(float x, float y, float e) {
  pushMatrix();
  translate(x + 50 * e, y);
  scale(-1, 1);
  image(imagenesCargadas[92], 0, -63 * e, 150 * e, 126 * e);
  popMatrix();
}


// el fondo de cada foto: un lugar distinto donde te etiquetaron (x, y = esquina del hueco en pixeles; mide 226 x 196)
// son las imagenes 79 a 87 (fiesta, playa, salon, concierto, parque, cumpleanos, ciudad, piscina, campamento)
// al final se oscurece un poco para que el brazo y la pulsera se vean bien
void dibujarFondoFotoP3(int i, float x, float y, float e) {
  image(imagenesCargadas[79 + i], x, y, 226 * e, 196 * e);

  // oscurecer un poco para que el brazo resalte
  noStroke();
  fill(0, 80);
  rect(x, y, 226 * e, 196 * e);
  strokeWeight(1);
}


// el brazo con tu pulsera para la pantalla de resultado (x, y en medidas de 1920, dentro del pushMatrix del resultado)
void dibujarPulseraP3(float x, float y, float tam) {
  float e = width / 1920.0;
  // la pulsera queda arriba del centro, para que el sello caiga sobre el antebrazo y no tape el simbolo
  dibujarBrazoP3(x * e, (y - 228 * tam) * e, tam * e, 'B', #3B5BA5, 0);
}


// 18 - ACTO I - PRUEBA 3 - ETIQUETADO
void dibujarEtiquetadoP3() {
  float e = width / 1920.0;

  // CIERRE: la animacion final reemplaza al juego hasta que empieza el resultado
  if (faseP3 == 2) {
    dibujarCierreP3();
    return;
  }

  // la primera vez: se dibujan los 9 fondos de las fotos y se guardan como imagen; despues solo se pegan
  if (!fondosListosP3) {
    for (int i = 0; i < cantidadFotosP3; i++) {
      float guardaX = (celdaXP3(i) + 12) * e;
      float guardaY = (celdaYP3(i) + 12) * e;
      clip(guardaX, guardaY, 226 * e, 196 * e);
      dibujarFondoFotoP3(i, guardaX, guardaY, e);
      noClip();
      fondoGuardadoP3[i] = get(int(guardaX), int(guardaY), ceil(226 * e), ceil(196 * e));
    }
    fondosListosP3 = true;
    background(26, 5, 8);
  }

  // la sombra mira la lupa (y se asoma con ansia cuando caza)
  sombraMiraX = lupaXP3;
  sombraMiraY = lupaYP3;
  sombraAnsia = 0;
  if (cazandoP3) {
    sombraAnsia = 1;
  }

  // la pantalla se sacude 0,35 s cuando la lupa te encuentra
  pushMatrix();
  if (millis() - inicioSacudidaP3 < 350) {
    translate(random(-9, 9) * e, random(-9, 9) * e);
  }

  background(0);
  image(imagenesCargadas[67], 0, 0, width, height);   // el mismo escenario de la prueba 2
  noStroke();
  fill(255, 230, 235, 18);
  triangle(960 * e, 90 * e, 300 * e, 1080 * e, 1620 * e, 1080 * e);

  // FASES: al terminar el telon y la guia se ve tu simbolo 3 s; despues se juega (el reloj corre desde ahi)
  if (faseP3 == -1 && !telonActivo && !guiaActiva) {
    faseP3 = 0;
    inicioFaseP3 = millis();
  }
  if (faseP3 <= 0) {
    inicioPrueba = millis();
  }
  if (faseP3 == 0 && millis() - inicioFaseP3 >= 3000) {
    faseP3 = 1;
    inicioJuegoP3 = millis();
    inicioPrueba = millis();
  }

  // RONDAS: cada una tiene su meta de etiquetas y su propio reloj; entre rondas hay una pausa de 1,5 s (el reloj espera)
  int ronda = rondaP3;
  boolean enPausa = millis() < pausaRondaHastaP3;
  if (enPausa) {
    inicioPrueba = millis();
  }
  int brazosAlaVez = ronda;                 // 1, 2 o 3 brazos arriba a la vez
  int tiempoArriba = 2000 - ronda * 400;    // 1600, 1200 u 800 ms
  if (ronda == 3) {
    tiempoArriba = 900;
  }
  int cambioLupa = 3000 - ronda * 500;      // 2500, 2000 o 1500 ms

  // la sombra detras del telon y el telon recogido
  float tension = calcularTension();
  dibujarSombraYTelon(tension);

  // titulo
  fill(255);
  textFont(fuenteTexto);
  textAlign(LEFT, CENTER);
  textSize(30 * e);
  text("Fotos en las que apareces: 9", 260 * e, 122 * e);

  // AYUDA DE LA PRIMERA VEZ: mientras dura, el reloj se detiene y tu pulsera se queda arriba esperando
  boolean enAyuda = millis() < ayudaHastaP3;
  if (enAyuda) {
    inicioPrueba = millis() - transcurridoAyudaP3;
    inicioBrazoP3[ayudaCeldaP3] = millis();
  }

  // LOGICA DE LOS BRAZOS (solo jugando, y no durante la pausa entre rondas ni durante la ayuda)
  if (faseP3 == 1 && !enPausa && !enAyuda) {

    for (int i = 0; i < cantidadFotosP3; i++) {
      int pasadoBrazo = millis() - inicioBrazoP3[i];
      if (estadoBrazoP3[i] == 1 && pasadoBrazo >= 300) {
        estadoBrazoP3[i] = 2;
        inicioBrazoP3[i] = millis();

        // la primera vez que sale tu pulsera, el juego te la muestra
        if (!ayudaVistaP3 && rondaP3 == 1 && varianteP3[i] == 'B' && etiquetadoP3[i]) {
          ayudaVistaP3 = true;
          ayudaHastaP3 = millis() + 2400;
          ayudaCeldaP3 = i;
          transcurridoAyudaP3 = millis() - inicioPrueba;
          sonidosCargadosSample[10].trigger();
        }
      }
      if (estadoBrazoP3[i] == 2 && pasadoBrazo >= tiempoArriba) {
        estadoBrazoP3[i] = 3;
        inicioBrazoP3[i] = millis();

        // tu pulsera bajo sin que la tocaras: la foto parpadea y la sombra se rie
        if (varianteP3[i] == 'B' && etiquetadoP3[i] && !encontradoP3[i]) {
          inicioEscapoP3[i] = millis();
          rachaP3 = 0;
          sombraReacciona(2);
          agregarImpacto("SE TE ESCAPÓ", celdaXP3(i) + 125, celdaYP3(i) + 110, 64, color(255));
        }
      }
      if (estadoBrazoP3[i] == 3 && pasadoBrazo >= 300) {
        estadoBrazoP3[i] = 0;
      }
    }

    // sube un brazo nuevo si hay menos de los que tocan
    int arriba = 0;
    for (int i = 0; i < cantidadFotosP3; i++) {
      if (estadoBrazoP3[i] != 0) {
        arriba++;
      }
    }

    if (arriba < brazosAlaVez && millis() - ultimoBrazoP3 > 300) {
      int celdaElegida = int(random(cantidadFotosP3));
      // no salen brazos en fotos tapadas por una carta ni en las que ya tienen el sello ENCONTRADO
      if (estadoBrazoP3[celdaElegida] == 0 && millis() > cubiertaHastaP3[celdaElegida] && !encontradoP3[celdaElegida]) {

        estadoBrazoP3[celdaElegida] = 1;
        inicioBrazoP3[celdaElegida] = millis();
        ultimoBrazoP3 = millis();
        sonidosCargadosSample[26].trigger();   // pop del brazo que sube

        // tu pulsera sale con un ritmo asegurado: al azar segun la ronda, y seguro despues de 2, 3 o 4 brazos sin ella
        // (asi la ronda depende de tu punteria y no de la suerte); solo donde aun puede quitarse la etiqueta
        // tu pulsera nunca sale en la foto donde ya esta la lupa (no daria tiempo de reaccionar)
        boolean puedeB = etiquetadoP3[celdaElegida] && !encontradoP3[celdaElegida] && celdaElegida != lupaCeldaP3;
        if (puedeB && (random(1) < probabilidadBP3[ronda - 1] || sinBP3 >= seguroBP3[ronda - 1])) {
          varianteP3[celdaElegida] = 'B';
          sinBP3 = 0;
        } else {
          // desde la ronda 2, 6 de cada 10 son trampas (las que mas se parecen a la tuya)
          if (ronda >= 2 && random(1) < 0.6) {
            varianteP3[celdaElegida] = trampasP3[int(random(cantidadTrampasP3))];
          } else {
            varianteP3[celdaElegida] = otrasVariantesP3[int(random(cantidadOtrasVariantesP3))];
          }
          sinBP3++;
        }
      }
    }

    // la lupa cambia de foto cada cierto tiempo
    if (millis() - cambioLupaP3 > cambioLupa) {
      int celdaAntes = lupaCeldaP3;
      lupaCeldaP3 = int(random(cantidadFotosP3));

      // la lupa caza: si tu pulsera esta arriba y etiquetada, a veces va directo hacia ella (35 %, 55 % o 75 % segun la ronda)
      boolean caza = false;
      float probabilidadCaza = 0.15 + ronda * 0.2;
      if (random(1) < probabilidadCaza) {
        for (int i = 0; i < cantidadFotosP3; i++) {
          // solo caza una pulsera que ya lleva 0,4 s arriba (si no, iria por ella apenas aparece)
          if (estadoBrazoP3[i] == 2 && millis() - inicioBrazoP3[i] >= 400 && varianteP3[i] == 'B' && etiquetadoP3[i] && !encontradoP3[i]) {
            lupaCeldaP3 = i;
            caza = true;
          }
        }
      }
      cazandoP3 = caza;
      cambioLupaP3 = millis();

      if (lupaCeldaP3 != celdaAntes) {
        llegoLupaP3 = false;
        sonidosCargadosSample[22].trigger();   // zumbido del salto
      }
      if (caza) {
        sonidosCargadosSample[24].trigger();   // alarma: va por tu pulsera
      }
    }

    // cartas del mago en la ronda 3: tapan dos fotos durante 1 s
    if (ronda == 3 && millis() - ultimaCartaP3 > 5000) {
      for (int carta = 0; carta < 2; carta++) {
        int tapada = int(random(cantidadFotosP3));
        inicioCartaP3[tapada] = millis() + carta * 200;          // la segunda sale un poco despues
        cubiertaHastaP3[tapada] = inicioCartaP3[tapada] + 1450;  // 0,45 s de vuelo + 1 s tapando
        origenCartaYP3[tapada] = random(300, 850);
        cartaSonoP3[tapada] = false;
      }
      ultimaCartaP3 = millis();
      sonidosCargadosSample[11].trigger();
    }
  }

  // la lupa se LANZA a su foto como un resorte: se pasa un poco y rebota (mas fuerte en cada ronda y cuando caza)
  float fuerzaLupa = 0.02 + 0.006 * (rondaP3 - 1);
  if (cazandoP3) {
    fuerzaLupa += 0.012;
  }
  velLupaXP3 += (celdaXP3(lupaCeldaP3) + 125 - lupaXP3) * fuerzaLupa;
  velLupaYP3 += (celdaYP3(lupaCeldaP3) + 110 - lupaYP3) * fuerzaLupa;
  velLupaXP3 *= 0.84;
  velLupaYP3 *= 0.84;
  lupaXP3 += velLupaXP3;
  lupaYP3 += velLupaYP3;

  // al llegar a su foto empieza a escanearla
  if (!llegoLupaP3 && dist(lupaXP3, lupaYP3, celdaXP3(lupaCeldaP3) + 125, celdaYP3(lupaCeldaP3) + 110) < 25) {
    llegoLupaP3 = true;
    inicioEscaneoP3 = millis();
    if (faseP3 == 1) {
      sonidosCargadosSample[23].trigger();
    }
  }

  // estela: se guardan las ultimas posiciones (la mas nueva en el lugar 0), una cada 45 ms
  // (por tiempo y no por cuadro: a 60 FPS seis cuadros son muy poco y los aros quedaban amontonados)
  if (millis() - ultimoRastroP3 >= 45) {
    ultimoRastroP3 = millis();
    for (int r = cantidadRastroP3 - 1; r > 0; r--) {
      rastroXP3[r] = rastroXP3[r - 1];
      rastroYP3[r] = rastroYP3[r - 1];
    }
    rastroXP3[0] = lupaXP3;
    rastroYP3[0] = lupaYP3;
  }

  // LAS NUEVE FOTOS
  for (int i = 0; i < cantidadFotosP3; i++) {

    float fotoX = celdaXP3(i) * e;
    float fotoY = celdaYP3(i) * e;
    float huecoX = fotoX + 12 * e;
    float huecoY = fotoY + 12 * e;

    // marco de polaroid y la foto oscura
    noStroke();
    fill(0, 90);
    rect(fotoX + 6 * e, fotoY + 8 * e, 250 * e, 250 * e);
    fill(245, 240, 228);
    rect(fotoX, fotoY, 250 * e, 250 * e);
    image(fondoGuardadoP3[i], int(huecoX), int(huecoY), ceil(226 * e), ceil(196 * e));

    // PELIGRO: la lupa va hacia esta foto y tu pulsera esta arriba y etiquetada: la foto late en rojo
    boolean peligro = faseP3 == 1 && lupaCeldaP3 == i && estadoBrazoP3[i] != 0 && varianteP3[i] == 'B' && etiquetadoP3[i] && !encontradoP3[i];
    if (peligro) {
      fill(255, 40, 40, 70 + 60 * sin(millis() * 0.03));
      rect(huecoX, huecoY, 226 * e, 196 * e);
    }

    // el brazo sube desde abajo (con rebote) y se recorta al hueco de la foto
    if (estadoBrazoP3[i] != 0) {
      float avanceBrazo = 1;
      if (estadoBrazoP3[i] == 1) {
        avanceBrazo = reboteTelon((millis() - inicioBrazoP3[i]) / 300.0);
      }
      if (estadoBrazoP3[i] == 3) {
        avanceBrazo = 1 - constrain((millis() - inicioBrazoP3[i]) / 300.0, 0, 1);
      }
      float arribaBrazo = huecoY + (200 - 188 * avanceBrazo) * e;   // sube hasta 12 px del borde: la pulsera queda entera a la vista

      clip(huecoX, huecoY, 226 * e, 196 * e);
      // desde la ronda 2 los simbolos se balancean (hasta 35 grados): uno girado puede parecer otro
      float giroSimbolo = 0;
      if (rondaP3 >= 2) {
        giroSimbolo = sin(millis() * 0.003 + i * 1.7) * 0.6;
      }
      dibujarBrazoP3(huecoX + 113 * e, arribaBrazo, e, varianteP3[i], mangaP3[i], giroSimbolo);
      noClip();

      // brillo amarillo si el mouse esta encima (se puede hacer clic)
      boolean encima = mouseX > fotoX && mouseX < fotoX + 250 * e && mouseY > fotoY && mouseY < fotoY + 250 * e;
      if (encima && faseP3 == 1) {
        noFill();
        stroke(255, 200, 0);
        strokeWeight(5 * e);
        rect(fotoX - 3 * e, fotoY - 3 * e, 256 * e, 256 * e);
        strokeWeight(1);
      }
    }

    // X roja del clic equivocado (0,6 s)
    int pasadoError = millis() - inicioErrorP3[i];
    if (pasadoError < 600) {
      float avanceError = pasadoError / 600.0;
      stroke(235, 40, 50, 255 * (1 - avanceError));
      strokeWeight(14 * e);
      float tamX = 60 * reboteTelon(pasadoError / 200.0);
      line((celdaXP3(i) + 125 - tamX) * e, (celdaYP3(i) + 110 - tamX) * e, (celdaXP3(i) + 125 + tamX) * e, (celdaYP3(i) + 110 + tamX) * e);
      line((celdaXP3(i) + 125 + tamX) * e, (celdaYP3(i) + 110 - tamX) * e, (celdaXP3(i) + 125 - tamX) * e, (celdaYP3(i) + 110 + tamX) * e);
      strokeWeight(1);
    }

    // por poco: destello blanco que se apaga (0,35 s)
    int pasadoPorPoco = millis() - inicioPorPocoP3;
    if (i == celdaPorPocoP3 && pasadoPorPoco < 350) {
      noStroke();
      fill(255, 220 * (1 - pasadoPorPoco / 350.0));
      rect(fotoX, fotoY, 250 * e, 250 * e);
    }

    // se te escapo: la foto parpadea en blanco (0,7 s)
    int pasadoEscapo = millis() - inicioEscapoP3[i];
    if (pasadoEscapo < 700 && (pasadoEscapo / 120) % 2 == 0) {
      noFill();
      stroke(255);
      strokeWeight(8 * e);
      rect(fotoX, fotoY, 250 * e, 250 * e);
      strokeWeight(1);
    }

    // nombre del amigo en el borde blanco
    fill(60);
    noStroke();
    textFont(fuente);
    textAlign(LEFT, CENTER);
    textSize(22 * e);
    text(amigoP3[i], fotoX + 14 * e, fotoY + 228 * e);

    // la etiqueta: puesta en la esquina, o saliendo volando y girando cuando se quita (0,7 s)
    int pasadoEtiqueta = millis() - inicioEtiquetaCaeP3[i];
    boolean esperandoCaer = etiquetadoP3[i] && millis() < inicioEtiquetaPoneP3[i];   // ronda nueva: aun no le toca caer
    if (!esperandoCaer && (etiquetadoP3[i] || pasadoEtiqueta < 700)) {
      float avanceEtiqueta = 0;
      if (!etiquetadoP3[i]) {
        avanceEtiqueta = pasadoEtiqueta / 700.0;
      }
      // ronda nueva: la etiqueta cae desde arriba y rebota (0,5 s)
      float caeEtiqueta = 0;
      if (etiquetadoP3[i]) {
        caeEtiqueta = -90 * (1 - reboteTelon((millis() - inicioEtiquetaPoneP3[i]) / 500.0));
      }
      pushMatrix();
      translate(fotoX + (212 + 90 * avanceEtiqueta) * e, fotoY + (28 + caeEtiqueta - 120 * avanceEtiqueta + 260 * avanceEtiqueta * avanceEtiqueta) * e);
      rotate(avanceEtiqueta * 5);
      // (rectangulo + triangulo: una figura libre con relleno es muy lenta en P2D)
      noStroke();
      fill(0, 255 * (1 - avanceEtiqueta));
      rect(-28 * e, -16 * e, 45 * e, 32 * e);
      triangle(15 * e, -17 * e, 33 * e, 0, 15 * e, 17 * e);
      fill(250, 250, 245, 255 * (1 - avanceEtiqueta));
      rect(-26 * e, -14 * e, 42 * e, 28 * e);
      triangle(16 * e, -14 * e, 30 * e, 0, 16 * e, 14 * e);
      fill(46, 24, 34);
      ellipse(16 * e, 0, 7 * e, 7 * e);
      popMatrix();
      strokeWeight(1);
    }

    // sello ENCONTRADO (cae y se queda)
    if (encontradoP3[i]) {
      pushMatrix();
      translate((celdaXP3(i) + 125) * e, (celdaYP3(i) + 110) * e);
      scale(0.62);
      dibujarSello("ENCONTRADO", 0, 0, color(235, 40, 50), millis() - inicioEncontradoP3[i], -0.3);
      popMatrix();
    }
  }

  // CARTAS DEL MAGO: un guante sale del telon izquierdo, la carta vuela en arco girando, se estampa en la foto,
  // la tapa 1 s y despues se cae girando
  for (int i = 0; i < cantidadFotosP3; i++) {
    int pasadoCarta = millis() - inicioCartaP3[i];

    // el guante blanco del mago se asoma y vuelve (0,5 s)
    if (pasadoCarta > -150 && pasadoCarta < 350) {
      float asomaGuante = sin(PI * constrain((pasadoCarta + 150) / 500.0, 0, 1));
      dibujarGuanteP3((150 + 70 * asomaGuante) * e, origenCartaYP3[i] * e, e);
    }

    if (pasadoCarta >= 0 && pasadoCarta < 1850) {
      float destinoX = celdaXP3(i) + 125;
      float destinoY = celdaYP3(i) + 115;
      float cartaX = destinoX;
      float cartaY = destinoY;
      float giroCarta = -0.12;
      float escalaCarta = 1;
      float opacidadCarta = 255;

      if (pasadoCarta < 450) {
        // vuelo: arco hacia arriba, girando varias veces y creciendo
        float avanceVuelo = pasadoCarta / 450.0;
        float suaveVuelo = 1 - sq(1 - avanceVuelo);
        cartaX = lerp(170, destinoX, suaveVuelo);
        cartaY = lerp(origenCartaYP3[i], destinoY, avanceVuelo) - 220 * sin(PI * avanceVuelo);
        giroCarta = lerp(-9, -0.12, suaveVuelo);
        escalaCarta = lerp(0.45, 1.1, avanceVuelo);
      } else {
        if (pasadoCarta < 1450) {
          // estampada: rebote al llegar y un temblor leve
          if (!cartaSonoP3[i]) {
            sonidosCargadosSample[28].trigger();   // golpe de papel
            cartaSonoP3[i] = true;
          }
          float golpe = max(0, 1 - (pasadoCarta - 450) / 180.0);
          escalaCarta = 1 + 0.18 * golpe;
          giroCarta = -0.12 + sin(millis() * 0.02) * 0.02;
        } else {
          // se cae: baja acelerando, gira y se desvanece
          float avanceCaida = (pasadoCarta - 1450) / 400.0;
          cartaY = destinoY + 320 * avanceCaida * avanceCaida;
          giroCarta = -0.12 + avanceCaida * 2.2;
          opacidadCarta = 255 * (1 - avanceCaida);
        }
      }
      dibujarCartaP3(cartaX * e, cartaY * e, giroCarta, escalaCarta, opacidadCarta, e);
    }
  }

  // LA LUPA: sobre una foto con tu pulsera arriba y la etiqueta puesta, te encuentra
  if (faseP3 == 1 && !enAyuda) {
    for (int i = 0; i < cantidadFotosP3; i++) {
      // la lupa no te encuentra hasta que tu pulsera lleva 0,6 s arriba: ese es tu tiempo para reaccionar
      if (estadoBrazoP3[i] == 2 && millis() - inicioBrazoP3[i] >= 600 && varianteP3[i] == 'B' && etiquetadoP3[i] && !encontradoP3[i] && dist(lupaXP3, lupaYP3, celdaXP3(i) + 125, celdaYP3(i) + 110) < 70) {
        encontradoP3[i] = true;
        inicioEncontradoP3[i] = millis();
        estadoBrazoP3[i] = 3;
        inicioBrazoP3[i] = millis();
        encontradasP3++;
        inicioSacudidaP3 = millis();
        subirExposicion(10);
        sombraReacciona(2);
        inicioGolpeLupaP3 = millis();
        sonidosCargadosSample[25].trigger();   // golpe grave con chirrido
        rachaP3 = 0;
        mostrarMensaje("La lupa te encontró: " + encontradasP3 + " de 3");
        if (encontradasP3 == 2) {
          agregarImpacto("ÚLTIMA OPORTUNIDAD", 960, 520, 96, color(255, 60, 60));
        }
      }
    }
  }

  // ESCANEO: una linea roja barre la foto que esta mirando la lupa
  if (faseP3 == 1 && llegoLupaP3) {
    float escaneoX = celdaXP3(lupaCeldaP3) + 12;
    float barrido = celdaYP3(lupaCeldaP3) + 12 + 98 + 98 * sin((millis() - inicioEscaneoP3) * 0.006);
    noStroke();
    fill(255, 40, 40, 45);
    rect(escaneoX * e, (barrido - 16) * e, 226 * e, 32 * e);
    stroke(255, 50, 50, 190);
    strokeWeight(4 * e);
    line(escaneoX * e, barrido * e, (escaneoX + 226) * e, barrido * e);
    strokeWeight(1);
  }

  // ESTELA: aros fantasma donde estuvo la lupa (se notan cuando se lanza rapido)
  // (se usa la imagen del aro rojo, agrandada: un circulo con contorno dibujado en cada cuadro es lento en P2D)
  float ladoEstela = aroRojoP3.width * 1.12;   // el aro de la imagen tiene radio 67; la estela, 75
  for (int r = 1; r < cantidadRastroP3; r++) {
    tint(255, 60, 60, 170 * (1 - r / (float) cantidadRastroP3));
    image(aroRojoP3, rastroXP3[r] * e - ladoEstela / 2, rastroYP3[r] * e - ladoEstela / 2, ladoEstela, ladoEstela);
  }
  noTint();

  // temblor: cazando tiembla mucho mas, como con ganas
  float temblorLupa = 1;
  if (cazandoP3) {
    temblorLupa = 5;
  }
  float lupaX = (lupaXP3 + sin(millis() * 0.004) * 8 + random(-temblorLupa, temblorLupa)) * e;
  float lupaY = (lupaYP3 + cos(millis() * 0.005) * 7 + random(-temblorLupa, temblorLupa)) * e;

  // ONDA ROJA cuando te encuentra (0,5 s)
  int pasadoGolpe = millis() - inicioGolpeLupaP3;
  if (pasadoGolpe < 500) {
    float avanceOnda = pasadoGolpe / 500.0;
    noFill();
    stroke(255, 40, 40, 255 * (1 - avanceOnda));
    strokeWeight((14 * (1 - avanceOnda) + 1) * e);
    ellipse(lupaX, lupaY, lerp(150, 650, avanceOnda) * e, lerp(150, 650, avanceOnda) * e);
  }

  // golpe al encontrarte: se agranda de golpe y vuelve; al moverse rapido se estira hacia donde va
  float golpeLupa = max(0, 1 - pasadoGolpe / 400.0);
  float tamLupa = 1 + 0.5 * golpeLupa * golpeLupa;
  float rapidezLupa = dist(0, 0, velLupaXP3, velLupaYP3);
  float estira = 1 + min(rapidezLupa * 0.015, 0.4);
  float anguloLupa = atan2(velLupaYP3, velLupaXP3);
  float latidoCaza = 0;
  if (cazandoP3) {
    latidoCaza = 0.5 + 0.5 * sin(millis() * 0.025);
  }
  // ultima oportunidad (2 veces encontrado): la lupa crece y su ojo queda rojo
  if (encontradasP3 >= 2) {
    tamLupa = tamLupa * 1.15;
    latidoCaza = max(latidoCaza, 0.6 + 0.4 * sin(millis() * 0.02));
  }

  pushMatrix();
  translate(lupaX, lupaY);
  scale(tamLupa);

  // brillo rojo (late fuerte cuando caza)
  noStroke();
  fill(255, 40, 40, 40 + 90 * latidoCaza);
  ellipse(0, 0, (200 + 50 * latidoCaza) * e, (200 + 50 * latidoCaza) * e);

  // mango de madera (imagen horizontal girada 45 grados; su punta queda pegada al aro)
  pushMatrix();
  translate(50 * e, 50 * e);
  rotate(QUARTER_PI);
  image(imagenesCargadas[94], 0, -16 * e, 110 * e, 33 * e);
  popMatrix();

  // aro y vidrio, estirados hacia donde se mueve
  pushMatrix();
  rotate(anguloLupa);
  scale(estira, 1 / estira);
  rotate(-anguloLupa);

  noStroke();
  fill(60, 10, 18, 80);   // vidrio casi transparente: deja ver la pulsera de abajo
  ellipse(0, 0, 150 * e, 150 * e);

  // EL OJO de la sombra dentro del vidrio: mira tu mouse; cazando, la pupila se achica y el ojo se pone rojo
  float parpadeoLupa = 1;
  if (millis() % 3500 < 120) {
    parpadeoLupa = 0.1;
  }
  // el ojo va arriba en el vidrio, para no tapar la pulsera (parpadea aplastandose; cazando se pone rosado)
  noStroke();
  tint(255, 255 - 85 * latidoCaza, 255 - 85 * latidoCaza);
  image(imagenesCargadas[95], -36 * e, (-36 - 24 * parpadeoLupa) * e, 72 * e, 48 * e * parpadeoLupa);
  noTint();
  if (parpadeoLupa > 0.5) {
    float miraAngulo = atan2(mouseY - lupaY, mouseX - lupaX);
    float irisX = cos(miraAngulo) * 12 * e;
    float irisY = -36 * e + sin(miraAngulo) * 6 * e;
    tint(lerpColor(color(170), color(255), latidoCaza));   // mas oscuro normal, rojo vivo cuando caza
    image(imagenesCargadas[96], irisX - 15 * e, irisY - 15 * e, 30 * e, 30 * e);
    noTint();
    float pupila = 14;
    if (cazandoP3) {
      pupila = 6;
    }
    fill(0);
    ellipse(irisX, irisY, pupila * e, pupila * e);
    fill(255, 200);
    ellipse(irisX - 5 * e, irisY - 5 * e, 6 * e, 6 * e);   // brillo del ojo
  }

  // el aro de la lupa (imagen de 180 x 180): se pone rojo y late cuando caza
  tint(255, 255 - 140 * latidoCaza, 255 - 140 * latidoCaza);
  image(imagenesCargadas[93], -90 * e, -90 * e, 180 * e, 180 * e);
  noTint();
  popMatrix();

  popMatrix();
  strokeWeight(1);

  // PANEL DE LA DERECHA: tu pulsera siempre a la vista, la ronda, las etiquetas quitadas y las veces encontrado
  fill(30, 12, 18, 235);
  stroke(255, 200, 0, 160);
  strokeWeight(3 * e);
  rect(1100 * e, 210 * e, 560 * e, 700 * e);   // llega hasta abajo: cubre tambien la ronda y los contadores (el escenario es claro)
  noStroke();

  fill(255, 200, 0);
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(34 * e);
  text("Tu pulsera", 1380 * e, 250 * e);

  // al empezar a jugar, el simbolo vuela desde el centro de la pantalla hasta su lugar en el panel
  if (faseP3 == 1) {
    float llegada = reboteTelon((millis() - inicioJuegoP3) / 600.0);
    fill(28, 22, 26);
    stroke(0);
    strokeWeight(3 * e);
    rect(1260 * e, 300 * e, 240 * e, 240 * e);
    dibujarSimbolo(lerp(960, 1380, llegada) * e, lerp(560, 425, llegada) * e, lerp(250, 170, llegada) * e, 'B');
  }

  fill(255);
  noStroke();
  textFont(fuenteTexto);
  textAlign(CENTER, CENTER);
  textSize(30 * e);
  text("Ronda " + rondaP3 + " de 3", 1380 * e, 650 * e);

  textSize(26 * e);
  int meta = metaRondaP3[rondaP3 - 1];
  text("Etiquetas de esta ronda", 1380 * e, 705 * e);
  noStroke();
  for (int i = 0; i < meta; i++) {
    fill(255);
    ellipse((1380 - (meta - 1) * 27 + i * 54) * e, 750 * e, 44 * e, 44 * e);
    fill(30, 12, 18);
    if (i < quitadasRondaP3) {
      fill(127, 212, 255);
    }
    ellipse((1380 - (meta - 1) * 27 + i * 54) * e, 750 * e, 40 * e, 40 * e);
  }

  noStroke();
  fill(255);
  text("La lupa te encontró", 1380 * e, 815 * e);
  for (int i = 0; i < 3; i++) {
    fill(235, 40, 50);
    ellipse((1380 - 54 + i * 54) * e, 860 * e, 44 * e, 44 * e);
    fill(30, 12, 18);
    if (i < encontradasP3) {
      fill(235, 40, 50);
    }
    ellipse((1380 - 54 + i * 54) * e, 860 * e, 40 * e, 40 * e);
  }
  strokeWeight(1);

  // cuando caza, un hilo rojo punteado que late une el ojo de la sombra con la lupa
  if (faseP3 == 1 && cazandoP3) {
    float latidoHilo = 0.5 + 0.5 * sin(millis() * 0.02);
    stroke(255, 40, 40, 60 + 90 * latidoHilo);
    strokeWeight(3 * e);
    float largoHilo = dist(ojoSombraX, ojoSombraY, lupaX, lupaY);
    int tramos = int(largoHilo / (18 * e));
    for (int tramo = 0; tramo < tramos; tramo += 2) {
      float desde = tramo / (float) tramos;
      float hasta = (tramo + 1) / (float) tramos;
      line(lerp(ojoSombraX, lupaX, desde), lerp(ojoSombraY, lupaY, desde), lerp(ojoSombraX, lupaX, hasta), lerp(ojoSombraY, lupaY, hasta));
    }
    strokeWeight(1);
  }

  // FASE 0: tu simbolo en grande con una cuenta atras (despues vuela al panel)
  if (faseP3 == 0) {
    float avanceMemoria = (millis() - inicioFaseP3) / 3000.0;
    fill(0, 220);
    noStroke();
    rect(0, 90 * e, width, height);

    fill(255);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(52 * e);
    text("Este es tu símbolo. Memorízalo.", width / 2, 255 * e);

    float aparece = reboteTelon((millis() - inicioFaseP3) / 500.0);
    fill(28, 22, 26);
    stroke(0);
    strokeWeight(4 * e);
    rect(960 * e - 175 * e * aparece, 560 * e - 175 * e * aparece, 350 * e * aparece, 350 * e * aparece);
    dibujarSimbolo(960 * e, 560 * e, 250 * e * aparece, 'B');

    noFill();
    stroke(255, 200, 0);
    strokeWeight(7 * e);
    arc(960 * e, 560 * e, 420 * e, 420 * e, -HALF_PI, -HALF_PI + TWO_PI * (1 - avanceMemoria));   // de y 350 a 770: no toca los textos
    strokeWeight(1);

    fill(255);
    noStroke();
    textSize(32 * e);
    text("Triángulo, línea en el centro y una abertura a la izquierda", width / 2, 870 * e);
  }

  // CELEBRACION: sello "RONDA SUPERADA" y chispas doradas que saltan (0,9 s), antes del cartel de la ronda nueva
  int pasadoSuperada = millis() - inicioRondaSuperadaP3;
  if (pasadoSuperada < 1500) {
    noStroke();
    for (int c = 0; c < cantidadChispasP3; c++) {
      chispaXP3[c] += chispaVXP3[c];
      chispaYP3[c] += chispaVYP3[c];
      chispaVYP3[c] += 0.45;   // gravedad
      if (c % 3 == 0) {
        fill(255, 210, 90, 255 * (1 - pasadoSuperada / 1500.0));
      }
      if (c % 3 == 1) {
        fill(127, 212, 255, 255 * (1 - pasadoSuperada / 1500.0));
      }
      if (c % 3 == 2) {
        fill(255, 255 * (1 - pasadoSuperada / 1500.0));
      }
      pushMatrix();
      translate(chispaXP3[c] * e, chispaYP3[c] * e);
      rotate(c + pasadoSuperada * 0.01);
      rect(-6 * e, -3 * e, 12 * e, 6 * e);
      popMatrix();
    }
  }
  if (pasadoSuperada < 900) {
    dibujarSello("RONDA SUPERADA", 960, 520, color(255, 200, 0), pasadoSuperada, -0.1);
  }

  // cartel de ronda nueva: entra creciendo y se va (1,5 s)
  int pasadoRonda = millis() - inicioCambioRondaP3;
  if (!sonoCartelP3 && pasadoRonda >= 0) {
    sonidosCargadosSample[6].trigger();
    sonoCartelP3 = true;
  }
  if (pasadoRonda >= 0 && pasadoRonda < 1500 && rondaP3 > 1) {
    float creceRonda = reboteTelon(pasadoRonda / 350.0);
    float seVa = constrain((pasadoRonda - 1100) / 400.0, 0, 1);
    String detalleRonda = "Quita 3 etiquetas. Dos brazos a la vez y los símbolos giran";
    if (rondaP3 == 3) {
      detalleRonda = "Quita 4 etiquetas. Tres a la vez y el mago tapa fotos";
    }
    pushMatrix();
    translate(width / 2, 520 * e);
    scale(creceRonda);
    noStroke();
    fill(0, 200 * (1 - seVa));
    rect(-470 * e, -90 * e, 940 * e, 180 * e);
    fill(255, 200, 0, 255 * (1 - seVa));
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(80 * e);
    text("Ronda " + rondaP3, 0, -22 * e);
    fill(255, 255 * (1 - seVa));
    textSize(30 * e);
    text(detalleRonda, 0, 48 * e);
    popMatrix();
  }

  // AYUDA DE LA PRIMERA VEZ: todo se oscurece menos la foto de tu pulsera, con un aro que late y un texto
  if (enAyuda) {
    float ayudaX = (celdaXP3(ayudaCeldaP3) - 10) * e;
    float ayudaY = (celdaYP3(ayudaCeldaP3) - 10) * e;
    float ayudaLado = 270 * e;
    noStroke();
    fill(0, 175);
    rect(0, 0, width, ayudaY);
    rect(0, ayudaY + ayudaLado, width, height - ayudaY - ayudaLado);
    rect(0, ayudaY, ayudaX, ayudaLado);
    rect(ayudaX + ayudaLado, ayudaY, width - ayudaX - ayudaLado, ayudaLado);

    float latidoAyuda = 0.5 + 0.5 * sin(millis() * 0.012);
    noFill();
    stroke(255, 200, 0);
    strokeWeight((5 + 5 * latidoAyuda) * e);
    rect(ayudaX, ayudaY, ayudaLado, ayudaLado);
    strokeWeight(1);

    // el texto va debajo de la foto (o encima si es la fila de abajo)
    float textoAyudaY = celdaYP3(ayudaCeldaP3) + 300;
    if (ayudaCeldaP3 >= 6) {
      textoAyudaY = celdaYP3(ayudaCeldaP3) - 70;
    }
    fill(255, 200, 0);
    noStroke();
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(46 * e);
    text("Esa es tu pulsera", (celdaXP3(ayudaCeldaP3) + 125) * e, textoAyudaY * e);
    fill(255);
    textSize(28 * e);
    text("Haz clic en la foto para quitar la etiqueta", (celdaXP3(ayudaCeldaP3) + 125) * e, (textoAyudaY + 45) * e);
  }

  // ultima oportunidad: un latido extra cada 1,1 s
  if (faseP3 == 1 && encontradasP3 == 2 && millis() - ultimoLatidoUltimaP3 > 1100) {
    sonidosCargadosSample[21].trigger();
    ultimoLatidoUltimaP3 = millis();
  }

  // exposicion, tension, barra de arriba, puntos en vivo y mensajes
  gotearExposicionPrueba();
  dibujarTension(tension);
  dibujarBarraSuperior(color(200, 30, 50));
  dibujarMarcador(quitadasP3 * 2 + min(porPocoP3, 4));
  dibujarMonedas();
  dibujarFlotantes();
  dibujarImpacto();
  dibujarRachaCursor();
  dibujarMensajePrueba();

  popMatrix();

  // se pierde con 3 veces encontrado o sin palitos
  if (encontradasP3 >= 3) {
    perderP3(1);
  } else {
    if (palitos <= 0) {
      perderP3(2);
    }
  }
}


// meta cumplida: empieza la ronda siguiente. Las fotos se vuelven a etiquetar, se borran los sellos,
// los brazos bajan, el reloj se reinicia con el tiempo de la ronda y hay 2,4 s de pausa (sello y despues cartel)
void pasarRondaP3() {
  rondaP3++;
  quitadasRondaP3 = 0;
  for (int i = 0; i < cantidadFotosP3; i++) {
    if (!etiquetadoP3[i]) {
      inicioEtiquetaPoneP3[i] = millis() + 300 + i * 60;   // vuelven a caer una tras otra
    }
    etiquetadoP3[i] = true;
    encontradoP3[i] = false;
    if (estadoBrazoP3[i] == 1 || estadoBrazoP3[i] == 2) {
      estadoBrazoP3[i] = 3;
      inicioBrazoP3[i] = millis();
    }
  }
  duracionPrueba = duracionRondaP3[rondaP3 - 1];
  inicioPrueba = millis();
  pausaRondaHastaP3 = millis() + 2400;
  inicioRondaSuperadaP3 = millis();
  inicioCambioRondaP3 = millis() + 900;   // el cartel sale despues del sello
  sonoCartelP3 = false;
  sonidosCargadosSample[16].trigger();    // sello
  sonidosCargadosSample[10].trigger();    // campanita
  for (int c = 0; c < cantidadChispasP3; c++) {
    float anguloChispa = random(TWO_PI);
    float fuerzaChispa = random(6, 16);
    chispaXP3[c] = 960;
    chispaYP3[c] = 520;
    chispaVXP3[c] = cos(anguloChispa) * fuerzaChispa;
    chispaVYP3[c] = sin(anguloChispa) * fuerzaChispa - 6;
  }
  musicaBajada = false;   // la musica vuelve a bajar en los ultimos 10 s de la ronda nueva
  sonidosCargadosAmbiente[3].shiftGain(sonidosCargadosAmbiente[3].getGain(), volumenAmbiente, 800);
}


// gana al cumplir la ronda 3: 2 por cada una de las 9 etiquetas (18) + hasta 4 "por poco" + 4 sin errores + 4 si nunca te encontro (maximo 30)
void ganarP3() {
  if (faseP3 == 2) {
    return;
  }
  int puntosPorPoco = min(porPocoP3, 4);
  int puntosSinErrores = 0;
  if (erroresP3 == 0) {
    puntosSinErrores = 4;
  }
  int puntosSinEncontrar = 0;
  if (encontradasP3 == 0) {
    puntosSinEncontrar = 4;
  }

  lineaTexto[0] = "Etiquetas quitadas";
  lineaPuntos[0] = quitadasP3 * 2;
  lineaTexto[1] = "Por poco";
  lineaPuntos[1] = puntosPorPoco;
  lineaTexto[2] = "Sin errores";
  lineaPuntos[2] = puntosSinErrores;
  lineaTexto[3] = "Nunca te encontró";
  lineaPuntos[3] = puntosSinEncontrar;
  cantidadLineas = 4;

  puntosGanadosP3 = quitadasP3 * 2 + puntosPorPoco + puntosSinErrores + puntosSinEncontrar;
  puntosJugador += puntosGanadosP3;
  subirExposicion(-5);
  resultadoActo1[2] = 1;
  if (erroresP3 == 0) {
    ganarLogro(2);
  }
  revisarLogrosActos();
  if (pruebasCompletadasActo1 == 2) {
    pruebasCompletadasActo1 = 3;
  }
  empezarCierreP3(true);
}


// pierde la prueba: se filtra el dato; por tiempo o por la lupa, 1 punto por etiqueta quitada; sin palitos, 0
void perderP3(int motivo) {
  if (faseP3 == 2) {
    return;
  }
  motivoDerrotaP3 = motivo;

  puntosGanadosP3 = 0;
  lineaTexto[0] = "Sin palitos";
  lineaPuntos[0] = 0;
  if (motivo != 2) {
    puntosGanadosP3 = quitadasP3;
    lineaTexto[0] = "Etiquetas quitadas";
    lineaPuntos[0] = puntosGanadosP3;
  }
  cantidadLineas = 1;
  puntosJugador += puntosGanadosP3;

  resultadoActo1[2] = 2;
  if (pruebasCompletadasActo1 == 2) {
    pruebasCompletadasActo1 = 3;
  }
  filtrarDato(2);
  empezarCierreP3(false);
}


// textos de la pantalla de resultado de la prueba 3
void llenarResultadoP3(boolean gano) {
  tituloResultado = "Se acabó el tiempo";
  if (motivoDerrotaP3 == 1) {
    tituloResultado = "La sombra te encontró";
  }
  if (motivoDerrotaP3 == 2) {
    tituloResultado = "Te quedaste sin palitos";
  }
  subtituloResultado = "La sombra siguió tu pulsera por las fotos de tus amigos.";
  selloIlustracion = "ENCONTRADA";
  if (gano) {
    tituloResultado = "Prueba superada";
    subtituloResultado = "Quitaste las etiquetas a tiempo: ninguna foto te delata.";
    selloIlustracion = "PROTEGIDA";
  }
  explicacionIlustracion = "Tu pulsera: triángulo, línea en el centro\ny una abertura a la izquierda.";
  fraseVidaReal = "Un detalle como una pulsera, un tatuaje o tu mochila basta para reconocerte en las fotos de otros.";
  consejoVidaReal = "Pídeles a tus amigos que te pregunten antes de etiquetarte o de subir una foto donde sales, y haz tú lo mismo con ellos.";
  datoResultado = 2;
  ilustracionResultado = 3;
  puntosResultado = puntosGanadosP3;
}


// empieza el cierre: al perder, se elige que fotos se lleva la sombra (las encontradas y las que siguen etiquetadas)
void empezarCierreP3(boolean gano) {
  faseP3 = 2;
  cierreGanoP3 = gano;
  inicioCierreP3 = millis();
  sonoFinalCierreP3 = false;
  cantidadVuelanP3 = 0;
  for (int i = 0; i < cantidadFotosP3; i++) {
    cierreSonoP3[i] = false;
    vuelaP3[i] = !gano && (encontradoP3[i] || etiquetadoP3[i]);
    if (vuelaP3[i]) {
      ordenVueloP3[i] = cantidadVuelanP3;
      cantidadVuelanP3++;
    }
  }
  sonidosCargadosAmbiente[3].shiftGain(sonidosCargadosAmbiente[3].getGain(), volumenAmbiente - 8, 600);
}


// una polaroid de la prueba (x, y = esquina en pixeles de pantalla): marco, el lugar de la foto, la etiqueta y el nombre
void dibujarPolaroidP3(int i, float x, float y, float e, boolean conEtiqueta) {
  noStroke();
  fill(0, 90);
  rect(x + 6 * e, y + 8 * e, 250 * e, 250 * e);
  fill(245, 240, 228);
  rect(x, y, 250 * e, 250 * e);
  image(fondoGuardadoP3[i], x + 12 * e, y + 12 * e, 226 * e, 196 * e);
  fill(60);
  textFont(fuente);
  textAlign(LEFT, CENTER);
  textSize(22 * e);
  text(amigoP3[i], x + 14 * e, y + 228 * e);
  if (conEtiqueta) {
    noStroke();
    fill(0);
    rect(x + 184 * e, y + 12 * e, 45 * e, 32 * e);
    triangle(x + 227 * e, y + 11 * e, x + 245 * e, y + 28 * e, x + 227 * e, y + 45 * e);
    fill(250, 250, 245);
    rect(x + 186 * e, y + 14 * e, 42 * e, 28 * e);
    triangle(x + 228 * e, y + 14 * e, x + 242 * e, y + 28 * e, x + 228 * e, y + 42 * e);
    noStroke();
    strokeWeight(1);
  }
}


// el reverso de la polaroid: papel con renglones, "ya no apareces aqui" a mano y un visto celeste
void dibujarReversoP3(float x, float y, float e) {
  noStroke();
  fill(0, 90);
  rect(x + 6 * e, y + 8 * e, 250 * e, 250 * e);
  fill(238, 230, 214);
  rect(x, y, 250 * e, 250 * e);
  stroke(200, 185, 165);
  strokeWeight(2 * e);
  for (int renglon = 1; renglon < 6; renglon++) {
    line(x + 20 * e, y + renglon * 40 * e, x + 230 * e, y + renglon * 40 * e);
  }
  noStroke();
  fill(60, 45, 40);
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(30 * e);
  text("ya no apareces\naquí", x + 125 * e, y + 105 * e);
  stroke(80, 180, 230);
  strokeWeight(9 * e);
  line(x + 95 * e, y + 185 * e, x + 118 * e, y + 208 * e);
  line(x + 118 * e, y + 208 * e, x + 160 * e, y + 160 * e);
  strokeWeight(1);
  noStroke();
}


// CIERRE: al ganar, las 9 fotos se dan vuelta una por una; al perder, la sombra se lleva tus fotos volando
void dibujarCierreP3() {
  float e = width / 1920.0;
  int pasado = millis() - inicioCierreP3;

  background(0);
  image(imagenesCargadas[67], 0, 0, width, height);   // el mismo escenario de la prueba 2
  noStroke();
  fill(255, 230, 235, 18);
  triangle(960 * e, 90 * e, 300 * e, 1080 * e, 1620 * e, 1080 * e);

  // la sombra mira las fotos; al perder, con ansia
  sombraMiraX = 650;
  sombraMiraY = 550;
  sombraAnsia = 0;
  if (!cierreGanoP3) {
    sombraAnsia = 1;
  }
  dibujarSombraYTelon(0);

  int duracionCierre = 2400;
  if (!cierreGanoP3) {
    duracionCierre = 300 + cantidadVuelanP3 * 140 + 700 + 900;
  }

  // titulo que cuenta las fotos donde todavia apareces
  int apareces = 0;
  for (int i = 0; i < cantidadFotosP3; i++) {
    boolean yaVolteada = cierreGanoP3 && pasado > 200 + i * 150 + 150;
    boolean yaSeFue = !cierreGanoP3 && vuelaP3[i] && pasado > 300 + ordenVueloP3[i] * 140 + 700;
    if (!yaVolteada && !yaSeFue) {
      apareces++;
    }
  }
  fill(255);
  textFont(fuenteTexto);
  textAlign(LEFT, CENTER);
  textSize(30 * e);
  text("Fotos en las que apareces: " + apareces, 260 * e, 122 * e);

  for (int i = 0; i < cantidadFotosP3; i++) {
    float centroX = celdaXP3(i) + 125;
    float centroY = celdaYP3(i) + 125;

    if (cierreGanoP3) {
      // GANO: la foto se da vuelta (se angosta hasta 0, cambia de cara y vuelve a abrirse) y se levanta un poco
      int inicioVuelta = 200 + i * 150;
      float avanceVuelta = constrain((pasado - inicioVuelta) / 300.0, 0, 1);
      if (pasado >= inicioVuelta && !cierreSonoP3[i]) {
        sonidosCargadosSample[28].trigger();
        cierreSonoP3[i] = true;
      }
      float anchoVuelta = cos(PI * avanceVuelta);
      boolean reverso = anchoVuelta < 0;
      if (reverso) {
        anchoVuelta = -anchoVuelta;
      }
      float levanta = 1 + 0.1 * sin(PI * avanceVuelta);

      pushMatrix();
      translate(centroX * e, centroY * e);
      scale(max(0.02, anchoVuelta) * levanta, levanta);
      if (reverso) {
        dibujarReversoP3(-125 * e, -125 * e, e);
      } else {
        dibujarPolaroidP3(i, -125 * e, -125 * e, e, true);
      }
      popMatrix();
    } else {
      if (!vuelaP3[i]) {
        dibujarPolaroidP3(i, celdaXP3(i) * e, celdaYP3(i) * e, e, false);
      } else {
        // PERDIO: la foto vuela en arco hacia la sombra, girando, achicandose y apagandose
        int inicioVuelo = 300 + ordenVueloP3[i] * 140;
        float avanceVuelo = constrain((pasado - inicioVuelo) / 700.0, 0, 1);
        if (pasado >= inicioVuelo && !cierreSonoP3[i]) {
          sonidosCargadosSample[22].trigger();
          cierreSonoP3[i] = true;
        }
        if (avanceVuelo < 1) {
          float suaveVuelo = avanceVuelo * avanceVuelo;
          float vueloX = lerp(centroX, 1690, suaveVuelo);
          float vueloY = lerp(centroY, 440, suaveVuelo) - 160 * sin(PI * avanceVuelo);

          pushMatrix();
          translate(vueloX * e, vueloY * e);
          rotate(avanceVuelo * 5);
          scale(lerp(1, 0.12, suaveVuelo));
          dibujarPolaroidP3(i, -125 * e, -125 * e, e, etiquetadoP3[i]);
          if (encontradoP3[i]) {
            scale(0.62);
            dibujarSello("ENCONTRADO", 0, 0, color(235, 40, 50), 1000, -0.3);
          }
          popMatrix();
        }
      }
    }
  }

  // al perder, cuando llega la ultima foto la sombra se asoma de golpe
  if (!cierreGanoP3 && !sonoFinalCierreP3 && pasado > 300 + cantidadVuelanP3 * 140 + 700) {
    sombraReacciona(2);
    sonoFinalCierreP3 = true;
  }

  dibujarBarraSuperior(color(200, 30, 50));
  dibujarMarcador(quitadasP3 * 2 + min(porPocoP3, 4));

  // termina el cierre: empieza la pantalla de resultado
  if (pasado > duracionCierre) {
    llenarResultadoP3(cierreGanoP3);
    empezarResultado(cierreGanoP3);
    if (cierreGanoP3) {
      pantalla = 20;
    } else {
      pantalla = 19;
    }
  }
}


// el tiempo se acabo (lo llama el contador)
void tiempoAgotadoP3() {
  perderP3(0);
}


// 19 - ACTO I - PRUEBA 3 - PRUEBA PERDIDA
void dibujarPerdidaP3() {
  dibujarResultado(false);
}


// 20 - ACTO I - PRUEBA 3 - PRUEBA SUPERADA
void dibujarSuperadaP3() {
  dibujarResultado(true);
}


// clic en la pantalla 18: quitar la etiqueta del brazo que lleva TU pulsera
void clicP3() {
  float e = width / 1920.0;

  if (faseP3 == 1) {
    for (int i = 0; i < cantidadFotosP3; i++) {

      float fotoXC = celdaXP3(i) * e;
      float fotoYC = celdaYP3(i) * e;
      boolean dentro = mouseX > fotoXC && mouseX < fotoXC + 250 * e && mouseY > fotoYC && mouseY < fotoYC + 250 * e;
      boolean brazoVisible = estadoBrazoP3[i] == 1 || estadoBrazoP3[i] == 2;

      boolean tapada = millis() > inicioCartaP3[i] + 450 && millis() < cubiertaHastaP3[i];
      if (dentro && brazoVisible && !tapada) {

        if (varianteP3[i] == 'B' && etiquetadoP3[i] && !encontradoP3[i]) {

          // acierto: la etiqueta sale volando, suma 2 y la sombra se esconde
          ayudaHastaP3 = 0;   // si estaba la ayuda, termina
          etiquetadoP3[i] = false;
          inicioEtiquetaCaeP3[i] = millis();
          estadoBrazoP3[i] = 3;
          inicioBrazoP3[i] = millis();
          quitadasP3++;
          quitadasRondaP3++;
          ultimoCambioPuntos = millis();
          agregarFlotante("+2", celdaXP3(i) + 125, celdaYP3(i) + 60, color(255, 210, 90));
          agregarMoneda(celdaXP3(i) + 125, celdaYP3(i) + 60);
          sombraReacciona(1);
          subirExposicion(-2);
          sonidosCargadosSample[19].trigger();
          sonidosCargadosSample[27].trigger();   // papel que se rasga
          mostrarMensaje("Etiqueta quitada.");

          // por poco: la lupa ya venia por esta foto
          if (cazandoP3 && lupaCeldaP3 == i) {
            porPocoP3++;
            agregarImpacto("POR POCO", celdaXP3(i) + 125, celdaYP3(i) + 110, 92, color(255, 150, 60));
            inicioPorPocoP3 = millis();
            celdaPorPocoP3 = i;
            sonidosCargadosSample[10].trigger();

            // la lupa sale rebotada (como si la empujaras) y huye a otra foto
            float empujeX = lupaXP3 - mouseX / e;
            float empujeY = lupaYP3 - mouseY / e;
            float largoEmpuje = max(1, dist(0, 0, empujeX, empujeY));
            velLupaXP3 += empujeX / largoEmpuje * 45;
            velLupaYP3 += empujeY / largoEmpuje * 45;
            lupaCeldaP3 = (i + 4) % cantidadFotosP3;
            cazandoP3 = false;
            cambioLupaP3 = millis();
          }

          // racha: etiquetas seguidas sin errores
          rachaP3++;
          if (rachaP3 >= 2) {
            mostrarRachaCursor(rachaP3);
          }

          // meta de la ronda cumplida: siguiente ronda, o se gana si era la ultima
          if (quitadasRondaP3 >= metaRondaP3[rondaP3 - 1]) {
            if (rondaP3 == 3) {
              ganarP3();
            } else {
              pasarRondaP3();
            }
          }
        } else {
          if (varianteP3[i] == 'B') {
            mostrarMensaje("La sombra ya te encontró en esta foto.");
          } else {

            // error: esa pulsera es de otra persona
            perderPalito();
            erroresP3++;
            rachaP3 = 0;
            inicioErrorP3[i] = millis();
            estadoBrazoP3[i] = 3;
            inicioBrazoP3[i] = millis();
            sombraReacciona(2);
            mostrarMensaje(diferenciaP3(varianteP3[i]));
          }
        }
      }
    }
  }
}


// ARO DE LA ESTELA: una imagen que se arma una sola vez, pixel por pixel, segun la distancia al centro
// aroRojoP3 = aro blanco (de radio 63 a 71) que se pinta de rojo con tint (el aro de la lupa es la imagen 93)
PImage aroRojoP3;

void prepararAroLupaP3() {
  if (aroRojoP3 == null) {
    float e = width / 1920.0;
    int lado = int(180 * e);
    aroRojoP3 = createImage(lado, lado, ARGB);
    aroRojoP3.loadPixels();
    for (int fila = 0; fila < lado; fila++) {
      for (int columna = 0; columna < lado; columna++) {
        float distancia = dist(columna, fila, lado / 2.0, lado / 2.0) / e;   // en medidas de 1920
        float rojo = constrain(min(distancia - 63, 71 - distancia) * e + 0.5, 0, 1);
        aroRojoP3.pixels[fila * lado + columna] = color(255, 255 * rojo);
      }
    }
    aroRojoP3.updatePixels();
  }
}
