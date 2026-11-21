// PANTALLAS 37 A 39 - ACTO III - PRUEBA 8: LA ADUANA DE PERMISOS
// llegan apps al celular y cada una pide permisos: NEGAR (izquierda) o PERMITIR (derecha), cada vez mas rapido
// permitir de mas suelta un rastreador (clic para aplastarlo); negar lo que la app necesita la rompe
// al final Aporia 2.0 pide TODO y solo hay 3 candados

// TUS DATOS (las 6 puertas, 3 a cada lado del celular)
String[] permisoP8 = {"Cámara", "Galería", "Ubicación", "Contactos", "Micrófono", "Calendario"};
int[] iconoPermisoP8 = {6, 7, 3, 5, 8, 9};
String[] datoRobadoP8 = {"tu cámara", "tus fotos", "tu ubicación", "tus contactos", "tu micrófono", "tu calendario"};
int cantidadPermisosP8 = 6;
int[] golpePuertaP8 = new int[6];           // millis() en que salio un rastreador por esa puerta (destello rojo)

// LAS APPS QUE LLEGAN
String[] nombreAppP8 = {"Mapas", "Linterna", "Grabadora", "Agenda", "Calculadora", "Videollamada"};
String[] sirveAppP8 = {
  "Te muestra cómo llegar",
  "Prende la luz del celular",
  "Graba notas de voz",
  "Anota tus citas",
  "Hace cuentas",
  "Llama con video a tus amigos"
};
int[] iconoAppP8 = {3, 13, 8, 9, 14, 6};
color[] colorAppP8 = {color(80, 180, 110), color(236, 196, 60), color(222, 82, 82), color(238, 140, 60), color(130, 140, 165), color(70, 130, 230)};

// LOS PEDIDOS, EN ORDEN (que app, que permiso, si de verdad lo necesita y por que)
int[] pedidoAppP8 = {0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5};
int[] pedidoPermisoP8 = {2, 3, 3, 2, 4, 5, 5, 0, 4, 3, 0, 4, 2};
boolean[] pedidoNecesarioP8 = {true, false, false, false, true, false, true, false, false, false, true, true, false};
String[] motivoP8 = {
  "Mapas necesita tu ubicación para guiarte.",
  "Para mostrar el camino no hacen falta tus contactos.",
  "Una linterna no necesita tus contactos.",
  "Para prender la luz no hace falta saber dónde estás.",
  "Sin micrófono no se puede grabar tu voz.",
  "Para grabar no necesita tu calendario.",
  "Una agenda sí necesita tu calendario.",
  "Para anotar citas no hace falta la cámara.",
  "Para hacer cuentas no hace falta escucharte.",
  "Una calculadora no necesita tus contactos.",
  "Sin cámara no hay videollamada.",
  "Sin micrófono no te pueden escuchar.",
  "Para llamar no hace falta saber dónde estás."
};
int cantidadPedidosP8 = 13;

// EL PEDIDO QUE SE ESTA DECIDIENDO
int pedidoP8 = 0;
int inicioAppP8 = 0;                        // millis() en que llego la app actual (entra con rebote)
int inicioPedidoP8 = 0;                     // millis() en que la tarjeta se puede responder (corre su reloj)
int tiempoPedidoP8 = 5000;                  // ms para decidir (baja de 5 s a 2,6 s)
boolean respondidoP8 = false;
int inicioRespuestaP8 = 0;
int decisionP8 = 0;                         // 1 permitir, -1 negar
boolean aciertoP8 = false;
boolean solaP8 = false;                     // se acabo el reloj y la app decidio sola
int correctasP8 = 0;
int rachaP8 = 0;
int mejorRachaP8 = 0;
int inicioRachaP8 = -10000;                 // millis() en que subio la racha (el contador salta)
int erroresP8 = 0;
int rotaAppP8 = -10000;                     // millis() en que la app se rompio (negaste lo que necesitaba)

// LOS RASTREADORES (salen de la puerta de un dato y corren hacia la sombra)
int cantidadBichosP8 = 8;
boolean[] bichoActivoP8 = new boolean[8];
float[] bichoXP8 = new float[8];
float[] bichoYP8 = new float[8];
float[] bichoDesdeXP8 = new float[8];
float[] bichoDesdeYP8 = new float[8];
float[] bichoAnguloP8 = new float[8];
int[] bichoNaceP8 = new int[8];
int[] bichoPermisoP8 = new int[8];
int duracionBichoP8 = 3200;                 // ms que tarda en llegar a la sombra
int aplastadosP8 = 0;
int robosP8 = 0;

// MANCHAS DE TINTA (rastreadores aplastados)
int cantidadManchasP8 = 8;
float[] manchaXP8 = new float[8];
float[] manchaYP8 = new float[8];
int[] manchaInicioP8 = new int[8];
int siguienteManchaP8 = 0;

int ultimoCuadroP8 = 0;
float dtP8 = 0;

int[] accesoPuertaP8 = new int[6];          // millis() en que una tarjeta permitida entro a la puerta (verde)
boolean llegoPuertaP8 = false;              // la tarjeta permitida ya llego a su puerta
boolean appListaP8 = false;                 // la app ya termino de "descargarse"
int ultimoTicP8 = 0;                        // tic-tac de los ultimos segundos de la tarjeta
int ultimaFuegoP8 = 0;                      // fuegos artificiales al ganar

// EL JEFE: APORIA 2.0 PIDE TODO (3 candados)
boolean[] necesarioJefeP8 = {true, true, false, false, true, false};
String[] avisoNecesarioP8 = {
  "Sin cámara, Aporía no puede tomar fotos.",
  "Sin galería, no puedes elegir qué subir.",
  "", "",
  "Sin micrófono, no hay mensajes de voz.",
  ""
};
boolean[] candadoJefeP8 = new boolean[6];
int[] cambioCandadoP8 = new int[6];         // millis() en que se puso o se saco (rebote)
int[] errorJefeP8 = new int[6];             // millis() en que se marco como error (rojo)
int candadosPuestosP8 = 0;
int intentosJefeP8 = 0;

// LA PELEA CONTRA APORIA 2.0: lanza burbujas de permisos; se cortan con el mouse las que no necesita
int vidaJefeP8 = 12;
int vidaMaximaJefeP8 = 12;
int nivelJefeP8 = 1;                        // 1 de a una, 2 disfrazadas de regalo, 3 rafagas
int golpeJefeP8 = -10000;                   // millis() del ultimo golpe (parpadea en blanco y tiembla)
int risaJefeP8 = -10000;                    // millis() en que se rio (le cortaste algo necesario o se te colo algo)
int bocaJefeP8 = -10000;                    // millis() en que lanzo (abre la boca)
int ultimoLanzamientoP8 = 0;
int cantidadBurbujasP8 = 10;
boolean[] burbujaActivaP8 = new boolean[10];
float[] burbujaXP8 = new float[10];
float[] burbujaYP8 = new float[10];
float[] burbujaVXP8 = new float[10];
float[] burbujaVYP8 = new float[10];
int[] burbujaPermisoP8 = new int[10];
boolean[] burbujaDisfrazP8 = new boolean[10];
int[] burbujaNaceP8 = new int[10];
boolean[] burbujaCortadaP8 = new boolean[10];
int[] burbujaCorteP8 = new int[10];         // millis() del corte (las mitades se separan)
float[] burbujaAnguloP8 = new float[10];    // angulo del tajo
int inicioCartelRegaloP8 = -100000;         // millis() del cartel que explica los regalos (al empezar el nivel 2)
float[] burbujaDesdeXP8 = new float[10];    // vienen hacia ti: salen chiquitas de la boca y crecen hasta chocar con la pantalla
float[] burbujaDesdeYP8 = new float[10];
float[] burbujaMetaXP8 = new float[10];
float[] burbujaMetaYP8 = new float[10];
float[] burbujaEscalaP8 = new float[10];
int[] burbujaVueloP8 = new int[10];         // ms que tarda en llegar a la pantalla
int pausaGolpeP8 = 0;                       // con cada tajo todo se congela un instante (para que el golpe se sienta)

// GRIETAS: lo que se te colo choca contra tu pantalla y raja el vidrio
int cantidadGrietasP8 = 6;
float[] grietaXP8 = new float[6];
float[] grietaYP8 = new float[6];
int[] grietaInicioP8 = new int[6];
int siguienteGrietaP8 = 0;
int cortesP8 = 0;
int ultimoCorteP8 = -10000;
int cortesSeguidosP8 = 0;
int inicioRemateP8 = 0;                     // millis() en que quedo mareado (empiezan los 10 s de los candados)
int duracionRemateP8 = 10000;
int vistaP8 = 0;                            // que se ve: 0 los pedidos, 1 la pelea, 2 las cartas del remate

// EL TAJO: los ultimos puntos por donde paso el mouse apretado
int cantidadRastroP8 = 14;
float[] rastroXP8 = new float[14];
float[] rastroYP8 = new float[14];
int[] rastroTiempoP8 = new int[14];
int siguienteRastroP8 = 0;

// ESTADO DE LA PRUEBA
int faseP8 = -1;                            // -1 telon y guia, 1 pedidos, 2 entra el jefe, 3 la pelea, 5 el remate, 4 cierre
int inicioFaseP8 = 0;
int motivoDerrotaP8 = 0;                    // 0 = tiempo, 2 = sin palitos
int puntosGanadosP8 = 0;
int inicioCierreP8 = 0;
boolean cierreGanoP8 = false;
int sacudidaP8 = -10000;

// EL PROTAGONISTA (su cara abajo a la izquierda)
int caraP8 = 4;                             // 0 alegre, 1 enojado, 2 sorprendido, 3 triste, 4 pensativo, 5 cansado
int caraHastaP8 = 0;
int inicioCaraP8 = -10000;

// GUIA DE LA PRUEBA 8
String[] titulosGuiaP8 = {
  "Tu cordura",
  "El tiempo",
  "Exposición",
  "Tus puntos",
  "Las apps",
  "Negar o permitir",
  "Tus datos",
  "A jugar"
};
String[] textosGuiaP8 = {
  "Estos palitos son tu cordura. Si cometes un error, pierdes uno. Si se acaban, pierdes la prueba.",
  "Lo que te queda para terminar. En los últimos 10 segundos la barra se pone roja.",
  "Cuánto de tu vida pueden ver los desconocidos. Sube sola mientras la sombra mira.",
  "Cada acierto suma puntos. Al final hay bonos por no equivocarte y por terminar rápido.",
  "Van a llegar apps a tu celular. Cada una dice para qué sirve y te pide permisos.",
  "Niega con la flecha izquierda y permite con la derecha, o haz clic. Si no decides a tiempo, la app decide por ti.",
  "Si permites algo que la app no necesita, sale un rastreador por esa puerta. Aplástalo con un clic antes de que llegue a la sombra.",
  "Dale a cada app solo lo que necesita para lo que hace. Pulsa ENTER para empezar."
};
float[][] zonasGuiaP8 = {
  {20, 8, 330, 80},
  {690, 22, 540, 100},
  {1385, 8, 490, 78},
  {1580, 98, 310, 80},
  {570, 230, 780, 560},
  {590, 830, 740, 140},
  {230, 210, 1370, 640},
  {960, 540, 0, 0}
};
int cantidadPasosGuiaP8 = 8;


// prepara la prueba (se llama al terminar el contexto)
void iniciarP8() {
  duracionPrueba = 100000;
  inicioPrueba = millis();
  palitos = 5;

  reiniciarEfectosA3();
  ultimoCuadroP8 = millis();
  for (int i = 0; i < cantidadPermisosP8; i++) {
    accesoPuertaP8[i] = -10000;
    golpePuertaP8[i] = -10000;
    candadoJefeP8[i] = false;
    cambioCandadoP8[i] = -10000;
    errorJefeP8[i] = -10000;
  }
  for (int b = 0; b < cantidadBichosP8; b++) {
    bichoActivoP8[b] = false;
  }
  for (int m = 0; m < cantidadManchasP8; m++) {
    manchaInicioP8[m] = -10000;
  }
  pedidoP8 = 0;
  respondidoP8 = false;
  correctasP8 = 0;
  rachaP8 = 0;
  mejorRachaP8 = 0;
  erroresP8 = 0;
  aplastadosP8 = 0;
  robosP8 = 0;
  candadosPuestosP8 = 0;
  intentosJefeP8 = 0;
  vidaJefeP8 = vidaMaximaJefeP8;
  nivelJefeP8 = 1;
  inicioCartelRegaloP8 = -100000;
  cortesP8 = 0;
  vistaP8 = 0;
  for (int b = 0; b < cantidadBurbujasP8; b++) {
    burbujaActivaP8[b] = false;
  }
  for (int r = 0; r < cantidadRastroP8; r++) {
    rastroTiempoP8[r] = -10000;
  }
  for (int g = 0; g < cantidadGrietasP8; g++) {
    grietaInicioP8[g] = -10000;
  }
  faseP8 = -1;
  motivoDerrotaP8 = 0;
  caraP8 = 4;
  mensajePrueba = "";
  inicioAppP8 = millis();
  inicioPedidoP8 = millis() + 1000000;   // durante la guia la tarjeta no aparece


  empezarAmbientePrueba();
  empezarTelon();
  empezarGuia(titulosGuiaP8, textosGuiaP8, zonasGuiaP8, cantidadPasosGuiaP8);
}


// POSICIONES (medidas de 1920)
// las puertas: 3 a la izquierda del celular y 3 a la derecha
float puertaXP8(int i) {
  if (i < 3) {
    return 250;
  }
  return 1395;
}

float puertaYP8(int i) {
  return 230 + (i % 3) * 210;
}

// las cartas del jefe dentro del celular (2 filas de 3)
float cartaXP8(int i) {
  return 615 + (i % 3) * 235;
}

float cartaYP8(int i) {
  return 300 + (i / 3) * 265;
}


// la cara del protagonista por un rato
void caraReaccionP8(int cara, int duracion) {
  caraP8 = cara;
  caraHastaP8 = millis() + duracion;
  inicioCaraP8 = millis();
}




// empieza el pedido actual (si es de una app nueva, primero entra la app)
void empezarPedidoP8() {
  respondidoP8 = false;
  solaP8 = false;
  tiempoPedidoP8 = int(lerp(5000, 2600, pedidoP8 / (float) (cantidadPedidosP8 - 1)));
  llegoPuertaP8 = false;
  boolean appNueva = pedidoP8 == 0 || pedidoAppP8[pedidoP8] != pedidoAppP8[pedidoP8 - 1];
  if (appNueva) {
    inicioAppP8 = millis();
    inicioPedidoP8 = millis() + 1400;
    appListaP8 = false;
    sonidosCargadosSample[5].trigger();
  } else {
    inicioPedidoP8 = millis() + 150;
  }
}


// decide el pedido: 1 = permitir, -1 = negar (sola = se acabo el reloj y la app se lo dio)
void decidirP8(int decision, boolean sola) {
  if (faseP8 != 1 || respondidoP8 || millis() < inicioPedidoP8) {
    return;
  }
  respondidoP8 = true;
  inicioRespuestaP8 = millis();
  decisionP8 = decision;
  solaP8 = sola;
  boolean necesario = pedidoNecesarioP8[pedidoP8];
  int permiso = pedidoPermisoP8[pedidoP8];
  aciertoP8 = (decision == 1 && necesario) || (decision == -1 && !necesario);
  sonidosCargadosSample[36].trigger();

  if (sola) {
    // la app decidio por ti: no es un acierto aunque lo necesitara
    aciertoP8 = false;
    rachaP8 = 0;
    sonidosCargadosSample[24].trigger();
    mensajeP5("Si no decides, la app decide por ti.", -1);
    caraReaccionP8(2, 1200);
    if (!necesario) {
      crearBichoP8(permiso);
    }
    return;
  }
  if (aciertoP8) {
    correctasP8++;
    rachaP8++;
    inicioRachaP8 = millis();
    if (rachaP8 > mejorRachaP8) {
      mejorRachaP8 = rachaP8;
    }
    sonidosCargadosSample[19].trigger();
    agregarMoneda(960, 680);
    mostrarRachaCursor(rachaP8);
    sombraReacciona(1);
    mensajeP5(motivoP8[pedidoP8], 1);
    if (decision == 1) {
      golpeA3(color(80, 220, 120));
      lanzarChispasA3(960, 680, 18, color(120, 235, 150), 520, 1);
    } else {
      // negar bien: la tarjeta se arruga con una X roja y suelta pedazos
      golpeA3(celesteA3);
      lanzarChispasA3(960, 680, 22, color(250, 250, 255), 600, 0);
      lanzarChispasA3(960, 680, 10, rojoA3, 500, 1);
      sonidosCargadosSample[46].trigger();
    }
    if (rachaP8 >= 3) {
      caraReaccionP8(0, 900);
    }
    // rachas grandes: cartel gigante y una lluvia de chispas
    if (rachaP8 == 3 || rachaP8 == 5 || rachaP8 == 8 || rachaP8 == 11) {
      agregarImpacto("RACHA x" + rachaP8, 960, 560, 96, color(255, 170, 50));
      lanzarChispasA3(1230, 330, 30, color(255, 170, 50), 700, 1);
      lanzarChispasA3(1230, 330, 16, color(255, 230, 120), 500, 0);
      sonidosCargadosSample[55].trigger();
    }
    return;
  }
  // error
  rachaP8 = 0;
  erroresP8++;
  sonidosCargadosSample[9].trigger();
  sacudidaP8 = millis();
  golpeA3(rojoA3);
  lanzarChispasA3(960, 680, 16, rojoA3, 450, 0);
  mensajeP5(motivoP8[pedidoP8], -1);
  if (decision == -1) {
    // negaste lo que la app necesita: la app se rompe
    perderPalito();
    rotaAppP8 = millis();
    sombraReacciona(2);
    caraReaccionP8(3, 1400);
  } else {
    // permitiste de mas: sale un rastreador por esa puerta
    crearBichoP8(permiso);
    caraReaccionP8(2, 1400);
  }
}


// sale un rastreador por la puerta de un dato
void crearBichoP8(int permiso) {
  for (int b = 0; b < cantidadBichosP8; b++) {
    if (!bichoActivoP8[b]) {
      bichoActivoP8[b] = true;
      bichoPermisoP8[b] = permiso;
      bichoDesdeXP8[b] = puertaXP8(permiso) + 90;
      bichoDesdeYP8[b] = puertaYP8(permiso) + 95;
      bichoXP8[b] = bichoDesdeXP8[b];
      bichoYP8[b] = bichoDesdeYP8[b];
      bichoAnguloP8[b] = 0;
      bichoNaceP8[b] = millis();
      golpePuertaP8[permiso] = millis();
      sonidosCargadosSample[20].trigger();
      return;
    }
  }
}


// rastreador bajo el mouse (-1 si ninguno)
int bichoBajoMouseP8() {
  float e = width / 1920.0;
  for (int b = 0; b < cantidadBichosP8; b++) {
    if (bichoActivoP8[b] && dist(mouseX / e, mouseY / e, bichoXP8[b], bichoYP8[b]) < 45) {
      return b;
    }
  }
  return -1;
}


// aplasta un rastreador: el dato no se pierde
void aplastarBichoP8(int b) {
  bichoActivoP8[b] = false;
  manchaXP8[siguienteManchaP8] = bichoXP8[b];
  manchaYP8[siguienteManchaP8] = bichoYP8[b];
  manchaInicioP8[siguienteManchaP8] = millis();
  siguienteManchaP8 = (siguienteManchaP8 + 1) % cantidadManchasP8;
  aplastadosP8++;
  sonidosCargadosSample[43].trigger();
  agregarFlotante("Atrapado", bichoXP8[b], bichoYP8[b] - 70, celesteA3);
  lanzarChispasA3(bichoXP8[b], bichoYP8[b], 16, color(40, 30, 70), 500, 0);
  lanzarChispasA3(bichoXP8[b], bichoYP8[b], 8, celesteA3, 450, 1);
  golpeA3(celesteA3);
  caraReaccionP8(0, 800);
}


// el rastreador llego a la sombra con el dato
void roboP8(int b) {
  bichoActivoP8[b] = false;
  robosP8++;
  perderPalito();
  if (robosP8 <= 6) {
    subirExposicion(1);
  }
  sombraReacciona(2);
  golpeA3(rojoA3);
  sacudidaP8 = millis();
  lanzarChispasA3(bichoXP8[b], bichoYP8[b], 20, rojoA3, 600, 0);
  lanzarChispasA3(bichoXP8[b], bichoYP8[b], 8, color(30, 10, 20), 200, 2);
  mensajeP5("Un rastreador se llevó " + datoRobadoP8[bichoPermisoP8[b]] + ".", -1);
  caraReaccionP8(3, 1500);
}


// botones de negar y permitir: -1 negar, 1 permitir, 0 ninguno
int botonBajoMouseP8() {
  float e = width / 1920.0;
  if (mouseY > 850 * e && mouseY < 960 * e) {
    if (mouseX > 610 * e && mouseX < 940 * e) {
      return -1;
    }
    if (mouseX > 980 * e && mouseX < 1310 * e) {
      return 1;
    }
  }
  return 0;
}

// carta del jefe bajo el mouse (-1 si ninguna)
int cartaBajoMouseP8() {
  float e = width / 1920.0;
  for (int i = 0; i < cantidadPermisosP8; i++) {
    float x = cartaXP8(i);
    float y = cartaYP8(i);
    if (mouseX > x * e && mouseX < (x + 210) * e && mouseY > y * e && mouseY < (y + 230) * e) {
      return i;
    }
  }
  return -1;
}

boolean listoBajoMouseP8() {
  float e = width / 1920.0;
  return mouseX > 790 * e && mouseX < 1130 * e && mouseY > 880 * e && mouseY < 970 * e;
}


// LA PELEA: empieza cuando termina la entrada del jefe
void empezarPeleaP8() {
  faseP8 = 3;
  vistaP8 = 1;
  inicioFaseP8 = millis();
  nivelJefeP8 = 1;
  ultimoLanzamientoP8 = millis() + 900;
  for (int b = 0; b < cantidadBurbujasP8; b++) {
    burbujaActivaP8[b] = false;
  }
  mensajeP5("Corta con el mouse lo que Aporía no necesita.", 0);
  sonidosCargadosSample[40].trigger();
  musicaA3(6);
  golpeA3(rojoA3);
}


// Aporia lanza una burbuja con un permiso: sale de su boca o de uno de sus cables y cae en arco a tu celular
void lanzarBurbujaP8(boolean disfraz) {
  for (int b = 0; b < cantidadBurbujasP8; b++) {
    if (!burbujaActivaP8[b]) {
      // dos de cada tres son cosas que Aporia no necesita (ubicacion, contactos, calendario)
      int[] noNecesita = {2, 3, 5};
      int[] siNecesita = {0, 1, 4};
      int permiso = noNecesita[int(random(3))];
      if (random(1) < 0.35) {
        permiso = siNecesita[int(random(3))];
        disfraz = false;
      }
      // sale de la boca y va hacia un punto de la pantalla (por todo el ancho, debajo del monstruo)
      float metaX = random(420, 1500);
      float metaY = random(560, 900);
      int vuelo = 2700;
      if (nivelJefeP8 == 2) {
        vuelo = 2400;
      }
      if (nivelJefeP8 == 3) {
        vuelo = 2100;
      }
      burbujaActivaP8[b] = true;
      burbujaCortadaP8[b] = false;
      burbujaPermisoP8[b] = permiso;
      burbujaDisfrazP8[b] = disfraz;
      burbujaDesdeXP8[b] = 960 + random(-30, 30);
      burbujaDesdeYP8[b] = 345;
      burbujaMetaXP8[b] = metaX;
      burbujaMetaYP8[b] = metaY;
      burbujaVueloP8[b] = int(vuelo * random(0.9, 1.1));
      burbujaXP8[b] = burbujaDesdeXP8[b];
      burbujaYP8[b] = burbujaDesdeYP8[b];
      burbujaEscalaP8[b] = 0.5;
      burbujaNaceP8[b] = millis();
      bocaJefeP8 = millis();
      sonidosCargadosSample[6].trigger();
      return;
    }
  }
}


// corta una burbuja: si Aporia no la necesitaba le quita vida (y si cortas varias seguidas, combo); si la necesitaba, error
void cortarBurbujaP8(int b, float angulo) {
  burbujaCortadaP8[b] = true;
  burbujaCorteP8[b] = millis();
  burbujaAnguloP8[b] = angulo;
  int permiso = burbujaPermisoP8[b];
  float x = burbujaXP8[b];
  float y = burbujaYP8[b];
  if (necesarioJefeP8[permiso]) {
    perderPalito();
    erroresP8++;
    risaJefeP8 = millis();
    golpeA3(rojoA3);
    sacudidaP8 = millis();
    sonidosCargadosSample[9].trigger();
    sonidosCargadosSample[49].trigger();
    lanzarChispasA3(x, y, 18, rojoA3, 500, 0);
    mensajeP5(avisoNecesarioP8[permiso], -1);
    caraReaccionP8(3, 1300);
    return;
  }
  cortesP8++;
  vidaJefeP8--;
  golpeJefeP8 = millis();
  pausaGolpeP8 = millis() + 70;
  sonidosCargadosSample[46].trigger();
  sonidosCargadosSample[47].trigger();
  sonidosCargadosSample[44].trigger();
  golpeA3(celesteA3);
  lanzarChispasA3(x, y, 16, color(250, 250, 255), 600, 0);
  lanzarChispasA3(x, y, 8, celesteA3, 500, 1);
  lanzarChispasA3(960, 300, 10, color(255, 240, 120), 500, 1);
  agregarFlotante("Zas", x, y - 60, color(255, 240, 200));
  // combo: varias burbujas cortadas en menos de 0,35 s
  if (millis() - ultimoCorteP8 < 350) {
    cortesSeguidosP8++;
  } else {
    cortesSeguidosP8 = 1;
  }
  ultimoCorteP8 = millis();
  if (cortesSeguidosP8 >= 3) {
    ganarLogro(8);
  }
  if (cortesSeguidosP8 >= 2) {
    agregarImpacto("COMBO x" + cortesSeguidosP8, x, y - 40, 84, color(255, 170, 50));
    vidaJefeP8--;
    sonidosCargadosSample[55].trigger();
    lanzarChispasA3(x, y, 20, color(255, 170, 50), 700, 1);
  }
  caraReaccionP8(0, 700);
  if (vidaJefeP8 <= 0) {
    empezarRemateP8();
  }
}


// una burbuja llego entera a la pantalla: si era necesaria, se instala bien; si no, choca, raja el vidrio y Aporia se cura
void aterrizaP8(int b) {
  burbujaActivaP8[b] = false;
  int permiso = burbujaPermisoP8[b];
  float x = burbujaXP8[b];
  float y = burbujaYP8[b];
  if (necesarioJefeP8[permiso]) {
    agregarFlotante("Ok", x, y - 60, color(120, 235, 150));
    lanzarChispasA3(x, y, 14, color(120, 235, 150), 450, 1);
    sonidosCargadosSample[19].trigger();
    return;
  }
  grietaXP8[siguienteGrietaP8] = x;
  grietaYP8[siguienteGrietaP8] = y;
  grietaInicioP8[siguienteGrietaP8] = millis();
  siguienteGrietaP8 = (siguienteGrietaP8 + 1) % cantidadGrietasP8;
  vidaJefeP8 = min(vidaMaximaJefeP8, vidaJefeP8 + 1);
  risaJefeP8 = millis();
  robosP8++;
  if (robosP8 <= 6) {
    subirExposicion(1);
  }
  sonidosCargadosSample[48].trigger();
  sonidosCargadosSample[49].trigger();
  golpeA3(rojoA3);
  sacudidaP8 = millis();
  lanzarChispasA3(x, y, 20, color(220, 235, 255), 600, 0);
  agregarFlotante("Se coló: " + permisoP8[permiso], x, y - 80, color(255, 120, 120));
}


// la vida llego a cero: Aporia queda mareada y hay 10 s para cerrarle 3 puertas con los candados
void empezarRemateP8() {
  faseP8 = 5;
  vistaP8 = 2;
  inicioFaseP8 = millis();
  inicioRemateP8 = millis();
  for (int b = 0; b < cantidadBurbujasP8; b++) {
    burbujaActivaP8[b] = false;
  }
  for (int i = 0; i < cantidadPermisosP8; i++) {
    candadoJefeP8[i] = false;
  }
  candadosPuestosP8 = 0;
  agregarImpacto("APORÍA ESTÁ MAREADA", 960, 540, 80, doradoA3);
  lanzarChispasA3(960, 300, 40, doradoA3, 800, 1);
  golpeA3(doradoA3);
  sonidosCargadosSample[16].trigger();
  sonidosCargadosSample[44].trigger();
  mensajeP5("Rápido: ciérrale 3 puertas con tus candados.", 0);
  caraReaccionP8(0, 1500);
}


// la logica de la pelea (cada cuadro)
void actualizarPeleaP8() {
  float e = width / 1920.0;

  // el nivel depende de la vida que le queda; al cambiar, cartel
  int nivel = 1;
  if (vidaJefeP8 <= 8) {
    nivel = 2;
  }
  if (vidaJefeP8 <= 4) {
    nivel = 3;
  }
  if (nivel > nivelJefeP8) {
    nivelJefeP8 = nivel;
    if (nivel == 2) {
      // se detiene todo 3,5 s y sale el cartel que explica los regalos
      inicioCartelRegaloP8 = millis();
      pausaGolpeP8 = millis() + 3500;
      ultimoLanzamientoP8 = millis() + 3500 - 1300;
    }
    if (nivel == 3) {
      agregarImpacto("RÁFAGA", 960, 560, 96, rojoA3);
      mensajeP5("Se enojó. Lanza de a tres.", -1);
    }
    sonidosCargadosSample[40].trigger();
    golpeA3(rojoA3);
  }

  // lanza: de a una, de a dos o de a tres
  int ritmo = 1350;
  int cuantas = 1;
  if (nivelJefeP8 == 2) {
    ritmo = 1300;
    cuantas = 2;
  }
  if (nivelJefeP8 == 3) {
    ritmo = 1150;
    cuantas = 3;
  }
  if (millis() - ultimoLanzamientoP8 > ritmo) {
    ultimoLanzamientoP8 = millis();
    for (int k = 0; k < cuantas; k++) {
      lanzarBurbujaP8(nivelJefeP8 >= 2 && random(1) < 0.6);
    }
  }

  // las burbujas vienen hacia ti: avanzan de la boca a su punto de la pantalla y crecen (cada vez mas rapido)
  // con cada tajo se congelan un instante
  boolean congeladas = millis() < pausaGolpeP8;
  for (int b = 0; b < cantidadBurbujasP8; b++) {
    if (burbujaActivaP8[b]) {
      if (burbujaCortadaP8[b]) {
        if (millis() - burbujaCorteP8[b] > 700) {
          burbujaActivaP8[b] = false;
        }
      } else {
        if (congeladas) {
          burbujaNaceP8[b] += int(dtP8 * 1000);
        }
        float avance = (millis() - burbujaNaceP8[b]) / (float) burbujaVueloP8[b];
        if (avance >= 1) {
          aterrizaP8(b);
        } else {
          // sale disparada de la boca (rapido al principio) y despues se acerca creciendo de a poco
          float sale = 1 - (1 - avance) * (1 - avance);
          burbujaXP8[b] = lerp(burbujaDesdeXP8[b], burbujaMetaXP8[b], sale);
          burbujaYP8[b] = lerp(burbujaDesdeYP8[b], burbujaMetaYP8[b], sale) - sin(avance * PI) * 50;
          burbujaEscalaP8[b] = 0.5 + 0.9 * avance;
        }
      }
    }
  }

  // el tajo: con el mouse apretado y moviendose, corta lo que toca
  if (mousePressed && millis() - inicioCartelRegaloP8 > 3500) {
    float ax = pmouseX / e;
    float ay = pmouseY / e;
    float bx = mouseX / e;
    float by = mouseY / e;
    if (dist(ax, ay, bx, by) > 6) {
      rastroXP8[siguienteRastroP8] = bx;
      rastroYP8[siguienteRastroP8] = by;
      rastroTiempoP8[siguienteRastroP8] = millis();
      siguienteRastroP8 = (siguienteRastroP8 + 1) % cantidadRastroP8;
      for (int b = 0; b < cantidadBurbujasP8; b++) {
        if (burbujaActivaP8[b] && !burbujaCortadaP8[b] && distSegmentoA3(burbujaXP8[b], burbujaYP8[b], ax, ay, bx, by) < 70 * burbujaEscalaP8[b] + 10) {
          cortarBurbujaP8(b, atan2(by - ay, bx - ax));
        }
      }
    }
  }
}


// LA PELEA: el monstruo arriba, tu celular abajo, las burbujas en el aire y el tajo del mouse
void dibujarPeleaP8(float e) {
  dibujarFuncionesAppP8(e);
  dibujarMonstruoP8(e);
  dibujarBurbujasP8(e);
  dibujarGrietasP8(e);
  dibujarTajoP8(e);
  dibujarCartelRegaloP8(e);
}


// EL CARTEL DE LOS REGALOS: al empezar el nivel 2 todo se detiene y se explica con un regalo de ejemplo
void dibujarCartelRegaloP8(float e) {
  int pasado = millis() - inicioCartelRegaloP8;
  if (pasado > 3500) {
    return;
  }
  float entra = reboteTelon(pasado / 400.0);
  float sale = constrain((pasado - 3100) / 400.0, 0, 1);
  fill(0, 160 * (1 - sale));
  rect(0, 90 * e, width, 990 * e);

  pushMatrix();
  translate(960 * e, (600 + 700 * sale * sale) * e);
  scale(entra);
  rotate(-0.015);
  fill(tintaA3);
  rect(-520 * e, -230 * e, 1040 * e, 460 * e);
  fill(250, 238, 245);
  rect(-512 * e, -222 * e, 1024 * e, 444 * e);
  fill(240, 120, 190);
  rect(-512 * e, -222 * e, 1024 * e, 70 * e);
  fill(255);
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(48 * e);
  text("Ahora se disfraza", 0, -190 * e);

  // el regalo de ejemplo a la izquierda, que se mece
  pushMatrix();
  translate(-330 * e, 40 * e);
  rotate(sin(millis() * 0.006) * 0.12);
  image(imagenesCargadas[147], -80 * e, -136 * e, 160 * e, 226 * e);
  fill(tintaA3);
  ellipse(0, 6 * e, 104 * e, 104 * e);
  fill(255);
  ellipse(0, 6 * e, 92 * e, 92 * e);
  popMatrix();
  popMatrix();
  dibujarIconoA3(ICONO_CONTACTOS, 960 - 330 * entra, 600 + 46 * entra + 700 * sale * sale, 60 * entra, color(200, 50, 120));

  // la explicacion a la derecha
  pushMatrix();
  translate(960 * e, (600 + 700 * sale * sale) * e);
  scale(entra);
  fill(30, 34, 60);
  textFont(fuenteTexto);
  textAlign(LEFT, CENTER);
  textSize(34 * e);
  text("Te lo ofrece gratis,", -180 * e, -80 * e);
  text("pero adentro hay algo", -180 * e, -30 * e);
  text("que Aporía no necesita.", -180 * e, 20 * e);
  fill(200, 50, 120);
  textFont(fuente);
  textSize(44 * e);
  text("Córtalo igual.", -180 * e, 110 * e);
  popMatrix();
}


// APORIA 2.0: una app gigante con cara enojada, cables que se mueven y ojos que siguen al mouse
void dibujarMonstruoP8(float e) {
  float entra = reboteTelon((millis() - inicioFaseP8) / 700.0);
  float dolor = constrain(1 - (millis() - golpeJefeP8) / 260.0, 0, 1);
  float risa = constrain(1 - (millis() - risaJefeP8) / 900.0, 0, 1);
  float cx = 960 + random(-9, 9) * dolor;
  float cy = lerp(-200, 290, entra) + sin(millis() * 0.004) * 6;

  // el color cambia con la fase: azul, morado, rojo
  color cuerpo = azulA3;
  if (nivelJefeP8 == 2) {
    cuerpo = color(130, 70, 200);
  }
  if (nivelJefeP8 == 3) {
    cuerpo = color(205, 50, 64);
  }

  // los cables (como tentaculos) con su enchufe en la punta
  noFill();
  for (int k = 0; k < 4; k++) {
    float lado = -1;
    if (k >= 2) {
      lado = 1;
    }
    float inicioX = cx + lado * 140;
    float inicioY = cy - 40 + (k % 2) * 90;
    float puntaX = cx + lado * (400 + 40 * sin(millis() * 0.002 + k));
    float puntaY = cy - 80 + (k % 2) * 210 + sin(millis() * 0.003 + k * 2) * 50;
    stroke(tintaA3);
    strokeWeight(24 * e);
    bezier(inicioX * e, inicioY * e, (inicioX + lado * 120) * e, (inicioY - 90) * e, (puntaX - lado * 120) * e, (puntaY + 90) * e, puntaX * e, puntaY * e);
    stroke(lerpColor(cuerpo, color(20, 20, 40), 0.35));
    strokeWeight(12 * e);
    bezier(inicioX * e, inicioY * e, (inicioX + lado * 120) * e, (inicioY - 90) * e, (puntaX - lado * 120) * e, (puntaY + 90) * e, puntaX * e, puntaY * e);
    noStroke();
    fill(tintaA3);
    rect((puntaX - 22) * e, (puntaY - 18) * e, 44 * e, 36 * e);
    fill(190, 195, 210);
    rect((puntaX - 16) * e, (puntaY - 12) * e, 32 * e, 24 * e);
    noFill();
  }
  noStroke();

  // el cuerpo: el icono de la app con contorno de tinta y un brillo arriba
  pushMatrix();
  translate(cx * e, cy * e);
  float aplasta = 1 + 0.06 * sin(millis() * 0.008);
  scale(entra * (1 + 0.12 * dolor), entra * aplasta);
  // la cara (imagen): normal, se rie o golpeada; en cada fase se tine mas morada y despues roja
  int cara = 143;
  if (risa > 0) {
    cara = 145;
  }
  if (dolor > 0.3) {
    cara = 146;
  }
  if (nivelJefeP8 == 2) {
    tint(215, 180, 255);
  }
  if (nivelJefeP8 == 3) {
    tint(255, 160, 165);
  }
  image(imagenesCargadas[cara], -232 * e, -181.5 * e, 464 * e, 363 * e);
  noTint();

  // la insignia 2.0
  fill(tintaA3);
  ellipse(150 * e, -118 * e, 92 * e, 92 * e);
  fill(doradoA3);
  ellipse(150 * e, -118 * e, 80 * e, 80 * e);
  fill(tintaA3);
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(36 * e);
  text("2.0", 150 * e, -122 * e);
  popMatrix();

  // se rie: JA JA
  if (risa > 0) {
    fill(255, 120, 120, 255 * risa);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(46 * e);
    text("JA JA", (cx + 250) * e, (cy - 150 - 30 * (1 - risa)) * e);
  }

  // BARRA DE VIDA debajo del monstruo
  float barraX = 760;
  float barraY = 452;
  fill(tintaA3);
  rect((barraX - 6) * e, (barraY - 6) * e, 412 * e, 40 * e);
  fill(40, 20, 30);
  rect(barraX * e, barraY * e, 400 * e, 28 * e);
  float ancho = 400.0 / vidaMaximaJefeP8;
  for (int v = 0; v < vidaMaximaJefeP8; v++) {
    if (v < vidaJefeP8) {
      fill(lerpColor(rojoA3, color(255, 150, 60), v / (float) vidaMaximaJefeP8));
      rect((barraX + v * ancho + 2) * e, (barraY + 2) * e, (ancho - 4) * e, 24 * e);
    }
  }
  fill(255);
  textFont(fuenteTexto);
  textAlign(CENTER, CENTER);
  textSize(24 * e);
  text("APORÍA 2.0", 960 * e, (barraY - 22) * e);
}


// LAS BURBUJAS: primero las que estan lejos (chicas) y despues las que ya llegan (grandes), para que las de adelante tapen
void dibujarBurbujasP8(float e) {
  for (int pasada = 0; pasada < 2; pasada++) {
    for (int b = 0; b < cantidadBurbujasP8; b++) {
      boolean cerca = burbujaEscalaP8[b] >= 0.8;
      if (burbujaActivaP8[b] && ((pasada == 0 && !cerca) || (pasada == 1 && cerca))) {
        dibujarBurbujaP8(b, e);
      }
    }
  }
}


// UNA BURBUJA: blanca con contorno de tinta, el icono grande y su nombre (o envuelta como regalo);
// mientras mas cerca, mas grande y con una sombra que crece; al cortarla se parte en dos mitades
void dibujarBurbujaP8(int b, float e) {
  float x = burbujaXP8[b];
  float y = burbujaYP8[b];
  float escala = burbujaEscalaP8[b];
  int permiso = burbujaPermisoP8[b];
  if (burbujaCortadaP8[b]) {
    float pasado = (millis() - burbujaCorteP8[b]) / 700.0;
    float separa = 90 * pasado;
    float cae = 380 * pasado * pasado;
    float perpX = cos(burbujaAnguloP8[b] + HALF_PI);
    float perpY = sin(burbujaAnguloP8[b] + HALF_PI);
    // el destello del corte
    if (pasado < 0.25) {
      fill(255, 255 * (1 - pasado * 4));
      pushMatrix();
      translate(x * e, y * e);
      rotate(burbujaAnguloP8[b]);
      rect(-150 * escala * e, -6 * e, 300 * escala * e, 12 * e);
      popMatrix();
    }
    for (int mitad = -1; mitad <= 1; mitad += 2) {
      pushMatrix();
      translate((x + perpX * separa * mitad) * e, (y + perpY * separa * mitad + cae) * e);
      rotate(burbujaAnguloP8[b] + mitad * pasado * 2);
      if (mitad == 1) {
        rotate(PI);
      }
      scale(escala);
      fill(tintaA3, 255 * (1 - pasado));
      arc(0, 0, 150 * e, 150 * e, 0, PI);
      fill(245, 248, 255, 255 * (1 - pasado));
      if (burbujaDisfrazP8[b]) {
        fill(240, 120, 190, 255 * (1 - pasado));
      }
      arc(0, 0, 134 * e, 134 * e, 0, PI);
      popMatrix();
    }
    return;
  }

  // sombra que crece cuando se acerca
  fill(0, 70 * escala);
  ellipse((x + 14 * escala) * e, (y + 20 * escala) * e, 150 * escala * e, 150 * escala * e);
  // aviso de que ya llega: un aro que late
  if (escala > 1.1) {
    noFill();
    stroke(255, 120 + 120 * sin(millis() * 0.03));
    strokeWeight(5 * e);
    ellipse(x * e, y * e, 175 * escala * e, 175 * escala * e);
    noStroke();
  }
  pushMatrix();
  translate(x * e, y * e);
  scale(escala);
  rotate(sin(millis() * 0.006 + b) * 0.12);
  fill(tintaA3);
  if (burbujaDisfrazP8[b]) {
    // envuelta como regalo (imagen)
    image(imagenesCargadas[147], -71 * e, -120 * e, 142 * e, 200 * e);
  } else {
    ellipse(0, 0, 150 * e, 150 * e);
    fill(245, 248, 255);
    ellipse(0, 0, 134 * e, 134 * e);
    fill(255);
    ellipse(-30 * e, -32 * e, 38 * e, 22 * e);
  }
  popMatrix();
  if (burbujaDisfrazP8[b]) {
    // el regalo lleva pegado un circulo blanco con lo que trae adentro
    fill(tintaA3);
    ellipse(x * e, (y + 6 * escala) * e, 92 * escala * e, 92 * escala * e);
    fill(255);
    ellipse(x * e, (y + 6 * escala) * e, 80 * escala * e, 80 * escala * e);
    dibujarIconoA3(iconoPermisoP8[permiso], x, y + 6 * escala, 52 * escala, color(200, 50, 120));
  } else {
    dibujarIconoA3(iconoPermisoP8[permiso], x, y, 78 * escala, azulA3);
  }

  // la etiqueta con el nombre ("Gratis:" si viene disfrazada); crece con la burbuja
  String etiqueta = permisoP8[permiso];
  if (burbujaDisfrazP8[b]) {
    etiqueta = "Gratis: " + permisoP8[permiso];
  }
  pushMatrix();
  translate(x * e, (y + 96 * escala) * e);
  scale(max(0.75, escala));
  textFont(fuenteTexto);
  textSize(30 * e);
  float anchoEtiqueta = textWidth(etiqueta) + 24 * e;
  fill(tintaA3);
  rect(-anchoEtiqueta / 2 - 4 * e, -24 * e, anchoEtiqueta + 8 * e, 48 * e);
  fill(255);
  if (burbujaDisfrazP8[b]) {
    fill(255, 225, 240);
  }
  rect(-anchoEtiqueta / 2, -20 * e, anchoEtiqueta, 40 * e);
  fill(30, 34, 60);
  textAlign(CENTER, CENTER);
  text(etiqueta, 0, -3 * e);
  popMatrix();
}


// LAS GRIETAS: el vidrio rajado donde choco lo que se colo (se borran en 1,8 s)
void dibujarGrietasP8(float e) {
  for (int g = 0; g < cantidadGrietasP8; g++) {
    int pasado = millis() - grietaInicioP8[g];
    if (pasado < 1800) {
      float opacidad = 255 * (1 - constrain((pasado - 1200) / 600.0, 0, 1));
      float abre = reboteTelon(pasado / 150.0);
      float x = grietaXP8[g];
      float y = grietaYP8[g];
      fill(255, 60 * opacidad / 255);
      ellipse(x * e, y * e, 80 * e, 80 * e);
      for (int rayo = 0; rayo < 9; rayo++) {
        float angulo = rayo * TWO_PI / 9 + g;
        float largo = (110 + 60 * sin(rayo * 3.7 + g)) * abre;
        // cada rayo se quiebra en la mitad
        float mx = x + cos(angulo) * largo * 0.5;
        float my = y + sin(angulo) * largo * 0.5;
        float fx = x + cos(angulo + 0.25 * sin(rayo + g)) * largo;
        float fy = y + sin(angulo + 0.25 * sin(rayo + g)) * largo;
        stroke(tintaA3, opacidad * 0.8);
        strokeWeight(7 * e);
        line(x * e, y * e, mx * e, my * e);
        line(mx * e, my * e, fx * e, fy * e);
        stroke(235, 245, 255, opacidad);
        strokeWeight(3 * e);
        line(x * e, y * e, mx * e, my * e);
        line(mx * e, my * e, fx * e, fy * e);
      }
      noFill();
      stroke(235, 245, 255, opacidad * 0.7);
      strokeWeight(3 * e);
      ellipse(x * e, y * e, 120 * abre * e, 100 * abre * e);
      noStroke();
    }
  }
  strokeWeight(1);
}


// EL TAJO: una estela blanca y celeste por donde paso el mouse apretado (dura 0,18 s)
void dibujarTajoP8(float e) {
  for (int k = 1; k < cantidadRastroP8; k++) {
    int actual = (siguienteRastroP8 - k + cantidadRastroP8) % cantidadRastroP8;
    int anterior = (actual - 1 + cantidadRastroP8) % cantidadRastroP8;
    int edad = millis() - rastroTiempoP8[actual];
    int edadAnterior = millis() - rastroTiempoP8[anterior];
    if (edad < 180 && edadAnterior < 180) {
      float fuerza = 1 - edad / 180.0;
      stroke(celesteA3, 140 * fuerza);
      strokeWeight(26 * fuerza * e);
      line(rastroXP8[anterior] * e, rastroYP8[anterior] * e, rastroXP8[actual] * e, rastroYP8[actual] * e);
      stroke(255, 255 * fuerza);
      strokeWeight(10 * fuerza * e);
      line(rastroXP8[anterior] * e, rastroYP8[anterior] * e, rastroXP8[actual] * e, rastroYP8[actual] * e);
    }
  }
  noStroke();
  strokeWeight(1);
}


// el jefe: pone o saca un candado de una carta
void candadoCartaP8(int i) {
  if (candadoJefeP8[i]) {
    candadoJefeP8[i] = false;
    candadosPuestosP8--;
    cambioCandadoP8[i] = millis();
    sonidosCargadosSample[7].trigger();
    return;
  }
  if (candadosPuestosP8 >= 3) {
    mensajeP5("Solo tienes 3 candados. Saca uno primero.", 0);
    sonidosCargadosSample[9].trigger();
    return;
  }
  candadoJefeP8[i] = true;
  candadosPuestosP8++;
  cambioCandadoP8[i] = millis();
  sonidosCargadosSample[16].trigger();
  agregarFlotante("Clac", cartaXP8(i) + 105, cartaYP8(i) + 40, doradoA3);
  lanzarChispasA3(cartaXP8(i) + 105, cartaYP8(i) + 110, 18, doradoA3, 500, 1);
  golpeA3(doradoA3);
  // con el tercer candado se revisa solo
  if (candadosPuestosP8 == 3) {
    confirmarJefeP8();
  }
}


// el jefe: revisa los candados
void confirmarJefeP8() {
  if (faseP8 != 5) {
    return;
  }
  if (candadosPuestosP8 < 3) {
    mensajeP5("Todavía te quedan candados por poner.", 0);
    return;
  }
  intentosJefeP8++;
  int mal = 0;
  String aviso = "";
  for (int i = 0; i < cantidadPermisosP8; i++) {
    if (candadoJefeP8[i] && necesarioJefeP8[i]) {
      mal++;
      errorJefeP8[i] = millis();
      lanzarChispasA3(cartaXP8(i) + 105, cartaYP8(i) + 110, 20, rojoA3, 550, 0);
      aviso = avisoNecesarioP8[i];
      candadoJefeP8[i] = false;
      candadosPuestosP8--;
      cambioCandadoP8[i] = millis();
    }
  }
  if (mal == 0) {
    // explota: chispas de todos los colores desde el centro
    lanzarChispasA3(960, 560, 40, doradoA3, 1000, 1);
    lanzarChispasA3(960, 560, 40, celesteA3, 900, 0);
    lanzarChispasA3(960, 560, 14, color(60, 60, 90), 300, 2);
    sonidosCargadosSample[44].trigger();
    ganarP8();
    return;
  }
  perderPalito();
  erroresP8++;
  sacudidaP8 = millis();
  golpeA3(rojoA3);
  sonidosCargadosSample[9].trigger();
  sombraReacciona(2);
  caraReaccionP8(3, 1500);
  mensajeP5(aviso, -1);
}


// 37 - ACTO III - PRUEBA 8 - LA ADUANA DE PERMISOS
void dibujarCandadosP8() {
  float e = width / 1920.0;
  dtP8 = constrain((millis() - ultimoCuadroP8) / 1000.0, 0, 0.05);
  ultimoCuadroP8 = millis();

  // FASES: al terminar el telon y la guia empieza (el reloj corre desde ahi)
  if (faseP8 == -1 && !telonActivo && !guiaActiva) {
    faseP8 = 1;
    inicioPrueba = millis();
    pedidoP8 = 0;
    empezarPedidoP8();
    musicaA3(5);
  }
  if (faseP8 == -1) {
    inicioPrueba = millis();
  }

  // LOGICA
  if (faseP8 == 1) {
    // la app termino de descargarse: estalla en chispas de su color
    if (!appListaP8 && millis() - inicioAppP8 > 950) {
      appListaP8 = true;
      int app = pedidoAppP8[pedidoP8];
      lanzarChispasA3(960, 340, 26, colorAppP8[app], 650, 1);
      lanzarChispasA3(960, 340, 14, color(255), 500, 0);
      golpeA3(colorAppP8[app]);
      sonidosCargadosSample[54].trigger();
    }
    // la tarjeta permitida llego a su puerta: la puerta se enciende en verde
    if (respondidoP8 && decisionP8 == 1 && aciertoP8 && !llegoPuertaP8 && millis() - inicioRespuestaP8 > 420) {
      llegoPuertaP8 = true;
      int permiso = pedidoPermisoP8[pedidoP8];
      accesoPuertaP8[permiso] = millis();
      lanzarChispasA3(puertaXP8(permiso) + 90, puertaYP8(permiso) + 95, 20, color(120, 235, 150), 500, 1);
      agregarFlotante("Acceso", puertaXP8(permiso) + 90, puertaYP8(permiso) + 40, color(120, 235, 150));
    }
    // ultimos segundos de la tarjeta: tic-tac cada vez mas rapido
    if (!respondidoP8 && millis() > inicioPedidoP8) {
      float queda = 1 - (millis() - inicioPedidoP8) / (float) tiempoPedidoP8;
      int ritmoTic = int(lerp(150, 380, constrain(queda / 0.35, 0, 1)));
      if (queda < 0.35 && millis() - ultimoTicP8 > ritmoTic) {
        ultimoTicP8 = millis();
        sonidosCargadosSample[17].trigger();
      }
    }
    // se acabo el reloj de la tarjeta: la app decide sola (y se lo da)
    if (!respondidoP8 && millis() > inicioPedidoP8 + tiempoPedidoP8) {
      decidirP8(1, true);
    }
    // la tarjeta ya salio volando: sigue el proximo pedido o entra el jefe
    if (respondidoP8 && millis() - inicioRespuestaP8 > 650) {
      pedidoP8++;
      if (pedidoP8 >= cantidadPedidosP8) {
        faseP8 = 2;
        inicioFaseP8 = millis();
        sonidosCargadosSample[52].trigger();
        agregarImpacto("APORÍA 2.0 QUIERE TODO", 960, 520, 76, rojoA3);
        sombraReacciona(2);
        caraReaccionP8(2, 1600);
      } else {
        empezarPedidoP8();
      }
    }
  }
  if (faseP8 == 2 && millis() - inicioFaseP8 > 1900) {
    empezarPeleaP8();
  }
  if (faseP8 == 3) {
    actualizarPeleaP8();
  }
  // el remate: si no le cierras las 3 puertas a tiempo, se recupera un poco y vuelve a pelear
  if (faseP8 == 5 && millis() - inicioRemateP8 > duracionRemateP8) {
    intentosJefeP8++;
    vidaJefeP8 = 4;
    nivelJefeP8 = 3;
    faseP8 = 3;
    vistaP8 = 1;
    inicioFaseP8 = millis() - 700;
    ultimoLanzamientoP8 = millis() + 600;
    risaJefeP8 = millis();
    sonidosCargadosSample[49].trigger();
    mensajeP5("Aporía se recuperó. Sigue cortando.", -1);
    caraReaccionP8(3, 1200);
  }
  if (faseP8 >= 1 && faseP8 <= 3 || faseP8 == 5) {
    if (palitos <= 0) {
      perderP8(2);
    }
    gotearExposicionPrueba();
  }
  if (millis() > caraHastaP8) {
    caraP8 = 4;
  }

  // los rastreadores corren hacia la sombra haciendo zigzag
  for (int b = 0; b < cantidadBichosP8; b++) {
    if (bichoActivoP8[b]) {
      float avance = (millis() - bichoNaceP8[b]) / (float) duracionBichoP8;
      if (avance >= 1) {
        roboP8(b);
      } else {
        float antesX = bichoXP8[b];
        float antesY = bichoYP8[b];
        float metaX = 1700;
        float metaY = 600;
        // primero bajan al piso y despues cruzan hacia la sombra
        float curvaY = lerp(bichoDesdeYP8[b], 1000, sin(avance * PI) * 0.8);
        bichoXP8[b] = lerp(bichoDesdeXP8[b], metaX, avance * avance) + sin(avance * 18 + b) * 40 * (1 - avance);
        bichoYP8[b] = lerp(curvaY, metaY, avance * avance * avance);
        bichoAnguloP8[b] = atan2(bichoYP8[b] - antesY, bichoXP8[b] - antesX);
        // deja una nube de polvo al correr
        if (frameCount % 4 == b % 4) {
          lanzarChispasA3(bichoXP8[b], bichoYP8[b] + 10, 1, color(150, 160, 190, 150), 40, 2);
        }
      }
    }
  }

  // al ganar: fuegos artificiales celestes y dorados por toda la pantalla
  if (faseP8 == 4 && cierreGanoP8 && millis() - ultimaFuegoP8 > 260) {
    ultimaFuegoP8 = millis();
    color colorFuego = celesteA3;
    if (random(1) < 0.5) {
      colorFuego = doradoA3;
    }
    float fx = random(400, 1500);
    float fy = random(200, 650);
    lanzarChispasA3(fx, fy, 22, colorFuego, 650, 1);
    lanzarChispasA3(fx, fy, 10, color(255), 400, 0);
    sonidosCargadosSample[17].trigger();
  }

  // cursor de mano sobre lo que se puede tocar
  cursor(ARROW);
  if (bichoBajoMouseP8() >= 0) {
    cursor(HAND);
  }
  if (faseP8 == 1 && !respondidoP8 && botonBajoMouseP8() != 0) {
    cursor(HAND);
  }
  if (faseP8 == 5 && (cartaBajoMouseP8() >= 0 || listoBajoMouseP8())) {
    cursor(HAND);
  }
  if (faseP8 == 3) {
    cursor(CROSS);
  }

  // DIBUJO
  dibujarFondoActo3();
  float tension = calcularTension();
  dibujarSombraYTelon(tension);

  // la escena da un pequeno salto de zoom con cada golpe y tiembla con los errores
  pushMatrix();
  zoomGolpeA3(e);
  int pasadoSacudida = millis() - sacudidaP8;
  if (pasadoSacudida < 300) {
    float fuerza = 9 * (1 - pasadoSacudida / 300.0);
    translate(random(-fuerza, fuerza) * e, random(-fuerza, fuerza) * e);
  }
  if (vistaP8 == 0) {
    for (int i = 0; i < cantidadPermisosP8; i++) {
      dibujarPuertaP8(i, e);
    }
    dibujarCelularP8(e);
  }
  if (vistaP8 == 1) {
    dibujarPeleaP8(e);
  }
  if (vistaP8 == 2) {
    dibujarFuncionesAppP8(e);
    dibujarBandejaP8(e);
    dibujarCelularP8(e);
  }
  dibujarManchasP8(e);
  dibujarBichosP8(e);
  dibujarChispasA3(e);
  popMatrix();

  dibujarBordesGolpeA3(e);

  dibujarTension(tension);
  dibujarBarraSuperior(azulA3);
  dibujarMarcador(puntosVivosP8());
  dibujarMonedas();
  dibujarFlotantes();
  dibujarImpacto();
  dibujarRachaCursor();
  dibujarMensajeP5(e);

  // cierre: un momento para ver el final y pasa a la pantalla de resultado
  if (faseP8 == 4 && millis() - inicioCierreP8 > 1800) {
    llenarResultadoP8(cierreGanoP8);
    empezarResultado(cierreGanoP8);
    if (cierreGanoP8) {
      pantalla = 39;
    } else {
      pantalla = 38;
    }
  }
}


// puntos que se ven en el marcador mientras se juega
int puntosVivosP8() {
  int candadosBien = 0;
  for (int i = 0; i < cantidadPermisosP8; i++) {
    if (candadoJefeP8[i] && !necesarioJefeP8[i]) {
      candadosBien++;
    }
  }
  return correctasP8 * 2 + min(mejorRachaP8, 8) + candadosBien * 3;
}


// UNA PUERTA DE DATO: se sacude y brilla cuando una app la pide; destello rojo cuando sale un rastreador
void dibujarPuertaP8(int i, float e) {
  float x = puertaXP8(i);
  float y = puertaYP8(i);
  boolean pedida = faseP8 == 1 && !respondidoP8 && pedidoPermisoP8[pedidoP8] == i && millis() > inicioAppP8 + 700;
  float toc = 0;
  if (pedida) {
    toc = sin(millis() * 0.05) * 3 * constrain((millis() - inicioPedidoP8) / 200.0 + 1, 0, 1);
  }
  int pasadoRobo = millis() - golpePuertaP8[i];
  float abre = 0;
  if (pasadoRobo < 900) {
    abre = sin(constrain(pasadoRobo / 900.0, 0, 1) * PI);
  }

  pushMatrix();
  translate(toc * e, 0);
  noStroke();
  if (pedida) {
    fill(celesteA3, 50 + 30 * sin(millis() * 0.01));
    rect((x - 16) * e, (y - 16) * e, 212 * e, 222 * e);
  }
  fill(tintaA3);
  rect((x - 6) * e, (y - 6) * e, 192 * e, 202 * e);
  fill(4, 6, 16);
  rect(x * e, y * e, 180 * e, 190 * e);
  if (abre > 0) {
    fill(230, 60, 60, 160 * abre);
    rect(x * e, y * e, 180 * e, 190 * e);
  }
  // acceso permitido: la puerta se ilumina en verde un momento
  int pasadoAcceso = millis() - accesoPuertaP8[i];
  if (pasadoAcceso < 700) {
    float luz = 1 - pasadoAcceso / 700.0;
    fill(120, 235, 150, 90 * luz);
    rect((x - 20) * e, (y - 20) * e, 220 * e, 230 * e);
  }
  // la hoja (se abre de golpe cuando sale un rastreador)
  float ancho = lerp(180, 120, abre);
  fill(30, 58, 128);
  if (pedida) {
    fill(46, 92, 190);
  }
  quad(x * e, y * e, (x + ancho) * e, (y + 10 * abre) * e, (x + ancho) * e, (y + 190 - 10 * abre) * e, x * e, (y + 190) * e);
  fill(doradoA3);
  ellipse((x + ancho - 18) * e, (y + 105) * e, 12 * e, 12 * e);
  color colorIcono = color(205, 225, 255);
  if (pedida) {
    colorIcono = color(255);
  }
  dibujarIconoA3(iconoPermisoP8[i], x + ancho / 2, y + 80, 70, colorIcono);
  fill(tintaA3);
  rect((x + 10) * e, (y + 140) * e, (ancho - 20) * e, 38 * e);
  fill(232, 236, 250);
  rect((x + 14) * e, (y + 144) * e, (ancho - 28) * e, 30 * e);
  fill(30, 34, 60);
  textFont(fuenteTexto);
  textAlign(CENTER, CENTER);
  textSize(22 * e);
  text(permisoP8[i], (x + ancho / 2) * e, (y + 157) * e);
  popMatrix();
}


// EL CELULAR: la app que llego, la tarjeta del pedido con su reloj y los botones (o el jefe)
void dibujarCelularP8(float e) {
  noStroke();
  fill(0, 120);
  rect(584 * e, 134 * e, 780 * e, 920 * e);
  fill(tintaA3);
  rect(562 * e, 112 * e, 796 * e, 936 * e);
  fill(28, 32, 52);
  rect(570 * e, 120 * e, 780 * e, 920 * e);
  fill(8, 14, 34);
  rect(590 * e, 150 * e, 740 * e, 870 * e);
  fill(tintaA3);
  ellipse(960 * e, 135 * e, 12 * e, 12 * e);

  if (faseP8 <= 1 || faseP8 == 4 && vistaP8 == 0) {
    dibujarPedidoP8(e);
  }
  if (faseP8 == 2) {
    // entra el jefe: luces de alarma que giran, la pantalla se rompe en franjas y el logo crece con los colores corridos
    int pasado = millis() - inicioFaseP8;
    float entra = reboteTelon(pasado / 500.0);
    for (int luz = 0; luz < 2; luz++) {
      pushMatrix();
      translate((590 + luz * 740) * e, 150 * e);
      rotate(millis() * 0.006 + luz * PI);
      fill(255, 60, 60, 45);
      triangle(0, 0, -120 * e, 1100 * e, 120 * e, 1100 * e);
      popMatrix();
    }
    fill(rojoA3, 70 + 50 * sin(millis() * 0.03));
    rect(590 * e, 150 * e, 740 * e, 870 * e);
    for (int franja = 0; franja < 9; franja++) {
      float fy = 150 + random(860);
      fill(255, 60, 60, 120);
      if (franja % 2 == 0) {
        fill(80, 220, 255, 110);
      }
      rect((590 + random(-30, 30)) * e, fy * e, 740 * e, random(4, 26) * e);
    }
    float corre = 10 * (1 - constrain(pasado / 1500.0, 0, 1)) + 3;
    // el logo con un fantasma rojo y otro celeste corridos (efecto de pantalla rota)
    fill(255, 50, 50, 140);
    ellipse((960 - corre) * e, 560 * e, 224 * entra * e, 224 * entra * e);
    fill(80, 220, 255, 140);
    ellipse((960 + corre) * e, 560 * e, 224 * entra * e, 224 * entra * e);
    dibujarLogoAporiaP8(960 + random(-3, 3), 560 + random(-3, 3), 1.6 * entra, e);
    // los ojos malvados del logo
    if (pasado > 700) {
      float abre = constrain((pasado - 700) / 300.0, 0, 1);
      fill(tintaA3);
      ellipse(925 * e, 500 * e, 30 * e, 22 * abre * e);
      ellipse(995 * e, 500 * e, 30 * e, 22 * abre * e);
      fill(255, 60, 60);
      ellipse(925 * e, 500 * e, 12 * e, 12 * abre * e);
      ellipse(995 * e, 500 * e, 12 * e, 12 * abre * e);
    }
  }
  if (vistaP8 == 2) {
    dibujarJefeP8(e);
  }
}


// el logo de Aporia (la imagen de la prueba 6), centrado en (cx, cy); a escala 1 mide 140
void dibujarLogoAporiaP8(float cx, float cy, float escala, float e) {
  pushMatrix();
  translate(cx * e, cy * e);
  scale(escala);
  image(imagenesCargadas[138], -70 * e, -70 * e, 140 * e, 140 * e);
  popMatrix();
}


// el pedido: arriba la app (icono, nombre y para que sirve), en el medio la tarjeta y abajo los botones
void dibujarPedidoP8(float e) {
  int app = pedidoAppP8[min(pedidoP8, cantidadPedidosP8 - 1)];
  int pasadoApp = millis() - inicioAppP8;
  float entraApp = reboteTelon(pasadoApp / 500.0);

  // la pantalla del celular se tine del color de la app
  noStroke();
  fill(colorAppP8[app], 22 + 10 * sin(millis() * 0.003));
  rect(590 * e, 150 * e, 740 * e, 870 * e);

  fill(150, 165, 200);
  textFont(fuenteTexto);
  textAlign(CENTER, CENTER);
  textSize(24 * e);
  String estadoApp = "Instalando app " + (app + 1) + " de 6";
  if (pasadoApp < 950) {
    estadoApp = "Descargando " + nombreAppP8[app] + "  " + int(constrain(pasadoApp / 9.0, 0, 100)) + " %";
  }
  text(estadoApp, 960 * e, 250 * e);

  // rayos de luz que giran detras de la app (mas fuertes justo al terminar de descargarse)
  float fuerzaRayos = 0.35 + 0.65 * constrain(1 - (pasadoApp - 950) / 900.0, 0, 1);
  if (pasadoApp < 950) {
    fuerzaRayos = 0.3;
  }
  pushMatrix();
  translate(960 * e, 340 * e);
  rotate(millis() * 0.0008);
  fill(colorAppP8[app], 55 * fuerzaRayos);
  for (int rayo = 0; rayo < 10; rayo++) {
    rotate(TWO_PI / 10);
    triangle(0, 0, -26 * e, -230 * e, 26 * e, -230 * e);
  }
  popMatrix();

  // anillo de descarga alrededor del icono
  if (pasadoApp < 950) {
    noFill();
    stroke(tintaA3);
    strokeWeight(16 * e);
    ellipse(960 * e, 340 * e, 210 * e, 210 * e);
    stroke(255);
    strokeWeight(9 * e);
    arc(960 * e, 340 * e, 210 * e, 210 * e, -HALF_PI, -HALF_PI + TWO_PI * pasadoApp / 950.0);
    noStroke();
  }

  // la app: su icono sobre un cuadro de color (si se rompio, tiembla y se agrieta)
  float rota = constrain(1 - (millis() - rotaAppP8) / 700.0, 0, 1);
  float estalla = 1 + 0.25 * constrain(1 - (pasadoApp - 950) / 250.0, 0, 1);
  if (pasadoApp < 950) {
    estalla = 0.85;
  }
  pushMatrix();
  translate((960 + random(-6, 6) * rota) * e, (340 + sin(millis() * 0.004) * 4) * e);
  scale(entraApp * estalla);
  rotate(sin(millis() * 0.002) * 0.05);
  fill(0, 100);
  rect(-66 * e, -60 * e, 140 * e, 140 * e);
  fill(tintaA3);
  rect(-76 * e, -76 * e, 152 * e, 152 * e);
  fill(colorAppP8[app]);
  if (rota > 0) {
    fill(lerpColor(colorAppP8[app], color(90), rota));
  }
  rect(-70 * e, -70 * e, 140 * e, 140 * e);
  fill(255, 60);
  rect(-70 * e, -70 * e, 140 * e, 30 * e);
  popMatrix();
  dibujarIconoA3(iconoAppP8[app], 960, 340 + sin(millis() * 0.004) * 4, 80 * entraApp * estalla, color(255));
  if (rota > 0) {
    stroke(tintaA3, 255 * rota);
    strokeWeight(5 * e);
    line(920 * e, 290 * e, 960 * e, 340 * e);
    line(960 * e, 340 * e, 945 * e, 395 * e);
    line(960 * e, 340 * e, 1005 * e, 320 * e);
    noStroke();
  }
  fill(255);
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(46 * e);
  text(nombreAppP8[app], 960 * e, 455 * e);
  fill(celesteA3);
  textFont(fuenteTexto);
  textSize(27 * e);
  text("Sirve para: " + sirveAppP8[app], 960 * e, 500 * e);

  // la racha a la derecha de la app: desde 3 seguidas echa fuego
  if (rachaP8 >= 3 && frameCount % 3 == 0) {
    lanzarChispasA3(1230 + random(-30, 30), 300, 1, color(255, 130 + random(80), 30), 60, 2);
  }
  if (rachaP8 >= 2) {
    float salto = 1 + 0.4 * constrain(1 - (millis() - inicioRachaP8) / 250.0, 0, 1);
    pushMatrix();
    translate(1230 * e, 330 * e);
    rotate(sin(millis() * 0.006) * 0.08 * min(rachaP8, 6) / 6.0);
    scale(salto);
    rotate(0.12);
    fill(tintaA3);
    ellipse(0, 0, 104 * e, 104 * e);
    fill(255, 150, 40);
    ellipse(0, 4 * e, 92 * e, 92 * e);
    fill(255, 210, 80);
    ellipse(0, 10 * e, 60 * e, 60 * e);
    fill(tintaA3);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(26 * e);
    text("racha", 0, -16 * e);
    textSize(40 * e);
    text("x" + rachaP8, 0, 16 * e);
    popMatrix();
  }

  // LA TARJETA DEL PEDIDO: baja como una notificacion; al decidir sale volando con su sello
  if (pedidoP8 < cantidadPedidosP8 && millis() > inicioPedidoP8 - 300) {
    int pasadoPedido = millis() - inicioPedidoP8 + 300;
    float baja = reboteTelon(pasadoPedido / 400.0);
    float cx = 960;
    float cy = lerp(300, 680, baja);
    // al caer se mece como una hoja y se queda flotando
    float giro = sin(pasadoPedido * 0.018) * 0.12 * constrain(1 - pasadoPedido / 700.0, 0, 1) + sin(millis() * 0.002) * 0.01;
    float escala = lerp(0.5, 1, baja);
    float escalaX = 1;
    float queda = 1;
    if (!respondidoP8) {
      queda = constrain(1 - (millis() - inicioPedidoP8) / (float) tiempoPedidoP8, 0, 1);
      // urgencia: en el ultimo tercio la tarjeta tiembla y late
      if (queda < 0.35 && millis() > inicioPedidoP8) {
        float urgencia = 1 - queda / 0.35;
        cx += sin(millis() * 0.09) * 6 * urgencia;
        escala *= 1 + 0.03 * urgencia * sin(millis() * 0.03);
      }
    }
    float sale = 0;
    if (respondidoP8) {
      sale = suaveTelon((millis() - inicioRespuestaP8 - 120) / 420.0);
      if (decisionP8 == 1 && aciertoP8) {
        // permitido bien: la tarjeta vuela achicandose hasta la puerta de ese dato
        int permiso = pedidoPermisoP8[pedidoP8];
        float puertaX = puertaXP8(permiso) + 90;
        float puertaY = puertaYP8(permiso) + 95;
        cx = lerp(960, puertaX, sale);
        cy = lerp(680, puertaY, sale) - sin(sale * PI) * 140;
        escala = lerp(1, 0.12, sale);
        giro = sale * TWO_PI * 0.5 * (puertaX - 960) / 700.0;
      } else {
        if (decisionP8 == -1 && aciertoP8) {
          // negado bien: la tarjeta se arruga (se aplasta de costado) y sale girando hacia abajo a la izquierda
          cx -= 700 * sale;
          cy += 260 * sale * sale;
          giro = -sale * 3;
          escalaX = lerp(1, 0.25, constrain(sale * 1.6, 0, 1));
          escala *= lerp(1, 0.6, sale);
        } else {
          cx += decisionP8 * 800 * sale;
          cy += 40 * sale;
          giro = decisionP8 * 0.5 * sale;
        }
      }
    }

    // estela fantasma mientras cae
    if (pasadoPedido < 350 && !respondidoP8) {
      for (int fantasma = 1; fantasma <= 3; fantasma++) {
        fill(250, 250, 255, 35 - fantasma * 9);
        float atrasY = -fantasma * 40 * (1 - baja);
        rect((cx - 300 * escala) * e, (cy + atrasY - 110 * escala) * e, 600 * escala * e, 220 * escala * e);
      }
    }

    pushMatrix();
    translate(cx * e, cy * e);
    rotate(giro);
    scale(escala * escalaX, escala);
    fill(0, 110);
    rect(-292 * e, -98 * e, 600 * e, 220 * e);
    fill(tintaA3);
    rect(-306 * e, -116 * e, 612 * e, 232 * e);
    fill(250, 250, 255);
    rect(-300 * e, -110 * e, 600 * e, 220 * e);
    fill(colorAppP8[app]);
    rect(-300 * e, -110 * e, 600 * e, 12 * e);
    fill(70, 76, 105);
    textFont(fuenteTexto);
    textAlign(LEFT, CENTER);
    textSize(27 * e);
    text(nombreAppP8[app] + " quiere acceder a", -270 * e, -66 * e);
    fill(tintaA3);
    textFont(fuente);
    textSize(54 * e);
    text(permisoP8[pedidoPermisoP8[pedidoP8]], -150 * e, 14 * e);
    dibujarIconoA3(iconoPermisoP8[pedidoPermisoP8[pedidoP8]], -225, 10, 80, azulA3);

    // el reloj: una barra que se vacia (de verde a rojo); al final parpadea
    fill(220, 224, 235);
    rect(-270 * e, 70 * e, 540 * e, 16 * e);
    fill(lerpColor(rojoA3, color(80, 200, 120), queda));
    if (queda < 0.35 && millis() % 200 < 100) {
      fill(255, 90, 90);
    }
    rect(-270 * e, 70 * e, 540 * e * queda, 16 * e);
    fill(255, 120);
    rect(-270 * e, 70 * e, 540 * e * queda, 5 * e);

    // negado bien: una X roja enorme encima
    if (respondidoP8 && decisionP8 == -1 && aciertoP8) {
      float marca = constrain((millis() - inicioRespuestaP8) / 120.0, 0, 1);
      stroke(rojoA3, 230);
      strokeWeight(22 * e);
      line(-200 * e, -80 * e, lerp(-200, 200, marca) * e, lerp(-80, 80, marca) * e);
      line(200 * e, -80 * e, lerp(200, -200, marca) * e, lerp(-80, 80, marca) * e);
      noStroke();
    }

    // el sello de la decision
    if (respondidoP8) {
      float avance = constrain((millis() - inicioRespuestaP8) / 180.0, 0, 1);
      String sello = "PERMITIDO";
      color colorSello = color(60, 170, 90);
      if (decisionP8 == -1) {
        sello = "NEGADO";
        colorSello = rojoA3;
      }
      if (solaP8) {
        sello = "SE LO DIO SOLA";
        colorSello = color(230, 140, 40);
      }
      pushMatrix();
      translate(120 * e, -10 * e);
      rotate(-0.15);
      scale(lerp(2.4, 1, avance * avance));
      noFill();
      stroke(colorSello, 235 * avance);
      strokeWeight(6 * e);
      rect(-160 * e, -38 * e, 320 * e, 76 * e);
      noStroke();
      fill(colorSello, 235 * avance);
      textFont(fuente);
      textAlign(CENTER, CENTER);
      textSize(40 * e);
      text(sello, 0, -4 * e);
      popMatrix();
    }
    popMatrix();
  }

  // LOS BOTONES: negar (izquierda) y permitir (derecha)
  int encima = 0;
  if (faseP8 == 1 && !respondidoP8) {
    encima = botonBajoMouseP8();
  }
  for (int lado = -1; lado <= 1; lado += 2) {
    float bx = 775;
    String texto = "NEGAR";
    color colorBoton = rojoA3;
    if (lado == 1) {
      bx = 1145;
      texto = "PERMITIR";
      colorBoton = color(70, 185, 105);
    }
    float crece = 1;
    if (encima == lado) {
      crece = 1.07;
    }
    // el boton que se eligio salta
    if (respondidoP8 && decisionP8 == lado && !solaP8) {
      crece = 1 + 0.15 * constrain(1 - (millis() - inicioRespuestaP8) / 200.0, 0, 1);
    }
    pushMatrix();
    translate(bx * e, 905 * e);
    scale(crece);
    fill(tintaA3);
    rect(-171 * e, -56 * e, 342 * e, 112 * e);
    fill(colorBoton);
    if (respondidoP8 || faseP8 != 1) {
      fill(colorBoton, 110);
    }
    rect(-165 * e, -50 * e, 330 * e, 100 * e);
    fill(255, 50);
    rect(-165 * e, -50 * e, 330 * e, 24 * e);
    fill(tintaA3);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(40 * e);
    text(texto, -18 * lado * e, -5 * e);
    // flecha dibujada hacia afuera (la fuente no la tiene): negar a la izquierda, permitir a la derecha
    float fx = 125 * lado;
    triangle((fx + 16 * lado) * e, 0, (fx - 6 * lado) * e, -16 * e, (fx - 6 * lado) * e, 16 * e);
    popMatrix();
  }
}


// EL JEFE: las 6 cartas de permisos de Aporia 2.0; clic pone o saca un candado
void dibujarJefeP8(float e) {
  int pasado = millis() - inicioFaseP8;
  fill(rojoA3);
  rect(590 * e, 150 * e, 740 * e, 90 * e);
  image(imagenesCargadas[144], 592 * e, 150 * e, 116 * e, 91 * e);   // Aporia mareada
  fill(255);
  textFont(fuenteTexto);
  textAlign(CENTER, CENTER);
  textSize(32 * e);
  // la cuenta atras del remate: el texto late y la barra se vacia
  int faltaRemate = max(0, duracionRemateP8 - (millis() - inicioRemateP8));
  float latido = 1;
  if (faltaRemate < 4000 && faseP8 == 5) {
    latido = 1 + 0.08 * sin(millis() * 0.03);
  }
  pushMatrix();
  translate(990 * e, 193 * e);
  scale(latido);
  text("Ciérrale 3 puertas  " + ceil(faltaRemate / 1000.0), 0, 0);
  popMatrix();
  fill(60, 10, 20);
  rect(590 * e, 232 * e, 740 * e, 10 * e);
  fill(doradoA3);
  if (faltaRemate < 4000) {
    fill(255, 120, 120);
  }
  rect(590 * e, 232 * e, 740 * e * faltaRemate / (float) duracionRemateP8, 10 * e);

  int encima = -1;
  if (faseP8 == 5) {
    encima = cartaBajoMouseP8();
  }
  for (int i = 0; i < cantidadPermisosP8; i++) {
    // las cartas se reparten: salen del centro girando y caen en su lugar
    float reparte = constrain((pasado - i * 110) / 450.0, 0, 1);
    float entra = reboteTelon(reparte);
    float x = lerp(855, cartaXP8(i), suaveTelon(reparte));
    float y = lerp(445, cartaYP8(i), suaveTelon(reparte)) + sin(millis() * 0.003 + i) * 3 * entra;
    float crece = 1;
    if (encima == i) {
      crece = 1.06;
    }
    int pasadoError = millis() - errorJefeP8[i];
    float tiembla = 0;
    if (pasadoError < 500) {
      tiembla = sin(millis() * 0.08) * 8;
    }
    pushMatrix();
    translate((x + 105 + tiembla) * e, (y + 115) * e);
    rotate((1 - suaveTelon(reparte)) * -2.5 + (crece - 1) * 0.5);
    scale(max(0.05, entra * crece));
    // brillo detras de la carta elegida
    if (encima == i) {
      fill(doradoA3, 60 + 30 * sin(millis() * 0.01));
      rect(-125 * e, -135 * e, 250 * e, 270 * e);
    }
    fill(tintaA3);
    rect(-111 * e, -121 * e, 222 * e, 242 * e);
    fill(30, 58, 128);
    if (candadoJefeP8[i]) {
      fill(58, 66, 92);
    }
    if (pasadoError < 900) {
      fill(lerpColor(color(30, 58, 128), rojoA3, 1 - pasadoError / 900.0));
    }
    rect(-105 * e, -115 * e, 210 * e, 230 * e);
    fill(tintaA3);
    rect(-90 * e, 64 * e, 180 * e, 40 * e);
    fill(232, 236, 250);
    rect(-86 * e, 68 * e, 172 * e, 32 * e);
    fill(30, 34, 60);
    textFont(fuenteTexto);
    textAlign(CENTER, CENTER);
    textSize(23 * e);
    text(permisoP8[i], 0, 82 * e);
    popMatrix();
    color colorIcono = color(205, 225, 255);
    if (candadoJefeP8[i]) {
      colorIcono = color(130, 140, 160);
    }
    dibujarIconoA3(iconoPermisoP8[i], x + 105 + tiembla, y + 80, 80 * entra, colorIcono);
    if (candadoJefeP8[i]) {
      float golpe = 1 + 0.5 * (1 - reboteTelon((millis() - cambioCandadoP8[i]) / 300.0));
      dibujarCandadoA3(x + 105, y + 110, 0.85 * golpe, false, constrain(1 - (millis() - cambioCandadoP8[i]) / 250.0, 0, 1));
    }
  }

  // boton listo
  boolean sobreListo = faseP8 == 5 && listoBajoMouseP8();
  pushMatrix();
  translate(960 * e, 925 * e);
  if (sobreListo) {
    scale(1.06);
  }
  fill(tintaA3);
  rect(-176 * e, -51 * e, 352 * e, 102 * e);
  fill(doradoA3);
  if (candadosPuestosP8 < 3) {
    fill(doradoA3, 110);
  }
  rect(-170 * e, -45 * e, 340 * e, 90 * e);
  fill(tintaA3);
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(40 * e);
  text("LISTO", 0, -4 * e);
  popMatrix();
}


// en el jefe: la tarjeta de la izquierda con lo unico que hace Aporia (la pista)
void dibujarFuncionesAppP8(float e) {
  pushMatrix();
  translate(395 * e, 420 * e);
  rotate(-0.025 + sin(millis() * 0.001) * 0.006);
  fill(0, 110);
  rect(-152 * e, -152 * e, 320 * e, 330 * e);
  fill(tintaA3);
  rect(-166 * e, -166 * e, 332 * e, 342 * e);
  fill(236, 240, 250);
  rect(-160 * e, -160 * e, 320 * e, 330 * e);
  fill(azulA3);
  rect(-160 * e, -160 * e, 320 * e, 62 * e);
  fill(255);
  textFont(fuenteTexto);
  textAlign(CENTER, CENTER);
  textSize(27 * e);
  text("Aporía sirve para", 0, -131 * e);
  popMatrix();

  String[] funciones = {"Publicar fotos", "Publicar historias", "Mensajes de voz"};
  int[] iconos = {ICONO_FOTO, ICONO_HISTORIA, ICONO_MICROFONO};
  for (int i = 0; i < 3; i++) {
    float y = 350 + i * 82;
    dibujarIconoA3(iconos[i], 280, y, 48, azulA3);
    fill(30, 34, 60);
    textFont(fuenteTexto);
    textAlign(LEFT, CENTER);
    textSize(26 * e);
    text(funciones[i], 318 * e, (y - 4) * e);
  }
}


// en el jefe: los candados que te quedan
void dibujarBandejaP8(float e) {
  fill(0, 110);
  rect(1413 * e, 268 * e, 220 * e, 420 * e);
  fill(tintaA3);
  rect(1399 * e, 254 * e, 232 * e, 432 * e);
  fill(78, 52, 26);
  rect(1405 * e, 260 * e, 220 * e, 420 * e);
  fill(98, 68, 36);
  rect(1405 * e, 260 * e, 220 * e, 16 * e);
  fill(255);
  textFont(fuenteTexto);
  textAlign(CENTER, CENTER);
  textSize(30 * e);
  text("Tus candados", 1515 * e, 225 * e);
  for (int c = 0; c < 3; c++) {
    float y = 350 + c * 125;
    fill(50, 32, 14);
    ellipse(1515 * e, (y + 52) * e, 140 * e, 28 * e);
    if (c < 3 - candadosPuestosP8) {
      dibujarCandadoA3(1515, y + sin(millis() * 0.003 + c * 2) * 4, 0.9, true, 0);
    }
  }
}


// los rastreadores: bichos negros con patas que se mueven, ojos rojos y el dato que se llevan
void dibujarBichosP8(float e) {
  for (int b = 0; b < cantidadBichosP8; b++) {
    if (bichoActivoP8[b]) {
      float x = bichoXP8[b];
      float y = bichoYP8[b];
      float crece = reboteTelon((millis() - bichoNaceP8[b]) / 300.0);
      float patas = sin(millis() * 0.05 + b) * 7;
      // aro que avisa que se puede aplastar
      noFill();
      stroke(rojoA3, 120 + 100 * sin(millis() * 0.015));
      strokeWeight(4 * e);
      ellipse(x * e, y * e, 80 * crece * e, 80 * crece * e);
      noStroke();
      pushMatrix();
      translate(x * e, y * e);
      rotate(bichoAnguloP8[b]);
      scale(crece * 1.2);
      stroke(tintaA3);
      strokeWeight(5 * e);
      for (int k = -1; k <= 1; k++) {
        float mueve = patas;
        if (k == 0) {
          mueve = -patas;
        }
        line(k * 10 * e, 0, (k * 12 + mueve) * e, -26 * e);
        line(k * 10 * e, 0, (k * 12 - mueve) * e, 26 * e);
      }
      line(16 * e, -6 * e, 34 * e, -16 * e);
      line(16 * e, 6 * e, 34 * e, 16 * e);
      noStroke();
      fill(tintaA3);
      ellipse(0, 0, 50 * e, 38 * e);
      fill(26, 24, 36);
      ellipse(0, 0, 42 * e, 30 * e);
      fill(70, 70, 95);
      ellipse(-6 * e, -6 * e, 14 * e, 6 * e);
      fill(255, 60, 60, 80);
      ellipse(14 * e, -6 * e, 14 * e, 14 * e);
      ellipse(14 * e, 6 * e, 14 * e, 14 * e);
      fill(255, 70, 70);
      ellipse(14 * e, -6 * e, 7 * e, 7 * e);
      ellipse(14 * e, 6 * e, 7 * e, 7 * e);
      popMatrix();
      // el dato que se lleva en una burbuja
      float burbuja = y - 56 + sin(millis() * 0.01 + b) * 4;
      fill(tintaA3);
      ellipse(x * e, burbuja * e, 50 * e, 50 * e);
      fill(255);
      ellipse(x * e, burbuja * e, 42 * e, 42 * e);
      dibujarIconoA3(iconoPermisoP8[bichoPermisoP8[b]], x, burbuja, 28, rojoA3);
    }
  }
  strokeWeight(1);
}


// las manchas de tinta de los rastreadores aplastados (se borran en 1,4 s)
void dibujarManchasP8(float e) {
  noStroke();
  for (int m = 0; m < cantidadManchasP8; m++) {
    int pasado = millis() - manchaInicioP8[m];
    if (pasado < 1400) {
      float avance = pasado / 1400.0;
      float revienta = reboteTelon(pasado / 200.0);
      fill(20, 16, 40, 230 * (1 - avance));
      ellipse(manchaXP8[m] * e, manchaYP8[m] * e, 70 * revienta * e, 52 * revienta * e);
      for (int gota = 0; gota < 7; gota++) {
        float angulo = gota * TWO_PI / 7 + m;
        float lejos = (40 + 30 * revienta) * (0.8 + 0.3 * (gota % 3));
        float tam = (14 - gota % 3 * 3) * e;
        ellipse((manchaXP8[m] + cos(angulo) * lejos) * e, (manchaYP8[m] + sin(angulo) * lejos * 0.7) * e, tam, tam);
      }
      if (pasado < 200) {
        fill(255, 255 * (1 - pasado / 200.0));
        ellipse(manchaXP8[m] * e, manchaYP8[m] * e, 90 * revienta * e, 16 * e);
        ellipse(manchaXP8[m] * e, manchaYP8[m] * e, 16 * e, 90 * revienta * e);
      }
      // la estrella de historieta con el PLAF (medio segundo)
      if (pasado < 550) {
        float crece = reboteTelon(pasado / 180.0);
        float opacidad = 255 * (1 - constrain((pasado - 350) / 200.0, 0, 1));
        pushMatrix();
        translate(manchaXP8[m] * e, (manchaYP8[m] - 20) * e);
        rotate(-0.15 + m * 0.3);
        scale(crece);
        fill(tintaA3, opacidad);
        beginShape();
        for (int punta = 0; punta < 20; punta++) {
          float radio = 78;
          if (punta % 2 == 1) {
            radio = 46;
          }
          vertex(cos(punta * TWO_PI / 20) * radio * e, sin(punta * TWO_PI / 20) * radio * 0.75 * e);
        }
        endShape(CLOSE);
        fill(255, 235, 120, opacidad);
        beginShape();
        for (int punta = 0; punta < 20; punta++) {
          float radio = 68;
          if (punta % 2 == 1) {
            radio = 40;
          }
          vertex(cos(punta * TWO_PI / 20) * radio * e, sin(punta * TWO_PI / 20) * radio * 0.75 * e);
        }
        endShape(CLOSE);
        fill(tintaA3, opacidad);
        textFont(fuente);
        textAlign(CENTER, CENTER);
        textSize(36 * e);
        text("PLAF", 0, -4 * e);
        popMatrix();
      }
    }
  }
}


// mouse apretado: aplastar un rastreador (responde al instante, sin esperar a soltar)
void presionarP8() {
  if (telonActivo || guiaActiva || faseP8 < 1 || faseP8 > 2) {
    return;
  }
  int b = bichoBajoMouseP8();
  if (b >= 0) {
    aplastarBichoP8(b);
  }
}


// (la prueba no arrastra nada; se deja para el mouseReleased del vestibulo)
void soltarP8() {
}


// clic: negar o permitir; en el jefe, poner candados y LISTO
void clicP8() {
  if (bichoBajoMouseP8() >= 0) {
    return;
  }
  if (faseP8 == 1) {
    int boton = botonBajoMouseP8();
    if (boton != 0) {
      decidirP8(boton, false);
    }
  }
  if (faseP8 == 5) {
    int i = cartaBajoMouseP8();
    if (i >= 0) {
      candadoCartaP8(i);
    }
    if (listoBajoMouseP8()) {
      confirmarJefeP8();
    }
  }
}


// teclas: flechas o A/D para decidir; ENTER confirma los candados del jefe
void teclaP8() {
  if (faseP8 == 1) {
    if (keyCode == LEFT || key == 'a' || key == 'A') {
      decidirP8(-1, false);
    }
    if (keyCode == RIGHT || key == 'd' || key == 'D') {
      decidirP8(1, false);
    }
  }
  if (faseP8 == 5 && (keyCode == ENTER || key == ENTER || key == RETURN)) {
    confirmarJefeP8();
  }
}


// gana: aciertos (13 x 2 = 26) + mejor racha (hasta 8) + Aporia 2.0 derrotada (10) + sin errores (6) = 50
void ganarP8() {
  if (faseP8 == 4) {
    return;
  }
  int puntosAciertos = correctasP8 * 2;
  int puntosRacha = min(mejorRachaP8, 8);
  int puntosJefe = 10;
  if (intentosJefeP8 > 1) {
    puntosJefe = 5;
  }
  int puntosSinErrores = 0;
  if (erroresP8 == 0 && robosP8 == 0) {
    puntosSinErrores = 6;
  }

  lineaTexto[0] = "Permisos bien decididos";
  lineaPuntos[0] = puntosAciertos;
  lineaTexto[1] = "Mejor racha";
  lineaPuntos[1] = puntosRacha;
  lineaTexto[2] = "Aporía 2.0 derrotada";
  lineaPuntos[2] = puntosJefe;
  lineaTexto[3] = "Sin errores";
  lineaPuntos[3] = puntosSinErrores;
  cantidadLineas = 4;

  puntosGanadosP8 = puntosAciertos + puntosRacha + puntosJefe + puntosSinErrores;
  puntosJugador += puntosGanadosP8;
  subirExposicion(-5);
  resultadoActo3[0] = 1;
  if (correctasP8 == cantidadPedidosP8) {
    ganarLogro(7);
  }
  revisarLogrosActos();
  if (pruebasCompletadasActo3 == 0) {
    pruebasCompletadasActo3 = 1;
  }
  empezarCierreP8(true);
}


// pierde: se filtra el dato (sus contactos); 1 punto por permiso bien decidido
void perderP8(int motivo) {
  if (faseP8 == 4) {
    return;
  }
  motivoDerrotaP8 = motivo;
  lineaTexto[0] = "Permisos bien decididos";
  lineaPuntos[0] = correctasP8;
  cantidadLineas = 1;
  puntosGanadosP8 = correctasP8;
  puntosJugador += puntosGanadosP8;

  resultadoActo3[0] = 2;
  if (pruebasCompletadasActo3 == 0) {
    pruebasCompletadasActo3 = 1;
  }
  filtrarDato(9);
  empezarCierreP8(false);
}


// el tiempo se acabo (lo llama el contador)
void tiempoAgotadoP8() {
  perderP8(0);
}


// empieza el cierre: los rastreadores que quedan se van
void empezarCierreP8(boolean gano) {
  faseP8 = 4;
  cierreGanoP8 = gano;
  inicioCierreP8 = millis();
  for (int b = 0; b < cantidadBichosP8; b++) {
    bichoActivoP8[b] = false;
  }
  if (gano) {
    agregarImpacto("CELULAR PROTEGIDO", 960, 540, 80, celesteA3);
    sonidosCargadosSample[14].trigger();
    caraReaccionP8(0, 3000);
  } else {
    agregarImpacto("TE RASTREARON", 960, 540, 80, color(255, 110, 110));
    sombraReacciona(2);
    caraReaccionP8(3, 3000);
  }
}


// textos de la pantalla de resultado
void llenarResultadoP8(boolean gano) {
  tituloResultado = "Se acabó el tiempo";
  if (motivoDerrotaP8 == 2) {
    tituloResultado = "Te quedaste sin palitos";
  }
  subtituloResultado = "Los rastreadores se llevaron lo que dejaste abierto.";
  selloIlustracion = "ABIERTO";
  if (gano) {
    tituloResultado = "Prueba superada";
    subtituloResultado = "Cada app tiene solo lo que necesita.";
    selloIlustracion = "BLOQUEADO";
  }
  explicacionIlustracion = "Una app solo necesita los permisos\nde lo que de verdad hace.";
  fraseVidaReal = "Muchas apps piden más permisos de los que usan. Y si no decides, muchas veces deciden por ti.";
  consejoVidaReal = "Cuando una app te pida algo, pregúntate para qué lo usa. Si no tiene sentido, niégalo. Revísalos en los ajustes.";
  datoResultado = 9;
  ilustracionResultado = 8;
  puntosResultado = puntosGanadosP8;
}


// la ilustracion del resultado: un celular con seis puertas y tres candados (se dibuja alrededor de 0, 0)
void dibujarIlustracionResultadoP8() {
  float e = width / 1920.0;
  noStroke();
  fill(0, 110);
  rect(-125 * e, -175 * e, 260 * e, 380 * e);
  fill(tintaA3);
  rect(-136 * e, -196 * e, 272 * e, 392 * e);
  fill(28, 32, 52);
  rect(-130 * e, -190 * e, 260 * e, 380 * e);
  fill(azulA3);
  rect(-116 * e, -170 * e, 232 * e, 44 * e);
  for (int i = 0; i < 6; i++) {
    float x = -106 + (i % 3) * 74;
    float y = -110 + (i / 3) * 140;
    fill(tintaA3);
    rect((x - 3) * e, (y - 3) * e, 64 * e, 106 * e);
    fill(30, 58, 128);
    if (!necesarioJefeP8[i]) {
      fill(58, 66, 92);
    }
    rect(x * e, y * e, 58 * e, 100 * e);
  }
  for (int i = 0; i < 6; i++) {
    if (!necesarioJefeP8[i]) {
      dibujarCandadoA3(-77 + (i % 3) * 74, -32 + (i / 3) * 140, 0.38, false, 0);
    }
  }
}


// 38 - ACTO III - PRUEBA 8 - PRUEBA PERDIDA
void dibujarPerdidaP8() {
  dibujarResultado(false);
}


// 39 - ACTO III - PRUEBA 8 - PRUEBA SUPERADA
void dibujarSuperadaP8() {
  dibujarResultado(true);
}
