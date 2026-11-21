// PRUEBA 1 - LA PRIMERA (pantallas 9, 11, 12 y 13)

// ZONAS DE LA PRUEBA 1 DEL ACTO 1: esquinas de cada forma (no son rectangulos)
// cada lista guarda las esquinas en orden, como fraccion del ancho (X) y del alto (Y) de la pantalla
// celular
float[] celularX = {0.3926, 0.3876, 0.3634, 0.3655, 0.3701, 0.3827, 0.3919, 0.4133, 0.4119, 0.4024};
float[] celularY = {0.2651, 0.2624, 0.2212, 0.2042, 0.1957, 0.1852, 0.1878, 0.2251, 0.2474, 0.2585};

// ventana
float[] ventanaX = {0.8272, 0.7921, 0.7781, 0.7697, 0.7588, 0.7567, 0.7637, 0.7637, 0.7317, 0.7293, 0.7384, 0.6938, 0.6882, 0.6850, 0.6808, 0.6696, 0.6650, 0.6397, 0.6299, 0.6138, 0.6053, 0.5976, 0.5909, 0.5874, 0.5948, 0.8350, 0.9115, 0.9863, 0.9863, 0.8754, 0.8596, 0.8441};
float[] ventanaY = {0.6067, 0.5818, 0.5491, 0.5425, 0.5223, 0.4961, 0.4764, 0.4660, 0.4274, 0.4175, 0.3626, 0.2991, 0.2991, 0.3050, 0.3416, 0.3534, 0.3724, 0.3645, 0.3436, 0.3370, 0.3122, 0.3122, 0.3037, 0.2814, 0.0569, 0.0596, 0.0517, 0.0576, 0.1571, 0.5982, 0.6027, 0.5962};

// espejo
float[] espejoX = {0.9888, 0.9870, 0.9386, 0.8904, 0.8374};
float[] espejoY = {0.1525, 0.6479, 0.7906, 0.8410, 0.7539};

// pintura
float[] pinturaX = {0.1404, 0.1352, 0.1254, 0.1197, 0.1218, 0.1271, 0.1404, 0.1429, 0.1436, 0.1468, 0.1643, 0.1770, 0.1801, 0.1801, 0.1886, 0.1921, 0.1914, 0.1840};
float[] pinturaY = {0.2454, 0.2343, 0.1846, 0.1387, 0.1309, 0.1237, 0.1158, 0.1113, 0.1008, 0.0962, 0.0988, 0.0949, 0.1008, 0.1139, 0.1597, 0.1885, 0.1976, 0.2114};

// las 4 zonas juntas, en el mismo orden que sus imagenes resaltadas (indices 37 a 40 de imagenes[])
float[][] zonasX = {celularX, ventanaX, espejoX, pinturaX};
float[][] zonasY = {celularY, ventanaY, espejoY, pinturaY};
int cantidadZonas = 4;  // cantidad de zonas
int[] esquinasZonas = {10, 32, 5, 18};  // cantidad de esquinas de cada zona (mismo orden: celular, ventana, espejo, pintura)
int zonaBajoElMouse = -1; // zona con el mouse encima (-1 = ninguna)
int zoomAbierto = -1; // zona cuyo zoom se esta viendo (-1 = ninguno); imagenes 41 a 44 en el mismo orden (tambien en: contador)

// ANIMACION DEL ZOOM: la habitacion se acerca a la zona y luego se funde con la imagen del zoom
// hacia donde se acerca cada zona (celular, ventana, espejo, pintura): esquina y lado del cuadrado, como fraccion de la imagen
float[] zoomX0 = {0.3005, 0.3618, 0.5000, 0.0054};
float[] zoomY0 = {0.1373, 0.0101, 0.2468, 0.0196};
float[] zoomLado = {0.1757, 0.6382, 0.5000, 0.3010};
int inicioZoom = 0;              // millis() del clic que abrio el zoom
int duracionAcercamiento = 700;  // ms que tarda en acercarse
int duracionFundido = 400;       // ms que tarda en aparecer la imagen del zoom

int ultimaEscrituraP1 = 0;      // millis() de la ultima tecla apretada en el interrogante (el cursor se oculta mientras se escribe)

// CUADERNO DE PISTAS: lo que se descubre en cada zona (mismo orden: celular, ventana, espejo, pintura)
String[] nombrePistaP1 = {"Celular", "Ventana", "Espejo", "Foto torcida"};
String[] textoPistaP1 = {
  "La hora del celular es 23:46, pero la notificación dice 23:47.",
  "El reflejo de la lámpara está corrido.",
  "Se reflejan la puerta y parte del escritorio.",
  "Lámpara encendida, ventana cerrada y reloj a las 23:31."
};
boolean[] pistaVistaP1 = new boolean[4];   // true = esa zona ya se reviso
int[] inicioPistaP1 = new int[4];          // millis() en que se anoto (se escribe letra por letra)
boolean[] lapizSonoP1 = new boolean[4];    // el lapiz ya sono al anotar esa pista
int pistasVistasP1 = 0;

// ESTADO DE LA PRUEBA 1
int fallosP1 = 0;                // respuestas equivocadas (para el bono "a la primera")
int motivoDerrotaP1 = 0;         // 0 = tiempo, 2 = sin palitos
int puntosGanadosP1 = 0;
int zonaAnteriorP1 = -1;         // para que el tic suene solo al entrar a una zona nueva
boolean sonoFlashP1 = false;     // el flash de la camara ya sono

// GUIA DE LA PRUEBA 1
String[] titulosGuiaP1 = {"Tu cordura", "El tiempo", "Exposición", "La foto", "Investiga", "Tu cuaderno", "Responder", "A jugar"};
String[] textosGuiaP1 = {
  "Estos palitos son tu cordura. Cada respuesta equivocada se come uno. Si se acaban, pierdes la prueba.",
  "Lo que te queda para resolverla. En los últimos 10 segundos la barra se pone roja.",
  "Cuánto de tu vida pueden ver los desconocidos. Sube sola mientras esta foto está a la vista.",
  "Alguien tomó esta foto de tu habitación. Algo en ella no encaja con el lugar donde está la cámara.",
  "Pasa la lupa por la foto: lo que se ilumina se puede revisar. Haz clic para acercarte y otro clic para volver.",
  "Cada cosa que revisas queda anotada aquí, para que puedas pensar con calma.",
  "Cuando sepas qué detalle no encaja, pulsa Responder y escríbelo. Acertar a la primera da más puntos.",
  "Aquí pierdes un palito cada vez que envías una respuesta equivocada. Revisa el celular, la ventana, el espejo y la foto torcida. Pulsa ENTER para empezar."
};
float[][] zonasGuiaP1 = {
  {20, 8, 330, 80},        // plato de zanahorias
  {690, 22, 540, 100},     // contador
  {1385, 8, 490, 78},      // exposicion
  {300, 120, 1320, 600},   // la foto
  {680, 180, 130, 120},    // el celular (una zona para revisar)
  {20, 692, 520, 366},     // el cuaderno
  {720, 940, 480, 96},     // boton Responder
  {960, 540, 0, 0}         // sin zona: recuadro en el centro
};
int cantidadPasosGuiaP1 = 8;

//Respuesta
String respuestaUser = "";  // lo que escribe el jugador (tambien en: contador)
Boolean RespuestaIncorrecta = false;  // true si fallo la respuesta
int tiempoFeedback = 0;  // momento de la ultima respuesta incorrecta

// Repeticion de teclas (mantener apretada una letra en la pantalla 11)
boolean teclaMantenida = false;   // true mientras la tecla sigue apretada (tambien en: teclado)
int teclaRepetida = 0;            // keyCode de la tecla que se esta repitiendo (tambien en: teclado)
char letraRepetida = 0;           // el caracter que se esta repitiendo (tambien en: teclado)
int inicioTecla = 0;              // millis() del momento en que se apreto (tambien en: teclado)
int ultimaRepeticion = 0;         // millis() de la ultima letra repetida (tambien en: teclado)
float[] BotonResolverP1 = new float [4];  // boton Responder (tambien en: setup, prueba 2)

// Lista de posibles sinónimos o formas en que el jugador podría responder
String[] respuestasValidasP1 = {
  "el espejo",
  "espejo",
  "la contradiccion del espejo",
  "la contradicción del espejo",
  "contradiccion del espejo",
  "contradicción del espejo",
  "el reflejo del espejo",
  "reflejo del espejo",
  "el reflejo",
  "reflejo",
  "la puerta en el espejo",
  "puerta en el espejo",
  "el angulo del espejo",
  "el ángulo del espejo",

  // el espejo con otras palabras
  "en el espejo",
  "lo del espejo",
  "el espejo de la habitacion",
  "el espejo de la habitación",
  "el espejo muestra algo imposible",
  "el espejo es la contradiccion",
  "el espejo es la contradicción",
  "la contradiccion en el espejo",
  "la contradicción en el espejo",
  "contradiccion en el espejo",
  "contradicción en el espejo",
  "la contradiccion del reflejo",
  "la contradicción del reflejo",
  "contradiccion del reflejo",
  "contradicción del reflejo",

  // el reflejo
  "los reflejos",
  "el reflejo en el espejo",
  "reflejo en el espejo",
  "el reflejo de la puerta",
  "reflejo de la puerta",
  "el reflejo imposible",
  "reflejo imposible",
  "el reflejo del escritorio",
  "reflejo del escritorio",

  // la puerta y el escritorio reflejados
  "la puerta",
  "puerta",
  "la puerta reflejada",
  "puerta reflejada",
  "la puerta del espejo",
  "la puerta en el reflejo",
  "puerta en el reflejo",
  "la puerta y el escritorio",
  "puerta y escritorio",
  "la puerta y el espejo",
  "la puerta y el reflejo",
  "el escritorio en el espejo",
  "escritorio en el espejo",
  "el escritorio reflejado",
  "escritorio reflejado",
  "la puerta y el escritorio en el espejo",
  "la puerta y parte del escritorio",
  "la puerta y una parte del escritorio",
  "puerta y parte del escritorio",

  // perspectiva y camara
  "la perspectiva del espejo",
  "perspectiva del espejo",
  "el angulo del reflejo",
  "el ángulo del reflejo",
  "angulo del espejo",
  "ángulo del espejo",
  "un angulo imposible",
  "un ángulo imposible",
  "el angulo imposible",
  "el ángulo imposible",
  "angulo imposible",
  "ángulo imposible",
  "la posicion de la puerta en el espejo",
  "la posición de la puerta en el espejo",
  "la posicion imposible de la puerta",
  "la posición imposible de la puerta",
  "posicion imposible de la puerta",
  "posición imposible de la puerta",
  "la puerta en una posicion imposible",
  "la puerta en una posición imposible",
  "la camara y el espejo",
  "la cámara y el espejo",
  "el espejo y la camara",
  "el espejo y la cámara",
  "el espejo no coincide con la camara",
  "el espejo no coincide con la cámara"
};
int cantidadRespuestasValidasP1 = 83;  // cantidad de respuestas validas (si se agrega una, sumar 1)

// Palabras que, si aparecen en cualquier parte de lo que escribe el jugador, dan la respuesta por buena
String[] palabrasClaveP1 = {
  "espejo",
  "reflejo",
  "reflejado",
  "puerta"
};
int cantidadPalabrasClaveP1 = 4;  // cantidad de palabras clave (si se agrega una, sumar 1)

// Palabras de negacion: si aparecen, la respuesta no vale aunque tenga una palabra clave ("no es el espejo")
String[] palabrasNegacionP1 = {
  " no ",
  " ni ",
  " nada ",
  " tampoco ",
  " nunca "
};
int cantidadPalabrasNegacionP1 = 5;  // cantidad de palabras de negacion (si se agrega una, sumar 1)


// 9 - ACTO I - PRUEBA 1
void dibujarPrueba1() {
  // acto 1, prueba 1 (imagenes de prueba, indices 36 a 40)
  background(0);

  // en que zona esta el mouse? (celular, ventana, espejo o pintura; -1 = en ninguna)
  zonaBajoElMouse = -1;

  for (int zona = 0; zona < cantidadZonas; zona++) {

    boolean estaDentro = false;
    int cantidadEsquinas = esquinasZonas[zona];

    for (int esquinaActual = 0; esquinaActual < cantidadEsquinas; esquinaActual++) {

      // cada lado va de una esquina a la siguiente (la ultima vuelve a la primera)
      // las esquinas estan como fraccion de la pantalla, se pasan a pixeles
      int esquinaSiguiente = (esquinaActual + 1) % cantidadEsquinas;

      float ladoInicioX = zonasX[zona][esquinaActual] * width;
      float ladoInicioY = zonasY[zona][esquinaActual] * height;
      float ladoFinX = zonasX[zona][esquinaSiguiente] * width;
      float ladoFinY = zonasY[zona][esquinaSiguiente] * height;

      // pregunta 1: este lado pasa por la altura del mouse?
      boolean ladoPasaPorLaAlturaDelMouse = (ladoInicioY > mouseY) != (ladoFinY > mouseY);

      if (ladoPasaPorLaAlturaDelMouse) {

        // en que posicion horizontal esta el lado justo a la altura del mouse
        float cuantoBajamosDesdeElInicio = mouseY - ladoInicioY;
        float cuantoBajaTodoElLado = ladoFinY - ladoInicioY;
        float fraccionDelLado = cuantoBajamosDesdeElInicio / cuantoBajaTodoElLado;

        float cuantoSeMueveTodoElLado = ladoFinX - ladoInicioX;
        float xDondeElLadoCruza = ladoInicioX + fraccionDelLado * cuantoSeMueveTodoElLado;

        // pregunta 2: ese cruce queda a la derecha del mouse?
        if (mouseX < xDondeElLadoCruza) {
          estaDentro = !estaDentro;   // cuenta un cruce: se invierte true/false
        }
      }
    }

    if (estaDentro) {
      zonaBajoElMouse = zona;
    }
  }

  // tic suave al entrar a una zona nueva (solo con la habitacion a la vista)
  if (zonaBajoElMouse != zonaAnteriorP1) {
    if (zonaBajoElMouse >= 0 && zoomAbierto == -1 && !guiaActiva && !telonActivo) {
      sonidosCargadosSample[7].trigger();
    }
    zonaAnteriorP1 = zonaBajoElMouse;
  }

  if (zoomAbierto >= 0) {

    int transcurrido = millis() - inicioZoom;

    // fase 1: la habitacion se acerca a la zona (se recorta una ventana cada vez mas chica)
    float acercamiento = constrain(transcurrido / (float) duracionAcercamiento, 0, 1);
    acercamiento = acercamiento * acercamiento * (3 - 2 * acercamiento);

    PImage habitacion = imagenesCargadas[36];

    float ventanaX0 = lerp(0, zoomX0[zoomAbierto], acercamiento) * habitacion.width;
    float ventanaY0 = lerp(0, zoomY0[zoomAbierto], acercamiento) * habitacion.height;
    float ventanaX1 = lerp(1, zoomX0[zoomAbierto] + zoomLado[zoomAbierto], acercamiento) * habitacion.width;
    float ventanaY1 = lerp(1, zoomY0[zoomAbierto] + zoomLado[zoomAbierto], acercamiento) * habitacion.height;

    image(habitacion, 0, 0, width, height, (int) ventanaX0, (int) ventanaY0, (int) ventanaX1, (int) ventanaY1);

    // fase 2: cuando termina el acercamiento, aparece la imagen del zoom con un fundido
    float fundido = constrain((transcurrido - duracionAcercamiento) / (float) duracionFundido, 0, 1);

    tint(255, 255 * fundido);
    image(imagenesCargadas[41 + zoomAbierto], 0, 0, width, height);
    noTint();
  } else {
    if (zonaBajoElMouse >= 0) {
      image(imagenesCargadas[37 + zonaBajoElMouse], 0, 0, width, height);   // la zona resaltada
    } else {
      image(imagenesCargadas[36], 0, 0, width, height);                     // normal
    }
  }
  //Respuesta
  if (zoomAbierto == -1) {
    boolean sobreBoton = mouseX > BotonResolverP1[0] && mouseX < BotonResolverP1[0] + BotonResolverP1[2] && mouseY > BotonResolverP1[1] && mouseY < BotonResolverP1[1] + BotonResolverP1[3];

    // fondo oscuro (un poco mas claro al pasar el mouse), esquinas redondeadas y borde amarillo/blanco
    fill (sobreBoton ? color(45, 40, 20) : color(20, 20, 20, 235));
    stroke (sobreBoton ? color(255, 200, 0) : 255);
    strokeWeight (3);
    rect ( BotonResolverP1 [0], BotonResolverP1[1], BotonResolverP1[2], BotonResolverP1[3], 12);

    fill (sobreBoton ? color(255, 200, 0): 255);
    textFont(fuente);
    textSize(sobreBoton ? 36 : 32);
    textAlign(CENTER, BASELINE);
    // centrado vertical con las medidas reales de la fuente (ascent y descent)
    text ("Responder", BotonResolverP1 [0] + BotonResolverP1[2]/2, BotonResolverP1[1] + BotonResolverP1[3]/2 + (textAscent() - textDescent())/2);
  }

  // OSCURO: mientras el telon se abre, detras queda todo negro; la foto aparece cuando el flash llega a su punto mas blanco
  // (a los 2,88 s desde que empezo el telon; despues de eso, o al volver del interrogante, ya no hay negro)
  boolean oscuroP1 = millis() - inicioTelon < 2880;
  if (oscuroP1) {
    noStroke();
    fill(0);
    rect(0, 0, width, height);
  }

  // FLASH: cuando el telon ya termino de abrirse (2,8 s), alguien toma la foto: el destello sube en 80 ms
  // y se apaga despacio en 700 ms; el obturador suena un poco antes para que el ojo lo espere
  int pasadoFlash = millis() - inicioTelon - 2800;
  if (pasadoFlash >= -120 && !sonoFlashP1) {
    sonidosCargadosSample[29].trigger();
    sonoFlashP1 = true;
  }
  if (pasadoFlash >= 0 && pasadoFlash < 780) {
    float fuerzaFlash = 0;
    if (pasadoFlash < 80) {
      fuerzaFlash = pasadoFlash / 80.0;
    } else {
      fuerzaFlash = 1 - (pasadoFlash - 80) / 700.0;
    }
    noStroke();
    fill(255, 235 * fuerzaFlash * fuerzaFlash);
    rect(0, 0, width, height);
  }

  // el cuaderno y la lupa aparecen junto con la foto
  if (!oscuroP1) {
    dibujarCuadernoP1();
  }
  dibujarEfectosP1();

  // el cursor es una lupa sobre la foto
  noCursor();
  if (!oscuroP1) {
    dibujarCursorLupaP1();
  }

  // sin palitos: se pierde
  if (palitos <= 0) {
    perderP1(2);
  }
}


// 11 - ACTO I - PRUEBA 1 - INTERROGANTE
void dibujarInterroganteP1() {
  //fondo
  image(imagenesCargadas[36], 0, 0, width, height);

  // mantener una tecla: pasados 400 ms, repite cada 50 ms (ENTER y ESC no se repiten)
  if (teclaMantenida && keyPressed && letraRepetida != ENTER && letraRepetida != RETURN && letraRepetida != ESC
    && millis() - inicioTecla > 400 && millis() - ultimaRepeticion > 50) {
    key = letraRepetida;
    keyCode = teclaRepetida;
    keyPressed();
    ultimaRepeticion = millis();
  }

  //oscurecer fondo
  fill(0, 150);
  noStroke();
  rect(0, 0, width, height);

  // Ventana central 
  float anchoV = 860;
  float altoV = 540;
  float xV = width/2 - anchoV/2;
  float yV = height/2 - altoV/2;

  // ventana: esquinas redondeadas y borde amarillo como los demas botones
  fill(20, 20, 20, 240);
  stroke(255, 200, 0);
  strokeWeight(3);
  rect(xV, yV, anchoV, altoV, 16);

  //titulo en amarillo con una linea debajo
  fill (255, 200, 0);
  textFont(fuente);
  textAlign(CENTER);
  textSize(54);
  text("Interrogante", width/2, yV + 75);

  stroke(255, 200, 0, 120);
  strokeWeight(1);
  line(xV + 70, yV + 100, xV + anchoV - 70, yV + 100);

  //pregunta (la fuente no tiene el signo de apertura: se dibuja un "?" dado vuelta antes de la primera linea)
  fill (255);
  textSize(26);
  String primeraLinea = "Qué detalle demuestra que la perspectiva de la habitación";
  text(primeraLinea + "\nno corresponde a la posición aparente de la cámara?", width/2, yV + 155);
  float inicioLinea = width/2 - textWidth(primeraLinea) / 2;   // donde empieza la primera linea (esta centrada)
  float anchoSigno = textWidth("?");
  float centroSigno = textAscent() * 0.35;                     // el signo gira alrededor de su centro, no de la base
  pushMatrix();
  translate(inicioLinea - anchoSigno / 2 - 3, yV + 155 - centroSigno);
  rotate(PI);
  text("?", 0, centroSigno);
  popMatrix();

  // temblor: si falla, el recuadro se sacude 400 ms de lado a lado (seno de millis)
  float temblor = 0;
  if (RespuestaIncorrecta && millis() - tiempoFeedback < 400) {
    temblor = sin(millis() * 0.08) * 8;
  }

  // Recuadro de escritura
  float cajaX = width/2 - 300 + temblor;
  float cajaY = yV + 235;
  float cajaAncho = 600;
  float cajaAlto = 60;

  //borde rojo si fallo hace poco, amarillo si no
  fill(10);
  if (RespuestaIncorrecta && millis() - tiempoFeedback < 3000) {
    stroke(255, 100, 100);
  } else {
    stroke(255, 200, 0);
  }
  strokeWeight(2);
  rect(cajaX, cajaY, cajaAncho, cajaAlto, 10);

  //Texto del jugador (o una pista en gris si todavia no escribio nada)
  // BASELINE + ascent/descent: centra el texto con las medidas reales de la fuente
  textAlign(LEFT, BASELINE);
  textSize(26);
  float yTextoCaja = cajaY + cajaAlto/2 + (textAscent() - textDescent())/2;
  if (respuestaUser.length() == 0) {
    fill(110);
    text("Escribe tu respuesta...", cajaX + 17, yTextoCaja);
  } else {
    fill (255);
    text(respuestaUser, cajaX + 17, yTextoCaja);
  }

  // solo aparece si pasaron mas de 300 ms sin apretar teclas; entonces parpadea medio segundo si, medio no,
  // justo despues del ultimo caracter escrito
  if (millis() - ultimaEscrituraP1 > 300 && (millis() / 500) % 2 == 0) {
    float xCursor = cajaX + 17 + textWidth(respuestaUser);
    stroke(255);
    strokeWeight(2);
    line(xCursor + 2, cajaY + 18, xCursor + 2, cajaY + cajaAlto - 18);
  }

  //Contador de letras, a la derecha debajo del recuadro
  fill(190);
  textAlign(RIGHT);
  textSize(22);
  text(respuestaUser.length() + " de 40", width/2 + 300, yV + 328);

  //Instrucción
  fill(190);
  textAlign(CENTER);
  textSize(22);
  text("Presiona ENTER para enviar", width/2, yV + 360);

  //Mensaje por si falla: aparece entero y se desvanece en el ultimo segundo
  if (RespuestaIncorrecta && millis() - tiempoFeedback < 3000) {
    float transparenciaFallo = 255;
    if (millis() - tiempoFeedback > 2000) {
      transparenciaFallo = map(millis() - tiempoFeedback, 2000, 3000, 255, 0);
    }
    fill (255, 100, 100, transparenciaFallo);
    textSize (24);
    text("Deducción incorrecta. Revisa los detalles.", width/2, yV + 410);
  }

  // Boton Volver: sus medidas se guardan una vez y las usan la deteccion del mouse, el rect y el texto
  float volverX = width/2 - 95;
  float volverY = yV + altoV - 85;
  float volverAncho = 190;
  float volverAlto = 60;
  boolean sobreVolver = mouseX > volverX && mouseX < volverX + volverAncho && mouseY > volverY && mouseY < volverY + volverAlto;

  fill(10);
  if (sobreVolver) {
    stroke(255, 200, 0);
  } else {
    stroke(255, 120);
  }
  strokeWeight(2);
  rect(volverX, volverY, volverAncho, volverAlto, 10);

  if (sobreVolver) {
    fill (255, 200, 0);
    textSize(42);
  } else {
    fill (255);
    textSize(38);
  }
  textAlign(CENTER, BASELINE);
  text ("Volver", width/2, volverY + volverAlto/2 + (textAscent() - textDescent())/2);

  cursor(ARROW);
  dibujarCuadernoP1();
  dibujarEfectosP1();
}


// 12 - ACTO I - PRUEBA 1 - PRUEBA PERDIDA (tiempo o palitos)
void dibujarTiempoAgotadoP1() {
  dibujarResultado(false);
}


// 13 - ACTO I - PRUEBA 1 - PRUEBA SUPERADA
void dibujarSuperadaP1() {
  dibujarResultado(true);
}


// clic en la pantalla 9
void clicPrueba1() {
  if (zoomAbierto >= 0) {

    // hay un zoom abierto: un clic lo cierra y vuelve a la habitacion
    zoomAbierto = -1;
    sonidosCargadosSample[31].trigger();
  } else {
    if (mouseX > BotonResolverP1[0] && mouseX < BotonResolverP1[0] + BotonResolverP1[2] && mouseY > BotonResolverP1[1] && mouseY < BotonResolverP1[1] + BotonResolverP1[3]) {  // boton Responder
      respuestaUser = "";
      RespuestaIncorrecta = false;
      sonidosCargadosSample[3].trigger();
      pantalla = 11;
    } else {
      if (zonaBajoElMouse >= 0) {

        // clic sobre una zona: abre su zoom y empieza a contar el tiempo de la animacion
        zoomAbierto = zonaBajoElMouse;
        inicioZoom = millis();
        sonidosCargadosSample[30].trigger();

        // la primera vez que se revisa una zona, queda anotada en el cuaderno
        if (!pistaVistaP1[zoomAbierto]) {
          pistaVistaP1[zoomAbierto] = true;
          inicioPistaP1[zoomAbierto] = millis() + 900;   // se anota cuando termina el acercamiento
          pistasVistasP1++;
        }
      }
    }
  }

  // un clic fuera de las zonas no hace nada: de la prueba solo se sale al ganar o al perderse el tiempo
}


// clic en la pantalla 11
// INTERROGANTE (medidas iguales a las del draw)
void clicInterroganteP1() {
  float wV = 860;
  float hV = 540;
  float posXV = width/2 - wV/2;
  float posYV = height/2 - hV/2;

  boolean clickVolver = mouseX > width/2 - 95 && mouseX < width/2 + 95 && mouseY > posYV + hV - 85 && mouseY < posYV + hV - 25;

  //Click Fuera
  boolean clickAfuera = mouseX < posXV || mouseX > posXV + wV || mouseY < posYV || mouseY > posYV + hV;

  if (clickVolver || clickAfuera) {
    pantalla = 9;
  }
}


// teclas en la pantalla 11
void teclaInterroganteP1() {
  ultimaEscrituraP1 = millis();   // cualquier tecla (tambien las repeticiones de draw) oculta el cursor
  if (key == ESC) {
    key = 0;
    pantalla = 9;
  } else {
    if (key == BACKSPACE) {
      if (respuestaUser.length() > 0) {
        respuestaUser = respuestaUser.substring(0, respuestaUser.length() - 1);
      }
    } else {
      if (key == ENTER || key == RETURN) {
        if (respuestaUser.length() > 0) {
          // minusculas y sin espacios en los bordes, para que "El Espejo " tambien valga
          String textoLimpio = respuestaUser.toLowerCase().trim();
          boolean esCorrecta = false;
          for (int indiceRespuesta = 0; indiceRespuesta < cantidadRespuestasValidasP1; indiceRespuesta++) {
            if (textoLimpio.equals(respuestasValidasP1[indiceRespuesta])) {
              esCorrecta = true;
            }
          }

          // ademas de la lista exacta, vale cualquier frase que contenga una palabra clave
          for (int indicePalabra = 0; indicePalabra < cantidadPalabrasClaveP1; indicePalabra++) {
            if (textoLimpio.indexOf(palabrasClaveP1[indicePalabra]) != -1) {
              esCorrecta = true;
            }
          }

          // pero si la frase niega ("no es el espejo"), no vale. Se le ponen espacios a los lados
          // para que " no " solo coincida con la palabra "no" y no con el final de otra palabra
          String textoConEspacios = " " + textoLimpio + " ";
          for (int indiceNegacion = 0; indiceNegacion < cantidadPalabrasNegacionP1; indiceNegacion++) {
            if (textoConEspacios.indexOf(palabrasNegacionP1[indiceNegacion]) != -1) {
              esCorrecta = false;
            }
          }

          if (esCorrecta) {
            respuestaUser = "";
            ganarP1();
          } else {
            // equivocarse cuesta un palito
            perderPalito();
            fallosP1++;
            RespuestaIncorrecta = true;
            tiempoFeedback = millis();
            if (palitos <= 0) {
              perderP1(2);
            }
          }
        }
      } else {
        if ((key >= ' ' && key <= '~') || key == 'ñ' || key == 'Ñ' || "áéíóúÁÉÍÓÚ".indexOf(key) != -1) {
          if (respuestaUser.length() < 40) {
            respuestaUser += key;
            sonidosCargadosSample[4].trigger();   // tecleo
          }
        }
      }
    }
  }
}


// prepara la prueba 1 (se llama al terminar el contexto)
void iniciarP1() {
  duracionPrueba = 50000;
  inicioPrueba = millis();
  palitos = 5;
  zoomAbierto = -1;
  respuestaUser = "";
  RespuestaIncorrecta = false;
  fallosP1 = 0;
  pistasVistasP1 = 0;
  for (int z = 0; z < cantidadZonas; z++) {
    pistaVistaP1[z] = false;
    inicioPistaP1[z] = -10000;
    lapizSonoP1[z] = false;
  }
  zonaAnteriorP1 = -1;
  sonoFlashP1 = false;
  mensajePrueba = "";

  empezarAmbientePrueba();
  empezarTelonCompleto();   // el telon sale del todo: la foto ocupa toda la pantalla
  empezarGuia(titulosGuiaP1, textosGuiaP1, zonasGuiaP1, cantidadPasosGuiaP1);
}


// lo comun de las pantallas 9 y 11: exposicion, latidos de los ultimos segundos, barra de arriba y mensajes
void dibujarEfectosP1() {
  float tension = calcularTension();
  gotearExposicionPrueba();
  dibujarTension(tension);
  dibujarBarraSuperior(color(200, 30, 50));
  dibujarMensajePrueba();
}


// CUADERNO DE PISTAS: hoja de libreta abajo a la izquierda; cada pista nueva se escribe letra por letra con el sonido del lapiz
// (sin girar: el texto girado se ve dentado; el nombre y la pista van juntos en un solo parrafo de 3 lineas como maximo)
void dibujarCuadernoP1() {
  float e = width / 1920.0;

  float hojaX = 30 * e;
  float hojaY = 700 * e;

  // la hoja, con espiral arriba y renglones
  noStroke();
  fill(0, 110);
  rect(hojaX + 6 * e, hojaY + 8 * e, 500 * e, 350 * e, 8 * e);
  fill(246, 238, 220);
  rect(hojaX, hojaY, 500 * e, 350 * e, 8 * e);
  stroke(190, 205, 230);
  strokeWeight(1.5 * e);
  for (int renglon = 0; renglon < 4; renglon++) {
    line(hojaX + 14 * e, hojaY + (106 + renglon * 64) * e, hojaX + 486 * e, hojaY + (106 + renglon * 64) * e);
  }
  stroke(90);
  strokeWeight(3 * e);
  noFill();
  for (int aro = 0; aro < 10; aro++) {
    ellipse(hojaX + (30 + aro * 49) * e, hojaY, 14 * e, 18 * e);
  }

  // titulo y cuantas zonas van revisadas
  noStroke();
  fill(140, 25, 40);
  textFont(fuente);
  textAlign(LEFT, CENTER);
  textSize(28 * e);
  text("Cuaderno de pistas", hojaX + 20 * e, hojaY + 34 * e);
  textAlign(RIGHT, CENTER);
  textSize(24 * e);
  text(pistasVistasP1 + " de 4", hojaX + 480 * e, hojaY + 34 * e);

  // una pista por zona (cada una ocupa 64 px: caben 3 lineas de 18 px); sin revisar, con puntitos
  textSize(18 * e);
  textAlign(LEFT, TOP);
  for (int z = 0; z < cantidadZonas; z++) {
    float pistaY = hojaY + (66 + z * 64) * e;
    if (!pistaVistaP1[z]) {
      fill(150, 140, 125);
      text(nombrePistaP1[z] + ": . . . . . . . . . .", hojaX + 20 * e, pistaY, 460 * e, 60 * e);
    } else {
      int pasadoPista = millis() - inicioPistaP1[z];
      int letras = constrain(pasadoPista / 28, 0, textoPistaP1[z].length());
      if (pasadoPista >= 0 && !lapizSonoP1[z]) {
        sonidosCargadosSample[32].trigger();   // lapiz
        lapizSonoP1[z] = true;
      }

      // la pista nueva brilla un momento
      if (pasadoPista >= 0 && pasadoPista < 1500) {
        fill(255, 220, 90, 90 * (1 - pasadoPista / 1500.0));
        rect(hojaX + 10 * e, pistaY - 4 * e, 480 * e, 62 * e, 6 * e);
      }

      // la pista se escribe completa en su caja; las letras que faltan no se dibujan
      fill(45, 35, 30);
      String completa = nombrePistaP1[z] + ": " + textoPistaP1[z];
      int largoNombre = nombrePistaP1[z].length() + 2;
      text(completa.substring(0, min(completa.length(), largoNombre + letras)), hojaX + 20 * e, pistaY, 460 * e, 60 * e);
    }
  }
  strokeWeight(1);
}


// el cursor del mouse dibujado como una lupa (aro, vidrio y mango)
void dibujarCursorLupaP1() {
  float e = width / 1920.0;
  pushMatrix();
  translate(mouseX, mouseY);
  stroke(20, 10, 8);
  strokeWeight(10 * e);
  line(20 * e, 20 * e, 46 * e, 46 * e);
  stroke(120, 60, 35);
  strokeWeight(6 * e);
  line(22 * e, 22 * e, 44 * e, 44 * e);
  fill(255, 255, 255, 35);
  stroke(20);
  strokeWeight(5 * e);
  ellipse(0, 0, 44 * e, 44 * e);
  noFill();
  stroke(255, 200, 0);
  strokeWeight(2 * e);
  ellipse(0, 0, 36 * e, 36 * e);
  stroke(255, 150);
  arc(0, 0, 26 * e, 26 * e, PI + 0.4, PI + 1.3);
  popMatrix();
  strokeWeight(1);
}


// gana: 6 por resolverla + hasta 2 por el tiempo que sobro + 2 si fue a la primera (maximo 10)
void ganarP1() {
  int restante = max(0, duracionPrueba - (millis() - inicioPrueba));
  int puntosTiempo = (2 * restante + duracionPrueba / 2) / duracionPrueba;
  int puntosPrimera = 0;
  if (fallosP1 == 0) {
    puntosPrimera = 2;
  }
  lineaTexto[0] = "Misterio resuelto";
  lineaPuntos[0] = 6;
  lineaTexto[1] = "Tiempo que sobró";
  lineaPuntos[1] = puntosTiempo;
  lineaTexto[2] = "A la primera";
  lineaPuntos[2] = puntosPrimera;
  cantidadLineas = 3;

  puntosGanadosP1 = 6 + puntosTiempo + puntosPrimera;
  puntosJugador += puntosGanadosP1;
  subirExposicion(-5);
  resultadoActo1[0] = 1;   // prueba 1 ganada: ya no se puede repetir
  if (fallosP1 == 0) {
    ganarLogro(0);
  }
  revisarLogrosActos();
  if (pruebasCompletadasActo1 == 0) {
    pruebasCompletadasActo1 = 1;
  }
  llenarResultadoP1(true);
  empezarResultado(true);
  pantalla = 13;
}


// pierde: 1 punto por cada zona revisada (maximo 4); el dato se filtra
void perderP1(int motivo) {
  motivoDerrotaP1 = motivo;
  puntosGanadosP1 = pistasVistasP1;
  lineaTexto[0] = "Zonas revisadas";
  lineaPuntos[0] = puntosGanadosP1;
  cantidadLineas = 1;
  puntosJugador += puntosGanadosP1;

  respuestaUser = "";
  zoomAbierto = -1;
  resultadoActo1[0] = 2;
  if (pruebasCompletadasActo1 == 0) {
    pruebasCompletadasActo1 = 1;
  }
  filtrarDato(0);
  llenarResultadoP1(false);
  empezarResultado(false);
  pantalla = 12;
}


// el tiempo se acabo (lo llama el contador)
void tiempoAgotadoP1() {
  perderP1(0);
}


// textos de la pantalla de resultado de la prueba 1
void llenarResultadoP1(boolean gano) {
  tituloResultado = "Se acabó el tiempo";
  if (motivoDerrotaP1 == 2) {
    tituloResultado = "Te quedaste sin palitos";
  }
  subtituloResultado = "La foto guardó su secreto.";
  selloIlustracion = "SIN RESOLVER";
  if (gano) {
    tituloResultado = "Prueba superada";
    subtituloResultado = "Descubriste que la foto no es lo que parece.";
    selloIlustracion = "RESUELTA";
  }
  explicacionIlustracion = "En el espejo se ven la puerta y el escritorio\ndesde un ángulo imposible para la cámara.";
  fraseVidaReal = "Una foto de tu cuarto muestra más de lo que crees: dónde duermes, a qué hora y qué hay en tu escritorio.";
  consejoVidaReal = "Antes de publicar, revisa el fondo de la foto: reflejos, ventanas, relojes y objetos también hablan de ti.";
  datoResultado = 0;
  ilustracionResultado = 1;
  puntosResultado = puntosGanadosP1;
}


// la foto de la habitacion en la pantalla de resultado, como una polaroid (centrada en 0, 0 del resultado)
void dibujarFotoResultadoP1() {
  float e = width / 1920.0;
  noStroke();
  fill(0, 90);
  rect(-222 * e, -142 * e, 450 * e, 300 * e, 6 * e);
  fill(245, 240, 228);
  rect(-228 * e, -150 * e, 450 * e, 300 * e, 6 * e);
  image(imagenesCargadas[36], -214 * e, -136 * e, 422 * e, 238 * e);
}
