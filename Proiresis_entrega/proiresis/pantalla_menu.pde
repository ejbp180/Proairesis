// PANTALLA 2 - MENU

//BOTONES
// cada boton: x, y, ancho, alto
float[] botonEntrar = new float[4];  // menu (tambien en: setup)
boolean sobreEntrar = false;  // true si el mouse ya estaba encima

float[] botonSalir = new float[4];  // menu (tambien en: setup)
boolean sobreSalir = false;

boolean confirmarSalida = false;  // true mientras se ve el cuadro de salir
int opcionSalida = 0; //0 = no, 1 = si

// MUSICA DEL MENU
boolean musicaMenuIniciada = false;  // true cuando ya suena la musica del menu


// 2 - MENU
void dibujarMenu() {
  background(0);

  // FONDO
  if (mouseX > botonSalir[0] && mouseX < botonSalir[0] + botonSalir[2] && mouseY > botonSalir[1] && mouseY < botonSalir[1] + botonSalir[3]) {

    image(imagenesCargadas[9], 0, 0, width, height);
  } else {
    if (mouseX > botonEntrar[0] && mouseX < botonEntrar[0] + botonEntrar[2] && mouseY > botonEntrar[1] && mouseY < botonEntrar[1] + botonEntrar[3]) {

      image(imagenesCargadas[4], 0, 0, width, height);
    } else {

      image(imagenesCargadas[0], 0, 0, width, height);
    }
  }

  boolean estaDentro_Entrar = mouseX > botonEntrar[0] && mouseX < botonEntrar[0] + botonEntrar[2] && mouseY > botonEntrar[1] && mouseY < botonEntrar[1] + botonEntrar[3];  // true si el mouse esta encima

  // BOTON ENTRAR

  // sonido al entrar y salir del boton
  if (estaDentro_Entrar && !sobreEntrar) {
    sonidosCargadosSample[0].trigger();

    sobreEntrar = true;
  } else {
    if (!estaDentro_Entrar && sobreEntrar) {
      sonidosCargadosSample[1].trigger();

      sobreEntrar = false;
    }
  }

  // mas grande si el mouse esta encima
  if (estaDentro_Entrar) {

    image(imagenesCargadas[8],
      botonEntrar[0] - 4,
      botonEntrar[1] - 4,
      botonEntrar[2] + 8,
      botonEntrar[3] + 8);
  } else {

    image(imagenesCargadas[7],
      botonEntrar[0],
      botonEntrar[1],
      botonEntrar[2],
      botonEntrar[3]);
  }


  boolean estaDentro_Salir = mouseX > botonSalir[0] && mouseX < botonSalir[0] + botonSalir[2] && mouseY > botonSalir[1] && mouseY < botonSalir[1] + botonSalir[3];  // true si el mouse esta encima

  // BOTON SALIR

  // sonido al entrar y salir del boton
  if (estaDentro_Salir && !sobreSalir) {
    sonidosCargadosSample[2].trigger();

    sobreSalir = true;
  } else {
    if (!estaDentro_Salir && sobreSalir) {
      sonidosCargadosSample[2].trigger();

      sobreSalir = false;
    }
  }

  // mas grande si el mouse esta encima
  if (estaDentro_Salir) {

    image(imagenesCargadas[6],
      botonSalir[0] - 1.5,
      botonSalir[1] - 1.5,
      botonSalir[2] + 3,
      botonSalir[3] + 3);
  } else {

    image(imagenesCargadas[5],
      botonSalir[0],
      botonSalir[1],
      botonSalir[2],
      botonSalir[3]);
  }

  // CONFIRMAR SALIDA

  if (confirmarSalida) {

    // oscurecer lo que ya existe
    fill(0, 150);
    noStroke();
    rect(0, 0, width, height);


    fill(20, 20, 20);
    rect(width/2-250, height/2-150, 500, 300);


    noFill();
    stroke(255);
    strokeWeight(3);
    rect(width/2-250, height/2-150, 500, 300);


    fill(255);
    textAlign(CENTER);
    textFont(fuente);
    textSize(35);

    text("¿Deseas abandonar el teatro?",
      width/2,
      height/2-50);



    // la opcion elegida en amarillo y mas grande
    if (opcionSalida == 0) {
      fill(255, 200, 0);
      textSize(30);
    } else {
      fill(255);
      textSize(25);
    }

    text("NO",
      width/2+100,
      height/2+50);



    if (opcionSalida == 1) {
      fill(255, 200, 0);
      textSize(30);
    } else {
      fill(255);
      textSize(25);
    }

    text("SI",
      width/2-100,
      height/2+50);
  }

  // musica del menu en bucle
  if (!musicaMenuIniciada) {

    sonidosCargadosAmbiente[0].loop();
    musicaMenuIniciada = true;
  }
}


// clic en la pantalla 2
// MENU
void clicMenu() {
  if (!confirmarSalida) {
    if (mouseX > botonEntrar[0] && mouseX < botonEntrar[0] + botonEntrar[2] && mouseY > botonEntrar[1] && mouseY < botonEntrar[1] + botonEntrar[3]) {
      sonidosCargadosAmbiente[0].pause();  // para la musica del menu
      musicaMenuIniciada = false;
      // si sonaba el tocadiscos, sigue
      if (reproduciendo) {
        sonidosCargadosMusica[cancionActual].play();
      }
      pantalla = 3;
    } else {
      if (mouseX > botonSalir[0] && mouseX < botonSalir[0] + botonSalir[2] && mouseY > botonSalir[1] && mouseY < botonSalir[1] + botonSalir[3]) {
        confirmarSalida = true;
        opcionSalida = 0;
      }
    }
  }
}


// teclas en la pantalla 2
// MENU
void teclaMenu() {
  if (confirmarSalida) {

    if (keyCode == LEFT || keyCode == RIGHT) {

      if (opcionSalida == 0) {
        opcionSalida = 1;
      } else {
        opcionSalida = 0;
      }
      sonidosCargadosSample[3].trigger();
    }


    if (keyCode == ENTER) {

      if (opcionSalida == 1) {
        exit();
      }

      if (opcionSalida == 0) {
        confirmarSalida = false;
      }
    }
  }
}
