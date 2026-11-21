// PRUEBA 5 - ACTO II - PRUEBA 1: EL EN VIVO (pantallas 27 juego, 28 perdida, 29 superada)
// transmites en vivo desde tu cuarto y el publico te escribe desde sus celulares: los comentarios vuelan hacia tu cara.
// Revienta los que piden tus datos y los que te hacen sentir culpable por querer privacidad; las opiniones validas
// dejalas llegar. Al final la voz A aparece en persona y su frase se rompe en palabras.

// TEXTOS (tipo: 0 = voz A, 1 = opinion valida, 2 = pide datos, 3 = relleno)
String fraseVozAP5 = "Si no tienes nada que esconder, déjalo público.";
String[] validasP5 = {
  "Yo lo mantendría privado, pero tú decides.",
  "No tienes que demostrarle nada a nadie.",
  "Piensa quién necesita ver eso de verdad.",
  "Tu cuenta, tus reglas.",
  "Haz lo que te haga sentir seguro."
};
String[] pideDatosP5 = {
  "cuál es tu contraseña? jaja",
  "en qué colegio estudias?",
  "pasa tu número",
  "dónde vives?",
  "mándame tu ubicación",
  "a qué hora sales de tu casa?"
};
String[] rellenoP5 = {"jajaja", "primero!!", "saludos", "te amo", "hola desde Medellín", "que fuego!!"};
String[] usuariosP5 = {"sofi.k", "el mono", "nati22", "juli.p", "fan n1", "dani.m", "luchoo", "vale.r"};
String[] disfracesP5 = {"mateo.r", "la vecina", "andre.g", "tu primo"};
String usuarioVozAP5 = "VerdadAbsoluta";

// COMENTARIOS QUE VUELAN (arreglos paralelos)
int cantidadComentariosP5 = 14;
float[] comXP5 = new float[14];            // centro (medidas de 1920)
float[] comYP5 = new float[14];
float[] comVelP5 = new float[14];          // pixeles por segundo
float[] comFaseP5 = new float[14];         // para el bamboleo
float[] comAnchoP5 = new float[14];
float[] comAltoP5 = new float[14];
int[] comTipoP5 = new int[14];
int[] comInicioP5 = new int[14];           // millis() en que aparecio (entra creciendo)
String[] comTextoP5 = new String[14];
String[] comUsuarioP5 = new String[14];
boolean[] comActivoP5 = new boolean[14];

// ESTALLIDOS (POP, PLAF...) en circulo
int cantidadPopsP5 = 12;
float[] popXP5 = new float[12];
float[] popYP5 = new float[12];
int[] popInicioP5 = new int[12];
color[] popColorP5 = new color[12];
String[] popTextoP5 = new String[12];
int siguientePopP5 = 0;
String[] onomatopeyasP5 = {"POP", "PLAF", "ZAS", "PUM"};

// EL PUBLICO CON CELULARES: de sus celulares salen los comentarios (4 en cada palco y 13 en la primera fila)
float[] publicoXP5 = {300, 430, 300, 430, 1490, 1620, 1490, 1620, 270, 385, 500, 615, 730, 845, 960, 1075, 1190, 1305, 1420, 1535, 1650};
float[] publicoYP5 = {370, 370, 630, 630, 370, 370, 630, 630, 985, 985, 985, 985, 985, 985, 985, 985, 985, 985, 985, 985, 985};
int[] pingPublicoP5 = new int[21];         // millis() en que su celular mando un comentario (destello)
int cantidadPublicoP5 = 21;

// CORAZONES que suben por el en vivo
int cantidadCorazonesP5 = 24;
float[] corXP5 = new float[24];
float[] corYP5 = new float[24];
int[] corInicioP5 = new int[24];
color[] corColorP5 = new color[24];
int siguienteCorazonP5 = 0;
int ultimoCorazonP5 = 0;

// CHAT DEL EN VIVO: las ultimas 4 lineas (la mas nueva abajo)
String[] chatP5 = new String[4];
int cantidadChatP5 = 4;
int ultimoChatP5 = 0;
int inicioChatP5 = 0;                      // millis() de la ultima linea (las lineas suben deslizandose)

// EL FILTRO: un poder que aparece dos veces; al reventarlo, borra todos los pedidos de datos y te protege 5 s
boolean filtroVisibleP5 = false;
float filtroXP5 = 0;
float filtroYP5 = 0;
int inicioFiltroP5 = 0;
int filtrosSalidosP5 = 0;
int escudoHastaP5 = 0;                     // millis() hasta cuando dura el escudo
int cantidadRayosP5 = 10;
float[] rayoX1P5 = new float[10];
float[] rayoY1P5 = new float[10];
float[] rayoX2P5 = new float[10];
float[] rayoY2P5 = new float[10];
int[] rayoInicioP5 = new int[10];
int siguienteRayoP5 = 0;

// GRIETAS en la pantalla del celular cuando algo malo te alcanza
int cantidadGrietasP5 = 4;
float[] grietaXP5 = new float[4];
float[] grietaYP5 = new float[4];
int[] grietaInicioP5 = new int[4];
int siguienteGrietaP5 = 0;

// EL JEFE: la voz A en persona; con 3 golpes su frase se rompe en palabras que giran hacia ti
float jefeYP5 = -150;
int golpesJefeP5 = 0;
int inicioJefeP5 = 0;
int ultimoGolpeJefeP5 = -10000;
boolean jefeRotoP5 = false;
String[] palabrasP5;                        // la frase partida con split (se arma en iniciarP5)
int cantidadPalabrasP5 = 8;
float[] palAnguloP5 = new float[8];
float[] palRadioP5 = new float[8];
float[] palGiroP5 = new float[8];          // velocidad de giro (rad/s)
float[] palXP5 = new float[8];             // posicion calculada en cada cuadro (para el clic)
float[] palYP5 = new float[8];
boolean[] palVivaP5 = new boolean[8];
int[] palErrorP5 = new int[8];
int trampasP5 = 0;                         // palabras trampa reventadas ("nada", "que", "esconder,")

// ESTADO DE LA PRUEBA
float caraXP5 = 960;                       // centro de tu cara (medidas de 1920)
float caraYP5 = 600;
int faseP5 = -1;                           // -1 = telon y guia, 1 = comentarios, 2 = el jefe, 3 = cierre
int inicioJuegoP5 = 0;
int ultimoComentarioP5 = 0;
int ultimoCuadroP5 = 0;
float dtP5 = 0.016;
int spawnsP5 = 0;
int desdeAP5 = 0;
int vecesAP5 = 0;                          // voz A reventadas
int datosElimP5 = 0;                       // pedidos de datos reventados
int escuchadasP5 = 0;                      // opiniones validas que dejaste llegar
int legitElimP5 = 0;                       // opiniones validas reventadas por error
int rachaP5 = 0;
int espectadoresP5 = 1204;
float aplausoP5 = 0;                       // 0 a 1
float aplausoMostradoP5 = 0;
float animoCaraP5 = 0;                     // -1 triste, 1 feliz
int inicioGolpeCaraP5 = -10000;            // te alcanzo algo malo: la cara se sacude en rojo
int inicioTinteP5 = -10000;                // la voz A te alcanzo: la pantalla se tine de amarillo
int inicioOvacionP5 = -10000;              // el publico salta y aplaude
boolean avisoDisfrazP5 = false;            // ya se aviso que la voz A se disfraza
int cartelP5 = 0;                          // cartel que explica al jefe: 1 = entra VerdadAbsoluta, 2 = la frase se rompio
int inicioCartelP5 = 0;                    // millis() en que aparecio el cartel
int cartelHastaP5 = 0;                     // mientras millis() sea menor, el juego espera (el reloj tambien)
int transcurridoCartelP5 = 0;              // tiempo de prueba que habia pasado al aparecer el cartel
String[] culpasP5 = {"Qué escondes?", "Algo ocultas", "Muy sospechoso", "Si no debes, no temes", "Para qué tanto secreto?"};
int ultimaCulpaP5 = 0;
int faseJefeP5 = 1;                        // 1 = las dudas, 2 = la exigencia (te abre la cuenta)
boolean cuentaAbiertaP5 = false;           // fase 2: el jefe puso tu cuenta en PUBLICA
int inicioAbiertaP5 = 0;                   // millis() en que la abrio
int proximoAtaqueP5 = 0;                   // millis() del proximo intento de abrirla
int tiempoParaCerrarP5 = 1700;             // ms que tienes para volver a cerrarla
String gritoJefeP5 = "";                   // lo que grita en la fase 2
int inicioCerradaP5 = -10000;              // millis() de la ultima vez que la cerraste a tiempo (destello verde)
String[] gritosP5 = {"Abre tu cuenta!", "Muéstralo todo!", "Qué escondes?", "Déjala pública!", "No seas misterioso!"};                     // millis() de la ultima duda que lanzo el jefe
int inicioSacudidaP5 = -10000;             // la pantalla tiembla al golpear al jefe
int tonoMensajeP5 = 0;                     // 1 = bien (verde), -1 = error (rojo), 0 = aviso (amarillo)
int expresionP5 = -1;                      // cara que se ve: -1 normal, 0 alegre, 1 enojado, 2 sorprendido, 3 triste, 4 pensativo, 5 cansado
int inicioExpresionP5 = 0;                 // millis() en que cambio la cara (da un saltito)
int inicioCierreP5 = 0;
boolean cierreGanoP5 = false;
int motivoDerrotaP5 = 0;                   // 0 = tiempo, 2 = sin palitos
int puntosGanadosP5 = 0;

// GUIA DE LA PRUEBA 5
String[] titulosGuiaP5 = {
  "Tu cordura",
  "El tiempo",
  "Exposición",
  "Tus puntos",
  "El en vivo",
  "El público",
  "Las opiniones",
  "La voz A",
  "Los aplausos",
  "A jugar"
};
String[] textosGuiaP5 = {
  "Estos palitos son tu cordura. Si cometes un error, pierdes uno. Si se acaban, pierdes la prueba.",
  "Lo que te queda para terminar. En los últimos 10 segundos la barra se pone roja.",
  "Cuánto de tu vida pueden ver los desconocidos. Sube sola mientras la sombra mira.",
  "Cada acierto suma puntos. Al final hay bonos por no equivocarte y por terminar rápido.",
  "Estás transmitiendo en vivo desde tu cuarto. Todo lo que te escriben vuela hacia tu cara.",
  "El público te escribe desde sus celulares. Haz clic en un comentario para reventarlo: revienta a quien te pide datos, como tu contraseña, tu colegio o dónde vives.",
  "Las opiniones válidas déjalas llegar: escuchar no es obedecer. Si revientas una, la gente se va y pierdes un palito. Lo de relleno no importa.",
  "VerdadAbsoluta dice que si no tienes nada que esconder, lo dejes público. Revienta su comentario 3 veces y aparecerá en persona. Ojo: después se disfraza.",
  "El público aplaude lo que quiere, no lo que te conviene. Si la barra se llena, te dejas llevar. A veces aparece un FILTRO dorado: revientalo y borra todos los pedidos de datos.",
  "Lee rápido, revienta lo que te presiona y deja pasar lo que te respeta. Pulsa ENTER para empezar."
};
float[][] zonasGuiaP5 = {
  {20, 8, 330, 80},
  {690, 22, 540, 100},
  {1385, 8, 490, 78},
  {1580, 98, 310, 80},
  {700, 180, 520, 800},
  {230, 300, 1460, 780},
  {230, 100, 1460, 900},
  {300, 100, 330, 85},
  {300, 175, 330, 60},
  {960, 540, 0, 0}
};
int cantidadPasosGuiaP5 = 10;


// prepara la prueba (se llama al terminar el contexto)
void iniciarP5() {
  duracionPrueba = 50000;
  inicioPrueba = millis();
  palitos = 5;

  for (int i = 0; i < cantidadComentariosP5; i++) {
    comActivoP5[i] = false;
  }
  for (int k = 0; k < cantidadPopsP5; k++) {
    popInicioP5[k] = -10000;
  }
  for (int s = 0; s < cantidadPublicoP5; s++) {
    pingPublicoP5[s] = -10000;
  }
  for (int c = 0; c < cantidadCorazonesP5; c++) {
    corInicioP5[c] = -10000;
  }
  for (int r = 0; r < cantidadRayosP5; r++) {
    rayoInicioP5[r] = -10000;
  }
  for (int g = 0; g < cantidadGrietasP5; g++) {
    grietaInicioP5[g] = -10000;
  }
  chatP5[0] = "";
  chatP5[1] = "";
  chatP5[2] = "nati22 se unió";
  chatP5[3] = "sofi.k se unió";

  // la frase de la voz A partida en palabras (cadenas: split corta donde hay espacios)
  palabrasP5 = split(fraseVozAP5, ' ');
  for (int p = 0; p < cantidadPalabrasP5; p++) {
    palVivaP5[p] = false;
    palErrorP5[p] = -10000;
  }

  faseP5 = -1;
  spawnsP5 = 0;
  desdeAP5 = 0;
  vecesAP5 = 0;
  datosElimP5 = 0;
  escuchadasP5 = 0;
  legitElimP5 = 0;
  rachaP5 = 0;
  trampasP5 = 0;
  espectadoresP5 = 1204;
  aplausoP5 = 0;
  aplausoMostradoP5 = 0;
  animoCaraP5 = 0;
  inicioGolpeCaraP5 = -10000;
  inicioTinteP5 = -10000;
  inicioOvacionP5 = -10000;
  avisoDisfrazP5 = false;
  cartelHastaP5 = 0;
  filtroVisibleP5 = false;
  filtrosSalidosP5 = 0;
  escudoHastaP5 = 0;
  jefeYP5 = -150;
  golpesJefeP5 = 0;
  jefeRotoP5 = false;
  ultimoGolpeJefeP5 = -10000;
  ultimoCuadroP5 = millis();
  motivoDerrotaP5 = 0;
  mensajePrueba = "";

  prepararArteP5();   // dibuja una sola vez el protagonista, el cuarto y el publico (prueba5_arte)

  empezarAmbientePrueba();
  empezarTelon();
  empezarGuia(titulosGuiaP5, textosGuiaP5, zonasGuiaP5, cantidadPasosGuiaP5);
}


// texto de espectadores con punto de miles: 1204 -> 1.204
String espectadoresTextoP5() {
  if (espectadoresP5 < 1000) {
    return "" + espectadoresP5;
  }
  return (espectadoresP5 / 1000) + "." + nf(espectadoresP5 % 1000, 3);
}


// puntos que lleva la prueba (marcador en vivo)
int puntosEnVivoP5() {
  return min(vecesAP5, 3) * 2 + min(datosElimP5, 4) + min(escuchadasP5, 4);
}


// segundos de juego (para que todo se acelere)
float segundosJuegoP5() {
  return (millis() - inicioJuegoP5) / 1000.0;
}


// un estallido de historieta en (x, y)
void agregarPopP5(float x, float y, color colorPop) {
  popXP5[siguientePopP5] = x;
  popYP5[siguientePopP5] = y;
  popInicioP5[siguientePopP5] = millis();
  popColorP5[siguientePopP5] = colorPop;
  popTextoP5[siguientePopP5] = onomatopeyasP5[int(random(4))];
  siguientePopP5 = (siguientePopP5 + 1) % cantidadPopsP5;
}


// un corazon que sube por el en vivo desde (x, y)
void agregarCorazonP5(float x, float y) {
  corXP5[siguienteCorazonP5] = x;
  corYP5[siguienteCorazonP5] = y;
  corInicioP5[siguienteCorazonP5] = millis();
  int tono = int(random(4));
  corColorP5[siguienteCorazonP5] = color(255, 90, 130);
  if (tono == 1) {
    corColorP5[siguienteCorazonP5] = color(255, 60, 70);
  }
  if (tono == 2) {
    corColorP5[siguienteCorazonP5] = color(255, 210, 90);
  }
  if (tono == 3) {
    corColorP5[siguienteCorazonP5] = color(127, 212, 255);
  }
  siguienteCorazonP5 = (siguienteCorazonP5 + 1) % cantidadCorazonesP5;
}


// una linea nueva en el chat del en vivo (las demas suben)
void agregarChatP5(String linea) {
  for (int l = 0; l < cantidadChatP5 - 1; l++) {
    chatP5[l] = chatP5[l + 1];
  }
  chatP5[cantidadChatP5 - 1] = linea;
  inicioChatP5 = millis();
}


// un rayo del filtro entre dos puntos
void agregarRayoP5(float x1, float y1, float x2, float y2) {
  rayoX1P5[siguienteRayoP5] = x1;
  rayoY1P5[siguienteRayoP5] = y1;
  rayoX2P5[siguienteRayoP5] = x2;
  rayoY2P5[siguienteRayoP5] = y2;
  rayoInicioP5[siguienteRayoP5] = millis();
  siguienteRayoP5 = (siguienteRayoP5 + 1) % cantidadRayosP5;
}


// una grieta en la pantalla del celular
void agregarGrietaP5(float x, float y) {
  grietaXP5[siguienteGrietaP5] = constrain(x, 760, 1160);
  grietaYP5[siguienteGrietaP5] = constrain(y, 280, 920);
  grietaInicioP5[siguienteGrietaP5] = millis();
  siguienteGrietaP5 = (siguienteGrietaP5 + 1) % cantidadGrietasP5;
}


// crea un comentario: sale del celular de alguien del publico y vuela hacia tu cara
void crearComentarioP5(boolean soloLigeros) {
  int libre = -1;
  for (int i = 0; i < cantidadComentariosP5; i++) {
    if (!comActivoP5[i] && libre == -1) {
      libre = i;
    }
  }
  if (libre == -1) {
    return;
  }

  // el tipo: al azar, pero la voz A sale al menos cada 5 comentarios; los 2 primeros son tranquilos
  float azar = random(1);
  int tipo = 3;
  if (azar < 0.68) {
    tipo = 2;
  }
  if (azar < 0.34) {
    tipo = 1;
  }
  if (desdeAP5 >= 4 && spawnsP5 >= 2 && !soloLigeros) {
    tipo = 0;
  }
  if (spawnsP5 < 2) {
    tipo = 3;
    if (spawnsP5 == 1) {
      tipo = 1;
    }
  }
  spawnsP5++;
  desdeAP5++;

  String texto = rellenoP5[int(random(6))];
  String usuario = usuariosP5[int(random(8))];
  if (tipo == 0) {
    desdeAP5 = 0;
    texto = fraseVozAP5;
    usuario = usuarioVozAP5;
    // despues de la primera vez (o pasados 15 s) se disfraza
    if (vecesAP5 >= 1 || segundosJuegoP5() > 15) {
      usuario = disfracesP5[int(random(4))];
    }
  }
  if (tipo == 1) {
    texto = validasP5[int(random(5))];
  }
  if (tipo == 2) {
    texto = pideDatosP5[int(random(6))];
  }

  // sale del celular de alguien del publico (su celular destella)
  int quien = int(random(cantidadPublicoP5));
  pingPublicoP5[quien] = millis();
  float x = constrain(publicoXP5[quien], 420, 1500);
  float y = min(publicoYP5[quien] - 40, 930);

  // tamano de la burbuja segun el texto (una o dos lineas)
  textFont(fuenteTexto);
  textSize(22 * width / 1920.0);
  float anchoTexto = textWidth(texto) / (width / 1920.0);
  float ancho = min(anchoTexto + 44, 340);
  float alto = 74;
  if (anchoTexto + 44 > 340) {
    alto = 102;
  }

  // velocidad: sube con el tiempo; la voz A va un poco mas rapido
  float velocidad = lerp(70, 125, constrain(segundosJuegoP5() / 30.0, 0, 1)) * random(0.85, 1.15);
  if (tipo == 0) {
    velocidad *= 1.1;
  }

  comActivoP5[libre] = true;
  comXP5[libre] = x;
  comYP5[libre] = y;
  comVelP5[libre] = velocidad;
  comFaseP5[libre] = random(TWO_PI);
  comAnchoP5[libre] = ancho;
  comAltoP5[libre] = alto;
  comTipoP5[libre] = tipo;
  comInicioP5[libre] = millis();
  comTextoP5[libre] = texto;
  comUsuarioP5[libre] = usuario;
}


// comentario bajo el mouse (el que esta dibujado encima), o -1
int comentarioBajoMouseP5() {
  float e = width / 1920.0;
  float mx = mouseX / e;
  float my = mouseY / e;
  for (int i = cantidadComentariosP5 - 1; i >= 0; i--) {
    if (comActivoP5[i]) {
      boolean dentro = mx > comXP5[i] - comAnchoP5[i] / 2 - 8 && mx < comXP5[i] + comAnchoP5[i] / 2 + 8 && my > comYP5[i] - comAltoP5[i] / 2 - 8 && my < comYP5[i] + comAltoP5[i] / 2 + 8;
      if (dentro) {
        return i;
      }
    }
  }
  return -1;
}


// el jugador revienta un comentario
void reventarComentarioP5(int i) {
  int tipo = comTipoP5[i];
  float x = comXP5[i];
  float y = comYP5[i];
  comActivoP5[i] = false;
  sonidosCargadosSample[43].trigger();

  if (tipo == 0) {
    vecesAP5++;
    rachaP5++;
    aplausoP5 = max(0, aplausoP5 - 0.3);
    animoCaraP5 = 1;
    agregarPopP5(x, y, color(255, 210, 90));
    agregarMoneda(x, y);
    agregarFlotante("+2", x, y - 40, color(255, 210, 90));
    agregarChatP5("Comentario eliminado");
    mensajeP5("Querer privacidad no significa esconder algo malo.", 1);
    sombraReacciona(1);
    if (vecesAP5 >= 3) {
      empezarJefeP5();
    }
  }
  if (tipo == 2) {
    datosElimP5++;
    rachaP5++;
    animoCaraP5 = 1;
    agregarPopP5(x, y, color(255, 150, 120));
    agregarMoneda(x, y);
    if (datosElimP5 <= 4) {
      agregarFlotante("+1", x, y - 40, color(255, 210, 90));
    }
    agregarChatP5("Comentario eliminado");
    mensajeP5("Nadie necesita ese dato.", 1);
  }
  if (tipo == 1) {
    legitElimP5++;
    rachaP5 = 0;
    espectadoresP5 = max(0, espectadoresP5 - 150);
    aplausoP5 = min(1, aplausoP5 + 0.2);
    animoCaraP5 = -1;
    agregarPopP5(x, y, color(127, 190, 255));
    agregarFlotante("-150", x, y - 40, color(255, 110, 110));
    agregarChatP5("150 personas salieron");
    perderPalito();
    mensajeP5("Era una opinión válida, no un ataque. La gente se va.", -1);
    sombraReacciona(2);
  }
  if (tipo == 3) {
    agregarPopP5(x, y, color(230));
  }
  if (tipo == 4) {
    rachaP5++;
    agregarPopP5(x, y, color(255, 210, 90));
    mensajeP5("Esa duda no es tuya. Revientala.", 1);
    mostrarRachaCursor(rachaP5);
  }

  // racha: el chat se emociona y llueven corazones
  if (tipo == 0 || tipo == 2) {
    mostrarRachaCursor(rachaP5);
    espectadoresP5 += 10 * rachaP5;
    for (int c = 0; c < min(rachaP5, 6); c++) {
      agregarCorazonP5(1150 + random(-20, 20), 930 + random(-10, 10));
    }
    if (rachaP5 == 5 || rachaP5 == 10) {
      agregarImpacto("RACHA " + rachaP5, 960, 330, 90, color(255, 210, 90));
    }
  }
}


// un comentario llego a tu cara sin que lo reventaras
void comentarioLlegoP5(int i) {
  int tipo = comTipoP5[i];
  float x = comXP5[i];
  float y = comYP5[i];
  comActivoP5[i] = false;

  // con el escudo del filtro, los pedidos de datos rebotan
  if (tipo == 2 && millis() < escudoHastaP5) {
    datosElimP5++;
    agregarPopP5(x, y, color(255, 210, 90));
    sonidosCargadosSample[43].trigger();
    return;
  }

  if (tipo == 0) {
    rachaP5 = 0;
    perderPalito();
    inicioTinteP5 = millis();
    inicioGolpeCaraP5 = millis();
    inicioOvacionP5 = millis();
    aplausoP5 = min(1, aplausoP5 + 0.34);
    animoCaraP5 = -1;
    agregarGrietaP5(x, y);
    sonidosCargadosSample[45].trigger();
    mensajeP5("Esa idea se te metió en la cabeza.", -1);
    sombraReacciona(2);
  }
  if (tipo == 2) {
    rachaP5 = 0;
    subirExposicion(5);
    inicioGolpeCaraP5 = millis();
    animoCaraP5 = -1;
    agregarGrietaP5(x, y);
    mensajeP5("Ese dato se filtró.", -1);
    sombraReacciona(2);
    agregarImpacto("FILTRADO", caraXP5, caraYP5 - 220, 70, color(225, 40, 55));
  }
  if (tipo == 4) {
    rachaP5 = 0;
    aplausoP5 = min(1, aplausoP5 + 0.25);
    inicioGolpeCaraP5 = millis();
    agregarGrietaP5(x, y);
    mensajeP5("Esa duda te hizo sentir culpable.", -1);
    sombraReacciona(2);
  }
  if (tipo == 1) {
    escuchadasP5++;
    espectadoresP5 += 40;
    animoCaraP5 = 1;
    for (int c = 0; c < 6; c++) {
      agregarCorazonP5(caraXP5 + random(-90, 90), caraYP5 + random(-40, 60));
    }
    if (escuchadasP5 <= 4) {
      agregarFlotante("+1", caraXP5, caraYP5 - 180, color(127, 212, 255));
    }
    mensajeP5("Escuchar una opinión no es obedecerla.", 1);
  }
}


// el filtro: revienta todos los pedidos de datos que hay en pantalla con rayos y te protege 5 s
void activarFiltroP5() {
  filtroVisibleP5 = false;
  escudoHastaP5 = millis() + 5000;
  int borrados = 0;
  for (int i = 0; i < cantidadComentariosP5; i++) {
    if (comActivoP5[i] && comTipoP5[i] == 2) {
      agregarRayoP5(filtroXP5, filtroYP5, comXP5[i], comYP5[i]);
      agregarPopP5(comXP5[i], comYP5[i], color(255, 210, 90));
      comActivoP5[i] = false;
      datosElimP5++;
      borrados++;
    }
  }
  agregarPopP5(filtroXP5, filtroYP5, color(255, 230, 140));
  sonidosCargadosSample[44].trigger();
  sonidosCargadosSample[43].trigger();
  agregarImpacto("FILTRO ACTIVADO", 960, 330, 80, color(255, 210, 90));
  agregarChatP5("Filtro de palabras activado");
  mensajeP5("En un en vivo puedes filtrar palabras como contraseña o dirección.", 1);
  if (borrados > 0) {
    agregarFlotante("+" + borrados, filtroXP5, filtroYP5 - 50, color(255, 210, 90));
  }
  sombraReacciona(1);
}


// muestra una frase en el recuadro de arriba del celular, con el color segun si fue un acierto, un error o un aviso
void mensajeP5(String texto, int tono) {
  mostrarMensaje(texto);
  tonoMensajeP5 = tono;
}


// el recuadro de los mensajes: una vineta de historieta encima del celular que entra con rebote y se va
void dibujarMensajeP5(float e) {
  int pasado = millis() - inicioMensajePrueba;
  if (pasado > 2800 || mensajePrueba.length() == 0) {
    return;
  }
  float entra = reboteTelon(pasado / 280.0);
  float opacidad = 255 * (1 - constrain((pasado - 2300) / 500.0, 0, 1));
  color borde = color(255, 210, 90);
  if (tonoMensajeP5 == 1) {
    borde = color(120, 225, 130);
  }
  if (tonoMensajeP5 == -1) {
    borde = color(240, 80, 80);
  }
  textFont(fuenteTexto);
  textSize(34 * e);
  float ancho = textWidth(mensajePrueba) / e + 70;

  pushMatrix();
  translate(960 * e, 140 * e);
  scale(0.6 + 0.4 * entra);
  rotate(-0.012);
  noStroke();
  fill(0, 120 * opacidad / 255);
  rect((-ancho / 2 + 7) * e, -27 * e, ancho * e, 66 * e);
  fill(borde, opacidad);
  rect((-ancho / 2 - 5) * e, -38 * e, (ancho + 10) * e, 76 * e);
  fill(22, 16, 8, opacidad);
  rect(-ancho / 2 * e, -33 * e, ancho * e, 66 * e);
  fill(255, opacidad);
  textAlign(CENTER, CENTER);
  text(mensajePrueba, 0, -3 * e);
  popMatrix();
}


// el jefe lanza una duda: un comentario amarillo que sale de su burbuja y vuela hacia tu cara
void crearCulpaP5() {
  int libre = -1;
  for (int i = 0; i < cantidadComentariosP5; i++) {
    if (!comActivoP5[i] && libre == -1) {
      libre = i;
    }
  }
  if (libre == -1) {
    return;
  }
  String texto = culpasP5[int(random(5))];
  textFont(fuenteTexto);
  textSize(22 * width / 1920.0);
  comActivoP5[libre] = true;
  comXP5[libre] = 960 + random(-320, 320);
  comYP5[libre] = jefeYP5 + 60;
  comVelP5[libre] = 115;
  comFaseP5[libre] = random(TWO_PI);
  comAnchoP5[libre] = min(textWidth(texto) / (width / 1920.0) + 44, 340);
  comAltoP5[libre] = 74;
  comTipoP5[libre] = 4;
  comInicioP5[libre] = millis();
  comTextoP5[libre] = texto;
  comUsuarioP5[libre] = usuarioVozAP5;
  sonidosCargadosSample[17].trigger();
}


// abre un cartel que explica lo que hay que hacer; el juego (y el reloj) esperan 5 s o hasta un clic
void abrirCartelP5(int cual) {
  cartelP5 = cual;
  inicioCartelP5 = millis();
  cartelHastaP5 = millis() + 5000;
  transcurridoCartelP5 = millis() - inicioPrueba;
}


// el jefe: se limpian los comentarios y la voz A baja en persona
void empezarJefeP5() {
  faseP5 = 2;
  inicioJefeP5 = millis();
  jefeYP5 = -150;
  golpesJefeP5 = 0;
  jefeRotoP5 = false;
  faseJefeP5 = 1;
  cuentaAbiertaP5 = false;
  filtroVisibleP5 = false;
  for (int i = 0; i < cantidadComentariosP5; i++) {
    if (comActivoP5[i]) {
      agregarPopP5(comXP5[i], comYP5[i], color(230));
      comActivoP5[i] = false;
    }
  }
  sonidosCargadosSample[45].trigger();
  inicioOvacionP5 = millis();
  agregarChatP5("VerdadAbsoluta se unió");
  agregarImpacto("VERDADABSOLUTA ENTRA AL CHAT", 960, 420, 64, color(255, 210, 90));
  sombraReacciona(2);
  abrirCartelP5(1);
}


// golpe al jefe en la fase 1: con 3 se rompe su escudo y pasa a la fase 2 (la exigencia)
void golpearJefeP5() {
  golpesJefeP5++;
  ultimoGolpeJefeP5 = millis();
  sonidosCargadosSample[44].trigger();
  inicioSacudidaP5 = millis();
  agregarPopP5(mouseX / (width / 1920.0), mouseY / (width / 1920.0), color(255, 210, 90));
  agregarImpacto(golpesJefeP5 + " de 3", 1040, jefeYP5 + 10, 80, color(255, 255, 255));
  if (golpesJefeP5 >= 3) {
    // se le cae el escudo: se enoja y empieza a exigirte que abras tu cuenta
    for (int k = 0; k < 6; k++) {
      agregarPopP5(960 + (k - 2.5) * 140, jefeYP5 + random(-40, 40), color(255, 225, 90));
    }
    for (int i = 0; i < cantidadComentariosP5; i++) {
      if (comActivoP5[i]) {
        agregarPopP5(comXP5[i], comYP5[i], color(255, 225, 90));
        comActivoP5[i] = false;
      }
    }
    sonidosCargadosSample[45].trigger();
    inicioOvacionP5 = millis();
    faseJefeP5 = 2;
    golpesJefeP5 = 0;
    jefeYP5 = 250;
    cuentaAbiertaP5 = false;
    tiempoParaCerrarP5 = 1700;
    gritoJefeP5 = "Ahora vas a mostrarlo todo!";
    agregarImpacto("FASE 2", 960, 420, 110, color(255, 110, 90));
    sombraReacciona(2);
    abrirCartelP5(3);
  }
}


// fase 2: cerraste tu cuenta a tiempo; con 3 veces, el jefe se rompe
void cerrarCuentaP5() {
  cuentaAbiertaP5 = false;
  golpesJefeP5++;
  rachaP5++;
  ultimoGolpeJefeP5 = millis();
  inicioCerradaP5 = millis();
  inicioSacudidaP5 = millis();
  animoCaraP5 = 1;
  sonidosCargadosSample[44].trigger();
  agregarPopP5(960, 450, color(120, 225, 130));
  agregarImpacto("BLOQUEADO", 960, 450, 80, color(120, 225, 130));
  mostrarRachaCursor(rachaP5);
  mensajeP5("Tu cuenta es tuya. Nadie puede obligarte a abrirla.", 1);
  proximoAtaqueP5 = millis() + int(random(1100, 1900));
  tiempoParaCerrarP5 = max(1100, tiempoParaCerrarP5 - 200);   // cada vez tienes menos tiempo
  if (golpesJefeP5 >= 3) {
    romperJefeP5();
  }
}


// el jefe se rompe del todo: su frase se parte en palabras que giran hacia tu cara (golpe final)
void romperJefeP5() {
  for (int k = 0; k < 6; k++) {
    agregarPopP5(960 + (k - 2.5) * 140, jefeYP5 + random(-40, 40), color(255, 225, 90));
  }
  sonidosCargadosSample[16].trigger();
  inicioOvacionP5 = millis();
  jefeRotoP5 = true;
  trampasP5 = 0;
  textFont(fuenteTitulo);
  textSize(34 * width / 1920.0);
  float x = 960 - textWidth(fraseVozAP5) / (width / 1920.0) / 2;
  for (int p = 0; p < cantidadPalabrasP5; p++) {
    float anchoPalabra = textWidth(palabrasP5[p] + " ") / (width / 1920.0);
    float px = x + anchoPalabra / 2;
    // pasa la posicion de la palabra a angulo y distancia alrededor de la cara (la orbita es un ovalo)
    palAnguloP5[p] = atan2((jefeYP5 - caraYP5) / 0.8, (px - caraXP5) / 1.5);
    palRadioP5[p] = dist(0, 0, (px - caraXP5) / 1.5, (jefeYP5 - caraYP5) / 0.8);
    palGiroP5[p] = random(0.5, 0.9);
    if (p % 2 == 1) {
      palGiroP5[p] = -palGiroP5[p];
    }
    palVivaP5[p] = true;
    x += anchoPalabra;
  }
  agregarImpacto("SE ROMPE", 960, 300, 90, color(255, 210, 90));
  abrirCartelP5(2);
  mensajeP5("Qué palabras convierten la privacidad en culpa? Revienta solo esas.", 0);
  sombraReacciona(1);
}


// el candado de la fase 2 esta bajo el mouse?
boolean candadoBajoMouseP5() {
  float e = width / 1920.0;
  return faseP5 == 2 && faseJefeP5 == 2 && !jefeRotoP5 && mouseX / e > 790 && mouseX / e < 1130 && mouseY / e > 405 && mouseY / e < 495;
}


// la palabra es parte de la trampa?
boolean esTrampaP5(int p) {
  return palabrasP5[p].equals("nada") || palabrasP5[p].equals("que") || palabrasP5[p].equals("esconder,");
}


// 27 - ACTO II - PRUEBA 1 - EL EN VIVO
void dibujarEnVivoP5() {
  float e = width / 1920.0;

  dtP5 = constrain((millis() - ultimoCuadroP5) / 1000.0, 0, 0.1);
  ultimoCuadroP5 = millis();

  // FASES: al terminar el telon y la guia empieza el en vivo (el reloj corre desde ahi)
  if (faseP5 == -1 && !telonActivo && !guiaActiva) {
    faseP5 = 1;
    inicioJuegoP5 = millis();
    inicioPrueba = millis();
    ultimoComentarioP5 = millis() - 900;
    agregarImpacto("EN VIVO", 960, 420, 110, color(225, 60, 60));
    mensajeP5("Estás en vivo. 1.204 personas te están viendo.", 0);
  }
  if (faseP5 == -1) {
    inicioPrueba = millis();
  }
  // a los 15 s la voz A empieza a disfrazarse
  if (faseP5 == 1 && !avisoDisfrazP5 && segundosJuegoP5() >= 15) {
    avisoDisfrazP5 = true;
    agregarImpacto("SE DISFRAZA", 960, 330, 90, color(255, 210, 90));
    mensajeP5("Ahora la voz A usa otros nombres. Lee el mensaje, no el nombre.", 0);
  }
  // si en 32 s no reventaste 3 veces a la voz A, igual aparece en persona
  if (faseP5 == 1 && segundosJuegoP5() >= 26) {
    empezarJefeP5();
  }

  // con el cartel abierto todo espera: el reloj no corre y el jefe no avanza
  boolean enCartel = millis() < cartelHastaP5;
  if (enCartel) {
    inicioPrueba = millis() - transcurridoCartelP5;
    inicioJefeP5 = millis();
    proximoAtaqueP5 = millis() + 1200;
  }

  // LOGICA
  if ((faseP5 == 1 || faseP5 == 2) && !enCartel) {
    // nuevos comentarios: cada vez mas seguido; con el jefe, menos y sin voz A
    int intervalo = int(lerp(1400, 650, constrain(segundosJuegoP5() / 30.0, 0, 1)));
    if (faseP5 == 2) {
      intervalo = 2300;
    }
    if (millis() - ultimoComentarioP5 >= intervalo && faseP5 == 1) {
      crearComentarioP5(faseP5 == 2);
      ultimoComentarioP5 = millis();
    }

    // los comentarios vuelan hacia la cara con un bamboleo
    for (int i = 0; i < cantidadComentariosP5; i++) {
      if (comActivoP5[i]) {
        float dx = caraXP5 - comXP5[i];
        float dy = caraYP5 - comYP5[i];
        float distancia = max(1, dist(0, 0, dx, dy));
        float bamboleo = sin(millis() * 0.004 + comFaseP5[i]) * 40;
        comXP5[i] += (dx / distancia * comVelP5[i] - dy / distancia * bamboleo) * dtP5;
        comYP5[i] += (dy / distancia * comVelP5[i] + dx / distancia * bamboleo) * dtP5;
        if (comTipoP5[i] == 0) {
          aplausoP5 = min(1, aplausoP5 + 0.025 * dtP5);   // el publico se entusiasma mientras la voz A esta en el chat
        }
        if (distancia < 150) {
          comentarioLlegoP5(i);
        }
      }
    }

    // el filtro aparece a los 11 s y a los 25 s, da vueltas en forma de ocho durante 7 s y se va
    if (faseP5 == 1 && !filtroVisibleP5 && ((filtrosSalidosP5 == 0 && segundosJuegoP5() >= 11) || (filtrosSalidosP5 == 1 && segundosJuegoP5() >= 25))) {
      filtroVisibleP5 = true;
      filtrosSalidosP5++;
      inicioFiltroP5 = millis();
      sonidosCargadosSample[17].trigger();
      agregarChatP5("Apareció un filtro");
    }
    if (filtroVisibleP5) {
      float t = (millis() - inicioFiltroP5) / 1000.0;
      filtroXP5 = 960 + cos(t * 1.1) * 560;
      filtroYP5 = 560 + sin(t * 2.2) * 250;
      if (t > 7) {
        filtroVisibleP5 = false;
      }
    }

    // el jefe lanza una duda cada 1,7 s mientras baja
    if (faseP5 == 2 && faseJefeP5 == 1 && !jefeRotoP5 && jefeYP5 > 150 && millis() - ultimaCulpaP5 > 1700) {
      crearCulpaP5();
      ultimaCulpaP5 = millis();
    }

    // FASE 2 (la exigencia): cada tanto te pone la cuenta en PUBLICA; si no la cierras a tiempo, se filtra
    if (faseP5 == 2 && faseJefeP5 == 2 && !jefeRotoP5) {
      jefeYP5 = lerp(jefeYP5, 250 + sin(millis() * 0.003) * 12, 0.1);
      if (!cuentaAbiertaP5 && millis() >= proximoAtaqueP5) {
        cuentaAbiertaP5 = true;
        inicioAbiertaP5 = millis();
        gritoJefeP5 = gritosP5[int(random(5))];
        ultimoGolpeJefeP5 = millis() - 200;
        agregarRayoP5(960, jefeYP5 + 70, 960, 450);
        agregarRayoP5(900, jefeYP5 + 70, 880, 450);
        agregarRayoP5(1020, jefeYP5 + 70, 1040, 450);
        sonidosCargadosSample[20].trigger();
        animoCaraP5 = -0.5;
      }
      if (cuentaAbiertaP5 && millis() - inicioAbiertaP5 > tiempoParaCerrarP5) {
        cuentaAbiertaP5 = false;
        rachaP5 = 0;
        perderPalito();
        subirExposicion(5);
        inicioGolpeCaraP5 = millis();
        agregarGrietaP5(960, 520);
        mensajeP5("Tu cuenta quedó abierta. Todos vieron tu perfil.", -1);
        sombraReacciona(2);
        proximoAtaqueP5 = millis() + 1500;
      }
    }

    // FASE 1: el jefe baja y despues avanza despacio hacia ti; si te alcanza, te empuja y vuelve arriba
    if (faseP5 == 2 && faseJefeP5 == 1 && !jefeRotoP5) {
      float meta = 250 + 10 * (millis() - inicioJefeP5) / 1000.0;
      jefeYP5 = lerp(jefeYP5, meta, 0.06);
      if (jefeYP5 > 400) {
        jefeYP5 = 200;
        inicioJefeP5 = millis();
        perderPalito();
        inicioGolpeCaraP5 = millis();
        inicioTinteP5 = millis();
        agregarGrietaP5(960, 450);
        mensajeP5("Te gritó en la cara. Golpéala antes de que llegue.", -1);
      }
    }

    // las palabras giran y se acercan; si una de la trampa te toca, pierdes un palito y vuelve atras
    if (faseP5 == 2 && jefeRotoP5) {
      for (int p = 0; p < cantidadPalabrasP5; p++) {
        if (palVivaP5[p]) {
          palAnguloP5[p] += palGiroP5[p] * dtP5;
          palRadioP5[p] -= 16 * dtP5;
          palXP5[p] = caraXP5 + cos(palAnguloP5[p]) * palRadioP5[p] * 1.5;
          palYP5[p] = caraYP5 + sin(palAnguloP5[p]) * palRadioP5[p] * 0.8;
          if (palRadioP5[p] < 95) {
            if (esTrampaP5(p)) {
              palRadioP5[p] = 340;
              perderPalito();
              inicioGolpeCaraP5 = millis();
              animoCaraP5 = -1;
              agregarGrietaP5(palXP5[p], palYP5[p]);
              mensajeP5("Esa palabra te hace sentir culpable. Revientala.", -1);
              sombraReacciona(2);
            } else {
              palVivaP5[p] = false;
              agregarPopP5(palXP5[p], palYP5[p], color(200));
            }
          }
        }
      }
    }

    // el aplausometro lleno: te dejas llevar
    if (aplausoP5 >= 1) {
      aplausoP5 = 0.4;
      perderPalito();
      inicioOvacionP5 = millis();
      sonidosCargadosSample[45].trigger();
      mensajeP5("Te dejaste llevar por los aplausos.", -1);
      agregarImpacto("TE DEJASTE LLEVAR", 960, 400, 80, color(255, 210, 90));
      sombraReacciona(2);
    }
    if (palitos <= 0) {
      perderP5(2);
    }

    // el en vivo esta vivo: corazones que suben (mas con la racha) y gente que entra al chat
    int ritmoCorazones = max(120, 520 - rachaP5 * 50);
    if (millis() - ultimoCorazonP5 > ritmoCorazones) {
      ultimoCorazonP5 = millis();
      agregarCorazonP5(1150 + random(-15, 15), 930);
    }
    if (millis() - ultimoChatP5 > 1500) {
      ultimoChatP5 = millis() + int(random(0, 900));
      String quien = usuariosP5[int(random(8))];
      if (random(1) < 0.5) {
        agregarChatP5(quien + " se unió");
        espectadoresP5 += int(random(3, 12));
      } else {
        agregarChatP5(quien + " mandó un corazón");
        agregarCorazonP5(1150, 930);
      }
    }
    gotearExposicionPrueba();
  }
  aplausoMostradoP5 = lerp(aplausoMostradoP5, aplausoP5, 0.1);
  animoCaraP5 = lerp(animoCaraP5, 0, 0.02);

  // cursor de mano sobre lo que se puede reventar
  cursor(ARROW);
  if ((faseP5 == 1 || faseP5 == 2) && (comentarioBajoMouseP5() >= 0 || palabraBajoMouseP5() >= 0 || jefeBajoMouseP5() || filtroBajoMouseP5() || (candadoBajoMouseP5() && cuentaAbiertaP5))) {
    cursor(HAND);
  }

  // DIBUJO: la escena tiembla cuando algo te alcanza
  pushMatrix();
  int pasadoGolpe = millis() - inicioGolpeCaraP5;
  if (pasadoGolpe < 250) {
    translate(random(-7, 7) * e * (1 - pasadoGolpe / 250.0), random(-7, 7) * e * (1 - pasadoGolpe / 250.0));
  }
  int pasadoSacudida = millis() - inicioSacudidaP5;
  if (pasadoSacudida < 300) {
    translate(random(-12, 12) * e * (1 - pasadoSacudida / 300.0), random(-12, 12) * e * (1 - pasadoSacudida / 300.0));
  }

  background(28, 22, 5);
  noStroke();
  fill(242, 194, 48, 16 + 4 * sin(millis() * 0.002));
  triangle(960 * e, 90 * e, 300 * e, 1080 * e, 1620 * e, 1080 * e);
  dibujarTramaComic(color(242, 194, 48), 8);

  float tension = calcularTension();
  dibujarSombraYTelon(tension);

  dibujarPalcosP5(e);
  dibujarCelularP5(e);
  dibujarPrimeraFilaP5(e);
  dibujarJefeP5(e);
  for (int i = 0; i < cantidadComentariosP5; i++) {
    if (comActivoP5[i]) {
      dibujarComentarioP5(i, e);
    }
  }
  dibujarPalabrasP5(e);
  dibujarFiltroP5(e);
  dibujarRayosP5(e);
  dibujarPopsP5(e);
  dibujarPanelLateralP5(e);
  popMatrix();

  // tinte amarillo cuando la voz A te alcanza
  int pasadoTinte = millis() - inicioTinteP5;
  if (pasadoTinte < 1000) {
    noStroke();
    fill(242, 194, 48, 110 * (1 - pasadoTinte / 1000.0));
    rect(0, 0, width, height);
  }

  dibujarTension(tension);
  dibujarBarraSuperior(color(242, 194, 48));
  dibujarMarcador(puntosEnVivoP5());
  dibujarMonedas();
  dibujarFlotantes();
  dibujarImpacto();
  dibujarRachaCursor();
  dibujarCartelP5(e);
  dibujarMensajeP5(e);

  // cierre: un momento para ver el final y pasa a la pantalla de resultado
  if (faseP5 == 3 && millis() - inicioCierreP5 > 1800) {
    llenarResultadoP5(cierreGanoP5);
    empezarResultado(cierreGanoP5);
    if (cierreGanoP5) {
      pantalla = 29;
    } else {
      pantalla = 28;
    }
  }
}


// el celular: tu cuarto de noche en la pantalla, tu cara, los corazones, el chat y la barra de arriba
void dibujarCelularP5(float e) {
  noStroke();
  fill(0, 120);
  rect(714 * e, 196 * e, 520 * e, 800 * e);
  fill(8, 6, 2);
  rect(700 * e, 180 * e, 520 * e, 800 * e, 40 * e);

  dibujarCuartoP5(e);
  dibujarProtagonistaP5(e);

  // escudo del filtro alrededor de tu cara
  if (millis() < escudoHastaP5) {
    float queda = (escudoHastaP5 - millis()) / 5000.0;
    float late = 1 + sin(millis() * 0.012) * 0.04;
    fill(255, 210, 90, 30 + 30 * queda);
    ellipse(caraXP5 * e, caraYP5 * e, 360 * late * e, 380 * late * e);
    fill(255, 230, 150, 25 + 25 * queda);
    ellipse(caraXP5 * e, caraYP5 * e, 330 * late * e, 350 * late * e);
  }

  dibujarCorazonesP5(e);

  // el chat del en vivo, abajo a la izquierda: la linea nueva entra subiendo
  float subeChat = 28 * (1 - suaveTelon((millis() - inicioChatP5) / 250.0));
  textFont(fuenteTexto);
  textAlign(LEFT, CENTER);
  textSize(19 * e);
  for (int l = 0; l < cantidadChatP5; l++) {
    float lineaY = 838 + l * 28 + subeChat;
    float opacidad = 90 + l * 55;
    if (chatP5[l].length() > 0) {
      fill(0, opacidad * 0.55);
      rect(724 * e, (lineaY - 13) * e, (textWidth(chatP5[l]) / e + 18) * e, 26 * e);
    }
    fill(0, opacidad * 0.8);
    text(chatP5[l], 734 * e, (lineaY + 2) * e);
    fill(255, 245, 230, opacidad);
    text(chatP5[l], 732 * e, lineaY * e);
  }

  // barra de arriba: EN VIVO con punto que late, espectadores y la hora
  fill(0, 90);
  rect(714 * e, 196 * e, 492 * e, 66 * e);
  fill(200, 40, 40);
  rect(730 * e, 212 * e, 130 * e, 40 * e);
  fill(255, 150 + 105 * sin(millis() * 0.008));
  ellipse(750 * e, 232 * e, 12 * e, 12 * e);
  fill(255);
  textSize(23 * e);
  text("EN VIVO", 764 * e, 230 * e);
  fill(255, 225, 150);
  text(espectadoresTextoP5() + " viendo", 875 * e, 230 * e);
  textAlign(RIGHT, CENTER);
  fill(255, 200);
  text("23:52", 1190 * e, 230 * e);

  // grietas en el vidrio
  for (int g = 0; g < cantidadGrietasP5; g++) {
    int pasado = millis() - grietaInicioP5[g];
    if (pasado < 1800) {
      float opacidad = 230 * (1 - constrain((pasado - 1200) / 600.0, 0, 1));
      float abre = constrain(pasado / 120.0, 0, 1);
      stroke(255, opacidad);
      strokeWeight(2.5 * e);
      for (int rama = 0; rama < 7; rama++) {
        float angulo = rama * TWO_PI / 7 + g;
        float largo = (60 + (rama % 3) * 30) * abre;
        float x1 = grietaXP5[g] + cos(angulo) * largo;
        float y1 = grietaYP5[g] + sin(angulo) * largo;
        line(grietaXP5[g] * e, grietaYP5[g] * e, x1 * e, y1 * e);
        line(x1 * e, y1 * e, (x1 + cos(angulo + 0.6) * 25 * abre) * e, (y1 + sin(angulo + 0.6) * 25 * abre) * e);
      }
      noStroke();
      strokeWeight(1);
    }
  }

  // el marco del celular encima de todo (tapa lo que se sale de la pantalla)
  noFill();
  stroke(8, 6, 2);
  strokeWeight(16 * e);
  rect(706 * e, 186 * e, 508 * e, 788 * e, 36 * e);
  noStroke();
  fill(8, 6, 2);
  rect(905 * e, 182 * e, 110 * e, 20 * e);   // la camara de arriba
  fill(40, 40, 60);
  ellipse(990 * e, 192 * e, 9 * e, 9 * e);
  strokeWeight(1);
}


// tu cuarto (la imagen se preparo una vez en prueba5_arte)
void dibujarCuartoP5(float e) {
  image(cuartoArteP5, 714 * e, 194 * e);
}


// que cara pone el protagonista segun lo que esta pasando (de la mas urgente a la mas tranquila)
int elegirExpresionP5() {
  if (millis() - inicioGolpeCaraP5 < 600) {
    return 2;                                       // sorprendido: algo malo le acaba de llegar
  }
  if (millis() - inicioTinteP5 < 1500 || (faseP5 == 2 && !jefeRotoP5)) {
    return 1;                                       // enojado: la voz A se le metio o esta en persona
  }
  if (animoCaraP5 < -0.3) {
    return 3;                                       // triste: reviento una opinion valida o se filtro algo
  }
  if (animoCaraP5 > 0.3) {
    return 0;                                       // alegre: acierto
  }
  if (faseP5 == 2 && jefeRotoP5) {
    return 4;                                       // pensativo: busca las palabras de la trampa
  }
  if (aplausoMostradoP5 > 0.65 || palitos <= 2) {
    return 5;                                       // cansado: la presion lo agota
  }
  return -1;                                        // normal
}


// el protagonista: el dibujo del personaje sin fondo; cambia de cara segun lo que pasa y se anima con codigo:
// respira, se balancea, da un saltito al cambiar de cara, tiembla y se pone rojo con un golpe
void dibujarProtagonistaP5(float e) {
  int pasadoGolpe = millis() - inicioGolpeCaraP5;
  float golpe = max(0, 1 - pasadoGolpe / 500.0);

  int expresion = elegirExpresionP5();
  if (expresion != expresionP5) {
    expresionP5 = expresion;
    inicioExpresionP5 = millis();
  }
  float salto = 1 + 0.05 * max(0, 1 - (millis() - inicioExpresionP5) / 200.0);
  float respira = (1 + sin(millis() * 0.003) * 0.008) * salto;
  float balanceo = sin(millis() * 0.0013) * 0.015 + golpe * random(-0.03, 0.03);

  // la cara normal mide 620 x 631 (se dibuja de 590 de ancho); las expresiones miden 920 x 900 (al 78 %)
  PImage cara = imagenesCargadas[60];
  float ancho = 590;
  float alto = 600;
  float x = caraXP5 - 419;
  float y = caraYP5 - 238;
  if (expresionP5 >= 0) {
    cara = imagenesCargadas[61 + expresionP5];
    ancho = 920 * 0.78;
    alto = 900 * 0.78;
    x = caraXP5 - 460 * 0.78;
    y = caraYP5 - 320 * 0.78;
  }

  // lo que se sale de la pantalla del celular no se dibuja
  clip(714 * e, 194 * e, 492 * e, 772 * e);
  pushMatrix();
  translate((x + ancho / 2) * e, (y + alto) * e);       // gira y respira desde abajo (desde el pecho)
  rotate(balanceo);
  scale(respira);
  if (golpe > 0) {
    tint(255, 255 - 120 * golpe, 255 - 130 * golpe);    // se pone rojo con el golpe
  }
  image(cara, -ancho / 2 * e, -alto * e, ancho * e, alto * e);
  noTint();
  popMatrix();
  noClip();

  float cx = caraXP5;
  float cy = caraYP5;
  noStroke();

  // alegre: brillitos que salen alrededor de la cabeza
  if (expresionP5 == 0) {
    for (int b = 0; b < 4; b++) {
      float angulo = millis() * 0.002 + b * HALF_PI;
      float bx = cx + cos(angulo) * 170;
      float by = cy - 90 + sin(angulo) * 100;
      fill(255, 235, 150, 230);
      quad((bx - 12) * e, by * e, bx * e, (by - 12) * e, (bx + 12) * e, by * e, bx * e, (by + 12) * e);
    }
  }

  // cansado: lineas de historieta sobre la cabeza y una gota de sudor
  if (expresionP5 == 5) {
    stroke(tintaP5);
    strokeWeight(5 * e);
    for (int l = 0; l < 3; l++) {
      float lx = cx - 40 + l * 40;
      line(lx * e, (cy - 230) * e, (lx - 8) * e, (cy - 200) * e);
    }
    noStroke();
    float baja = (millis() % 1200) / 1200.0 * 40;
    fill(tintaP5);
    ellipse((cx + 130) * e, (cy - 40 + baja) * e, 24 * e, 28 * e);
    triangle((cx + 119) * e, (cy - 46 + baja) * e, (cx + 141) * e, (cy - 46 + baja) * e, (cx + 130) * e, (cy - 72 + baja) * e);
    fill(150, 210, 255);
    ellipse((cx + 130) * e, (cy - 40 + baja) * e, 17 * e, 21 * e);
    triangle((cx + 123) * e, (cy - 46 + baja) * e, (cx + 137) * e, (cy - 46 + baja) * e, (cx + 130) * e, (cy - 66 + baja) * e);
  }

  // enojado: venita de historieta en la frente
  if (expresionP5 == 1) {
    stroke(225, 50, 60);
    strokeWeight(6 * e);
    float vx = cx + 110;
    float vy = cy - 150;
    line((vx - 14) * e, (vy - 4) * e, (vx - 4) * e, (vy - 4) * e);
    line((vx - 4) * e, (vy - 14) * e, (vx - 4) * e, (vy - 4) * e);
    line((vx + 14) * e, (vy - 4) * e, (vx + 4) * e, (vy - 4) * e);
    line((vx + 4) * e, (vy - 14) * e, (vx + 4) * e, (vy - 4) * e);
    line((vx - 14) * e, (vy + 4) * e, (vx - 4) * e, (vy + 4) * e);
    line((vx - 4) * e, (vy + 14) * e, (vx - 4) * e, (vy + 4) * e);
    line((vx + 14) * e, (vy + 4) * e, (vx + 4) * e, (vy + 4) * e);
    line((vx + 4) * e, (vy + 14) * e, (vx + 4) * e, (vy + 4) * e);
    noStroke();
  }

  // golpe: estrellitas de dolor
  if (golpe > 0.1) {
    fill(255, 230, 120, 255 * golpe);
    for (int k = 0; k < 3; k++) {
      float angulo = millis() * 0.01 + k * TWO_PI / 3;
      float kx = cx + cos(angulo) * 120;
      float ky = cy - 170 + sin(angulo) * 30;
      quad((kx - 10) * e, ky * e, kx * e, (ky - 10) * e, (kx + 10) * e, ky * e, kx * e, (ky + 10) * e);
    }
  }
  strokeWeight(1);
}


// un corazon con contorno: dos circulos y un triangulo (centro en x, y; tam en medidas de 1920)
void dibujarCorazonFormaP5(float x, float y, float tam, color colorCorazon, float opacidad, float e) {
  noStroke();
  fill(20, 14, 30, opacidad);
  ellipse((x - tam * 0.5) * e, (y - tam * 0.25) * e, tam * 1.25 * e, tam * 1.25 * e);
  ellipse((x + tam * 0.5) * e, (y - tam * 0.25) * e, tam * 1.25 * e, tam * 1.25 * e);
  triangle((x - tam * 1.12) * e, y * e, (x + tam * 1.12) * e, y * e, x * e, (y + tam * 1.12) * e);
  fill(colorCorazon, opacidad);
  ellipse((x - tam * 0.5) * e, (y - tam * 0.25) * e, tam * e, tam * e);
  ellipse((x + tam * 0.5) * e, (y - tam * 0.25) * e, tam * e, tam * e);
  triangle((x - tam * 0.98) * e, y * e, (x + tam * 0.98) * e, y * e, x * e, (y + tam * 0.95) * e);
}


// los corazones suben bamboleandose, crecen y se desvanecen (2 s)
void dibujarCorazonesP5(float e) {
  for (int c = 0; c < cantidadCorazonesP5; c++) {
    int pasado = millis() - corInicioP5[c];
    if (pasado < 2000) {
      float avance = pasado / 2000.0;
      float x = corXP5[c] + sin(pasado * 0.006 + c) * 18;
      float y = corYP5[c] - 380 * avance;
      float tam = 10 + 10 * reboteTelon(pasado / 300.0);
      dibujarCorazonFormaP5(x, y, tam, corColorP5[c], 255 * (1 - avance * avance), e);
    }
  }
}


// los palcos de los lados: gente con el celular encendido detras de una baranda de terciopelo
void dibujarPalcosP5(float e) {
  for (int s = 0; s < 8; s++) {
    dibujarEspectadorP5(s, e);
  }
  image(palcoArteP5, 225 * e, 405 * e);
  image(palcoArteP5, 225 * e, 665 * e);
  image(palcoArteP5, 1415 * e, 405 * e);
  image(palcoArteP5, 1415 * e, 665 * e);
}


// la primera fila: delante del escenario, aplauden con el aplausometro y saltan en la ovacion
void dibujarPrimeraFilaP5(float e) {
  for (int s = 8; s < cantidadPublicoP5; s++) {
    dibujarEspectadorP5(s, e);
  }
}


// una persona del publico (silueta con borde de luz) con su celular en las manos
void dibujarEspectadorP5(int s, float e) {
  int pasadoOvacion = millis() - inicioOvacionP5;
  float ovacion = max(0, 1 - pasadoOvacion / 1200.0);
  float salto = ovacion * sq(sin(millis() * 0.02 + s)) * 30;
  float px = publicoXP5[s];
  float py = publicoYP5[s] + sin(millis() * 0.004 + s * 1.7) * 4 - salto;
  int pasadoPing = millis() - pingPublicoP5[s];
  float destello = max(0, 1 - pasadoPing / 500.0);

  image(siluetaArteP5[s % 5], (px - 90) * e, (py - 70) * e);

  // el celular en las manos: su brillo y la pantalla
  noStroke();
  fill(150, 200, 255, 20 + 60 * destello);
  ellipse(px * e, (py + 78) * e, (70 + 50 * destello) * e, (46 + 30 * destello) * e);
  // (imagenes de la prueba 7; al mandar un comentario la pantalla se pone blanca)
  image(imagenesCargadas[140], (px - 13) * e, (py + 58) * e, 26 * e, 40 * e);
  tint(255, 255 * destello);
  image(imagenesCargadas[141], (px - 13) * e, (py + 58) * e, 26 * e, 40 * e);
  noTint();

  // al escribir le sale un globito con puntos encima de la cabeza
  if (pasadoPing < 700) {
    float sube = reboteTelon(pasadoPing / 250.0);
    float opacidad = 255 * (1 - constrain((pasadoPing - 450) / 250.0, 0, 1));
    float gy = py - 52 - 20 * sube;
    fill(20, 14, 4, opacidad);
    rect((px - 24) * e, (gy - 15) * e, 48 * e, 30 * e);
    fill(255, opacidad);
    rect((px - 21) * e, (gy - 12) * e, 42 * e, 24 * e);
    triangle((px - 6) * e, (gy + 12) * e, (px + 6) * e, (gy + 12) * e, px * e, (gy + 20) * e);
    fill(30, 22, 6, opacidad);
    ellipse((px - 10) * e, gy * e, 6 * e, 6 * e);
    ellipse(px * e, gy * e, 6 * e, 6 * e);
    ellipse((px + 10) * e, gy * e, 6 * e, 6 * e);
  }

  // con aplausos altos u ovacion, levantan una mano que se agita
  if (aplausoMostradoP5 > 0.45 || ovacion > 0) {
    float agita = sin(millis() * 0.03 + s * 1.3) * 10;
    fill(16, 11, 8);
    ellipse((px - 52 + agita) * e, (py - 10 - 20 * ovacion) * e, 22 * e, 28 * e);
  }
}


// una burbuja de comentario: entra creciendo con rebote, tiene una colita hacia tu cara y se resalta con el mouse
void dibujarComentarioP5(int i, float e) {
  float x = comXP5[i];
  float y = comYP5[i];
  float ancho = comAnchoP5[i];
  float alto = comAltoP5[i];
  float crece = reboteTelon((millis() - comInicioP5[i]) / 300.0);
  boolean encima = comentarioBajoMouseP5() == i;
  if (encima) {
    crece *= 1.06;
  }

  // direccion hacia la cara (para la colita)
  float dx = caraXP5 - x;
  float dy = caraYP5 - y;
  float distancia = max(1, dist(0, 0, dx, dy));
  dx = dx / distancia;
  dy = dy / distancia;

  pushMatrix();
  translate(x * e, y * e);
  scale(crece);

  noStroke();
  fill(0, 110);
  rect((-ancho / 2 + 6) * e, (-alto / 2 + 7) * e, ancho * e, alto * e);
  // contorno negro grueso, estilo historieta
  fill(20, 14, 4);
  rect((-ancho / 2 - 4) * e, (-alto / 2 - 4) * e, (ancho + 8) * e, (alto + 8) * e);
  triangle(dx * (alto / 2 + 34) * e, dy * (alto / 2 + 34) * e, (-dy * 16) * e, (dx * 16) * e, (dy * 16) * e, (-dx * 16) * e);
  fill(255);
  if (comTipoP5[i] == 4) {
    fill(255, 225, 90);
  }
  if (encima) {
    fill(255, 248, 215);
  }
  rect(-ancho / 2 * e, -alto / 2 * e, ancho * e, alto * e);
  triangle(dx * (alto / 2 + 26) * e, dy * (alto / 2 + 26) * e, (-dy * 11) * e, (dx * 11) * e, (dy * 11) * e, (-dx * 11) * e);

  textFont(fuenteTexto);
  textAlign(LEFT, TOP);
  fill(160, 110, 20);
  textSize(18 * e);
  text(comUsuarioP5[i], (-ancho / 2 + 16) * e, (-alto / 2 + 7) * e);
  fill(30, 22, 6);
  textSize(22 * e);
  text(comTextoP5[i], (-ancho / 2 + 16) * e, (-alto / 2 + 28) * e, (ancho - 28) * e, (alto - 30) * e);

  // con el mouse encima: mira de punteria en las esquinas
  if (encima) {
    stroke(225, 60, 60);
    strokeWeight(4 * e);
    float bx = ancho / 2 + 10;
    float by = alto / 2 + 10;
    line(-bx * e, -by * e, (-bx + 22) * e, -by * e);
    line(-bx * e, -by * e, -bx * e, (-by + 22) * e);
    line(bx * e, -by * e, (bx - 22) * e, -by * e);
    line(bx * e, -by * e, bx * e, (-by + 22) * e);
    line(-bx * e, by * e, (-bx + 22) * e, by * e);
    line(-bx * e, by * e, -bx * e, (by - 22) * e);
    line(bx * e, by * e, (bx - 22) * e, by * e);
    line(bx * e, by * e, bx * e, (by - 22) * e);
    noStroke();
    strokeWeight(1);
  }
  popMatrix();
}


// el cartel del jefe: la pantalla se oscurece y entra una vineta de historieta con lo que hay que hacer
void dibujarCartelP5(float e) {
  if (millis() >= cartelHastaP5) {
    return;
  }
  int pasado = millis() - inicioCartelP5;
  float entra = reboteTelon(pasado / 450.0);
  float queda = constrain((cartelHastaP5 - millis()) / 250.0, 0, 1);

  noStroke();
  fill(0, 150 * queda);
  rect(0, 0, width, height);

  String titulo = "Fase 1: las dudas";
  String paso1 = "VerdadAbsoluta entró en persona. Para él, todo lo privado es sospechoso, y te lanza dudas.";
  String paso2 = "Revienta sus dudas y haz clic 3 veces en su burbuja para romper su escudo.";
  if (cartelP5 == 3) {
    titulo = "Fase 2: la exigencia";
    paso1 = "Ahora quiere obligarte a abrir tu cuenta. Cuando la cambie a PÚBLICA, haz clic en el candado para volver a PRIVADA.";
    paso2 = "Ciérrala a tiempo 3 veces. Si se queda abierta, pierdes un palito y sube tu exposición.";
  }
  if (cartelP5 == 2) {
    titulo = "Golpe final: su frase se rompió";
    paso1 = "Las palabras giran hacia ti. Revienta SOLO las que te hacen sentir culpable por querer privacidad.";
    paso2 = "Son 3. Si revientas otra, o si una de las 3 te toca, pierdes un palito.";
  }

  pushMatrix();
  translate(960 * e, (540 + (1 - entra) * 300) * e);
  rotate(-0.02);
  scale(queda);
  fill(0, 120);
  rect(-462 * e, -152 * e, 940 * e, 320 * e);
  fill(20, 14, 4);
  rect(-476 * e, -166 * e, 952 * e, 332 * e);
  fill(255, 225, 90);
  rect(-470 * e, -160 * e, 940 * e, 320 * e);

  textFont(fuenteTitulo);
  textAlign(CENTER, CENTER);
  fill(30, 22, 6);
  textSize(50 * e);
  text(titulo, 0, -105 * e);
  textFont(fuenteTexto);
  textSize(30 * e);
  text(paso1, -420 * e, -60 * e, 840 * e, 100 * e);
  fill(120, 40, 20);
  text(paso2, -420 * e, 40 * e, 840 * e, 80 * e);
  fill(30, 22, 6, 160 + 90 * sin(millis() * 0.008));
  textSize(24 * e);
  text("Haz clic para seguir", 0, 135 * e);
  popMatrix();
}


// el filtro dorado: un escudo con brillo que da vueltas; parpadea antes de irse
boolean filtroBajoMouseP5() {
  float e = width / 1920.0;
  return filtroVisibleP5 && dist(mouseX / e, mouseY / e, filtroXP5, filtroYP5) < 80;
}

void dibujarFiltroP5(float e) {
  if (!filtroVisibleP5) {
    return;
  }
  float t = (millis() - inicioFiltroP5) / 1000.0;
  if (t > 5.5 && millis() % 240 < 120) {
    return;
  }
  float x = filtroXP5;
  float y = filtroYP5;
  float late = 1 + sin(millis() * 0.012) * 0.08;
  if (filtroBajoMouseP5()) {
    late *= 1.15;
  }

  pushMatrix();
  translate(x * e, y * e);
  scale(late * reboteTelon(t / 0.4));
  noStroke();
  fill(255, 210, 90, 50);
  ellipse(0, 0, 190 * e, 190 * e);
  // destellos que giran
  fill(255, 240, 180);
  for (int d = 0; d < 4; d++) {
    float angulo = millis() * 0.003 + d * HALF_PI;
    float dx = cos(angulo) * 85;
    float dy = sin(angulo) * 85;
    quad((dx - 10) * e, dy * e, dx * e, (dy - 10) * e, (dx + 10) * e, dy * e, dx * e, (dy + 10) * e);
  }
  // escudo con contorno
  fill(20, 14, 4);
  ellipse(0, -14 * e, 132 * e, 104 * e);
  triangle(-66 * e, -14 * e, 66 * e, -14 * e, 0, 70 * e);
  fill(255, 200, 60);
  ellipse(0, -14 * e, 120 * e, 92 * e);
  triangle(-58 * e, -14 * e, 58 * e, -14 * e, 0, 60 * e);
  fill(255, 235, 150);
  ellipse(-18 * e, -32 * e, 40 * e, 18 * e);
  fill(30, 22, 6);
  textFont(fuenteTitulo);
  textAlign(CENTER, CENTER);
  textSize(26 * e);
  text("FILTRO", 0, -12 * e);
  popMatrix();
}


// rayos del filtro: lineas quebradas que tiemblan y se apagan (0,35 s)
void dibujarRayosP5(float e) {
  for (int r = 0; r < cantidadRayosP5; r++) {
    int pasado = millis() - rayoInicioP5[r];
    if (pasado < 350) {
      float opacidad = 255 * (1 - pasado / 350.0);
      stroke(255, 230, 120, opacidad);
      strokeWeight(5 * e);
      float x0 = rayoX1P5[r];
      float y0 = rayoY1P5[r];
      for (int tramo = 1; tramo <= 4; tramo++) {
        float x1 = lerp(rayoX1P5[r], rayoX2P5[r], tramo / 4.0);
        float y1 = lerp(rayoY1P5[r], rayoY2P5[r], tramo / 4.0);
        if (tramo < 4) {
          x1 += random(-25, 25);
          y1 += random(-25, 25);
        }
        line(x0 * e, y0 * e, x1 * e, y1 * e);
        x0 = x1;
        y0 = y1;
      }
      noStroke();
      strokeWeight(1);
    }
  }
}


// el jefe: una burbuja enorme amarilla con la frase, que tiembla y se agrieta con cada golpe
boolean jefeBajoMouseP5() {
  float e = width / 1920.0;
  return faseP5 == 2 && faseJefeP5 == 1 && !jefeRotoP5 && mouseX / e > 560 && mouseX / e < 1360 && mouseY / e > jefeYP5 - 70 && mouseY / e < jefeYP5 + 70;
}

void dibujarJefeP5(float e) {
  if (faseP5 != 2 || jefeRotoP5) {
    return;
  }
  int pasadoGolpe = millis() - ultimoGolpeJefeP5;
  float sacudida = 0;
  if (pasadoGolpe < 300) {
    sacudida = random(-12, 12) * (1 - pasadoGolpe / 300.0);
  }
  float respira = 1 + sin(millis() * 0.006) * 0.02;
  float habla = sq(sin(millis() * 0.01));     // la boca se abre y se cierra
  float jy = jefeYP5;

  boolean furioso = faseJefeP5 == 2;
  color colorBurbuja = color(255, 225, 90);
  if (furioso) {
    colorBurbuja = color(255, 140, 100);
  }

  // un foco que lo ilumina desde arriba (rojo cuando esta furioso)
  noStroke();
  fill(colorBurbuja, 26);
  triangle(960 * e, 90 * e, 500 * e, (jy + 80) * e, 1420 * e, (jy + 80) * e);

  pushMatrix();
  translate((960 + sacudida) * e, jy * e);
  scale(respira);

  // la burbuja gigante con la colita hacia tu cara
  fill(0, 120);
  rect(-392 * e, -62 * e, 800 * e, 140 * e);
  fill(20, 14, 4);
  rect(-406 * e, -76 * e, 812 * e, 152 * e);
  triangle(-40 * e, 70 * e, 40 * e, 70 * e, 0, 130 * e);
  fill(colorBurbuja);
  if (pasadoGolpe < 120) {
    fill(255);
  }
  rect(-400 * e, -70 * e, 800 * e, 140 * e);
  triangle(-30 * e, 68 * e, 30 * e, 68 * e, 0, 118 * e);

  // su nombre con la insignia de verificado (aunque de verdad no tiene nada)
  textFont(fuenteTexto);
  textAlign(LEFT, CENTER);
  fill(120, 70, 0);
  textSize(22 * e);
  text("VerdadAbsoluta", -230 * e, -46 * e);
  fill(80, 150, 255);
  ellipse(-40 * e, -46 * e, 22 * e, 22 * e);
  stroke(255);
  strokeWeight(3 * e);
  line(-46 * e, -46 * e, -41 * e, -41 * e);
  line(-41 * e, -41 * e, -33 * e, -52 * e);
  noStroke();

  fill(30, 22, 6);
  textFont(fuenteTitulo);
  textAlign(CENTER, CENTER);
  textSize(34 * e);
  if (furioso) {
    textSize(46 * e);
    text(gritoJefeP5, 75 * e + random(-2, 2) * e, 6 * e);
  } else {
    text(fraseVozAP5, 75 * e, 6 * e);
  }

  // grietas: una mas por cada golpe
  stroke(30, 22, 6);
  strokeWeight(4 * e);
  if (golpesJefeP5 >= 1) {
    line(-250 * e, -70 * e, -210 * e, -10 * e);
    line(-210 * e, -10 * e, -240 * e, 40 * e);
    line(-210 * e, -10 * e, -160 * e, 20 * e);
  }
  if (golpesJefeP5 >= 2) {
    line(180 * e, 70 * e, 140 * e, 10 * e);
    line(140 * e, 10 * e, 190 * e, -40 * e);
    line(140 * e, 10 * e, 80 * e, -20 * e);
    line(20 * e, -70 * e, 40 * e, -20 * e);
  }
  noStroke();

  // EL AVATAR: la mascara se rie; con 2 golpes (o justo al golpearla) se agrieta; furioso se enoja
  int caraJefe = 126;
  if (golpesJefeP5 >= 2 || pasadoGolpe < 300) {
    caraJefe = 128;
  }
  if (furioso) {
    caraJefe = 127;
  }
  pushMatrix();
  translate(-322 * e, 0);
  rotate(sin(millis() * 0.004) * 0.08);
  scale(0.85 + 0.04 * habla);   // late mientras habla
  noStroke();
  image(imagenesCargadas[caraJefe], -75 * e, -75 * e, 150 * e, 150 * e);
  popMatrix();

  // BARRA DE VIDA: 3 corazones rotos que se van tachando
  for (int v = 0; v < 3; v++) {
    float vx = 260 + v * 50;
    float vy = 100;
    fill(20, 14, 4);
    rect((vx - 20) * e, (vy - 16) * e, 40 * e, 32 * e);
    fill(225, 60, 70);
    if (v < golpesJefeP5) {
      fill(90, 70, 70);
    }
    rect((vx - 16) * e, (vy - 12) * e, 32 * e, 24 * e);
    if (v < golpesJefeP5) {
      stroke(255);
      strokeWeight(3 * e);
      line((vx - 10) * e, (vy - 8) * e, (vx + 10) * e, (vy + 8) * e);
      noStroke();
    }
  }
  popMatrix();
  strokeWeight(1);

  // aviso que late encima (solo en la fase 1)
  if (!furioso) {
    fill(255, 210, 90, 160 + 90 * sin(millis() * 0.01));
    textFont(fuenteTexto);
    textAlign(CENTER, CENTER);
    textSize(24 * e);
    text("Haz clic en la burbuja para romperla", 740 * e, (jy + 100) * e);
  }

  // FASE 2: el interruptor de privacidad de tu cuenta, con su candado
  if (furioso) {
    dibujarCandadoP5(e);
  }
}


// el interruptor de tu cuenta: verde y cerrado (PRIVADA) o rojo, abierto y temblando (PUBLICA) con el tiempo que queda
void dibujarCandadoP5(float e) {
  float abiertaHace = (millis() - inicioAbiertaP5) / (float) tiempoParaCerrarP5;
  float temblor = 0;
  if (cuentaAbiertaP5) {
    temblor = random(-4, 4);
  }
  float late = 1 + 0.06 * max(0, 1 - (millis() - inicioCerradaP5) / 250.0);
  if (candadoBajoMouseP5() && cuentaAbiertaP5) {
    late *= 1.06;
  }

  pushMatrix();
  translate((960 + temblor) * e, 450 * e);
  scale(late);
  noStroke();
  fill(0, 130);
  rect(-164 * e, -38 * e, 340 * e, 90 * e, 45 * e);
  fill(20, 14, 4);
  rect(-172 * e, -47 * e, 344 * e, 94 * e, 47 * e);
  color colorCuenta = color(90, 200, 120);
  String texto = "PRIVADA";
  if (cuentaAbiertaP5) {
    colorCuenta = color(230, 60, 60);
    if (millis() % 300 < 150) {
      colorCuenta = color(255, 110, 90);
    }
    texto = "PÚBLICA";
  }
  fill(colorCuenta);
  rect(-166 * e, -41 * e, 332 * e, 82 * e, 41 * e);

  // el candado (imagen de la prueba 8): abierto si la cuenta esta publica
  float cx = -110;
  noStroke();
  int imagenCandado = 149;
  if (cuentaAbiertaP5) {
    imagenCandado = 148;
  }
  image(imagenesCargadas[imagenCandado], (cx - 21.4) * e, -36.2 * e, 42.8 * e, 64.6 * e);

  fill(255);
  textFont(fuenteTitulo);
  textAlign(CENTER, CENTER);
  textSize(34 * e);
  text("Cuenta " + texto, 42 * e, -4 * e);

  // tiempo que queda para cerrarla
  if (cuentaAbiertaP5) {
    fill(20, 14, 4);
    rect(-140 * e, 56 * e, 280 * e, 14 * e);
    fill(255, 225, 90);
    rect(-140 * e, 56 * e, 280 * e * max(0, 1 - abiertaHace), 14 * e);
    fill(255, 225, 90, 180 + 75 * sin(millis() * 0.02));
    textFont(fuenteTexto);
    textSize(26 * e);
    text("Haz clic para cerrarla", 0, 96 * e);
  }
  popMatrix();
  strokeWeight(1);
}


// palabra bajo el mouse, o -1
int palabraBajoMouseP5() {
  if (faseP5 != 2 || !jefeRotoP5) {
    return -1;
  }
  float e = width / 1920.0;
  float mx = mouseX / e;
  float my = mouseY / e;
  for (int p = 0; p < cantidadPalabrasP5; p++) {
    if (palVivaP5[p] && mx > palXP5[p] - 85 && mx < palXP5[p] + 85 && my > palYP5[p] - 34 && my < palYP5[p] + 34) {
      return p;
    }
  }
  return -1;
}


// las palabras sueltas giran alrededor de tu cara y se acercan
void dibujarPalabrasP5(float e) {
  if (faseP5 != 2 || !jefeRotoP5) {
    return;
  }
  int encima = palabraBajoMouseP5();
  textFont(fuenteTexto);
  textSize(30 * e);
  for (int p = 0; p < cantidadPalabrasP5; p++) {
    if (palVivaP5[p]) {
      float temblor = 0;
      if (millis() - palErrorP5[p] < 300) {
        temblor = sin(millis() * 0.08) * 8;
      }
      float x = palXP5[p] + temblor;
      float y = palYP5[p];
      float escala = 1;
      if (encima == p) {
        escala = 1.12;
      }
      pushMatrix();
      translate(x * e, y * e);
      rotate(sin(millis() * 0.003 + p) * 0.12);
      scale(escala);
      fill(0, 110);
      rect(-74 * e, -22 * e, 156 * e, 56 * e);
      fill(20, 14, 4);
      rect(-82 * e, -30 * e, 164 * e, 60 * e);
      fill(255, 225, 90);
      if (millis() - palErrorP5[p] < 300) {
        fill(255, 150, 150);
      }
      rect(-78 * e, -26 * e, 156 * e, 52 * e);
      fill(30, 22, 6);
      textAlign(CENTER, CENTER);
      text(palabrasP5[p], 0, -3 * e);
      popMatrix();
    }
  }
}


// estallidos de historieta: estrella de puntas que crece con la onomatopeya encima (0,45 s)
void dibujarPopsP5(float e) {
  for (int k = 0; k < cantidadPopsP5; k++) {
    int pasado = millis() - popInicioP5[k];
    if (pasado < 450) {
      float avance = pasado / 450.0;
      float crece = reboteTelon(pasado / 200.0);
      float opacidad = 255 * (1 - avance * avance);
      float x = popXP5[k] * e;
      float y = popYP5[k] * e;
      noStroke();
      // estrella hecha con triangulos (rapido en P2D)
      fill(popColorP5[k], opacidad);
      for (int punta = 0; punta < 10; punta++) {
        float angulo = punta * TWO_PI / 10 + k;
        float largo = (60 + (punta % 2) * 30) * crece;
        triangle(x, y, x + cos(angulo - 0.22) * 30 * crece * e, y + sin(angulo - 0.22) * 30 * crece * e, x + cos(angulo) * largo * e, y + sin(angulo) * largo * e);
        triangle(x, y, x + cos(angulo + 0.22) * 30 * crece * e, y + sin(angulo + 0.22) * 30 * crece * e, x + cos(angulo) * largo * e, y + sin(angulo) * largo * e);
      }
      // gotitas que salen volando
      fill(255, opacidad);
      for (int gota = 0; gota < 8; gota++) {
        float anguloGota = gota * TWO_PI / 8 + k * 0.7;
        float lejos = (40 + 90 * avance) * e;
        ellipse(x + cos(anguloGota) * lejos, y + sin(anguloGota) * lejos, 8 * e * (1 - avance), 8 * e * (1 - avance));
      }
      // la onomatopeya
      pushMatrix();
      translate(x, y);
      rotate(-0.15);
      scale(0.6 + 0.5 * crece);
      textFont(fuenteTitulo);
      textAlign(CENTER, CENTER);
      textSize(44 * e);
      fill(0, opacidad);
      text(popTextoP5[k], 3 * e, 3 * e);
      fill(255, opacidad);
      text(popTextoP5[k], 0, 0);
      popMatrix();
    }
  }
}


// el contador de la voz A y, debajo, el aplausometro (horizontal, para no estorbar a los comentarios)
void dibujarPanelLateralP5(float e) {
  noStroke();
  fill(0, 160);
  rect(300 * e, 105 * e, 330 * e, 125 * e);
  textFont(fuenteTexto);
  fill(255, 225, 150);
  textAlign(LEFT, CENTER);
  textSize(22 * e);
  text("VerdadAbsoluta", 316 * e, 127 * e);
  for (int c = 0; c < 3; c++) {
    if (c < vecesAP5) {
      fill(242, 194, 48);
    } else {
      fill(80, 66, 30);
    }
    ellipse((335 + c * 46) * e, 160 * e, 30 * e, 30 * e);
  }

  // aplausometro: se llena de izquierda a derecha; cerca del tope parpadea y tiembla
  float temblor = 0;
  if (aplausoMostradoP5 > 0.8) {
    temblor = random(-2, 2);
  }
  fill(255, 225, 150);
  textSize(20 * e);
  text("Aplausos", 316 * e, 196 * e);
  fill(0, 180);
  rect((410 + temblor) * e, 186 * e, 205 * e, 22 * e);
  fill(lerpColor(color(242, 194, 48), color(220, 60, 40), aplausoMostradoP5));
  if (aplausoMostradoP5 > 0.8 && millis() % 300 < 150) {
    fill(255, 240, 160);
  }
  rect((410 + temblor) * e, 186 * e, 205 * e * aplausoMostradoP5, 22 * e);
  noFill();
  stroke(242, 194, 48);
  strokeWeight(3 * e);
  rect((410 + temblor) * e, 186 * e, 205 * e, 22 * e);
  noStroke();
  strokeWeight(1);
}


// clic en la pantalla 27
void clicP5() {
  if (faseP5 != 1 && faseP5 != 2) {
    return;
  }
  if (millis() < cartelHastaP5) {
    if (millis() - inicioCartelP5 > 600) {
      cartelHastaP5 = millis();
    }
    return;
  }

  // primero las palabras del jefe roto (estan encima)
  int p = palabraBajoMouseP5();
  if (p >= 0) {
    if (esTrampaP5(p)) {
      palVivaP5[p] = false;
      trampasP5++;
      rachaP5++;
      animoCaraP5 = 1;
      sonidosCargadosSample[43].trigger();
      agregarPopP5(palXP5[p], palYP5[p], color(255, 210, 90));
      agregarMoneda(palXP5[p], palYP5[p]);
      mostrarRachaCursor(rachaP5);
      sombraReacciona(1);
      if (trampasP5 >= 3) {
        ganarP5();
      }
    } else {
      palErrorP5[p] = millis();
      rachaP5 = 0;
      perderPalito();
      animoCaraP5 = -1;
      mensajeP5("Esa palabra no es la trampa. Busca la que te culpa.", -1);
      sombraReacciona(2);
    }
    return;
  }

  if (filtroBajoMouseP5()) {
    activarFiltroP5();
    return;
  }

  if (candadoBajoMouseP5()) {
    if (cuentaAbiertaP5) {
      cerrarCuentaP5();
    }
    return;
  }

  if (jefeBajoMouseP5()) {
    golpearJefeP5();
    return;
  }

  int i = comentarioBajoMouseP5();
  if (i >= 0) {
    reventarComentarioP5(i);
  }
}


// gana al romper la frase: voz A (6) + datos (4) + opiniones escuchadas (4, menos 2 por cada una reventada) + tiempo (6) = 20
void ganarP5() {
  if (faseP5 == 3) {
    return;
  }
  int puntosVoces = min(vecesAP5, 3) * 2;
  int puntosDatos = min(datosElimP5, 4);
  int puntosOpiniones = max(0, min(escuchadasP5, 4) - legitElimP5 * 2);
  int restanteMs = duracionPrueba - (millis() - inicioPrueba);
  int puntosTiempo = constrain(restanteMs / 3000, 0, 6);

  lineaTexto[0] = "Voz A reventada";
  lineaPuntos[0] = puntosVoces;
  lineaTexto[1] = "Datos protegidos";
  lineaPuntos[1] = puntosDatos;
  lineaTexto[2] = "Opiniones escuchadas";
  lineaPuntos[2] = puntosOpiniones;
  lineaTexto[3] = "Tiempo que sobró";
  lineaPuntos[3] = puntosTiempo;
  cantidadLineas = 4;

  puntosGanadosP5 = puntosVoces + puntosDatos + puntosOpiniones + puntosTiempo;
  puntosJugador += puntosGanadosP5;
  subirExposicion(-5);
  resultadoActo2[0] = 1;
  ganarLogro(4);
  revisarLogrosActos();
  if (pruebasCompletadasActo2 == 0) {
    pruebasCompletadasActo2 = 1;
  }
  empezarCierreP5(true);
}


// pierde: se filtra el dato; 1 punto por cada voz A reventada y hasta 2 por datos protegidos
void perderP5(int motivo) {
  if (faseP5 == 3) {
    return;
  }
  motivoDerrotaP5 = motivo;
  puntosGanadosP5 = min(vecesAP5, 3) + min(datosElimP5, 2);
  lineaTexto[0] = "Voz A reventada";
  lineaPuntos[0] = min(vecesAP5, 3);
  lineaTexto[1] = "Datos protegidos";
  lineaPuntos[1] = min(datosElimP5, 2);
  cantidadLineas = 2;
  puntosJugador += puntosGanadosP5;

  resultadoActo2[0] = 2;
  if (pruebasCompletadasActo2 == 0) {
    pruebasCompletadasActo2 = 1;
  }
  filtrarDato(4);
  empezarCierreP5(false);
}


// el tiempo se acabo (lo llama el contador)
void tiempoAgotadoP5() {
  perderP5(0);
}


// empieza el cierre: todo revienta y sale una palabra grande
void empezarCierreP5(boolean gano) {
  faseP5 = 3;
  cierreGanoP5 = gano;
  inicioCierreP5 = millis();
  filtroVisibleP5 = false;
  for (int i = 0; i < cantidadComentariosP5; i++) {
    if (comActivoP5[i]) {
      agregarPopP5(comXP5[i], comYP5[i], color(230));
      comActivoP5[i] = false;
    }
  }
  for (int p = 0; p < cantidadPalabrasP5; p++) {
    if (palVivaP5[p]) {
      agregarPopP5(palXP5[p], palYP5[p], color(230));
      palVivaP5[p] = false;
    }
  }
  if (gano) {
    agregarImpacto("SIN CULPA", 960, 380, 110, color(255, 210, 90));
    sonidosCargadosSample[45].trigger();
    inicioOvacionP5 = millis();
    animoCaraP5 = 1;
    for (int c = 0; c < 12; c++) {
      agregarCorazonP5(caraXP5 + random(-150, 150), caraYP5 + random(0, 250));
    }
  } else {
    agregarImpacto("TE DEJASTE LLEVAR", 960, 380, 80, color(255, 110, 110));
    sombraReacciona(2);
    animoCaraP5 = -1;
  }
}


// textos de la pantalla de resultado
void llenarResultadoP5(boolean gano) {
  tituloResultado = "Se acabó el tiempo";
  if (motivoDerrotaP5 == 2) {
    tituloResultado = "Te quedaste sin palitos";
  }
  subtituloResultado = "La voz que te presiona se quedó en tu transmisión.";
  selloIlustracion = "CULPABLE";
  if (gano) {
    tituloResultado = "Prueba superada";
    subtituloResultado = "Tener privacidad no te hace culpable.";
    selloIlustracion = "SIN CULPA";
  }
  explicacionIlustracion = "Escuchar una opinión no es obedecerla.\nY nadie tiene derecho a tus datos.";
  fraseVidaReal = "Querer privacidad no significa que escondas algo malo. Nadie tiene derecho a exigirte tus contraseñas, tu ubicación ni tu perfil abierto.";
  consejoVidaReal = "En un en vivo puedes filtrar palabras, borrar comentarios y bloquear usuarios. Úsalo sin culpa.";
  datoResultado = 4;
  ilustracionResultado = 5;
  puntosResultado = puntosGanadosP5;
}


// la ilustracion del resultado: un celular con el comentario de la voz A tachado (se dibuja alrededor de 0, 0)
void dibujarIlustracionResultadoP5() {
  float e = width / 1920.0;
  noStroke();
  fill(0, 110);
  rect(-125 * e, -175 * e, 260 * e, 380 * e);
  fill(8, 6, 2);
  rect(-130 * e, -190 * e, 260 * e, 380 * e, 24 * e);
  fill(58, 48, 112);
  rect(-118 * e, -176 * e, 236 * e, 352 * e, 16 * e);

  fill(200, 40, 40);
  rect(-104 * e, -164 * e, 70 * e, 24 * e);
  fill(255);
  textFont(fuenteTexto);
  textAlign(CENTER, CENTER);
  textSize(15 * e);
  text("EN VIVO", -69 * e, -152 * e);

  fill(20, 14, 4);
  rect(-108 * e, -64 * e, 216 * e, 108 * e);
  fill(255, 225, 90);
  rect(-104 * e, -60 * e, 208 * e, 100 * e);
  fill(120, 70, 0);
  textAlign(LEFT, TOP);
  textSize(14 * e);
  text("VerdadAbsoluta", -92 * e, -54 * e);
  fill(30, 22, 6);
  textSize(16 * e);
  text(fraseVozAP5, -92 * e, -34 * e, 184 * e, 70 * e);

  // una equis roja encima: reventado
  stroke(200, 40, 40);
  strokeWeight(10 * e);
  line(-104 * e, -60 * e, 104 * e, 40 * e);
  line(104 * e, -60 * e, -104 * e, 40 * e);
  noStroke();
  strokeWeight(1);
}


// 28 - ACTO II - PRUEBA 1 - PRUEBA PERDIDA
void dibujarPerdidaP5() {
  dibujarResultado(false);
}


// 29 - ACTO II - PRUEBA 1 - PRUEBA SUPERADA
void dibujarSuperadaP5() {
  dibujarResultado(true);
}
