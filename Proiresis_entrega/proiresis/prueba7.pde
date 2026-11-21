// PRUEBA 7 - ACTO II - PRUEBA 3: LLUVIA DE NOTIFICACIONES (pantallas 33 juego, 34 perdida, 35 superada)
// cierre del acto. FASE 1: una batalla por turnos contra EL PUBLICO (estilo Undertale): en su turno te lanza
// notificaciones dentro de una caja y tu corazon las esquiva; en tu turno eliges que hacer. No se gana peleando:
// se gana escuchandote hasta tener claridad y decidiendo por ti.
// FASE 2: todo se apaga; sin publico, eliges una situacion y escribes tu respuesta a la pregunta final.

String respuestaFinal = "";                 // lo que el jugador escribio al final del Acto II (se usa en los finales del juego)

// TU CARA: las expresiones recortadas en circulo (alegre, enojado, sorprendido, triste, pensativo, cansado)
PImage[] avatarP7 = new PImage[6];
int caraYoP7 = 1;
int caraHastaP7 = 0;

// LA BATALLA
int batallaP7 = 0;                          // 0 texto de entrada, 1 menu, 2 texto de la accion, 3 ataque, 4 texto despues del ataque, 5 decidiste
float claridadP7 = 0;                       // 0 a 100: con 100, DECIDIR funciona
float claridadMostradaP7 = 0;
float presionP7 = 40;                       // 0 a 100: con mas presion, los ataques son mas rapidos
float presionMostradaP7 = 40;
int silenciosP7 = 2;                        // cuantas veces puedes silenciar
boolean silenciadoP7 = false;               // el proximo ataque es suave
boolean decidioP7 = false;                  // eligio DECIDIR con la claridad llena

// EL TEXTO (se escribe letra por letra)
String textoBatallaP7 = "";
int inicioTextoP7 = 0;
int letrasSonadasP7 = 0;

// EL MENU
String[] accionP7 = {"SATISFACERLOS", "LO CONTRARIO", "ESCUCHARTE", "SILENCIAR", "DECIDIR"};
int cantidadAccionesP7 = 5;
int accionElegidaP7 = -1;

// LA CAJA DE BATALLA (centro y tamano, medidas de 1920): cambia suave entre la caja del ataque y la del texto
float cajaXP7 = 960;
float cajaYP7 = 600;
float cajaAnchoP7 = 1300;
float cajaAltoP7 = 230;

// TU CORAZON
float almaXP7 = 960;
float almaYP7 = 600;
boolean arribaP7 = false;
boolean abajoP7 = false;
boolean izquierdaP7 = false;
boolean derechaP7 = false;
int invulnerableHastaP7 = 0;

// EL ATAQUE
int patronP7 = 0;                           // 0 circulo de celulares, 1 ola de likes, 2 muro, 3 focos, 4 espiral
String[] nombrePatronP7 = {"CÍRCULO DE CELULARES", "OLA DE LIKES", "MURO DE NOTIFICACIONES", "FOCOS DEL TRENDING", "ESPIRAL DE COMENTARIOS"};
int inicioAtaqueP7 = 0;
int duracionAtaqueP7 = 6500;
int nivelP7 = 0;                             // que tan dificil es este ataque: 0 (claridad baja), 1 (desde 40), 2 (desde 70)
int pasoP7 = 0;                              // cuantas veces ya disparo el patron (anillos, muros, focos...)
float giroEspiralP7 = 0;                     // angulo de la espiral
float espiralXP7 = 960;                      // donde esta la campana (se mueve por la caja)
float espiralYP7 = 600;
int anillosEspiralP7 = 0;                    // anillos completos que ya lanzo la campana

// LOS FOCOS DEL TRENDING: primero una franja de aviso, despues el rayo
int cantidadFocosP7 = 6;
boolean[] focoActivoP7 = new boolean[6];
boolean[] focoHorizontalP7 = new boolean[6];
float[] focoPosP7 = new float[6];            // y si es horizontal, x si es vertical
int[] focoInicioP7 = new int[6];
float cajaMetaAnchoP7 = 560;                 // tamano de la caja del ataque (se achica con la claridad)
float cajaMetaAltoP7 = 330;
int turnosP7 = 0;                            // ataques que ya pasaron
int golpesAtaqueP7 = 0;
int rocesAtaqueP7 = 0;                      // claridad ganada rozando en este ataque (tiene tope)
float multiP7 = 1;                          // que tan rapido y seguido ataca (sube con la presion)
String[] gritosP7 = {"PUBLICA ALGO!", "TODOS LO HACEN!", "QUEREMOS MÁS!", "NO SEAS ABURRIDO!", "DEMUESTRA QUIÉN ERES!", "SUBE OTRA!"};
int gritoP7 = 0;
int inicioGritoP7 = 0;
int ultimoTransAtaqueP7 = 0;                 // para descontar solo el tiempo de los ataques

// LAS BALAS (tarjetas de notificacion, likes que rebotan y "!" que te apuntan)
int cantidadBalasP7 = 90;
float[] balaXP7 = new float[90];
float[] balaYP7 = new float[90];
float[] balaVXP7 = new float[90];
float[] balaVYP7 = new float[90];
float[] balaAnchoP7 = new float[90];        // tarjetas: ancho y alto; circulos: el radio va en el ancho
float[] balaAltoP7 = new float[90];
int[] balaTipoP7 = new int[90];             // 0 tarjeta, 1 like (rebota), 2 "!" (te apunta)
boolean[] balaActivaP7 = new boolean[90];
boolean[] balaRozoP7 = new boolean[90];
// los celulares del circulo: giran alrededor del centro y se lanzan uno por uno
float[] balaAnguloP7 = new float[90];
float[] balaRadioP7 = new float[90];
float[] balaCXP7 = new float[90];
float[] balaCYP7 = new float[90];
int[] balaLanzaP7 = new int[90];             // millis() en que se lanza (0 = ya va volando)
float[] balaRapidezP7 = new float[90];
int[] balaNaceP7 = new int[90];             // millis() en que aparecio el celular (entra creciendo)

// ESTADO
int faseP7 = -1;                             // -1 telon y guia, 1 batalla, 2 se apaga todo, 3 situaciones, 4 pregunta, 5 seguro?, 6 cierre
int inicioJuegoP7 = 0;
int inicioFaseP7 = 0;
int golpesP7 = 0;
int toquesABP7 = 0;                          // veces que eligio SATISFACERLOS o LO CONTRARIO
boolean alcanzoCP7 = false;                  // decidio por si mismo
int ultimoCuadroP7 = 0;
float dtP7 = 0.016;
int restanteAlAlcanzarP7 = 0;
int transcurridoP7 = 0;                      // tiempo de ataques que ya paso (el reloj solo corre durante los ataques)
int eleccionErradaP7 = 0;
int inicioErrorTarjetaP7 = -10000;
String avisoP7 = "";
int inicioAvisoP7 = -10000;
boolean mencionabaP7 = false;
int inicioCierreP7 = 0;
int puntosGanadosP7 = 0;

// GUIA DE LA PRUEBA 7
String[] titulosGuiaP7 = {
  "Tu cordura",
  "Exposición",
  "Tus puntos",
  "El público",
  "Tu corazón",
  "Tu claridad",
  "Tus acciones",
  "A jugar"
};
String[] textosGuiaP7 = {
  "Estos palitos son tu cordura. Si cometes un error, pierdes uno. Si se acaban, pierdes la prueba.",
  "Cuánto de tu vida pueden ver los desconocidos. Sube sola mientras la sombra mira.",
  "Cada acierto suma puntos. Al final hay bonos por no equivocarte y por terminar rápido.",
  "Este es el público. Cuanta más presión tiene, más rápido ataca. No lo vas a vencer peleando.",
  "En su turno, el público te lanza notificaciones dentro de esta caja. Mueve tu corazón con las flechas o con W A S D y esquívalas. Rozarlas sin que te toquen te da claridad.",
  "Tu claridad. Sube cuando te escuchas a ti y cuando esquivas bien. Con la claridad llena puedes decidir por ti.",
  "En tu turno, haz clic en una acción. Satisfacerlos y hacer lo contrario son trampas: siguen decidiendo por ti. Escúchate, silencia y, cuando estés listo, decide.",
  "Esta prueba no tiene tiempo. Pero cuanto más claridad tengas, más se desespera el público y peor ataca. Pulsa ENTER para empezar."
};
float[][] zonasGuiaP7 = {
  {20, 8, 330, 80},
  {1385, 8, 490, 78},
  {1580, 98, 310, 80},
  {540, 95, 840, 300},
  {300, 470, 1320, 270},
  {480, 760, 640, 100},
  {280, 870, 1360, 110},
  {960, 540, 0, 0}
};
int cantidadPasosGuiaP7 = 8;


// prepara la prueba (se llama al terminar el contexto)
void iniciarP7() {
  duracionPrueba = 60000;
  inicioPrueba = millis();
  palitos = 5;

  for (int b = 0; b < cantidadBalasP7; b++) {
    balaActivaP7[b] = false;
  }
  faseP7 = -1;
  batallaP7 = 0;
  claridadP7 = 0;
  claridadMostradaP7 = 0;
  presionP7 = 40;
  presionMostradaP7 = 40;
  silenciosP7 = 2;
  silenciadoP7 = false;
  decidioP7 = false;
  accionElegidaP7 = -1;
  cajaXP7 = 960;
  cajaYP7 = 600;
  cajaAnchoP7 = 1300;
  cajaAltoP7 = 230;
  almaXP7 = 960;
  almaYP7 = 600;
  arribaP7 = false;
  abajoP7 = false;
  izquierdaP7 = false;
  derechaP7 = false;
  golpesP7 = 0;
  toquesABP7 = 0;
  alcanzoCP7 = false;
  transcurridoP7 = 0;
  turnosP7 = 0;
  eleccionErradaP7 = 0;
  respuestaFinal = "";
  mencionabaP7 = false;
  avisoP7 = "";
  caraYoP7 = 1;
  caraHastaP7 = 0;
  invulnerableHastaP7 = 0;
  ultimoCuadroP7 = millis();
  mensajePrueba = "";

  prepararArteP5();
  prepararAvataresP7();

  empezarAmbientePrueba();
  empezarTelon();
  empezarGuia(titulosGuiaP7, textosGuiaP7, zonasGuiaP7, cantidadPasosGuiaP7);
}


// recorta la cara de cada expresion en un circulo (una sola vez): lo de afuera del circulo queda transparente
void prepararAvataresP7() {
  if (avatarP7[0] != null) {
    return;
  }
  for (int k = 0; k < 6; k++) {
    PImage cara = imagenesCargadas[61 + k].get(460 - 170, 330 - 170, 340, 340);
    cara.loadPixels();
    for (int py = 0; py < 340; py++) {
      for (int px = 0; px < 340; px++) {
        if (dist(px, py, 170, 170) > 165) {
          cara.pixels[py * 340 + px] = color(0, 0);
        }
      }
    }
    cara.updatePixels();
    avatarP7[k] = cara;
  }
}


// la cara que pones por un rato
void caraP7(int cual, int duracion) {
  caraYoP7 = cual;
  caraHastaP7 = millis() + duracion;
}


// empieza a escribirse un texto nuevo en la caja (cada linea empieza con una estrellita, como en Undertale)
void textoP7(String texto) {
  textoBatallaP7 = texto;
  inicioTextoP7 = millis();
  letrasSonadasP7 = 0;
}


// cuantas letras del texto ya se ven
int letrasVisiblesP7() {
  return constrain((millis() - inicioTextoP7) / 28, 0, textoBatallaP7.length());
}


// termina la fase 1 sin decidir (por tiempo o sin palitos): se filtra el dato, pero igual hay fase 2
void perderFase1P7() {
  if (faseP7 != 1) {
    return;
  }
  alcanzoCP7 = false;
  filtrarDato(7);
  empezarOscuridadP7();
}


// todo se apaga: se corta la musica y desaparece el publico
void empezarOscuridadP7() {
  faseP7 = 2;
  inicioFaseP7 = millis();
  restanteAlAlcanzarP7 = duracionPrueba - transcurridoP7;
  sonidosCargadosAmbiente[3].pause();
  sonidosCargadosSample[16].trigger();
  cursor(ARROW);
}


// una bala nueva
void balaP7(int tipo, float x, float y, float vx, float vy, float ancho, float alto) {
  for (int b = 0; b < cantidadBalasP7; b++) {
    if (!balaActivaP7[b]) {
      balaActivaP7[b] = true;
      balaTipoP7[b] = tipo;
      balaXP7[b] = x;
      balaYP7[b] = y;
      balaVXP7[b] = vx;
      balaVYP7[b] = vy;
      balaAnchoP7[b] = ancho;
      balaAltoP7[b] = alto;
      balaRozoP7[b] = false;
      return;
    }
  }
}


// empieza el turno del publico: UN ataque, con su forma y su ritmo; la claridad lo hace mas dificil (nivel 0, 1 o 2)
void empezarAtaqueP7() {
  batallaP7 = 3;
  turnosP7++;
  int nuevo = int(random(5));
  if (nuevo == patronP7) {
    nuevo = (nuevo + 1 + int(random(4))) % 5;
  }
  patronP7 = nuevo;
  nivelP7 = 0;
  if (claridadP7 >= 40) {
    nivelP7 = 1;
  }
  if (claridadP7 >= 70) {
    nivelP7 = 2;
  }
  inicioAtaqueP7 = millis();
  pasoP7 = 0;
  giroEspiralP7 = random(TWO_PI);
  espiralXP7 = 960;
  espiralYP7 = 600;
  anillosEspiralP7 = 0;
  golpesAtaqueP7 = 0;
  rocesAtaqueP7 = 0;
  multiP7 = 0.78 + presionP7 / 100.0 * 0.22;
  duracionAtaqueP7 = 7000 + nivelP7 * 1000;
  cajaMetaAnchoP7 = 560;
  cajaMetaAltoP7 = 330;
  if (silenciadoP7) {
    multiP7 *= 0.7;
    nivelP7 = 0;
    duracionAtaqueP7 = 4500;
    silenciadoP7 = false;
  }
  almaXP7 = 960;
  almaYP7 = 600;
  // en la espiral la campana esta en el centro: empiezas abajo
  if (patronP7 == 4) {
    almaYP7 = 600 + cajaMetaAltoP7 / 2 - 40;
  }
  ultimoTransAtaqueP7 = millis();
  for (int b = 0; b < cantidadBalasP7; b++) {
    balaActivaP7[b] = false;
  }
  for (int f = 0; f < cantidadFocosP7; f++) {
    focoActivoP7[f] = false;
  }
  gritoP7 = int(random(6));
  inicioGritoP7 = millis();
  sonidosCargadosSample[45].trigger();
  agregarImpacto(nombrePatronP7[patronP7], 960, 405, 58, color(240, 120, 110));
}


// termina el turno del publico: si no te toco nada, ganas claridad
void terminarAtaqueP7() {
  for (int b = 0; b < cantidadBalasP7; b++) {
    balaActivaP7[b] = false;
  }
  batallaP7 = 4;
  if (golpesAtaqueP7 == 0) {
    claridadP7 = min(100, claridadP7 + 10);
    caraP7(0, 1500);
    textoP7("Esquivaste todo sin perderte.\nClaridad más 10.");
  } else {
    String[] ambiente = {
      "El público te mira desde sus celulares.",
      "Las notificaciones no paran.\nTu celular vibra en tu bolsillo.",
      "Alguien grita tu nombre.\nNo sabes quién es.",
      "El ruido se mete en tu cabeza."
    };
    textoP7(ambiente[int(random(4))]);
  }
  if (claridadP7 >= 100) {
    textoP7("Ya sabes lo que quieres.\nAhora puedes decidir por ti.");
  }
}


// elegiste una accion en tu turno
void elegirAccionP7(int a) {
  accionElegidaP7 = a;
  batallaP7 = 2;
  sonidosCargadosSample[16].trigger();
  if (a == 0) {
    // SATISFACERLOS: baja la presion por un rato, pero pierdes claridad y un palito
    toquesABP7++;
    perderPalito();
    presionP7 = max(0, presionP7 - 25);
    claridadP7 = max(0, claridadP7 - 15);
    inicioOvacionP5 = millis();
    caraP7(3, 2500);
    textoP7("Publicas lo que te piden.\nAplauden... y ahora quieren más.");
    sombraReacciona(2);
  }
  if (a == 1) {
    // LO CONTRARIO: sigues reaccionando a ellos
    toquesABP7++;
    perderPalito();
    presionP7 = min(100, presionP7 + 20);
    claridadP7 = max(0, claridadP7 - 10);
    caraP7(5, 2500);
    textoP7("Haces justo lo contrario.\nSigues reaccionando a ellos. Se enojan más.");
    sombraReacciona(2);
  }
  if (a == 2) {
    // ESCUCHARTE: la accion buena
    claridadP7 = min(100, claridadP7 + 12);
    presionP7 = min(100, presionP7 + 10);
    caraP7(4, 2500);
    textoP7("Cierras los ojos y te escuchas.\nClaridad más 12. El público grita más fuerte.");
    if (claridadP7 >= 40) {
      textoP7("Cierras los ojos y te escuchas.\nEl público lo nota. Sus ataques se ponen más duros.");
    }
    if (claridadP7 >= 70) {
      textoP7("Cierras los ojos y te escuchas.\nEl público se desespera. Viene lo peor.");
    }
    sombraReacciona(1);
  }
  if (a == 3) {
    // SILENCIAR: el proximo ataque es mas suave (2 veces)
    if (silenciosP7 > 0) {
      silenciosP7--;
      silenciadoP7 = true;
      claridadP7 = min(100, claridadP7 + 5);
      caraP7(0, 2000);
      textoP7("Activas No molestar.\nEl próximo ataque será más suave.");
    } else {
      textoP7("Ya silenciaste todo lo que podías.\nEl ruido vuelve igual.");
    }
  }
  if (a == 4) {
    // DECIDIR: solo funciona con la claridad llena
    if (claridadP7 >= 100) {
      decidioP7 = true;
      caraP7(0, 5000);
      textoP7("Decides por ti.\nEl ruido... se apaga.");
      sonidosCargadosAmbiente[3].shiftGain(sonidosCargadosAmbiente[3].getGain(), -60, 2500);
    } else {
      caraP7(4, 2000);
      textoP7("Todavía no sabes qué quieres.\nNecesitas más claridad.");
    }
  }
}


// avanzar el texto: si no termino de escribirse, se completa; si termino, sigue
void avanzarTextoP7() {
  if (letrasVisiblesP7() < textoBatallaP7.length()) {
    inicioTextoP7 = millis() - 100000;
    return;
  }
  if (batallaP7 == 0 || batallaP7 == 4) {
    batallaP7 = 1;
    return;
  }
  if (batallaP7 == 2) {
    if (decidioP7) {
      alcanzoCP7 = true;
      empezarOscuridadP7();
    } else {
      empezarAtaqueP7();
    }
  }
}


// 33 - ACTO II - PRUEBA 3 - LLUVIA DE NOTIFICACIONES
void dibujarLluviaP7() {
  float e = width / 1920.0;
  dtP7 = constrain((millis() - ultimoCuadroP7) / 1000.0, 0, 0.1);
  ultimoCuadroP7 = millis();

  if (faseP7 == -1 && !telonActivo && !guiaActiva) {
    faseP7 = 1;
    inicioJuegoP7 = millis();
    batallaP7 = 0;
    textoP7("EL PÚBLICO te cierra el paso.\nTienes 99 notificaciones sin leer.");
  }

  if (faseP7 <= 1) {
    dibujarFase1P7(e);
  } else {
    dibujarFase2P7(e);
  }
}


// FASE 1: la batalla
void dibujarFase1P7(float e) {
  // esta prueba no tiene tiempo: el reloj se queda quieto (y asi tampoco hay tension de los ultimos segundos)
  inicioPrueba = millis();

  // LOGICA DEL ATAQUE
  if (faseP7 == 1 && batallaP7 == 3) {
    moverAlmaP7();
    dispararP7();
    moverBalasP7();
    if (millis() - inicioGritoP7 > 1500) {
      gritoP7 = int(random(6));
      inicioGritoP7 = millis();
    }
    if (millis() - inicioAtaqueP7 > duracionAtaqueP7) {
      terminarAtaqueP7();
    }
    gotearExposicionPrueba();
  }
  if (faseP7 == 1 && palitos <= 0) {
    perderFase1P7();
  }
  // la presion baja sola un poquito con el tiempo
  if (faseP7 == 1 && batallaP7 != 3) {
    presionP7 = max(0, presionP7 - 1.5 * dtP7);
  }

  // los textos suenan como maquina de escribir
  int letras = letrasVisiblesP7();
  if (letras > letrasSonadasP7 + 1) {
    letrasSonadasP7 = letras;
    sonidosCargadosSample[4].trigger();
  }

  // la caja: chica para el ataque, ancha para el texto
  float metaAncho = 1300;
  float metaAlto = 230;
  if (batallaP7 == 3) {
    metaAncho = cajaMetaAnchoP7;
    metaAlto = cajaMetaAltoP7;
  }
  cajaAnchoP7 = lerp(cajaAnchoP7, metaAncho, 0.15);
  cajaAltoP7 = lerp(cajaAltoP7, metaAlto, 0.15);
  claridadMostradaP7 = lerp(claridadMostradaP7, claridadP7, 0.12);
  presionMostradaP7 = lerp(presionMostradaP7, presionP7, 0.12);

  cursor(ARROW);
  if (faseP7 == 1 && batallaP7 == 1 && accionBajoMouseP7() >= 0) {
    cursor(HAND);
  }

  // DIBUJO
  pushMatrix();
  int pasadoGolpe = millis() - inicioGolpeCaraP5;
  if (pasadoGolpe < 250) {
    translate(random(-8, 8) * e * (1 - pasadoGolpe / 250.0), random(-8, 8) * e * (1 - pasadoGolpe / 250.0));
  }
  background(20, 15, 8);
  noStroke();
  fill(242, 194, 48, 10 + 4 * sin(millis() * 0.002));
  triangle(960 * e, 90 * e, 300 * e, 1080 * e, 1620 * e, 1080 * e);
  dibujarTramaComic(color(242, 194, 48), 8);
  dibujarSombraYTelon(calcularTension());

  dibujarPublicoEnemigoP7(e);
  dibujarCajaP7(e);
  if (batallaP7 == 3) {
    clip((cajaXP7 - cajaAnchoP7 / 2) * e, (cajaYP7 - cajaAltoP7 / 2) * e, cajaAnchoP7 * e, cajaAltoP7 * e);
    dibujarFocosP7(e);
    dibujarBalasP7(e);
    dibujarAlmaP7(e);
    noClip();
    dibujarCelularesP7(e);
  } else {
    dibujarTextoBatallaP7(e);
  }
  dibujarEstadoP7(e);
  dibujarMenuP7(e);
  dibujarPopsP5(e);
  popMatrix();

  dibujarTension(calcularTension());
  dibujarBarraSuperior(color(242, 194, 48));
  int puntosVivo = max(0, 8 - golpesP7);
  if (toquesABP7 == 0) {
    puntosVivo += 5;
  }
  dibujarMarcador(puntosVivo);
  dibujarFlotantes();
  dibujarImpacto();
}


// tu corazon se mueve con las flechas o W A S D, dentro de la caja
void moverAlmaP7() {
  float dx = 0;
  float dy = 0;
  if (arribaP7) {
    dy -= 1;
  }
  if (abajoP7) {
    dy += 1;
  }
  if (izquierdaP7) {
    dx -= 1;
  }
  if (derechaP7) {
    dx += 1;
  }
  // en diagonal se mueve en las dos direcciones a la vez: se divide para que no vaya mas rapido
  if (dx != 0 && dy != 0) {
    dx *= 0.7071;
    dy *= 0.7071;
  }
  float rapidez = 270 * dtP7;
  almaXP7 += dx * rapidez;
  almaYP7 += dy * rapidez;
  almaXP7 = constrain(almaXP7, cajaXP7 - cajaAnchoP7 / 2 + 14, cajaXP7 + cajaAnchoP7 / 2 - 14);
  almaYP7 = constrain(almaYP7, cajaYP7 - cajaAltoP7 / 2 + 14, cajaYP7 + cajaAltoP7 / 2 - 14);
}


// el publico dispara segun la coreografia del ataque (todo depende del tiempo desde que empezo)
void dispararP7() {
  int t = millis() - inicioAtaqueP7;
  float izq = 960 - cajaMetaAnchoP7 / 2;
  float der = 960 + cajaMetaAnchoP7 / 2;
  float arriba = 600 - cajaMetaAltoP7 / 2;
  float abajo = 600 + cajaMetaAltoP7 / 2;
  float m = multiP7;

  // 0 CIRCULO DE CELULARES: aparecen celulares AFUERA de la caja, rodeandola; te apuntan y se disparan
  // uno por uno, en desorden (cada uno desde otro lado), hacia donde estas en ese momento
  if (patronP7 == 0) {
    int cuantos = 8 + nivelP7 * 3;
    int intervalo = 320 - nivelP7 * 60;
    int cadaAnillo = 900 + cuantos * intervalo + 700;
    if (t > 400 + pasoP7 * cadaAnillo && t < duracionAtaqueP7 - 1500) {
      float radioX = cajaMetaAnchoP7 / 2 + 110;
      float radioY = cajaMetaAltoP7 / 2 + 50;
      int salto = 3 + nivelP7;                 // para el orden de disparo: salta de lado en lado
      float giroAnillo = random(TWO_PI);
      for (int k = 0; k < cuantos; k++) {
        int b = celularP7(960, 600, giroAnillo + k * TWO_PI / cuantos, radioX, radioY);
        if (b >= 0) {
          int orden = (k * salto) % cuantos;
          balaLanzaP7[b] = millis() + 900 + orden * intervalo;
          balaRapidezP7[b] = (470 + nivelP7 * 80) * m;
        }
      }
      pasoP7++;
      sonidosCargadosSample[17].trigger();
    }
  }

  // 1 OLA DE LIKES: una serpiente de corazones que ondula de borde a borde; cada tanto deja un hueco para cruzarla
  // (desde el nivel 1, otra serpiente desde el otro lado, con sus huecos corridos)
  if (patronP7 == 1 && t > 500 && t < duracionAtaqueP7 - 1200) {
    int cada = 145 - nivelP7 * 12;
    if (t > 500 + pasoP7 * cada) {
      float onda = sin(t * 0.0026) * (cajaMetaAltoP7 / 2 - 16);
      int tramo = 9 - nivelP7;                 // corazones seguidos antes de cada hueco
      if (pasoP7 % tramo < tramo - 3) {
        balaP7(1, izq - 10, 600 + onda, (300 + nivelP7 * 50) * m, 0, 13, 13);
      }
      if (nivelP7 >= 1 && (pasoP7 + 4) % tramo < tramo - 3) {
        balaP7(1, der + 10, 600 - onda, -(300 + nivelP7 * 50) * m, 0, 13, 13);
      }
      pasoP7++;
    }
  }

  // 2 MURO DE NOTIFICACIONES: bajan al compas; el hueco se mueve en escalera de un lado al otro
  if (patronP7 == 2 && t < duracionAtaqueP7 - 1300) {
    int compas = 1200 - nivelP7 * 170;
    if (t > 500 + pasoP7 * compas) {
      int escalones = 5;
      int posicion = pasoP7 % (escalones * 2 - 2);
      if (posicion >= escalones) {
        posicion = escalones * 2 - 2 - posicion;   // va y vuelve
      }
      float ancho = cajaMetaAnchoP7 - 140;
      float hueco = izq + 70 + posicion * ancho / (escalones - 1);
      float mitadHueco = 75 - nivelP7 * 10;
      for (float x = izq + 24; x < der; x += 48) {
        if (x < hueco - mitadHueco || x > hueco + mitadHueco) {
          balaP7(0, x, arriba - 20, 0, (200 + nivelP7 * 40) * m, 48, 30);
        }
      }
      pasoP7++;
    }
  }

  // 3 FOCOS DEL TRENDING: una franja avisa (roja, parpadea) y despues cae el rayo; desde el nivel 1, a veces en cruz
  if (patronP7 == 3 && t < duracionAtaqueP7 - 1200) {
    int cada = 1200 - nivelP7 * 170;
    if (t > 400 + pasoP7 * cada) {
      boolean horizontal = pasoP7 % 2 == 0;
      nuevoFocoP7(horizontal, horizontal);
      if (nivelP7 >= 1 && pasoP7 % 2 == 1) {
        nuevoFocoP7(true, true);              // en cruz: uno horizontal y otro vertical a la vez
      }
      if (nivelP7 >= 2 && pasoP7 % 3 == 2) {
        nuevoFocoP7(false, false);
      }
      pasoP7++;
    }
  }

  // 4 ESPIRAL DE COMENTARIOS: la campana se pasea por la caja, gira y escupe "!" en brazos (mas brazos con mas nivel);
  // cada tanto lanza un ANILLO completo con un solo hueco, para que no haya un rincon donde quedarse quieto
  if (patronP7 == 4 && t > 900 && t < duracionAtaqueP7 - 800) {
    espiralXP7 = 960 + sin(t * 0.0009) * (cajaMetaAnchoP7 / 2 - 90);
    espiralYP7 = 600 + sin(t * 0.0014) * (cajaMetaAltoP7 / 2 - 70);
    int cada = 170 - nivelP7 * 18;
    float velocidadGiro = 2.0;
    if (nivelP7 >= 1 && t > duracionAtaqueP7 / 2) {
      velocidadGiro = -2.4;                   // a la mitad cambia de sentido
    }
    giroEspiralP7 += velocidadGiro * dtP7;
    float rapidez = (190 + nivelP7 * 25) * m;
    if (t > 900 + pasoP7 * cada) {
      int brazos = 2 + nivelP7;
      for (int k = 0; k < brazos; k++) {
        float angulo = giroEspiralP7 + k * TWO_PI / brazos;
        balaP7(2, espiralXP7, espiralYP7, cos(angulo) * rapidez, sin(angulo) * rapidez, 13, 13);
      }
      pasoP7++;
    }
    int cadaAnillo = 2000 - nivelP7 * 300;
    if (t > 1600 + anillosEspiralP7 * cadaAnillo) {
      int cuantos = 16;
      int hueco = int(random(cuantos));
      for (int k = 0; k < cuantos; k++) {
        if (k != hueco && k != (hueco + 1) % cuantos) {
          float angulo = k * TWO_PI / cuantos;
          balaP7(2, espiralXP7, espiralYP7, cos(angulo) * rapidez * 0.8, sin(angulo) * rapidez * 0.8, 13, 13);
        }
      }
      anillosEspiralP7++;
      sonidosCargadosSample[17].trigger();
    }
  }

  revisarFocosP7();
}


// un celular del circulo, quieto afuera de la caja (devuelve su lugar en los arreglos, o -1 si no hay espacio)
int celularP7(float cx, float cy, float angulo, float radioX, float radioY) {
  for (int b = 0; b < cantidadBalasP7; b++) {
    if (!balaActivaP7[b]) {
      balaActivaP7[b] = true;
      balaTipoP7[b] = 3;
      balaCXP7[b] = cx;
      balaCYP7[b] = cy;
      balaAnguloP7[b] = angulo;
      balaRadioP7[b] = radioX;
      balaAltoP7[b] = radioY;
      balaVXP7[b] = 0;
      balaVYP7[b] = 0;
      balaAnchoP7[b] = 13;
      balaXP7[b] = cx + cos(angulo) * radioX;
      balaYP7[b] = cy + sin(angulo) * radioY;
      balaRozoP7[b] = false;
      balaNaceP7[b] = millis();
      return b;
    }
  }
  return -1;
}


// un foco nuevo: horizontal o vertical; "cruzar" lo pone sobre tu posicion para que te obligue a moverte
void nuevoFocoP7(boolean horizontal, boolean sobreTi) {
  for (int f = 0; f < cantidadFocosP7; f++) {
    if (!focoActivoP7[f]) {
      focoActivoP7[f] = true;
      focoHorizontalP7[f] = horizontal;
      focoInicioP7[f] = millis();
      if (horizontal) {
        focoPosP7[f] = constrain(almaYP7 + random(-40, 40), 600 - cajaMetaAltoP7 / 2 + 35, 600 + cajaMetaAltoP7 / 2 - 35);
      } else {
        focoPosP7[f] = constrain(almaXP7 + random(-50, 50), 960 - cajaMetaAnchoP7 / 2 + 35, 960 + cajaMetaAnchoP7 / 2 - 35);
      }
      return;
    }
  }
}


// los focos: 850 ms de aviso y 350 ms de rayo; si el rayo te toca, es un golpe
void revisarFocosP7() {
  for (int f = 0; f < cantidadFocosP7; f++) {
    if (focoActivoP7[f]) {
      int pasado = millis() - focoInicioP7[f];
      if (pasado > 1200) {
        focoActivoP7[f] = false;
      }
      if (pasado > 850 && pasado < 1200) {
        float distancia = almaXP7 - focoPosP7[f];
        if (focoHorizontalP7[f]) {
          distancia = almaYP7 - focoPosP7[f];
        }
        if (distancia > -42 && distancia < 42) {
          golpeAlmaP7();
        }
      }
    }
  }
}


// te golpearon: pierdes un palito cada 2 golpes y baja tu claridad
void golpeAlmaP7() {
  if (millis() < invulnerableHastaP7) {
    return;
  }
  golpesP7++;
  golpesAtaqueP7++;
  invulnerableHastaP7 = millis() + 900;
  claridadP7 = max(0, claridadP7 - 5);
  presionP7 = min(100, presionP7 + 3);
  inicioGolpeCaraP5 = millis();
  sonidosCargadosSample[44].trigger();
  agregarPopP5(almaXP7, almaYP7, color(240, 120, 110));
  caraP7(2, 700);
  if (golpesP7 % 2 == 0) {
    perderPalito();
    sombraReacciona(2);
  }
}


// mueve las balas; te golpean o te rozan
void moverBalasP7() {
  float izq = cajaXP7 - cajaAnchoP7 / 2;
  float der = cajaXP7 + cajaAnchoP7 / 2;
  float arriba = cajaYP7 - cajaAltoP7 / 2;
  float abajo = cajaYP7 + cajaAltoP7 / 2;
  for (int b = 0; b < cantidadBalasP7; b++) {
    if (balaActivaP7[b] && balaTipoP7[b] == 3 && balaLanzaP7[b] > 0) {
      // el celular espera quieto afuera de la caja; al llegar su turno se lanza hacia donde estas
      balaXP7[b] = balaCXP7[b] + cos(balaAnguloP7[b]) * balaRadioP7[b];
      balaYP7[b] = balaCYP7[b] + sin(balaAnguloP7[b]) * balaAltoP7[b];
      if (millis() >= balaLanzaP7[b]) {
        float dx = almaXP7 - balaXP7[b];
        float dy = almaYP7 - balaYP7[b];
        float d = max(1, dist(0, 0, dx, dy));
        balaVXP7[b] = dx / d * balaRapidezP7[b];
        balaVYP7[b] = dy / d * balaRapidezP7[b];
        balaLanzaP7[b] = 0;
        sonidosCargadosSample[17].trigger();
      }
    } else {
      if (balaActivaP7[b]) {
        balaXP7[b] += balaVXP7[b] * dtP7;
        balaYP7[b] += balaVYP7[b] * dtP7;
      }
    }
    if (balaActivaP7[b]) {

      // se van al salir de la caja; los celulares (que vienen de afuera) se van cuando quedan muy lejos
      if (balaTipoP7[b] == 3) {
        if (balaLanzaP7[b] == 0 && dist(balaXP7[b], balaYP7[b], 960, 600) > 650) {
          balaActivaP7[b] = false;
        }
      } else {
        if (balaYP7[b] > abajo + 60 || balaYP7[b] < arriba - 80 || balaXP7[b] < izq - 60 || balaXP7[b] > der + 60) {
          balaActivaP7[b] = false;
        }
      }

      // distancia de la bala a tu corazon
      float distancia;
      if (balaTipoP7[b] == 0) {
        float cercaX = constrain(almaXP7, balaXP7[b] - balaAnchoP7[b] / 2, balaXP7[b] + balaAnchoP7[b] / 2);
        float cercaY = constrain(almaYP7, balaYP7[b] - balaAltoP7[b] / 2, balaYP7[b] + balaAltoP7[b] / 2);
        distancia = dist(almaXP7, almaYP7, cercaX, cercaY);
      } else {
        distancia = dist(almaXP7, almaYP7, balaXP7[b], balaYP7[b]) - balaAnchoP7[b];
      }

      // te golpea
      if (balaActivaP7[b] && distancia < 9 && millis() > invulnerableHastaP7) {
        balaActivaP7[b] = false;
        golpeAlmaP7();
      }
      // te roza sin tocarte: claridad
      if (balaActivaP7[b] && !balaRozoP7[b] && distancia >= 9 && distancia < 30) {
        balaRozoP7[b] = true;
        if (rocesAtaqueP7 < 12) {
          rocesAtaqueP7 += 2;
          claridadP7 = min(100, claridadP7 + 2);
          agregarFlotante("+2", almaXP7 + 40, almaYP7 - 30, color(170, 220, 250));
          sonidosCargadosSample[17].trigger();
        }
      }
    }
  }
}


// EL PUBLICO (el enemigo): siluetas con celulares que tiemblan con la presion, su nombre y su barra de presion
void dibujarPublicoEnemigoP7(float e) {
  float temblor = presionMostradaP7 / 100.0 * 3;
  for (int k = 0; k < 7; k++) {
    float x = 960 + (k - 3) * 125 + random(-temblor, temblor);
    float y = 250 - sq(sin(millis() * 0.006 + k)) * 10 * (presionMostradaP7 / 100.0) + (k % 2) * 18;
    image(siluetaArteP5[k % 5], (x - 90) * e, (y - 70) * e);
    // el celular encendido en sus manos (mas brillante con mas presion)
    noStroke();
    fill(150, 200, 255, 30 + presionMostradaP7);
    ellipse(x * e, (y + 78) * e, 70 * e, 46 * e);
    image(imagenesCargadas[140], (x - 13) * e, (y + 58) * e, 26 * e, 40 * e);
  }

  // nombre y barra de presion
  noStroke();
  fill(0, 170);
  rect(760 * e, 98 * e, 400 * e, 64 * e);
  fill(245, 235, 215);
  textFont(fuenteTitulo);
  textAlign(LEFT, CENTER);
  textSize(26 * e);
  text("EL PÚBLICO", 776 * e, 117 * e);
  textFont(fuenteTexto);
  textSize(18 * e);
  fill(200, 190, 180);
  text("Presión", 776 * e, 145 * e);
  fill(0, 200);
  rect(860 * e, 136 * e, 280 * e, 16 * e);
  fill(lerpColor(color(228, 188, 106), color(215, 80, 80), presionMostradaP7 / 100.0));
  rect(860 * e, 136 * e, 280 * e * presionMostradaP7 / 100.0, 16 * e);

  // durante el ataque, grita en un globo de historieta
  if (batallaP7 == 3) {
    float entra = reboteTelon((millis() - inicioGritoP7) / 250.0);
    pushMatrix();
    translate(1310 * e, 220 * e);
    scale(0.5 + 0.5 * entra);
    rotate(0.05);
    fill(20, 14, 4);
    rect(-174 * e, -38 * e, 348 * e, 76 * e);
    triangle(-90 * e, 36 * e, -40 * e, 36 * e, -130 * e, 80 * e);
    fill(250, 244, 230);
    rect(-170 * e, -34 * e, 340 * e, 68 * e);
    triangle(-86 * e, 32 * e, -44 * e, 32 * e, -124 * e, 70 * e);
    fill(30, 22, 6);
    textFont(fuenteTitulo);
    textAlign(CENTER, CENTER);
    textSize(28 * e);
    text(gritosP7[gritoP7], 0, -2 * e);
    popMatrix();
  }
}


// la caja de batalla: borde crema grueso con contorno de tinta, fondo negro
void dibujarCajaP7(float e) {
  float x = (cajaXP7 - cajaAnchoP7 / 2) * e;
  float y = (cajaYP7 - cajaAltoP7 / 2) * e;
  noStroke();
  fill(0, 120);
  rect(x + 10 * e, y + 12 * e, cajaAnchoP7 * e, cajaAltoP7 * e);
  fill(20, 14, 4);
  rect(x - 12 * e, y - 12 * e, (cajaAnchoP7 + 24) * e, (cajaAltoP7 + 24) * e);
  fill(245, 235, 215);
  rect(x - 7 * e, y - 7 * e, (cajaAnchoP7 + 14) * e, (cajaAltoP7 + 14) * e);
  fill(8, 6, 12);
  rect(x, y, cajaAnchoP7 * e, cajaAltoP7 * e);
  // barra del tiempo del ataque
  if (batallaP7 == 3) {
    float queda = 1 - constrain((millis() - inicioAtaqueP7) / (float) duracionAtaqueP7, 0, 1);
    fill(245, 235, 215, 120);
    rect(x, y - 24 * e, cajaAnchoP7 * e * queda, 6 * e);
  }
}


// el texto de la caja: cada linea con su estrellita al principio, letra por letra; y el aviso para seguir
void dibujarTextoBatallaP7(float e) {
  if (cajaAnchoP7 < 1100) {
    return;
  }
  String visible = textoBatallaP7.substring(0, letrasVisiblesP7());
  // cuantas lineas ya se ven (una por cada salto de linea)
  int lineas = 1;
  for (int k = 0; k < visible.length(); k++) {
    if (visible.substring(k, k + 1).equals("\n")) {
      lineas++;
    }
  }
  float x = 960 - 600;
  float y = 600 - 80;
  for (int l = 0; l < lineas; l++) {
    dibujarEstrellitaP7(x, y + 26 + l * 62, e);
  }
  fill(245, 240, 230);
  textFont(fuenteTitulo);
  textAlign(LEFT, TOP);
  textSize(38 * e);
  textLeading(62 * e);
  text(visible, (x + 40) * e, y * e);
  if (letrasVisiblesP7() >= textoBatallaP7.length() && batallaP7 != 1) {
    fill(245, 235, 215, 150 + 100 * sin(millis() * 0.01));
    textFont(fuenteTexto);
    textAlign(RIGHT, CENTER);
    textSize(22 * e);
    text("clic o ENTER", (960 + 620) * e, (600 + 90) * e);
  }
}


// la estrellita de cuatro puntas que reemplaza al asterisco
void dibujarEstrellitaP7(float x, float y, float e) {
  noStroke();
  fill(245, 235, 215);
  quad((x - 10) * e, y * e, x * e, (y - 10) * e, (x + 10) * e, y * e, x * e, (y + 10) * e);
}


// los celulares del circulo: aparecen creciendo afuera de la caja, apuntan su parte de arriba hacia ti,
// y justo antes de lanzarse tiemblan, brillan y marcan con una linea roja por donde van a pasar
void dibujarCelularesP7(float e) {
  noStroke();
  for (int b = 0; b < cantidadBalasP7; b++) {
    if (balaActivaP7[b] && balaTipoP7[b] == 3) {
      float x = balaXP7[b];
      float y = balaYP7[b];
      float apunta = atan2(almaYP7 - y, almaXP7 - x);
      if (balaLanzaP7[b] == 0) {
        apunta = atan2(balaVYP7[b], balaVXP7[b]);
      }
      float brillo = 0;
      if (balaLanzaP7[b] > 0) {
        brillo = constrain(1 - (balaLanzaP7[b] - millis()) / 350.0, 0, 1);
        // la linea de aviso
        if (brillo > 0) {
          stroke(230, 70, 70, 120 * brillo);
          strokeWeight(3 * e);
          line(x * e, y * e, almaXP7 * e, almaYP7 * e);
          noStroke();
        }
        x += random(-3, 3) * brillo;
        y += random(-3, 3) * brillo;
      }
      float crece = reboteTelon((millis() - balaNaceP7[b]) / 250.0);
      pushMatrix();
      translate(x * e, y * e);
      rotate(apunta + HALF_PI);
      scale(crece);
      fill(150, 200, 255, 50 + 130 * brillo);
      ellipse(0, 0, 50 * e, 50 * e);
      // el celular; antes de lanzarse su pantalla se pone blanca (la imagen blanca aparece encima)
      image(imagenesCargadas[140], -13 * e, -20 * e, 26 * e, 40 * e);
      tint(255, 255 * brillo);
      image(imagenesCargadas[141], -13 * e, -20 * e, 26 * e, 40 * e);
      noTint();
      popMatrix();
    }
  }
  strokeWeight(1);
}


// los focos del trending (aviso rojo que parpadea y despues el rayo crema) y la campana de la espiral
void dibujarFocosP7(float e) {
  float izq = cajaXP7 - cajaAnchoP7 / 2;
  float arriba = cajaYP7 - cajaAltoP7 / 2;
  noStroke();
  for (int f = 0; f < cantidadFocosP7; f++) {
    if (focoActivoP7[f]) {
      int pasado = millis() - focoInicioP7[f];
      float bx = (focoPosP7[f] - 42) * e;
      float by = arriba * e;
      float bw = 84 * e;
      float bh = cajaAltoP7 * e;
      if (focoHorizontalP7[f]) {
        bx = izq * e;
        by = (focoPosP7[f] - 42) * e;
        bw = cajaAnchoP7 * e;
        bh = 84 * e;
      }
      if (pasado < 850) {
        // aviso: franja roja que parpadea cada vez mas rapido
        float parpadeo = 60 + 50 * sin(pasado * (0.02 + pasado * 0.00004));
        fill(230, 70, 70, parpadeo);
        rect(bx, by, bw, bh);
      } else {
        // el rayo: crema brillante con un nucleo blanco
        float apaga = 1 - constrain((pasado - 850) / 350.0, 0, 1);
        fill(255, 235, 190, 230 * apaga);
        rect(bx, by, bw, bh);
        fill(255, 255, 255, 230 * apaga);
        if (focoHorizontalP7[f]) {
          rect(bx, by + bh * 0.3, bw, bh * 0.4);
        } else {
          rect(bx + bw * 0.3, by, bw * 0.4, bh);
        }
      }
    }
  }
  // la campana que gira (y se pasea) durante la espiral
  if (patronP7 == 4) {
    pushMatrix();
    translate(espiralXP7 * e, espiralYP7 * e);
    rotate(giroEspiralP7);
    fill(20, 14, 4);
    ellipse(0, 0, 58 * e, 58 * e);
    image(imagenesCargadas[139], -18 * e, -22 * e, 36 * e, 43 * e);
    popMatrix();
  }
}


// tu corazon: rojo con contorno de tinta; parpadea despues de un golpe
void dibujarAlmaP7(float e) {
  if (millis() < invulnerableHastaP7 && millis() % 140 < 70) {
    return;
  }
  float late = 1 + sin(millis() * 0.012) * 0.06;
  pushMatrix();
  translate(almaXP7 * e, almaYP7 * e);
  scale(late * e);
  noStroke();
  fill(230, 70, 80, 60);
  ellipse(0, 0, 46, 46);
  dibujarCorazonFormaP5(0, 0, 13, color(230, 70, 80), 255, 1);
  popMatrix();
}


// las balas: tarjetas de notificacion con campanita, likes (corazones rosados) y "!" rojos
void dibujarBalasP7(float e) {
  noStroke();
  for (int b = 0; b < cantidadBalasP7; b++) {
    if (balaActivaP7[b]) {
      float x = balaXP7[b];
      float y = balaYP7[b];
      if (balaTipoP7[b] == 0) {
        float w = balaAnchoP7[b];
        float h = balaAltoP7[b];
        fill(20, 14, 4);
        rect((x - w / 2 - 3) * e, (y - h / 2 - 3) * e, (w + 6) * e, (h + 6) * e);
        fill(250, 244, 230);
        rect((x - w / 2) * e, (y - h / 2) * e, w * e, h * e);
        if (w > h) {
          image(imagenesCargadas[139], (x - w / 2 + 7) * e, (y - 10) * e, 17 * e, 20 * e);
          fill(215, 70, 70);
          ellipse((x - w / 2 + 24) * e, (y - 8) * e, 9 * e, 9 * e);
          fill(160, 150, 170);
          rect((x - w / 2 + 34) * e, (y - 4) * e, (w - 46) * e, 4 * e);
          rect((x - w / 2 + 34) * e, (y + 4) * e, (w - 60) * e, 4 * e);
        } else {
          fill(215, 70, 70);
          rect((x - 6) * e, (y - 12) * e, 12 * e, 24 * e);
        }
      }
      if (balaTipoP7[b] == 1) {
        dibujarCorazonFormaP5(x, y, 13, color(255, 120, 160), 255, e);
      }

      if (balaTipoP7[b] == 2) {
        fill(20, 14, 4);
        ellipse(x * e, y * e, 34 * e, 34 * e);
        fill(225, 70, 70);
        ellipse(x * e, y * e, 28 * e, 28 * e);
        fill(255);
        rect((x - 2.5) * e, (y - 9) * e, 5 * e, 11 * e);
        ellipse(x * e, (y + 7) * e, 5 * e, 5 * e);
      }
    }
  }
}


// abajo de la caja: tu cara y tu claridad
void dibujarEstadoP7(float e) {
  int cara = 1;
  if (millis() < caraHastaP7) {
    cara = caraYoP7;
  }
  float cx = 560;
  float cy = 815;
  noStroke();
  fill(20, 14, 4);
  ellipse(cx * e, cy * e, 104 * e, 104 * e);
  fill(250, 240, 220);
  ellipse(cx * e, cy * e, 96 * e, 96 * e);
  image(avatarP7[cara], (cx - 45) * e, (cy - 45) * e, 90 * e, 90 * e);

  fill(245, 235, 215);
  textFont(fuenteTitulo);
  textAlign(LEFT, CENTER);
  textSize(28 * e);
  text("TÚ", 630 * e, 795 * e);
  textFont(fuenteTexto);
  textSize(22 * e);
  fill(170, 220, 250);
  text("Claridad  " + round(claridadMostradaP7) + " de 100", 690 * e, 795 * e);
  fill(0, 200);
  rect(630 * e, 822 * e, 480 * e, 20 * e);
  fill(140, 200, 240);
  if (claridadP7 >= 100) {
    fill(170, 225, 255, 200 + 55 * sin(millis() * 0.01));
  }
  rect(630 * e, 822 * e, 480 * e * claridadMostradaP7 / 100.0, 20 * e);
  noFill();
  stroke(140, 200, 240);
  strokeWeight(3 * e);
  rect(630 * e, 822 * e, 480 * e, 20 * e);
  noStroke();
  strokeWeight(1);
  fill(200, 190, 210);
  textAlign(LEFT, CENTER);
  textSize(20 * e);
  text("Silencios  " + silenciosP7, 1150 * e, 832 * e);
}


// el menu de acciones: 5 botones de historieta; DECIDIR esta apagado hasta tener la claridad llena
int accionBajoMouseP7() {
  float e = width / 1920.0;
  for (int a = 0; a < cantidadAccionesP7; a++) {
    float x = 295 + a * 270;
    if (mouseX / e > x && mouseX / e < x + 250 && mouseY / e > 880 && mouseY / e < 960) {
      return a;
    }
  }
  return -1;
}

void dibujarMenuP7(float e) {
  boolean activo = faseP7 == 1 && batallaP7 == 1;
  int encima = -1;
  if (activo) {
    encima = accionBajoMouseP7();
  }
  color[] colores = {color(228, 188, 106), color(205, 96, 92), color(110, 168, 208), color(150, 130, 200), color(245, 235, 215)};
  for (int a = 0; a < cantidadAccionesP7; a++) {
    float x = 295 + a * 270;
    float y = 880;
    float sube = 0;
    if (encima == a) {
      sube = -6;
    }
    float opacidad = 255;
    if (!activo) {
      opacidad = 90;
    }
    boolean bloqueado = a == 4 && claridadP7 < 100;
    noStroke();
    fill(0, 120 * opacidad / 255);
    rect((x + 6) * e, (y + 8) * e, 250 * e, 80 * e);
    fill(20, 14, 4, opacidad);
    rect((x - 4) * e, (y - 4 + sube) * e, 258 * e, 88 * e);
    color c = colores[a];
    if (bloqueado) {
      c = color(110, 105, 115);
    }
    fill(c, opacidad);
    if (encima == a) {
      fill(lerpColor(c, color(255), 0.25), opacidad);
    }
    rect(x * e, (y + sube) * e, 250 * e, 80 * e);
    // DECIDIR brilla cuando ya se puede
    if (a == 4 && !bloqueado) {
      fill(255, 255, 255, (90 + 80 * sin(millis() * 0.01)) * opacidad / 255);
      rect(x * e, (y + sube) * e, 250 * e, 80 * e);
    }
    fill(30, 22, 6, opacidad);
    textFont(fuenteTitulo);
    textAlign(CENTER, CENTER);
    textSize(26 * e);
    text(accionP7[a], (x + 125) * e, (y + 38 + sube) * e);
    if (bloqueado) {
      textFont(fuenteTexto);
      textSize(16 * e);
      text("necesitas claridad", (x + 125) * e, (y + 66 + sube) * e);
    }
  }
}


// clic durante la batalla
void clicBatallaP7() {
  if (batallaP7 == 0 || batallaP7 == 2 || batallaP7 == 4) {
    avanzarTextoP7();
    return;
  }
  if (batallaP7 == 1) {
    int a = accionBajoMouseP7();
    if (a >= 0) {
      elegirAccionP7(a);
    }
  }
}


// teclas durante la batalla: flechas o W A S D mueven el corazon; ENTER avanza el texto
void teclaBatallaP7() {
  if (keyCode == UP || key == 'w' || key == 'W') {
    arribaP7 = true;
  }
  if (keyCode == DOWN || key == 's' || key == 'S') {
    abajoP7 = true;
  }
  if (keyCode == LEFT || key == 'a' || key == 'A') {
    izquierdaP7 = true;
  }
  if (keyCode == RIGHT || key == 'd' || key == 'D') {
    derechaP7 = true;
  }
  if ((keyCode == ENTER || key == ENTER || key == RETURN) && batallaP7 != 1 && batallaP7 != 3) {
    avanzarTextoP7();
  }
}


// al soltar una tecla el corazon deja de moverse en esa direccion
void soltarTeclaP7() {
  if (keyCode == UP || key == 'w' || key == 'W') {
    arribaP7 = false;
  }
  if (keyCode == DOWN || key == 's' || key == 'S') {
    abajoP7 = false;
  }
  if (keyCode == LEFT || key == 'a' || key == 'A') {
    izquierdaP7 = false;
  }
  if (keyCode == RIGHT || key == 'd' || key == 'D') {
    derechaP7 = false;
  }
}


// FASE 2: el teatro a oscuras, sin publico
void dibujarFase2P7(float e) {
  int pasado = millis() - inicioFaseP7;

  // primero la lluvia se queda congelada y se va oscureciendo (2 s)
  if (faseP7 == 2) {
    dibujarFase1P7(e);
    fill(0, 255 * constrain(pasado / 2000.0, 0, 1));
    rect(0, 0, width, height);
    if (pasado > 2400) {
      faseP7 = 3;
      inicioFaseP7 = millis();
    }
    return;
  }

  // el teatro vacio: butacas grises y un solo foco sobre la silla
  background(8, 6, 12);
  noStroke();
  fill(255, 245, 220, 20);
  triangle(960 * e, 0, 760 * e, 1080 * e, 1160 * e, 1080 * e);
  fill(255, 245, 220, 14);
  ellipse(960 * e, 1010 * e, 520 * e, 90 * e);
  dibujarSillaP7(e);
  for (int fila = 0; fila < 2; fila++) {
    for (int k = 0; k < 12; k++) {
      float bx = 160 + k * 145 + fila * 70;
      float by = 930 + fila * 70;
      if (bx < 760 || bx > 1160) {
        fill(40 + fila * 6, 36, 46);
        rect((bx - 50) * e, (by - 40) * e, 100 * e, 70 * e, 18 * e);
        fill(30, 26, 36);
        rect((bx - 56) * e, (by + 10) * e, 112 * e, 30 * e, 8 * e);
      }
    }
  }

  // el texto de entrada, letra por letra
  String intro = "Las personas desaparecen. Las luces se apagan.\nNadie podrá ver qué eliges.";
  int letras = constrain((millis() - inicioFaseP7) / 45, 0, intro.length());
  if (faseP7 == 3) {
    fill(235, 230, 240);
    textFont(fuenteTitulo);
    textAlign(CENTER, CENTER);
    textSize(40 * e);
    text(intro.substring(0, letras), 960 * e, 170 * e);
  }

  if (faseP7 == 3 && letras >= intro.length()) {
    dibujarTarjetasP7(e);
  }
  if (faseP7 == 4 || faseP7 == 5) {
    dibujarPreguntaP7(e);
  }
  if (faseP7 == 5) {
    dibujarSeguroP7(e);
  }

  // aviso en voz baja (gris, sin recuadro: aqui ya no hay publico)
  if (millis() - inicioAvisoP7 < 2600 && avisoP7.length() > 0) {
    fill(200, 190, 210, 255 * (1 - constrain((millis() - inicioAvisoP7 - 2000) / 600.0, 0, 1)));
    textFont(fuenteTexto);
    textAlign(CENTER, CENTER);
    textSize(30 * e);
    text(avisoP7, 960 * e, 820 * e);
  }

  dibujarBarraSuperior(color(120, 110, 140));

  // cierre
  if (faseP7 == 6 && millis() - inicioCierreP7 > 1200) {
    llenarResultadoP7();
    empezarResultado(alcanzoCP7);
    if (alcanzoCP7) {
      pantalla = 35;
    } else {
      pantalla = 34;
    }
  }
}


// la silla del mago bajo el foco
void dibujarSillaP7(float e) {
  image(imagenesCargadas[142], 847 * e, 640 * e, 226 * e, 300 * e);
}


// las tres situaciones
String[] situacionP7 = {
  "Mantienes tu decisión porque todavía te representa.",
  "Cambias tu decisión porque ya no necesitas demostrar nada.",
  "Haces lo contrario de lo que el público quería."
};

int tarjetaBajoMouseP7() {
  float e = width / 1920.0;
  for (int t = 0; t < 3; t++) {
    float tx = 120 + t * 585;
    if (mouseX / e > tx && mouseX / e < tx + 510 && mouseY / e > 450 && mouseY / e < 660) {
      return t;
    }
  }
  return -1;
}

void dibujarTarjetasP7(float e) {
  float entra = constrain((millis() - inicioFaseP7 - 3400) / 600.0, 0, 1);
  fill(220, 215, 230, 255 * entra);
  textFont(fuenteTexto);
  textAlign(CENTER, CENTER);
  textSize(32 * e);
  text("Qué situación muestra que tu decisión ya no depende del público?", 960 * e, 360 * e);

  int encima = tarjetaBajoMouseP7();
  for (int t = 0; t < 3; t++) {
    float tx = 120 + t * 585;
    float ty = 450 + (1 - reboteTelon(entra * 1.2 - t * 0.1)) * 60;
    boolean luz = encima == t;
    float temblor = 0;
    if (t == 2 && millis() - inicioErrorTarjetaP7 < 400) {
      temblor = sin(millis() * 0.08) * 10;
    }
    noStroke();
    fill(20, 16, 28, 255 * entra);
    if (luz) {
      fill(48, 42, 64, 255 * entra);
    }
    rect((tx + temblor) * e, ty * e, 510 * e, 210 * e, 18 * e);
    noFill();
    stroke(110, 100, 130, 255 * entra);
    if (luz) {
      stroke(240, 230, 200, 255 * entra);
    }
    strokeWeight(3 * e);
    rect((tx + temblor) * e, ty * e, 510 * e, 210 * e, 18 * e);
    noStroke();
    fill(180, 170, 200, 255 * entra);
    textFont(fuenteTitulo);
    textAlign(LEFT, TOP);
    textSize(34 * e);
    text(letraP6[t], (tx + 26 + temblor) * e, (ty + 18) * e);
    fill(235, 230, 240, 255 * entra);
    textFont(fuenteTexto);
    textSize(28 * e);
    text(situacionP7[t], (tx + 70 + temblor) * e, (ty + 24) * e, 410 * e, 170 * e);
  }
  if (encima >= 0) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }
}


// la pregunta final con el cuadro para escribir
void dibujarPreguntaP7(float e) {
  float entra = constrain((millis() - inicioFaseP7) / 800.0, 0, 1);
  fill(235, 230, 240, 255 * entra);
  textFont(fuenteTitulo);
  textAlign(CENTER, CENTER);
  textSize(36 * e);
  text("Si nadie pudiera aprobarte, criticarte, premiarte ni castigarte por esta decisión, qué elegirías?", 310 * e, 300 * e, 1300 * e, 160 * e);

  noStroke();
  fill(250, 246, 240, 255 * entra);
  rect(435 * e, 540 * e, 1050 * e, 90 * e, 12 * e);
  fill(30, 22, 34);
  textFont(fuenteTexto);
  textAlign(LEFT, CENTER);
  textSize(30 * e);
  String visible = respuestaFinal;
  textSize(30 * e);
  while (textWidth(visible) > 990 * e && visible.length() > 0) {
    visible = visible.substring(1);              // si es muy larga, se ve el final
  }
  text(visible, 460 * e, 583 * e);
  if (faseP7 == 4 && millis() % 1000 < 500) {
    float cursorX = 460 * e + textWidth(visible) + 4 * e;
    rect(cursorX, 560 * e, 3 * e, 46 * e);
  }
  fill(180, 170, 200);
  textAlign(RIGHT, CENTER);
  textSize(24 * e);
  text(respuestaFinal.length() + " de 140", 1485 * e, 655 * e);
  fill(200, 190, 210, 150 + 80 * sin(millis() * 0.005));
  textAlign(CENTER, CENTER);
  text("Escribe tu respuesta y pulsa ENTER para terminar", 960 * e, 700 * e);
}


// la pregunta de si de verdad lo decide por si mismo (si menciona al publico)
void dibujarSeguroP7(float e) {
  noStroke();
  fill(0, 170);
  rect(0, 0, width, height);
  fill(30, 26, 40);
  rect(660 * e, 400 * e, 600 * e, 260 * e, 18 * e);
  noFill();
  stroke(200, 190, 210);
  strokeWeight(3 * e);
  rect(660 * e, 400 * e, 600 * e, 260 * e, 18 * e);
  noStroke();
  fill(235, 230, 240);
  textFont(fuenteTitulo);
  textAlign(CENTER, CENTER);
  textSize(34 * e);
  text("Seguro que no lo decides por ellos?", 960 * e, 470 * e);
  for (int b = 0; b < 2; b++) {
    float bx = 700 + b * 280;
    boolean encima = seguroBotonBajoMouseP7() == b;
    fill(70, 62, 90);
    if (encima) {
      fill(110, 100, 140);
    }
    rect(bx * e, 550 * e, 240 * e, 70 * e, 14 * e);
    fill(235, 230, 240);
    textFont(fuenteTexto);
    textSize(28 * e);
    if (b == 0) {
      text("Reescribir", (bx + 120) * e, 583 * e);
    } else {
      text("Mantener", (bx + 120) * e, 583 * e);
    }
  }
}

int seguroBotonBajoMouseP7() {
  float e = width / 1920.0;
  for (int b = 0; b < 2; b++) {
    float bx = 700 + b * 280;
    if (mouseX / e > bx && mouseX / e < bx + 240 && mouseY / e > 550 && mouseY / e < 620) {
      return b;
    }
  }
  return -1;
}


// la respuesta menciona al publico? (cadenas: se pasa a minusculas y se buscan palabras)
boolean mencionaPublicoP7(String r) {
  String t = r.toLowerCase();
  return t.indexOf("like") >= 0 || t.indexOf("público") >= 0 || t.indexOf("publico") >= 0 || t.indexOf("seguidor") >= 0 || t.indexOf("me gusta") >= 0 || t.indexOf("aprob") >= 0 || t.indexOf("lo que piensen") >= 0;
}


// aviso en voz baja de la fase 2
void avisoFase2P7(String texto) {
  avisoP7 = texto;
  inicioAvisoP7 = millis();
}


// clic en la pantalla 33
void clicP7() {
  if (faseP7 == 1) {
    clicBatallaP7();
    return;
  }
  if (faseP7 == 3) {
    int t = tarjetaBajoMouseP7();
    if (t == 0 || t == 1) {
      sonidosCargadosSample[16].trigger();
      faseP7 = 4;
      inicioFaseP7 = millis();
      cursor(ARROW);
    }
    if (t == 2) {
      eleccionErradaP7++;
      inicioErrorTarjetaP7 = millis();
      if (palitos > 1) {
        perderPalito();
      }
      avisoFase2P7("Sigues reaccionando al público. Vuelve a elegir.");
    }
  }
  if (faseP7 == 5) {
    int b = seguroBotonBajoMouseP7();
    if (b == 0) {
      faseP7 = 4;
    }
    if (b == 1) {
      mencionabaP7 = true;
      terminarP7();
    }
  }
}


// teclas en la pantalla 33: en la pregunta final se escribe la respuesta
void teclaP7() {
  if (faseP7 == 1) {
    teclaBatallaP7();
    return;
  }
  if (faseP7 != 4) {
    return;
  }
  if (keyCode == ENTER || key == ENTER || key == RETURN) {
    if (trim(respuestaFinal).length() == 0) {
      avisoFase2P7("Escribe algo. Nadie más lo va a leer.");
    } else {
      if (mencionaPublicoP7(respuestaFinal)) {
        faseP7 = 5;
      } else {
        terminarP7();
      }
    }
    return;
  }
  if (key == BACKSPACE) {
    if (respuestaFinal.length() > 0) {
      respuestaFinal = respuestaFinal.substring(0, respuestaFinal.length() - 1);
    }
    return;
  }
  if (key != CODED && key >= ' ' && respuestaFinal.length() < 140) {
    respuestaFinal = respuestaFinal + key;
    sonidosCargadosSample[4].trigger();
  }
}


// termina la prueba: calcula los puntos y pasa al resultado
// alcanzar tu decision (20) + esquivar la presion (hasta 15) + la situacion correcta (5) + tu respuesta (5) = 45
void terminarP7() {
  faseP7 = 6;
  inicioCierreP7 = millis();

  int puntosDecidir = 0;
  int puntosEsquivar = 0;
  if (alcanzoCP7) {
    puntosDecidir = 20;
    puntosEsquivar = max(0, 8 - golpesP7);
    if (toquesABP7 == 0) {
      puntosEsquivar += 5;
    }
    if (turnosP7 <= 6) {
      puntosEsquivar += 2;
    }
  }
  int puntosSituacion = 0;
  if (eleccionErradaP7 == 0) {
    puntosSituacion = 5;
  }
  int puntosRespuesta = 5;
  if (mencionabaP7) {
    puntosRespuesta = 2;
  }

  lineaTexto[0] = "Decidiste por ti";
  lineaPuntos[0] = puntosDecidir;
  lineaTexto[1] = "Esquivaste la presión";
  lineaPuntos[1] = puntosEsquivar;
  lineaTexto[2] = "La situación correcta";
  lineaPuntos[2] = puntosSituacion;
  lineaTexto[3] = "Tu respuesta";
  lineaPuntos[3] = puntosRespuesta;
  cantidadLineas = 4;
  puntosGanadosP7 = puntosDecidir + puntosEsquivar + puntosSituacion + puntosRespuesta;
  puntosJugador += puntosGanadosP7;

  if (alcanzoCP7) {
    subirExposicion(-5);
    resultadoActo2[2] = 1;
    if (toquesABP7 == 0) {
      ganarLogro(6);
    }
    revisarLogrosActos();
  } else {
    resultadoActo2[2] = 2;
  }
  if (pruebasCompletadasActo2 == 2) {
    pruebasCompletadasActo2 = 3;
  }
}


// el tiempo de la fase 1 se acabo (lo llama el contador)
void tiempoAgotadoP7() {
  perderFase1P7();
}


// textos de la pantalla de resultado
void llenarResultadoP7() {
  tituloResultado = "No alcanzaste tu decisión";
  subtituloResultado = "Las notificaciones decidieron por ti un rato.";
  selloIlustracion = "PRESIONADO";
  if (alcanzoCP7) {
    tituloResultado = "Prueba superada";
    subtituloResultado = "Decidiste sin que nadie te viera. Esa decisión es tuya.";
    selloIlustracion = "SILENCIO";
  }
  explicacionIlustracion = "Tu respuesta:\n" + respuestaFinal;
  if (respuestaFinal.length() > 40) {
    explicacionIlustracion = "Tu respuesta:\n" + respuestaFinal.substring(0, 40) + "...";
  }
  fraseVidaReal = "Hacer lo contrario de lo que te piden tampoco es decidir por ti: sigue siendo reaccionar.";
  consejoVidaReal = "Silenciar notificaciones también es una decisión. Pregúntate qué harías si nadie te viera.";
  datoResultado = 7;
  ilustracionResultado = 7;
  puntosResultado = puntosGanadosP7;
}


// la ilustracion del resultado: una campana tachada bajo una luna (se dibuja alrededor de 0, 0)
void dibujarIlustracionResultadoP7() {
  float e = width / 1920.0;
  noStroke();
  fill(0, 110);
  ellipse(8 * e, 10 * e, 300 * e, 300 * e);
  fill(20, 14, 30);
  ellipse(0, 0, 300 * e, 300 * e);
  fill(58, 48, 112);
  ellipse(0, 0, 286 * e, 286 * e);
  // luna
  fill(235, 235, 255);
  ellipse(-60 * e, -60 * e, 90 * e, 90 * e);
  fill(58, 48, 112);
  ellipse(-40 * e, -76 * e, 80 * e, 80 * e);
  // campana
  image(imagenesCargadas[139], -35 * e, -32 * e, 110 * e, 132 * e);
  // tachada
  stroke(205, 96, 92);
  strokeWeight(12 * e);
  line(-50 * e, -20 * e, 90 * e, 100 * e);
  noStroke();
  strokeWeight(1);
}


// 34 - ACTO II - PRUEBA 3 - PRUEBA PERDIDA
void dibujarPerdidaP7() {
  dibujarResultado(false);
}


// 35 - ACTO II - PRUEBA 3 - PRUEBA SUPERADA
void dibujarSuperadaP7() {
  dibujarResultado(true);
}
