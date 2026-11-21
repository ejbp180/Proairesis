// PANTALLA 4 - INICIAR/CARGAR PARTIDA

// BOTONES: cada boton es x, y, ancho, alto
float[] botonNuevaPartida = new float[4];  // iniciar partida (tambien en: setup)

float[] botonCargarPartida = new float[4];  // continuar partida (tambien en: setup)

float[] botonVolverInicio = new float[4];  // iniciar partida (tambien en: setup)


// 4 - INICIAR/CARGAR PARTIDA
void dibujarIniciarPartida() {
  background(0);

  fill(255);

  textFont(fuente);
  textAlign(CENTER);

  textSize(60);

  text("INICIO", width/2, height*0.25);



  // NUEVA PARTIDA

  if (mouseX > botonNuevaPartida[0] &&
    mouseX < botonNuevaPartida[0]+botonNuevaPartida[2] &&
    mouseY > botonNuevaPartida[1] &&
    mouseY < botonNuevaPartida[1]+botonNuevaPartida[3]) {

    fill(255, 200, 0);
    textSize(40);
  } else {

    fill(255);
    textSize(35);
  }


  text("Nueva partida",
    width/2,
    height*0.40);



  // si hay una partida a medias, nueva partida la borra: se avisa debajo
  if (partidaEnCurso) {
    fill(160);
    textSize(20);
    text("Empieza de cero y borra la partida que llevas",
      width/2,
      height*0.40 + 38);
  }


  // CONTINUAR (solo se puede si saliste al vestibulo desde los botones de un acto)

  if (partidaEnCurso &&
    mouseX > botonCargarPartida[0] &&
    mouseX < botonCargarPartida[0]+botonCargarPartida[2] &&
    mouseY > botonCargarPartida[1] &&
    mouseY < botonCargarPartida[1]+botonCargarPartida[3]) {

    fill(255, 200, 0);
    textSize(40);
  } else {

    if (partidaEnCurso) {
      fill(255);
    } else {
      fill(90);   // apagado: no hay partida que continuar
    }
    textSize(35);
  }


  text("Continuar partida",
    width/2,
    height*0.53);



  // VOLVER
  if (mouseX > botonVolverInicio[0] &&
    mouseX < botonVolverInicio[0]+botonVolverInicio[2] &&
    mouseY > botonVolverInicio[1] &&
    mouseY < botonVolverInicio[1]+botonVolverInicio[3]) {

    fill(255, 200, 0);
    textSize(40);
  } else {

    fill(255);
    textSize(35);
  }

  text("Volver",
    width/2,
    height*0.66);
}


// clic en la pantalla 4
// INICIAR/CARGAR PARTIDA
void clicIniciarPartida() {
  if (mouseX > botonNuevaPartida[0] &&
    mouseX < botonNuevaPartida[0]+botonNuevaPartida[2] &&
    mouseY > botonNuevaPartida[1] &&
    mouseY < botonNuevaPartida[1]+botonNuevaPartida[3]) {

    // todo empieza de cero (introduccion, teatro, pruebas), aunque haya una partida a medias o una ya terminada
    reiniciarPartida(0);
    pantalla = 5;
  }

  // continuar: vuelve a los botones del acto donde quedo
  if (partidaEnCurso &&
    mouseX > botonCargarPartida[0] &&
    mouseX < botonCargarPartida[0]+botonCargarPartida[2] &&
    mouseY > botonCargarPartida[1] &&
    mouseY < botonCargarPartida[1]+botonCargarPartida[3]) {

    pantalla = lobbyPartida;
    inicioPantallaActo2 = millis();   // las tarjetas de los actos II y III vuelven a entrar animadas
    inicioPantallaActo3 = millis();
    sonidosCargadosSample[3].trigger();
  }

  if (mouseX > botonVolverInicio[0] &&
    mouseX < botonVolverInicio[0]+botonVolverInicio[2] &&
    mouseY > botonVolverInicio[1] &&
    mouseY < botonVolverInicio[1]+botonVolverInicio[3]) {

    pantalla = 3;

    if (reproduciendo) {
      sonidosCargadosMusica[cancionActual].play();
    }
  }
}
