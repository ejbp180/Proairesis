// PANTALLA 8 - BOTONES DEL ACTO 1

// BOTONES DEL ACTO 1
float[] boton1Acto1 = new float[4];  // tambien en: setup

float[] boton2Acto1 = new float[4];  // tambien en: setup

float[] boton3Acto1 = new float[4];  // tambien en: setup

float[] boton4Acto1 = new float[4];  // tambien en: setup

float[][] botonesActo1 = {boton1Acto1, boton2Acto1, boton3Acto1, boton4Acto1};  // los 4 botones juntos
int cantidadBotonesActo1 = 4;  // cantidad de botones del Acto 1

// nombre de cada prueba (mismo orden que los botones)
String[] nombresPruebasActo1 = {
  "La primera", // boton 1
  "Seis momentos", // boton 2
  "El símbolo", // boton 3
  "La fotografía que no existe" // boton 4
};

String avisoPruebaActo1 = ""; // nombre de la prueba que se pide completar al hacer clic en una bloqueada
String prefijoAvisoActo1 = "Para desbloquear esto completa: "; // texto del aviso (cambia si la prueba ya se jugo)
int[] resultadoActo1 = new int[4]; // resultado de cada prueba: 0 = sin jugar, 1 = ganada, 2 = perdida (tambien en: contador, prueba 1, prueba 2, prueba 3)
int inicioAvisoActo1 = -10000; // millis() del ultimo aviso (muy atras = ya no se ve)

int pruebasCompletadasActo1 = 0; // el boton 1 empieza desbloqueado; cada prueba completada desbloquea la siguiente (tambien en: contador, prueba 1, prueba 2, prueba 3)

int puntosJugador = 0;  // puntos del jugador (tambien en: prueba 1, prueba 2, prueba 3)


// 8 - ACTO I - BOTONES
// BOTONES DEL ACTO 1
void dibujarBotonesActo1() {
  background(0);
  image(imagenesCargadas[23], 0, 0, width, height);   // teatro con el mago (sin los huecos negros)
  // oscurecer fondo
  fill(0, 150);
  noStroke();
  rect(0, 0, width, height);

  // desbloqueados: indices 24 a 27 de imagenes[]; bloqueados: 30 a 33
  int seleccionado = -1; // boton con el mouse encima (-1 = ninguno)

  for (int i = 0; i < cantidadBotonesActo1; i++) {

    float[] b = botonesActo1[i];

    if (resultadoActo1[i] != 0) {

      // prueba ya jugada: no se dibuja y tampoco se puede seleccionar, queda el hueco negro del fondo
    } else {
      if (mouseX > b[0] && mouseX < b[0] + b[2] && mouseY > b[1] && mouseY < b[1] + b[3]) {

        // el seleccionado se dibuja despues, agrandado, para que quede encima de los demas
        seleccionado = i;
      } else {
        if (i <= pruebasCompletadasActo1) {
          image(imagenesCargadas[24 + i], b[0], b[1], b[2], b[3]);
        } else {
          image(imagenesCargadas[30 + i], b[0], b[1], b[2], b[3]);
        }
      }
    }
  }

  if (seleccionado >= 0) {

    float[] b = botonesActo1[seleccionado];

    // 6% mas grande, creciendo desde el centro
    float aumento = 0.06;
    float x = b[0] - b[2] * aumento / 2;
    float y = b[1] - b[3] * aumento / 2;
    float ancho = b[2] * (1 + aumento);
    float alto = b[3] * (1 + aumento);

    if (seleccionado <= pruebasCompletadasActo1) {
      image(imagenesCargadas[24 + seleccionado], x, y, ancho, alto);
    } else {
      image(imagenesCargadas[30 + seleccionado], x, y, ancho, alto);
    }

    // contorno
    noFill();
    stroke(255, 200, 0);
    strokeWeight(5);
    rect(x, y, ancho, alto, 15);

    // nombre de la prueba abajo, sobre una franja oscura del ancho del texto
    String nombre = nombresPruebasActo1[seleccionado];

    textFont(fuente);
    textSize(45);
    textAlign(CENTER);

    float anchoNombre = textWidth(nombre);

    noStroke();
    fill(0, 150);
    rect(width/2 - anchoNombre/2 - 30, height - 97, anchoNombre + 60, 70, 15);

    fill(255);
    text(nombre, width/2, height - 50);
  }

  // aviso de prueba bloqueada: 2 s completo y 1 s desvaneciendose
  int pasado = millis() - inicioAvisoActo1;

  if (pasado < 3000) {

    float opacidadAvisoActo1 = 255;

    if (pasado > 2000) {
      opacidadAvisoActo1 = map(pasado, 2000, 3000, 255, 0);
    }

    textFont(fuente);
    textSize(38);
    textAlign(LEFT);

    // el aviso se dibuja en dos tramos para poder pintar el nombre de otro color
    String textoAviso1 = prefijoAvisoActo1;

    float anchoTexto = textWidth(textoAviso1);
    float anchoNombreAviso = textWidth(avisoPruebaActo1);
    float anchoAviso = anchoTexto + anchoNombreAviso;
    float inicioAviso = width/2 - anchoAviso/2; // donde empieza el texto para quedar centrado

    noStroke();
    fill(0, opacidadAvisoActo1 * 0.6);
    rect(inicioAviso - 30, height * 0.08, anchoAviso + 60, 70, 15);

    fill(255, opacidadAvisoActo1);
    text(textoAviso1, inicioAviso, height * 0.08 + 48);

    fill(255, 200, 0, opacidadAvisoActo1);
    text(avisoPruebaActo1, inicioAviso + anchoTexto, height * 0.08 + 48);
  }

  // puntos del jugador, arriba a la derecha
  String etiquetaPuntos = "Puntos: ";
  String numeroPuntos = "" + puntosJugador;

  textFont(fuente);
  textSize(40);
  textAlign(LEFT);

  float anchoEtiquetaPuntos = textWidth(etiquetaPuntos);
  float anchoPuntos = anchoEtiquetaPuntos + textWidth(numeroPuntos);
  float inicioPuntos = width - anchoPuntos - 60;   // 60 px de margen con el borde derecho

  noStroke();
  fill(0, 150);
  rect(inicioPuntos - 30, 25, anchoPuntos + 60, 70, 15);

  fill(255);
  text(etiquetaPuntos, inicioPuntos, 73);

  fill(255, 200, 0);
  text(numeroPuntos, inicioPuntos + anchoEtiquetaPuntos, 73);

  strokeWeight(1);

  // boton para salir al vestibulo
  dibujarBotonSalirLobby();
}


// SALIR AL VESTIBULO: boton arriba a la izquierda en los botones de los 3 actos (pantallas 8, 26 y 36)
// la partida queda a medias y se continua desde la puerta del vestibulo ("Continuar partida")
boolean partidaEnCurso = false;   // true = hay una partida a medias (tambien en: pantalla iniciar, reiniciarPartida, resena)
int lobbyPartida = 8;             // pantalla de los botones del acto donde quedo: 8, 26 o 36

// true si el mouse esta encima del boton
boolean encimaSalirLobby() {
  float e = width / 1920.0;
  return mouseX > 40 * e && mouseX < 380 * e && mouseY > 25 * e && mouseY < 95 * e;
}

void dibujarBotonSalirLobby() {
  float e = width / 1920.0;
  boolean encima = encimaSalirLobby();
  pushStyle();
  noStroke();
  if (encima) {
    fill(0, 210);
  } else {
    fill(0, 150);
  }
  rect(40 * e, 25 * e, 340 * e, 70 * e);
  textFont(fuente);
  textSize(34 * e);
  textAlign(CENTER, CENTER);
  if (encima) {
    fill(255, 200, 0);
  } else {
    fill(255);
  }
  text("Salir al vestíbulo", 210 * e, 56 * e);
  popStyle();
}

// se llama al principio del clic de los botones de cada acto; devuelve true si se salio
boolean clicBotonSalirLobby() {
  if (!encimaSalirLobby()) {
    return false;
  }
  partidaEnCurso = true;
  lobbyPartida = pantalla;
  cursor(ARROW);
  sonidosCargadosSample[3].trigger();
  // si sonaba el tocadiscos, sigue (igual que al entrar desde el menu)
  if (reproduciendo) {
    sonidosCargadosMusica[cancionActual].play();
  }
  pantalla = 3;
  return true;
}


// clic en la pantalla 8
void clicBotonesActo1() {
  // el boton de salir al vestibulo va primero
  if (clicBotonSalirLobby()) {
    return;
  }
  // clic en un boton: la prueba desbloqueada entra a su contexto
  for (int i = 0; i < cantidadBotonesActo1; i++) {

    float[] b = botonesActo1[i];

    boolean encima = mouseX > b[0] && mouseX < b[0] + b[2] && mouseY > b[1] && mouseY < b[1] + b[3];

    if (encima && i <= pruebasCompletadasActo1) {

      // desbloqueado (pendiente o ya completado)
      if (resultadoActo1[i] != 0) {

        // la prueba ya se jugo (ganada o perdida): no se puede repetir, solo sale un aviso
        prefijoAvisoActo1 = "Esta prueba ya no se puede jugar";
        avisoPruebaActo1 = "";
        inicioAvisoActo1 = millis();
      } else {
        // las 4 pruebas primero pasan por la pantalla de contexto (10)
        pruebaActual = i;                     // 0 = prueba 1, 1 = prueba 2, 2 = prueba 3, 3 = prueba 4
        if (i == 0) {
          textosContexto = textosContextoP1;  // el contexto escribe los textos de la prueba que toca
          cantidadEscenasContexto = 3;
        }
        if (i == 1) {
          textosContexto = textosContextoP2;
          cantidadEscenasContexto = 3;
        }
        if (i == 2) {
          textosContexto = textosContextoP3;
          cantidadEscenasContexto = 3;
        }
        if (i == 3) {
          textosContexto = textosContextoP4;
          cantidadEscenasContexto = 3;
        }
        escenaContexto = 0;
        textoMostradoContexto = "";
        letraContexto = 0;
        tiempoLetraContexto = 0;
        textoContextoTerminado = false;
        contadorSonidoTeclaContexto = 0;
        opacidadEnter = 150;
        subirOpacidadEnter = true;
        pantalla = 10;
      }
    } else {
      if (encima && i > pruebasCompletadasActo1) {

        // bloqueado: se pide completar la prueba anterior a la que se pulso
        prefijoAvisoActo1 = "Para desbloquear esto completa: ";
        avisoPruebaActo1 = nombresPruebasActo1[i - 1];
        inicioAvisoActo1 = millis();
      }
    }
  }
}
