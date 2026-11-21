// PRUEBA 2 - SEIS MOMENTOS: "HISTORIAS DE LA NOCHE" (pantallas 14, 16 y 17)
// cae una historia a la vez; hay que colgarlas en la barra en orden y reportar la falsa

// DATOS DE LAS SEIS HISTORIAS (indice 0 a 4 = las verdaderas en orden, 5 = la falsa)
// cada historia es una foto de la habitacion (imagenes 45 a 50 = acto1prueba2_fotoA a F)
// orden real: cama, de pie, espejo, SALIENDO (foto E, 23:48) y despues la habitacion VACIA (foto D, 23:49), y la falsa
// (en el PDF la vacia iba antes que saliendo; se invirtio porque asi se entiende mejor: primero sale y luego queda vacia)
int[] fotoP2 = {45, 46, 47, 49, 48, 50};
String[] horaTomadaP2 = {"23:41", "23:44", "23:46", "23:48", "23:49", "23:45"};
String[] horaPublicadaP2 = {"23:42", "23:44", "23:46", "23:48", "23:50", "23:43"};
int cantidadTarjetasP2 = 6;

// ESTADO DE LA PRUEBA
int[] barraP2 = {-1, -1, -1, -1, -1};  // historia colgada en cada hueco (-1 = vacio)
int[] colaP2 = new int[20];            // historias por caer, en orden
int colaIniP2 = 0;                     // siguiente de la cola
int colaFinP2 = 0;                     // primer lugar libre de la cola
int tarjetaP2 = -1;                    // historia que esta cayendo (-1 = ninguna)
int columnaP2 = 2;                     // 0 a 4 = huecos de la barra, 5 = cesto
float xCaidaP2 = 870;                  // x del centro de la historia que cae (medidas de 1920)
int inicioCaidaP2 = 0;                 // millis() en que empezo a caer
int colocadasP2 = 0;                   // historias ya soltadas (cada una acelera la caida un 15 %)
int seleccionadaP2 = -1;               // hueco seleccionado para intercambiar (-1 = ninguno)
float inclinacionP2 = 0;               // desbalance de la cuerda: diferencia de altura entre sus puntas (positivo = baja la derecha)
float velInclinacionP2 = 0;            // velocidad con que se mece la cuerda
float entradaCuerdaP2 = 0;             // al entrar la cuerda baja desde arriba: cuanto le falta para llegar (negativo)
float hundimientoP2 = 30;             // cuanto se curva la cuerda en el centro (mas historias = mas peso)
float[] balanceoP2 = new float[5];     // angulo extra de cada historia colgada (se mece)
float[] velBalanceoP2 = new float[5];  // velocidad de ese balanceo
int falsaCaeP2 = -10000;               // millis() en que la falsa se solto de la cuerda
float falsaXP2 = 0;                    // de donde se solto (medidas de 1920)
float falsaYP2 = 0;
int miradaP2 = -1;                     // historia colgada que se esta mirando con la lupa (-1 = ninguna)
float zoomMiradaP2 = 0;                // 0 = tamano normal, 1 = agrandada del todo
boolean lupaAbiertaP2 = false;         // true mientras la lupa esta abierta (clic izquierdo)
float lupaXP2 = 0;                     // donde quedo dibujada la foto agrandada (pixeles de pantalla)
float lupaYP2 = 0;
float lupaAnchoP2 = 0;
float lupaAltoP2 = 0;
float[] alzadoP2 = new float[5];       // 0 = colgada, 1 = despegada de la cuerda (la seleccionada)
boolean pistaIntercambioP2 = false;    // true cuando ya se mostro la pista de intercambiar
boolean sonoCuerdaP2 = false;          // sonidos de la entrada que suenan una sola vez

// PUNTOS EN VIVO: cada historia en su lugar vale 2; se celebran con textos que flotan
boolean[] bienColocadaP2 = new boolean[5];   // como estaba cada posicion en el cuadro anterior
int rachaP2 = 0;                             // historias seguidas colgadas bien a la primera
int intercambiosP2 = 0;                      // intercambios hechos (para el bono "sin intercambios")
int inicioVueloRelojP2 = -10000;             // "-3 s" que vuela hacia el reloj al intercambiar
float vueloXP2 = 0;
float vueloYP2 = 0;

int intercambioAP2 = -1;              // las dos posiciones que se estan intercambiando
int intercambioBP2 = -1;
int inicioIntercambioP2 = -10000;      // millis() del intercambio
float anilloXP2 = 0;                   // aro que se abre al engancharse una historia (medidas de 1920)
float anilloYP2 = 0;
int inicioAnilloP2 = -10000;
color colorAnilloP2 = color(255, 200, 0);   // amarillo al colgar, rojo en un error
boolean falsaDescartadaP2 = false;     // true cuando la falsa ya fue reportada

// GUIA DE LA PRUEBA 2: que se senala en cada paso y que se dice
String[] titulosGuiaP2 = {
  "Tu cordura",
  "El tiempo",
  "Exposición",
  "Tus puntos",
  "Tus historias",
  "La cuerda",
  "Reportar",
  "Ver e intercambiar",
  "La sombra",
  "A jugar"
};
String[] textosGuiaP2 = {
  "Estos palitos de zanahoria son tu cordura. Cada error se come uno. Si se acaban, pierdes la prueba.",
  "Lo que te queda para terminar. En los últimos 10 segundos la barra se pone roja.",
  "Cuánto de tu vida pueden ver los desconocidos. Sube sola mientras la sombra mira tus historias, y más con cada error. Baja cuando aciertas o reportas la falsa.",
  "Cada historia que queda en su lugar suma 2 puntos. Al final hay bonos por el tiempo que sobre, por no equivocarte y por no intercambiar.",
  "Aquí cae cada historia de anoche. Muévela con las flechas izquierda y derecha, y suéltala con la flecha de abajo en la pinza que quieras.",
  "Cuélgalas en el orden en que pasaron, de antes a después, como dicen los letreros de los postes. Si una queda en un lugar que no es suyo, la cuerda se desbalancea.",
  "Una de las historias no la subiste tú. Mándala a este cesto, o pulsa R mientras cae.",
  "Clic izquierdo en una historia colgada para verla de cerca. Clic derecho en dos historias para intercambiarlas, pero cuesta 3 segundos.",
  "Está mirando todo lo que publicas. Cada error le cuenta algo más de ti.",
  "Aquí pierdes un palito si cuelgas la historia falsa o mandas una verdadera al cesto. Fíjate en la hora, la mochila y la puerta de cada foto. Pulsa ENTER para empezar."
};
float[][] zonasGuiaP2 = {
  {20, 8, 330, 80},        // plato de zanahorias
  {690, 22, 540, 100},     // contador
  {1385, 8, 490, 78},      // exposicion
  {1580, 98, 310, 80},     // marcador de puntos
  {700, 115, 520, 345},    // donde cae la historia
  {200, 540, 1380, 420},   // la cuerda con sus letreros
  {1530, 730, 190, 290},   // el cesto
  {270, 540, 1240, 420},   // la cuerda otra vez (clics)
  {1560, 290, 340, 520},   // la sombra
  {960, 540, 0, 0}         // sin zona: recuadro en el centro
};
int cantidadPasosGuiaP2 = 10;

int motivoDerrotaP2 = 0;              // 0 = tiempo, 1 = (sin usar), 2 = sin palitos (tambien en: contador)
int puntosGanadosP2 = 0;               // puntos de la prueba para las pantallas de resultado


// prepara la prueba (se llama al terminar el contexto)
void iniciarP2() {
  duracionPrueba = 60000;
  inicioPrueba = millis();
  palitos = 5;

  for (int s = 0; s < 5; s++) {
    barraP2[s] = -1;
  }

  // orden de caida al azar, pero la falsa (5) nunca cae primera ni ultima
  do {
    for (int i = 0; i < 6; i++) {
      colaP2[i] = i;
    }
    for (int k = 0; k < 20; k++) {
      int a = int(random(6));
      int b = int(random(6));
      int cambio = colaP2[a];
      colaP2[a] = colaP2[b];
      colaP2[b] = cambio;
    }
  } while (colaP2[0] == 5 || colaP2[5] == 5);

  colaIniP2 = 0;
  colaFinP2 = 6;
  tarjetaP2 = -1;
  columnaP2 = 2;
  xCaidaP2 = 870;
  colocadasP2 = 0;
  seleccionadaP2 = -1;
  falsaDescartadaP2 = false;
  inclinacionP2 = 0;
  velInclinacionP2 = 0;
  hundimientoP2 = 30;
  for (int s = 0; s < 5; s++) {
    balanceoP2[s] = 0;
    velBalanceoP2[s] = 0;
  }
  falsaCaeP2 = -10000;
  for (int s = 0; s < 5; s++) {
    alzadoP2[s] = 0;
  }
  miradaP2 = -1;
  zoomMiradaP2 = 0;
  lupaAbiertaP2 = false;
  pistaIntercambioP2 = false;
  sonoCuerdaP2 = false;
  rachaP2 = 0;
  intercambiosP2 = 0;
  inicioVueloRelojP2 = -10000;
  for (int s = 0; s < 5; s++) {
    bienColocadaP2[s] = false;
  }

  // musica con fundido, sombra, latidos, flotantes y monedas en cero
  empezarAmbientePrueba();

  // antes de jugar se abre el telon y despues la guia explica cada parte de la pantalla
  empezarTelon();
  empezarGuia(titulosGuiaP2, textosGuiaP2, zonasGuiaP2, cantidadPasosGuiaP2);
  mensajePrueba = "";
}


// dibuja una historia como polaroid (220 x 143 multiplicado por "esc"): la foto de la habitacion y las horas escritas a mano
// no lleva numero: la foto la identifica (un numero se confundia con la posicion en la cuerda)
void dibujarTarjetaP2(int i, float x, float y, float esc) {
  // sombra y papel
  noStroke();
  fill(0, 90);
  rect(x + 5 * esc, y + 6 * esc, 220 * esc, 143 * esc, 4 * esc);
  fill(245, 240, 228);
  rect(x, y, 220 * esc, 143 * esc, 4 * esc);

  // la foto recortada: de (175, 175) a (1085, 580) de la imagen de 1280 x 720
  // asi no se ven la letra ni el reloj que estan dibujados arriba a la izquierda
  image(imagenesCargadas[fotoP2[i]], x + 10 * esc, y + 10 * esc, 200 * esc, 89 * esc, 175, 175, 1085, 580);

  // horas escritas a mano en el borde blanco (letra de tamano fijo agrandada con scale: cambiar textSize en cada cuadro es lento)
  fill(45);
  textFont(fuente);
  textAlign(LEFT, CENTER);
  textSize(32);
  pushMatrix();
  translate(x + 12 * esc, y + 112 * esc);
  scale(esc * 14 / 32.0);
  text("Tomada " + horaTomadaP2[i], 0, 0);
  text("Publicada " + horaPublicadaP2[i], 0, 18 / (14 / 32.0));
  popMatrix();
}


// 14 - ACTO I - PRUEBA 2 - HISTORIAS DE LA NOCHE
void dibujarHistoriasP2() {
  float e = width / 1920.0;
  // fondo del escenario
  image(imagenesCargadas[67], 0, 0, width, height);

  // foco de luz sobre la zona de juego
  noStroke();
  fill(255, 230, 235, 18);
  triangle(960 * e, 90 * e, 360 * e, 1080 * e, 1560 * e, 1080 * e);

  // ENTRADA (cuenta desde que empezo a abrirse el telon): a 1,6 s baja la cuerda y a 2,05 s llega y se sacude
  int pasadoEntrada = millis() - inicioTelon;
  entradaCuerdaP2 = -650 * (1 - reboteTelon((pasadoEntrada - 1600) / 800.0));
  if (!sonoCuerdaP2 && pasadoEntrada >= 2050) {
    sonidosCargadosSample[12].trigger();   // la cuerda llega y se sacude
    sonoCuerdaP2 = true;
  }

  // la sombra se asoma desde detras del telon derecho (reacciona a aciertos, errores y a los ultimos 10 s)
  float tension = calcularTension();
  dibujarSombraYTelon(tension);

  // CUERDA CON PINZAS: cada historia mal colgada la desbalancea hacia su lado
  float pesoMalColgado = 0;   // negativo = pesa a la izquierda, positivo = a la derecha
  int colgadas = 0;
  for (int s = 0; s < 5; s++) {
    if (barraP2[s] != -1) {
      colgadas++;
      if (barraP2[s] != s) {
        if (s == 2) {
          pesoMalColgado += 0.7;     // la del centro tambien desbalancea un poco
        } else {
          pesoMalColgado += s - 2;   // -2, -1, +1, +2: mas lejos del centro, mas palanca
        }
      }
    }
  }
  float inclinacionMeta = constrain(pesoMalColgado * 30, -120, 120);

  // resorte: la cuerda se pasa un poco, vuelve y se queda en su inclinacion
  velInclinacionP2 += (inclinacionMeta - inclinacionP2) * 0.02;
  velInclinacionP2 *= 0.93;
  inclinacionP2 += velInclinacionP2;

  // con mas historias colgadas la cuerda se hunde un poco mas (suave)
  hundimientoP2 = lerp(hundimientoP2, 30 + colgadas * 8, 0.08);

  // postes de madera en las puntas
  float puntaIzqY = cuerdaYP2(300);
  float puntaDerY = cuerdaYP2(1480);
  noStroke();
  image(imagenesCargadas[73], 284 * e, (puntaIzqY - 16) * e, 32 * e, (1000 - puntaIzqY + 16) * e);
  image(imagenesCargadas[73], 1464 * e, (puntaDerY - 16) * e, 32 * e, (1000 - puntaDerY + 16) * e);

  // la cuerda: una curva hecha con 40 tramos
  noFill();
  stroke(225, 210, 180);
  strokeWeight(4 * e);
  beginShape();
  for (int tramo = 0; tramo <= 40; tramo++) {
    float cuerdaX = 300 + tramo * 29.5;
    vertex(cuerdaX * e, cuerdaYP2(cuerdaX) * e);
  }
  endShape();

  // LETREROS DE MADERA clavados en los postes: la cuerda va de "antes" (izquierda) a "despues" (derecha)
  // bajan con su poste cuando la cuerda se desbalancea y se mecen un poquito
  for (int letrero = 0; letrero < 2; letrero++) {
    float letreroX = 300;
    String palabra = "antes";
    if (letrero == 1) {
      letreroX = 1480;
      palabra = "después";
    }
    float letreroY = cuerdaYP2(letreroX) + 205;

    pushMatrix();
    translate(letreroX * e, letreroY * e);
    rotate(sin(millis() * 0.0015 + letrero * 2) * 0.03);

    // la tabla (imagen del letrero vacio)
    noStroke();
    image(imagenesCargadas[72], -80 * e, -46 * e, 160 * e, 92 * e);

    // la palabra pintada
    fill(45, 22, 12);
    textFont(fuenteTexto);
    textAlign(CENTER, CENTER);
    textSize(28 * e);
    text(palabra, 0, -2 * e);
    popMatrix();
  }
  strokeWeight(1);

  // cada pinza con su historia colgando
  for (int s = 0; s < 5; s++) {

    float pinzaX = 390 + s * 240;
    float pinzaY = cuerdaYP2(pinzaX);

    // pendiente de la cuerda en la pinza: la historia la sigue a medias (la gravedad la endereza)
    float pendiente = atan2(cuerdaYP2(pinzaX + 5) - cuerdaYP2(pinzaX - 5), 10);

    // balanceo propio: vuelve a 0 como un pendulo y lo empujan los cambios de la cuerda
    velBalanceoP2[s] += -balanceoP2[s] * 0.03 - velInclinacionP2 * 0.0015;
    velBalanceoP2[s] *= 0.95;
    balanceoP2[s] += velBalanceoP2[s];

    // con una historia seleccionada, las demas colgadas muestran flechas de intercambio que suben y bajan
    if (seleccionadaP2 >= 0 && seleccionadaP2 != s && barraP2[s] != -1) {
      float flechaY = (pinzaY - 88 + sin(millis() * 0.008) * 6) * e;
      float flechaX = pinzaX * e;
      stroke(255, 200, 0);
      strokeWeight(4 * e);
      line(flechaX - 22 * e, flechaY - 7 * e, flechaX + 22 * e, flechaY - 7 * e);   // flecha de arriba, hacia la derecha
      line(flechaX + 22 * e, flechaY - 7 * e, flechaX + 12 * e, flechaY - 15 * e);
      line(flechaX - 22 * e, flechaY + 7 * e, flechaX + 22 * e, flechaY + 7 * e);   // flecha de abajo, hacia la izquierda
      line(flechaX - 22 * e, flechaY + 7 * e, flechaX - 12 * e, flechaY + 15 * e);
      noStroke();
    }

    // la seleccionada se despega 40 px de la cuerda (suave)
    float alzadoMeta = 0;
    if (seleccionadaP2 == s) {
      alzadoMeta = 1;
    }
    alzadoP2[s] = lerp(alzadoP2[s], alzadoMeta, 0.2);

    pushMatrix();
    translate(pinzaX * e, pinzaY * e);
    // la seleccionada ademas tiembla un poco, como pidiendo pareja
    rotate(pendiente * 0.5 + balanceoP2[s] + sin(millis() * 0.03) * 0.03 * alzadoP2[s]);

    // mientras dos historias se intercambian van por el aire: su pinza se ve vacia
    boolean enVuelo = millis() - inicioIntercambioP2 < 500 && (s == intercambioAP2 || s == intercambioBP2);
    float alzado = 40 * alzadoP2[s];

    if (barraP2[s] == -1 || enVuelo) {
      noFill();
      stroke(255, 40);
      strokeWeight(2);
      rect(-110 * e, 8 * e, 220 * e, 143 * e, 4 * e);
    } else {

      // brillo amarillo que late detras de la seleccionada
      if (seleccionadaP2 == s) {
        noStroke();
        fill(255, 200, 0, 70 + 50 * sin(millis() * 0.01));
        rect(-122 * e, (-4 - alzado) * e, 244 * e, 167 * e, 10 * e);
      }

      dibujarTarjetaP2(barraP2[s], -110 * e, (8 - alzado) * e, e);

      // historia seleccionada para intercambiar
      if (seleccionadaP2 == s) {
        noFill();
        stroke(255, 200, 0);
        strokeWeight(5);
        rect(-114 * e, (4 - alzado) * e, 228 * e, 151 * e, 6 * e);
      }
    }

    // la pinza de madera
    noStroke();
    image(imagenesCargadas[74], -9 * e, -22 * e, 18 * e, 62 * e);
    popMatrix();
  }
  strokeWeight(1);

  // INTERCAMBIO (0,5 s): cada historia viaja a la pinza de la otra haciendo un arco, girando y creciendo un poco
  int pasadoIntercambio = millis() - inicioIntercambioP2;
  if (pasadoIntercambio < 500) {

    float avanceIntercambio = pasadoIntercambio / 500.0;
    avanceIntercambio = avanceIntercambio * avanceIntercambio * (3 - 2 * avanceIntercambio);
    float arco = sin(PI * avanceIntercambio);   // 0 al salir, 1 a la mitad, 0 al llegar

    for (int k = 0; k < 2; k++) {

      // k = 0 va de A a B por arriba; k = 1 va de B a A por un arco mas bajo (asi no se tapan del todo)
      int desde = intercambioAP2;
      int hasta = intercambioBP2;
      float altoArco = 170;
      if (k == 1) {
        desde = intercambioBP2;
        hasta = intercambioAP2;
        altoArco = 50;
      }

      float desdeX = 390 + desde * 240;
      float hastaX = 390 + hasta * 240;
      float vueloX = lerp(desdeX, hastaX, avanceIntercambio);
      float vueloY = lerp(cuerdaYP2(desdeX), cuerdaYP2(hastaX), avanceIntercambio) - altoArco * arco;

      float sentido = 1;
      if (hastaX < desdeX) {
        sentido = -1;
      }
      float escalaVuelo = 1 + 0.15 * arco;

      pushMatrix();
      translate(vueloX * e, vueloY * e);
      rotate(arco * 0.35 * sentido);
      dibujarTarjetaP2(barraP2[hasta], -110 * escalaVuelo * e, 8 * e, escalaVuelo * e);
      popMatrix();
    }
  }

  // aro que se abre donde se engancho o cayo una historia (0,45 s)
  int pasadoAnillo = millis() - inicioAnilloP2;
  if (pasadoAnillo < 450) {
    float avanceAnillo = pasadoAnillo / 450.0;
    noFill();
    stroke(colorAnilloP2, 255 * (1 - avanceAnillo));
    strokeWeight(6 * e * (1 - avanceAnillo) + 1);
    ellipse(anilloXP2 * e, anilloYP2 * e, lerp(30, 180, avanceAnillo) * e, lerp(30, 180, avanceAnillo) * e);
    strokeWeight(1);
  }

  // la falsa se suelta de la cuerda y cae girando (0,9 s)
  int pasadoFalsa = millis() - falsaCaeP2;
  if (pasadoFalsa < 900) {
    float tiempoFalsa = pasadoFalsa / 1000.0;
    pushMatrix();
    translate(falsaXP2 * e, (falsaYP2 + 1400 * tiempoFalsa * tiempoFalsa) * e);
    rotate(tiempoFalsa * 2.5);
    dibujarTarjetaP2(5, -110 * e, 8 * e, e);
    popMatrix();
  }

  // cesto "Reportar historia falsa" (la imagen ya trae la bandera): parado en el piso, con su sombra debajo
  noStroke();
  fill(0, 110);
  ellipse(1622 * e, 962 * e, 150 * e, 24 * e);
  image(imagenesCargadas[71], 1545 * e, 751 * e, 155 * e, 214 * e);
  fill(255);
  textFont(fuenteTexto);
  textAlign(CENTER, CENTER);
  textSize(20 * e);
  text("Reportar historia falsa", 1622 * e, 995 * e);

  // LUPA: clic izquierdo en una historia colgada la agranda; otro clic izquierdo la cierra
  if (lupaAbiertaP2) {
    zoomMiradaP2 = lerp(zoomMiradaP2, 1, 0.2);
  } else {
    zoomMiradaP2 = lerp(zoomMiradaP2, 0, 0.25);
    if (zoomMiradaP2 < 0.02) {
      miradaP2 = -1;
    }
  }

  // fondo que se oscurece mientras la lupa esta abierta (la historia que cae queda por encima)
  if (miradaP2 >= 0) {
    noStroke();
    fill(0, 140 * zoomMiradaP2);
    rect(0, 90 * e, width, height);
  }

  if (miradaP2 >= 0 && barraP2[miradaP2] != -1) {
    float escalaMirada = lerp(1, 2.2, zoomMiradaP2);
    // centrada en su pinza, sin salirse de la pantalla; sube un poco al crecer
    float centroMirada = constrain(390 + miradaP2 * 240, 110 * escalaMirada + 20, 1900 - 110 * escalaMirada);
    float arribaMirada = cuerdaYP2(390 + miradaP2 * 240) + 8 - 60 * zoomMiradaP2;
    float miradaX = (centroMirada - 110 * escalaMirada) * e;
    float miradaY = arribaMirada * e;
    dibujarTarjetaP2(barraP2[miradaP2], miradaX, miradaY, escalaMirada * e);

    // se guarda donde quedo, para que los clics sobre la foto agrandada cuenten
    lupaXP2 = miradaX;
    lupaYP2 = miradaY;
    lupaAnchoP2 = 220 * escalaMirada * e;
    lupaAltoP2 = 143 * escalaMirada * e;

    if (miradaP2 == seleccionadaP2) {
      // la seleccionada sigue marcada aunque este agrandada
      noFill();
      stroke(255, 200, 0);
      strokeWeight(5);
      rect(miradaX - 4 * e, miradaY - 4 * e, (220 * escalaMirada + 8) * e, (143 * escalaMirada + 8) * e, 6 * e);
      strokeWeight(1);
    } else {
      if (seleccionadaP2 >= 0) {
        // hay otra seleccionada: avisa que un clic aqui las intercambia
        textFont(fuenteTexto);
        textSize(24 * e);
        textAlign(CENTER, CENTER);
        float anchoAviso = textWidth("Clic derecho para intercambiar");
        noStroke();
        fill(0, 200 * zoomMiradaP2);
        rect(centroMirada * e - anchoAviso/2 - 16 * e, miradaY - 50 * e, anchoAviso + 32 * e, 40 * e, 10 * e);
        fill(255, 200, 0, 255 * zoomMiradaP2);
        text("Clic derecho para intercambiar", centroMirada * e, miradaY - 30 * e);
      }
    }
  }

  // pista que sale una sola vez, cuando ya hay dos historias colgadas y no hay otro mensaje en pantalla
  if (!pistaIntercambioP2 && colgadas >= 2 && millis() - inicioMensajePrueba > 2500) {
    mostrarMensaje("Clic izquierdo para ver de cerca, clic derecho en dos para intercambiarlas");
    pistaIntercambioP2 = true;
  }

  // mientras la guia explica todavia no cae ninguna historia
  // la historia que cae
  if (!guiaActiva && tarjetaP2 == -1 && colaIniP2 < colaFinP2) {
    tarjetaP2 = colaP2[colaIniP2];
    colaIniP2++;
    inicioCaidaP2 = millis();
    sonidosCargadosSample[6].trigger();   // whoosh de la historia que entra
    columnaP2 = 2;
    xCaidaP2 = 870;
  }

  if (tarjetaP2 >= 0) {

    float xColumna = 1622;
    if (columnaP2 < 5) {
      xColumna = 390 + columnaP2 * 240;
    }

    // al moverla se inclina hacia donde va (mas inclinada cuanto mas lejos esta)
    float inclinacionCarta = constrain((xColumna - xCaidaP2) * 0.0015, -0.25, 0.25);
    xCaidaP2 = lerp(xCaidaP2, xColumna, 0.2);

    // 11 s al principio, un 8 % mas rapido con cada historia soltada, nunca menos de 6 s
    float duracionCaida = max(6000, 11000 * pow(0.92, colocadasP2));
    int pasadoCaida = millis() - inicioCaidaP2;

    // baja hasta tocar la cuerda (o hasta el cesto)
    float yFinal = 480;   // la historia baja hasta la boca del cesto (y 810)
    if (columnaP2 < 5) {
      yFinal = cuerdaYP2(xColumna) - 340;
    }

    // entrada: cae desde fuera de la pantalla y rebota un poco al llegar (0,6 s)
    // despues baja despacio al principio (para leerla) y mas rapido al final
    float yCaida = 130;
    if (pasadoCaida < 600) {
      float avanceEntrada = pasadoCaida / 600.0;
      float rebote = 1 + 2.7 * pow(avanceEntrada - 1, 3) + 1.7 * pow(avanceEntrada - 1, 2);
      yCaida = lerp(-380, 130, rebote);
    } else {
      float avanceBajada = constrain((pasadoCaida - 600) / (duracionCaida - 600), 0, 1);
      yCaida = lerp(130, yFinal, avanceBajada * avanceBajada);
    }
    float avanceCaida = constrain(pasadoCaida / duracionCaida, 0, 1);

    // linea punteada: donde caeria si se suelta ahora
    float yDestino = 810;
    if (xCaidaP2 < 1480) {
      yDestino = cuerdaYP2(xCaidaP2);
    }
    stroke(255, 120);
    strokeWeight(2 * e);
    for (float yPunto = yCaida + 329; yPunto < yDestino; yPunto += 14) {
      line(xCaidaP2 * e, yPunto * e, xCaidaP2 * e, (yPunto + 7) * e);
    }

    // pinza de destino: un aro amarillo que late
    if (columnaP2 < 5) {
      float pinzaDestinoX = 390 + columnaP2 * 240;
      noFill();
      stroke(255, 200, 0, 150 + 100 * sin(millis() * 0.01));
      strokeWeight(4);
      ellipse(pinzaDestinoX * e, cuerdaYP2(pinzaDestinoX) * e, 56 * e, 56 * e);
    }

    // brillo rojo y la polaroid en grande (506 x 329) para mirar bien la foto, flotando y meciendose suave
    pushMatrix();
    translate(xCaidaP2 * e, yCaida * e);
    rotate(inclinacionCarta + sin(millis() * 0.003) * 0.03);
    noFill();
    stroke(255, 60, 80, 170);
    strokeWeight(8 * e);
    rect(-253 * e, 0, 506 * e, 329 * e, 8 * e);
    dibujarTarjetaP2(tarjetaP2, -253 * e, 0, 2.3 * e);
    popMatrix();

    // llego abajo sola: se suelta donde este
    if (avanceCaida >= 1) {
      soltarTarjetaP2(true);
    }
  }

  // siguiente historia
  if (colaIniP2 < colaFinP2) {
    // miniatura de la que viene; sale desde detras del telon cada vez que cae una nueva
    float entraSiguiente = reboteTelon((millis() - inicioCaidaP2) / 500.0);
    float siguienteX = lerp(-150, 240, entraSiguiente);
    fill(200);
    noStroke();
    textFont(fuenteTexto);
    textAlign(LEFT, CENTER);
    textSize(24 * e);
    text("Siguiente", siguienteX * e, 118 * e);
    pushMatrix();
    translate(siguienteX * e, 138 * e);
    rotate(-0.05);
    dibujarTarjetaP2(colaP2[colaIniP2], 0, 0, 0.6 * e);
    popMatrix();
  }

  // la exposicion sube sola mientras se juega; en los ultimos 10 s, latidos y bordes rojos
  gotearExposicionPrueba();
  dibujarTension(tension);
  if (tension > 0) {
    velInclinacionP2 += random(-0.5, 0.5) * tension;   // la cuerda tiembla
  }

  dibujarBarraSuperior(color(200, 30, 50));

  // PUNTOS EN VIVO: cuando una posicion queda bien sale "+2"; si se deshace, "-2"
  int correctasAhora = 0;
  for (int s = 0; s < 5; s++) {
    boolean bienAhora = barraP2[s] == s;
    if (bienAhora) {
      correctasAhora++;
    }
    if (bienAhora && !bienColocadaP2[s]) {
      agregarFlotante("+2", 390 + s * 240, cuerdaYP2(390 + s * 240) - 45, color(255, 210, 90));
      agregarMoneda(390 + s * 240, cuerdaYP2(390 + s * 240) - 45);
      sombraReacciona(1);
      subirExposicion(-2);   // acertar baja un poco la exposicion
      ultimoCambioPuntos = millis();
      sonidosCargadosSample[19].trigger();
    }
    if (!bienAhora && bienColocadaP2[s]) {
      agregarFlotante("-2", 390 + s * 240, cuerdaYP2(390 + s * 240) - 45, color(225, 60, 70));
      ultimoCambioPuntos = millis();
    }
    bienColocadaP2[s] = bienAhora;
  }

  dibujarMarcador(correctasAhora * 2);

  dibujarMonedas();
  dibujarFlotantes();

  // "-3 s" que vuela desde las historias intercambiadas hasta el reloj (0,7 s)
  int pasadoVuelo = millis() - inicioVueloRelojP2;
  if (pasadoVuelo < 700) {
    float avanceVuelo = pasadoVuelo / 700.0;
    float suaveVuelo = avanceVuelo * avanceVuelo * (3 - 2 * avanceVuelo);
    fill(225, 60, 70, 255 * (1 - avanceVuelo * avanceVuelo));
    textoConSigno("-3 s", lerp(vueloXP2, 960, suaveVuelo), lerp(vueloYP2, 105, suaveVuelo), 46 * (1 - 0.4 * avanceVuelo));
  }

  dibujarMensajePrueba();

  // sin palitos: se pierde sin puntos
  if (palitos <= 0) {
    perderP2(2);
  }
}


// suelta la historia que cae en la columna elegida (o en el cesto)
void soltarTarjetaP2(boolean automatico) {
  if (tarjetaP2 >= 0) {

    // llego sola y el hueco esta ocupado: va al primer hueco libre (o al cesto si no hay)
    if (automatico && columnaP2 < 5 && barraP2[columnaP2] != -1) {
      columnaP2 = 5;
      for (int s = 4; s >= 0; s--) {
        if (barraP2[s] == -1) {
          columnaP2 = s;
        }
      }
    }

    if (columnaP2 == 5) {

      // cesto: reportar la falsa es correcto, reportar una verdadera es un error
      anilloXP2 = 1622;
      anilloYP2 = 810;
      inicioAnilloP2 = millis();
      if (tarjetaP2 == 5) {
        falsaDescartadaP2 = true;
        subirExposicion(-12);   // reportar la falsa: recuperas el control
        sonidosCargadosSample[10].trigger();   // campanita
        colorAnilloP2 = color(255, 200, 0);
        mostrarMensaje("Reportada. Se publicó antes de tomarse.");
      } else {
        perderPalito();
        colorAnilloP2 = color(225, 40, 55);
        mostrarMensaje("Esa historia sí era tuya.");
        colaP2[colaFinP2] = tarjetaP2;
        colaFinP2++;
        rachaP2 = 0;
        sombraReacciona(2);
        subirExposicion(8);
      }
      tarjetaP2 = -1;
      colocadasP2++;
    } else {
      if (barraP2[columnaP2] != -1) {
        mostrarMensaje("Ese lugar está ocupado.");
      } else {
        barraP2[columnaP2] = tarjetaP2;
        velBalanceoP2[columnaP2] += 0.12;   // al colgarla se mece
        sonidosCargadosSample[8].trigger();   // chasquido de la pinza
        anilloXP2 = 390 + columnaP2 * 240;
        anilloYP2 = cuerdaYP2(anilloXP2);
        inicioAnilloP2 = millis();
        colorAnilloP2 = color(255, 200, 0);

        // racha: historias seguidas colgadas en su lugar a la primera
        if (tarjetaP2 != 5) {
          if (columnaP2 == tarjetaP2) {
            rachaP2++;
            if (rachaP2 >= 2) {
              agregarFlotante("Racha " + rachaP2, 390 + columnaP2 * 240, cuerdaYP2(390 + columnaP2 * 240) - 95, color(255, 150, 60));
            }
          } else {
            rachaP2 = 0;
          }
        }

        if (tarjetaP2 == 5) {
          rachaP2 = 0;
          sombraReacciona(2);
          colorAnilloP2 = color(225, 40, 55);

          // la falsa colgada: la cuerda se sacude, la falsa se suelta y vuelve a caer despues
          barraP2[columnaP2] = -1;
          falsaCaeP2 = millis();
          falsaXP2 = 390 + columnaP2 * 240;
          falsaYP2 = cuerdaYP2(falsaXP2);
          velInclinacionP2 += random(-14, 14);
          sonidosCargadosSample[12].trigger();   // la cuerda se sacude
          for (int s = 0; s < 5; s++) {
            velBalanceoP2[s] += random(-0.15, 0.15);
          }
          perderPalito();
          subirExposicion(10);
          mostrarMensaje("Esta historia no encaja. La mochila volvió a la silla.");
          colaP2[colaFinP2] = 5;
          colaFinP2++;
        }
        tarjetaP2 = -1;
        colocadasP2++;
      }
    }

    revisarVictoriaP2();
  }
}


// altura de la cuerda en una x (medidas de 1920): curva hacia abajo en el centro e inclinada segun el desbalance
float cuerdaYP2(float x) {
  float t = (x - 300) / 1180.0;   // 0 en el poste izquierdo, 1 en el derecho
  return 620 + entradaCuerdaP2 + hundimientoP2 * 4 * t * (1 - t) + inclinacionP2 * (t - 0.5);
}


// gana si las cinco verdaderas estan en orden y la falsa fue reportada
void revisarVictoriaP2() {
  boolean enOrden = true;
  for (int s = 0; s < 5; s++) {
    if (barraP2[s] != s) {
      enOrden = false;
    }
  }

  if (enOrden && falsaDescartadaP2) {

    // puntos: 10 por ganar + hasta 4 por el tiempo que sobra + 3 sin errores + 3 sin intercambios (maximo 20)
    int restante = max(0, duracionPrueba - (millis() - inicioPrueba));
    int puntosTiempo = (4 * restante + duracionPrueba / 2) / duracionPrueba;
    int puntosSinErrores = 0;
    if (palitos == 5) {
      puntosSinErrores = 3;
    }
    int puntosSinIntercambios = 0;
    if (intercambiosP2 == 0) {
      puntosSinIntercambios = 3;
    }

    lineaTexto[0] = "Historias en orden";
    lineaPuntos[0] = 10;
    lineaTexto[1] = "Tiempo que sobró";
    lineaPuntos[1] = puntosTiempo;
    lineaTexto[2] = "Sin errores";
    lineaPuntos[2] = puntosSinErrores;
    lineaTexto[3] = "Sin intercambios";
    lineaPuntos[3] = puntosSinIntercambios;
    cantidadLineas = 4;

    puntosGanadosP2 = 10 + puntosTiempo + puntosSinErrores + puntosSinIntercambios;
    puntosJugador += puntosGanadosP2;
    subirExposicion(-5);
    resultadoActo1[1] = 1;
    ganarLogro(1);
    revisarLogrosActos();
    if (pruebasCompletadasActo1 == 1) {
      pruebasCompletadasActo1 = 2;
    }
    llenarResultadoP2(true);
    empezarResultado(true);
    pantalla = 17;
  }
}


// pierde la prueba: se filtra el dato y se dan 2 puntos por cada historia bien colocada si fue por tiempo
void perderP2(int motivo) {
  motivoDerrotaP2 = motivo;

  int correctas = 0;
  for (int s = 0; s < 5; s++) {
    if (barraP2[s] == s) {
      correctas++;
    }
  }

  puntosGanadosP2 = 0;
  lineaTexto[0] = "Sin palitos";
  lineaPuntos[0] = 0;
  if (motivo == 0) {
    puntosGanadosP2 = correctas * 2;
    lineaTexto[0] = "Historias en su lugar";
    lineaPuntos[0] = puntosGanadosP2;
  }
  cantidadLineas = 1;
  puntosJugador += puntosGanadosP2;

  resultadoActo1[1] = 2;
  if (pruebasCompletadasActo1 == 1) {
    pruebasCompletadasActo1 = 2;
  }
  filtrarDato(1);
  llenarResultadoP2(false);
  empezarResultado(false);
  pantalla = 16;
}


// textos de la pantalla de resultado de la prueba 2 (las lineas de puntos ya estan llenas)
void llenarResultadoP2(boolean gano) {
  tituloResultado = "Se acabó el tiempo";
  if (motivoDerrotaP2 == 2) {
    tituloResultado = "Te quedaste sin palitos";
  }
  subtituloResultado = "La sombra armó tu noche con tus historias.";
  selloIlustracion = "FALSA";
  if (gano) {
    tituloResultado = "Prueba superada";
    subtituloResultado = "Tu noche está en orden y la historia falsa fue reportada.";
    selloIlustracion = "REPORTADA";
  }
  explicacionIlustracion = "Se publicó a las 23:43,\npero se tomó a las 23:45.";
  fraseVidaReal = "Cada historia dice dónde estabas y a qué hora. Juntas, cuentan tu rutina.";
  consejoVidaReal = "Antes de subir una historia, piensa en lo que muestra. Súbela cuando ya no estés en ese lugar y compártela solo con quien conoces.";
  datoResultado = 1;
  ilustracionResultado = 2;
  puntosResultado = puntosGanadosP2;
}


// 16 - ACTO I - PRUEBA 2 - PRUEBA PERDIDA
void dibujarPerdidaP2() {
  dibujarResultado(false);
}


// 17 - ACTO I - PRUEBA 2 - PRUEBA SUPERADA
void dibujarSuperadaP2() {
  dibujarResultado(true);
}


// el tiempo se acabo (lo llama el contador)
void tiempoAgotadoP2() {
  perderP2(0);
}


// teclas en la pantalla 14: flechas para mover, abajo para soltar y R para reportar
void teclaP2() {
  if (key == CODED) {
    if (keyCode == LEFT && columnaP2 > 0) {
      columnaP2--;
      sonidosCargadosSample[7].trigger();
    }
    if (keyCode == RIGHT && columnaP2 < 5) {
      columnaP2++;
      sonidosCargadosSample[7].trigger();
    }
    if (keyCode == DOWN) {
      soltarTarjetaP2(false);
    }
  }

  if (key == 'r' || key == 'R') {
    columnaP2 = 5;
    soltarTarjetaP2(false);
  }
}


// clic en la pantalla 14: el izquierdo abre o cierra la lupa; el derecho selecciona e intercambia (cuesta 3 s)
void clicP2() {
  float e = width / 1920.0;

  // historia bajo el mouse: primero la agrandada (si la lupa esta abierta), si no la colgada
  int clicada = -1;
  if (lupaAbiertaP2 && miradaP2 >= 0 && mouseX > lupaXP2 && mouseX < lupaXP2 + lupaAnchoP2 && mouseY > lupaYP2 && mouseY < lupaYP2 + lupaAltoP2) {
    clicada = miradaP2;
  } else {
    for (int s = 0; s < 5; s++) {
      // la historia cuelga de su pinza (se toma sin el giro, es casi recta)
      float huecoXC = (390 + s * 240 - 110) * e;
      float huecoYC = (cuerdaYP2(390 + s * 240) + 8 - 40 * alzadoP2[s]) * e;
      if (barraP2[s] != -1 && mouseX > huecoXC && mouseX < huecoXC + 220 * e && mouseY > huecoYC && mouseY < huecoYC + 143 * e) {
        clicada = s;
      }
    }
  }

  // CLIC IZQUIERDO: con la lupa abierta, cualquier clic la cierra; si no, abre la lupa en la historia
  if (mouseButton == LEFT) {
    if (lupaAbiertaP2) {
      lupaAbiertaP2 = false;
      sonidosCargadosSample[13].trigger();
    } else {
      if (clicada >= 0) {
        miradaP2 = clicada;
        zoomMiradaP2 = 0;
        lupaAbiertaP2 = true;
        sonidosCargadosSample[13].trigger();
      }
    }
  }

  // CLIC DERECHO: selecciona una historia; en otra, las intercambia
  if (mouseButton == RIGHT && clicada >= 0 && millis() - inicioIntercambioP2 >= 500) {
    if (seleccionadaP2 == -1) {
      seleccionadaP2 = clicada;
    } else {
      if (seleccionadaP2 == clicada) {
        seleccionadaP2 = -1;
      } else {
        int cambioHueco = barraP2[clicada];
        barraP2[clicada] = barraP2[seleccionadaP2];
        barraP2[seleccionadaP2] = cambioHueco;
        velBalanceoP2[clicada] += 0.1;          // las dos se mecen al llegar
        velBalanceoP2[seleccionadaP2] -= 0.1;
        intercambioAP2 = seleccionadaP2;        // empieza la animacion de vuelo
        intercambioBP2 = clicada;
        inicioIntercambioP2 = millis();
        sonidosCargadosSample[11].trigger();   // whoosh del intercambio
        seleccionadaP2 = -1;
        lupaAbiertaP2 = false;                  // la lupa se cierra para ver el vuelo
        inicioPrueba -= 3000;
        intercambiosP2++;
        inicioVueloRelojP2 = millis();
        vueloXP2 = 390 + (clicada + intercambioAP2) * 120;   // entre las dos historias
        vueloYP2 = cuerdaYP2(vueloXP2) + 60;
        revisarVictoriaP2();
      }
    }
  }
}
