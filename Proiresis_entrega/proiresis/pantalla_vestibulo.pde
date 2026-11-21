// PANTALLA 3 - VESTIBULO (con los ajustes y el tocadiscos)

// BOTONES: cada boton es x, y, ancho, alto
float[] botonPuerta = new float[4];  // vestibulo (tambien en: setup)

float[] botonLogros = new float[4];  // vestibulo: la vitrina (tambien en: setup)

float[] botonOpciones = new float[4];  // vestibulo: el engranaje (tambien en: setup)

float[] botonVolver_Opciones = new float[4];  // ajustes (tambien en: setup)

float[] botonRestaurar = new float[4];  // ajustes (tambien en: setup)

float[] botonTocaVinilo = new float[4];  // vestibulo (tambien en: setup)

float[] botonVolver_Vestibulo = new float[4];  // vestibulo (tambien en: setup)

float[] botonVolver_TocaVinilo = new float[4];  // tocadiscos (tambien en: setup)

float[] botonAnterior = new float[4];  // tocadiscos (tambien en: setup)

float[] botonSiguiente = new float[4];  // tocadiscos (tambien en: setup)

float[] botonPlay = new float[4];  // tocadiscos (tambien en: setup)

// VARIABLES PARA VENTANAS DEL VESTIBULO
boolean mostrarAjustes = false;  // true mientras se ven los ajustes
boolean mostrarTocaVinilo = false;  // true mientras se ve el tocadiscos

// VARIABLES PARA EL TEXTO DE SELECCION
String textoSeleccion = "";  // texto de la zona seleccionada
String textoMostrando = "";  // texto que se esta mostrando
float opacidadTextoSeleccion = 0;  // transparencia del texto

String textoAviso = "";  // mensaje de los ajustes
float opacidadAviso = 0;  // transparencia del mensaje
boolean mostrarAviso = false;  // true mientras se ve el mensaje
int tiempoAviso = 0;  // cuadros que lleva el mensaje

// VOLUMEN SONIDO
float volumenAmbiente = -15;  // volumen en decibelios (tambien en: carga)
float porcentajeAmbiente = 100;  // porcentaje de la barra (tambien en: carga)

float volumenEfectos = 0;  // tambien en: carga
float porcentajeEfectos = 85.7;  // tambien en: carga

float volumenMusica = 0;  // tambien en: carga
float porcentajeMusica = 85.7;  // tambien en: carga

// VARIABLES PARA BARRAS DE AJUSTES
// posicion de las barras
float xBarraAmbiente;  // tambien en: setup
float yBarraAmbiente;  // tambien en: setup

float xBarraEfectos;  // tambien en: setup
float yBarraEfectos;  // tambien en: setup

float xBarraMusica;  // tambien en: setup
float yBarraMusica;  // tambien en: setup

// true mientras se arrastra la barra
boolean arrastrandoAmbiente = false;
boolean arrastrandoEfectos = false;
boolean arrastrandoMusica = false;

// VARIABLES PARA BARRA DE CANCION
float xBarraCancion;  // tambien en: setup
float yBarraCancion;  // tambien en: setup

boolean arrastrandoCancion = false;

boolean reproduciendo = false;  // true si esta sonando (tambien en: iniciar partida, menu)
float rotacionVinilo = 0;  // angulo del disco

int cancionActual = 0;  // indice de la cancion actual (tambien en: iniciar partida, menu)
float progresoCancion;  // ancho de la barra de progreso
int posicionPrevisualizada = 0;  // posicion mientras se arrastra


// 3 - VESTIBULO
void dibujarVestibulo() {
  background(0);

  image(imagenesCargadas[1],
    0,
    0,
    width,
    height);

  // zona bajo el mouse: imagen iluminada y texto
  if (!mostrarAjustes && !mostrarTocaVinilo && !mostrarLogros) {

    // se vacia y se llena si hay zona
    textoSeleccion = "";

    if (mouseX > botonPuerta[0] &&  // puerta (el arco)
      mouseX < botonPuerta[0] + botonPuerta[2] &&
      mouseY > botonPuerta[1] &&
      mouseY < botonPuerta[1] + botonPuerta[3]) {

      image(imagenesCargadas[11],
        0,
        0,
        width,
        height);

      textoSeleccion = "Entrar al teatro";
    } else {
      if (mouseX > botonLogros[0] &&  // logros (la vitrina)
        mouseX < botonLogros[0] + botonLogros[2] &&
        mouseY > botonLogros[1] &&
        mouseY < botonLogros[1] + botonLogros[3]) {

        image(imagenesCargadas[12],
          0,
          0,
          width,
          height);

        textoSeleccion = "Ver logros";
      } else {
        if (mouseX > botonOpciones[0] &&  // opciones (el engranaje se ilumina abajo)
          mouseX < botonOpciones[0] + botonOpciones[2] &&
          mouseY > botonOpciones[1] &&
          mouseY < botonOpciones[1] + botonOpciones[3]) {

          textoSeleccion = "Ver opciones";
        } else {
          if (mouseX > botonTocaVinilo[0] &&  // tocadiscos
            mouseX < botonTocaVinilo[0] + botonTocaVinilo[2] &&
            mouseY > botonTocaVinilo[1] &&
            mouseY < botonTocaVinilo[1] + botonTocaVinilo[3]) {

            image(imagenesCargadas[15],
              0,
              0,
              width,
              height);

            textoSeleccion = "Escuchar vinilo";
          } else {
            if (mouseX > botonVolver_Vestibulo[0] &&  // volver (la puerta de la derecha)
              mouseX < botonVolver_Vestibulo[0] + botonVolver_Vestibulo[2] &&
              mouseY > botonVolver_Vestibulo[1] &&
              mouseY < botonVolver_Vestibulo[1] + botonVolver_Vestibulo[3]) {

              image(imagenesCargadas[16],
                0,
                0,
                width,
                height);
              textoSeleccion = "Volver al menú";
            }
          }
        }
      }
    }

    // el engranaje de opciones (dorado si el mouse esta encima)
    dibujarEngranajeVestibulo(textoSeleccion.equals("Ver opciones"));



    // el texto aparece y se desvanece poco a poco
    if (!textoSeleccion.equals("")) {

      if (opacidadTextoSeleccion < 255) {
        textoMostrando = textoSeleccion;
        opacidadTextoSeleccion = min(opacidadTextoSeleccion + 5, 255);
      }
    } else {

      if (opacidadTextoSeleccion > 0) {
        opacidadTextoSeleccion = max(opacidadTextoSeleccion - 5, 0);
      }
    }

    // franja y texto de abajo
    noStroke();
    fill(0, opacidadTextoSeleccion * 0.5);
    rect(width/2 - 200, height - 97, 400, 70);

    fill(255, opacidadTextoSeleccion);

    textFont(fuente);
    textAlign(CENTER);
    textSize(45);

    text(textoMostrando,
      width/2,
      height - 50);
  }

  // AJUSTES
  if (mostrarAjustes) {

    fill(0, 150);
    noStroke();
    rect(0, 0, width, height);


    fill(20, 20, 20);
    rect(width/2-320, height/2-350, 640, 700);


    noFill();
    stroke(255);
    strokeWeight(3);
    rect(width/2-320, height/2-350, 640, 700);


    fill(255);
    textFont(fuente);
    textAlign(CENTER);
    textSize(45);

    text("OPCIONES",
      width/2,
      height/2-275);


    textSize(30);

    text("Ambiente",
      width/2,
      height/2-200);


    text("Efectos",
      width/2,
      height/2 - 90);

    text("Música",
      width/2,
      height/2 + 20);

    fill(255);
    textAlign(CENTER);
    textSize(25);


    // restablecer: amarillo si el mouse esta encima
    if (mouseX > botonRestaurar[0] && mouseX < botonRestaurar[0] + botonRestaurar[2] && mouseY > botonRestaurar[1] && mouseY < botonRestaurar[1] + botonRestaurar[3]) {
      fill(255, 200, 0);
      textSize(33);
    } else {
      fill(255);
      textSize(28);
    }
    text("RESTABLECER VALORES",
      width/2,
      height/2 + 220);


    if (mouseX > botonVolver_Opciones[0] && mouseX < botonVolver_Opciones[0] + botonVolver_Opciones[2] && mouseY > botonVolver_Opciones[1] && mouseY < botonVolver_Opciones[1] + botonVolver_Opciones[3]) {
      fill(255, 200, 0);
      textSize(40);
    } else {
      fill(255);
      textSize(35);
    }
    text("Volver",
      width/2,
      height/2 + 280);
    textSize(30);

    // aviso: 2 segundos y se desvanece
    if (mostrarAviso) {

      fill(255, opacidadAviso);

      textFont(fuente);
      textAlign(CENTER);
      textSize(25);

      text(textoAviso,
        width/2,
        height/2+150);

      if (tiempoAviso >= 120) {
        opacidadAviso = max(opacidadAviso - 4, 0);
      }

      tiempoAviso++;

      if (opacidadAviso <= 0) {
        mostrarAviso = false;
        tiempoAviso = 0;
      }
    }


    // BARRA DE AMBIENTE

    fill(80);
    rect(xBarraAmbiente,
      yBarraAmbiente,
      300,
      10);



    fill(255, 200, 0);

    rect(xBarraAmbiente,
      yBarraAmbiente,
      map(porcentajeAmbiente, 0, 100, 0, 300),
      10);



    fill(255);
    ellipse(
      xBarraAmbiente + map(porcentajeAmbiente, 0, 100, 0, 300),
      yBarraAmbiente + 5,
      20,
      20
      );

    textAlign(LEFT, CENTER);
    text(int(porcentajeAmbiente) + "%",
      xBarraAmbiente + 315,
      yBarraAmbiente + 5);


    // BARRA DE EFECTOS


    fill(80);

    rect(xBarraEfectos,
      yBarraEfectos,
      300,
      10);



    fill(255, 200, 0);

    rect(xBarraEfectos,
      yBarraEfectos,
      map(porcentajeEfectos, 0, 100, 0, 300),
      10);



    fill(255);

    ellipse(
      xBarraEfectos + map(porcentajeEfectos, 0, 100, 0, 300),
      yBarraEfectos + 5,
      20,
      20);

    textAlign(LEFT, CENTER);
    text(int(porcentajeEfectos) + "%",
      xBarraEfectos + 315,
      yBarraEfectos + 5);


    // BARRA DE MUSICA


    fill(80);

    rect(xBarraMusica,
      yBarraMusica,
      300,
      10);


    fill(255, 200, 0);

    rect(xBarraMusica,
      yBarraMusica,
      map(porcentajeMusica, 0, 100, 0, 300),
      10);


    fill(255);

    ellipse(
      xBarraMusica + map(porcentajeMusica, 0, 100, 0, 300),
      yBarraMusica + 5,
      20,
      20);

    textAlign(LEFT, CENTER);
    text(int(porcentajeMusica) + "%",
      xBarraMusica + 315,
      yBarraMusica + 5);


    // arrastre: el porcentaje sale del mouse
    if (arrastrandoAmbiente) {

      porcentajeAmbiente = map(mouseX,
        xBarraAmbiente,
        xBarraAmbiente+300,
        0,
        100);


      porcentajeAmbiente = constrain(porcentajeAmbiente, 0, 100);  // entre 0 y 100


      volumenAmbiente = map(porcentajeAmbiente,  // porcentaje a decibelios
        0,
        100,
        -60,
        10);


      for (int i = 0; i < cantidadSonidosAmbiente; i++) {

        sonidosCargadosAmbiente[i].setGain(volumenAmbiente);
      }
    }

    if (arrastrandoEfectos) {

      porcentajeEfectos = map(mouseX,
        xBarraEfectos,
        xBarraEfectos + 300,
        0,
        100);


      porcentajeEfectos = constrain(porcentajeEfectos, 0, 100);


      volumenEfectos = map(porcentajeEfectos,
        0,
        100,
        -60,
        10);


      for (int i = 0; i < cantidadSonidosSample; i++) {

        sonidosCargadosSample[i].setGain(volumenEfectos);
      }
    }

    if (arrastrandoMusica) {

      porcentajeMusica = map(mouseX,
        xBarraMusica,
        xBarraMusica + 300,
        0,
        100);


      porcentajeMusica = constrain(porcentajeMusica, 0, 100);


      volumenMusica = map(porcentajeMusica,
        0,
        100,
        -60,
        10);


      for (int i = 0; i < cantidadCanciones; i++) {

        sonidosCargadosMusica[i].setGain(volumenMusica);
      }
    }
  }

  // TOCADISCOS
  if (mostrarTocaVinilo) {


    fill(0, 150);
    noStroke();
    rect(0, 0, width, height);



    fill(20);
    stroke(255);
    strokeWeight(3);
    rect(width/2-350,
      height/2-260,
      700,
      520);




    fill(255);
    textAlign(CENTER);
    textSize(35);

    text("TOCADISCOS",
      width/2,
      height/2-190);


    text(
      nombresCanciones[cancionActual],
      width*0.5484375,
      height*0.438703703704
      );

    if (mouseX > botonPlay[0] &&
      mouseX < botonPlay[0] + botonPlay[2] &&
      mouseY > botonPlay[1] &&
      mouseY < botonPlay[1] + botonPlay[3]) {

      tint(255, 200, 0);
      if (reproduciendo) {

        image(imagenesCargadas[21],
          botonPlay[0]-4,
          botonPlay[1]-4,
          botonPlay[2]+8,
          botonPlay[3]+8);
      } else {
        image(imagenesCargadas[20],
          botonPlay[0]-4,
          botonPlay[1]-4,
          botonPlay[2]+8,
          botonPlay[3]+8);
      }
    } else {
      tint(255);
      if (reproduciendo) {

        image(imagenesCargadas[21],
          botonPlay[0],
          botonPlay[1],
          botonPlay[2],
          botonPlay[3]);
      } else {
        image(imagenesCargadas[20],
          botonPlay[0],
          botonPlay[1],
          botonPlay[2],
          botonPlay[3]);
      }
    }


    if (mouseX > botonAnterior[0] &&
      mouseX < botonAnterior[0] + botonAnterior[2] &&
      mouseY > botonAnterior[1] &&
      mouseY < botonAnterior[1] + botonAnterior[3]) {

      tint(255, 200, 0);
      image(imagenesCargadas[19],
        botonAnterior[0] -4,
        botonAnterior[1] -4,
        botonAnterior[2] +8,
        botonAnterior[3] +8);
    } else {
      tint(255);
      image(imagenesCargadas[19],
        botonAnterior[0],
        botonAnterior[1],
        botonAnterior[2],
        botonAnterior[3]);
    }


    if (mouseX > botonSiguiente[0] &&
      mouseX < botonSiguiente[0] + botonSiguiente[2] &&
      mouseY > botonSiguiente[1] &&
      mouseY < botonSiguiente[1] + botonSiguiente[3]) {

      tint(255, 200, 0);
      image(imagenesCargadas[18],
        botonSiguiente[0] -4,
        botonSiguiente[1] -4,
        botonSiguiente[2] +8,
        botonSiguiente[3] +8);
    } else {
      tint(255);
      image(imagenesCargadas[18],
        botonSiguiente[0],
        botonSiguiente[1],
        botonSiguiente[2],
        botonSiguiente[3]);
    }
    tint(255);




    if (mouseX > botonVolver_TocaVinilo[0] &&
      mouseX < botonVolver_TocaVinilo[0] + botonVolver_TocaVinilo[2] &&
      mouseY > botonVolver_TocaVinilo[1] &&
      mouseY < botonVolver_TocaVinilo[1] + botonVolver_TocaVinilo[3]) {

      fill(255, 200, 0);
      textSize(40);
    } else {
      fill(255);
      textSize(35);
    }


    text("Volver",
      width/2,
      height/2+210);

    pushMatrix();

    translate(width*0.394270833333, height*0.432407407407);

    rotate(rotacionVinilo);

    image(imagenesCargadas[17],
      -80,
      -80,
      160,
      160);

    popMatrix();


    // gira solo si esta sonando
    if (reproduciendo) {

      rotacionVinilo += 0.05;
    }

    // progreso de la cancion
    progresoCancion = map(
      sonidosCargadosMusica[cancionActual].position(),
      0,
      sonidosCargadosMusica[cancionActual].length(),
      0,
      360
      );


    fill(80);
    rect(xBarraCancion,
      yBarraCancion,
      360,
      15,
      10);


    float anchoBarraCancion =  map(posicionPrevisualizada, 0, sonidosCargadosMusica[cancionActual].length(), 0, 360);
    anchoBarraCancion = constrain(anchoBarraCancion, 0, 360);

    fill(255);
    if (arrastrandoCancion) {
      rect(xBarraCancion,
        yBarraCancion,
        anchoBarraCancion,
        15,
        10);

      rect(xBarraCancion + anchoBarraCancion - 5,
        yBarraCancion - 5,
        10,
        25,
        5);
    } else {
      rect(xBarraCancion,
        yBarraCancion,
        progresoCancion,
        15,
        10);

      rect(xBarraCancion + progresoCancion - 5,
        yBarraCancion - 5,
        10,
        25,
        5);
    }


    // posicion mientras se arrastra
    if (arrastrandoCancion) {

      posicionPrevisualizada = (int)map(
        mouseX,
        xBarraCancion,
        xBarraCancion + 360,
        0,
        sonidosCargadosMusica[cancionActual].length()
        );
      posicionPrevisualizada = constrain(posicionPrevisualizada, 0, sonidosCargadosMusica[cancionActual].length());
    }

    int tiempoActual;

    if (arrastrandoCancion) {

      tiempoActual = posicionPrevisualizada / 1000;
    } else {

      tiempoActual = sonidosCargadosMusica[cancionActual].position()/1000;
    }

    int minutos = tiempoActual/60;  // minutos

    int segundos = tiempoActual%60;  // segundos

    textSize(30);
    text(
      nf(minutos, 1) + ":" + nf(segundos, 2),
      width/2 + 210,
      height/2+140
      );
  }
  // pasa a la siguiente cancion al terminar
  if (reproduciendo && !sonidosCargadosMusica[cancionActual].isPlaying()) {

    sonidosCargadosMusica[cancionActual].pause();
    sonidosCargadosMusica[cancionActual].rewind();

    cancionActual++;

    if (cancionActual >= cantidadCanciones) {
      cancionActual = 0;
    }

    sonidosCargadosMusica[cancionActual].rewind();
    sonidosCargadosMusica[cancionActual].play();
  }
}


// clic en la pantalla 3
// VESTIBULO
void clicVestibulo() {
  // con el panel de logros abierto, el clic solo lo cierra
  if (mostrarLogros) {
    clicLogros();
    return;
  }
  if (!mostrarAjustes && !mostrarTocaVinilo && !mostrarLogros) {

    // el tocadiscos tapa parte de la puerta: ahi el clic es para el tocadiscos
    boolean sobreTocadiscos = mouseX > botonTocaVinilo[0] &&
      mouseX < botonTocaVinilo[0] + botonTocaVinilo[2] &&
      mouseY > botonTocaVinilo[1] &&
      mouseY < botonTocaVinilo[1] + botonTocaVinilo[3];

    if (!sobreTocadiscos &&
      mouseX > botonVolver_Vestibulo[0] &&
      mouseX < botonVolver_Vestibulo[0] + botonVolver_Vestibulo[2] &&
      mouseY > botonVolver_Vestibulo[1] &&
      mouseY < botonVolver_Vestibulo[1] + botonVolver_Vestibulo[3]) {

      sonidosCargadosMusica[cancionActual].pause();

      pantalla = 2;
    }


    if (mouseX > botonPuerta[0] &&
      mouseX < botonPuerta[0] + botonPuerta[2] &&
      mouseY > botonPuerta[1] &&
      mouseY < botonPuerta[1] + botonPuerta[3]) {

      sonidosCargadosMusica[cancionActual].pause();

      pantalla = 4;
    }


    if (mouseX > botonOpciones[0] &&
      mouseX < botonOpciones[0] + botonOpciones[2] &&
      mouseY > botonOpciones[1] &&
      mouseY < botonOpciones[1] + botonOpciones[3]) {

      mostrarAjustes = true;
    }


    if (mouseX > botonLogros[0] &&
      mouseX < botonLogros[0] + botonLogros[2] &&
      mouseY > botonLogros[1] &&
      mouseY < botonLogros[1] + botonLogros[3]) {

      mostrarLogros = true;
      inicioPanelLogros = millis();
      sonidosCargadosSample[3].trigger();
    }


    if (mouseX > botonTocaVinilo[0] &&
      mouseX < botonTocaVinilo[0] + botonTocaVinilo[2] &&
      mouseY > botonTocaVinilo[1] &&
      mouseY < botonTocaVinilo[1] + botonTocaVinilo[3]) {

      mostrarTocaVinilo = true;
    }
  } else {
    if (mostrarAjustes) {  // ajustes abiertos

      if (mouseX > botonVolver_Opciones[0] &&
        mouseX < botonVolver_Opciones[0] + botonVolver_Opciones[2] &&
        mouseY > botonVolver_Opciones[1] &&
        mouseY < botonVolver_Opciones[1] + botonVolver_Opciones[3]) {

        mostrarAjustes = false;
      }

      if (botonRestaurar[0] < mouseX &&
        mouseX < botonRestaurar[0] + botonRestaurar[2] &&
        botonRestaurar[1] < mouseY &&
        mouseY < botonRestaurar[1] + botonRestaurar[3]) {

        porcentajeAmbiente = 100;
        porcentajeEfectos = 85.7;
        porcentajeMusica = 85.7;

        textoAviso = "Valores restablecidos.";

        opacidadAviso = 255;

        mostrarAviso = true;

        volumenAmbiente = map(porcentajeAmbiente, 0, 100, -60, 10);
        volumenEfectos = map(porcentajeEfectos, 0, 100, -60, 10);
        volumenMusica = map(porcentajeMusica, 0, 100, -60, 10);

        for (int i = 0; i < cantidadSonidosSample; i++) {
          sonidosCargadosSample[i].setGain(volumenEfectos);
        }

        for (int i = 0; i < cantidadSonidosAmbiente; i++) {
          sonidosCargadosAmbiente[i].setGain(volumenAmbiente);
        }

        for (int i = 0; i < cantidadCanciones; i++) {
          sonidosCargadosMusica[i].setGain(volumenMusica);
        }
      }
    } else {
      if (mostrarTocaVinilo) {  // tocadiscos abierto

        if (mouseX > botonVolver_TocaVinilo[0] &&
          mouseX < botonVolver_TocaVinilo[0] + botonVolver_TocaVinilo[2] &&
          mouseY > botonVolver_TocaVinilo[1] &&
          mouseY < botonVolver_TocaVinilo[1] + botonVolver_TocaVinilo[3]) {

          mostrarTocaVinilo = false;
        }

        if (mouseX > botonSiguiente[0] &&
          mouseX < botonSiguiente[0] + botonSiguiente[2] &&
          mouseY > botonSiguiente[1] &&
          mouseY < botonSiguiente[1] + botonSiguiente[3]) {



          sonidosCargadosMusica[cancionActual].pause();

          sonidosCargadosMusica[cancionActual].rewind();



          cancionActual++;


          if (cancionActual >= cantidadCanciones) {

            cancionActual = 0;
          }

          sonidosCargadosMusica[cancionActual].play();
          reproduciendo = true;
        }

        if (mouseX > botonAnterior[0] &&
          mouseX < botonAnterior[0] + botonAnterior[2] &&
          mouseY > botonAnterior[1] &&
          mouseY < botonAnterior[1] + botonAnterior[3]) {


          sonidosCargadosMusica[cancionActual].pause();

          sonidosCargadosMusica[cancionActual].rewind();


          cancionActual--;


          if (cancionActual < 0) {

            cancionActual = cantidadCanciones - 1;
          }


          sonidosCargadosMusica[cancionActual].play();
          reproduciendo = true;
        }

        if (mouseX > botonPlay[0] &&
          mouseX < botonPlay[0]+botonPlay[2] &&
          mouseY > botonPlay[1] &&
          mouseY < botonPlay[1]+botonPlay[3]) {


          if (reproduciendo) {

            sonidosCargadosMusica[cancionActual].pause();

            reproduciendo = false;
          } else {

            sonidosCargadosMusica[cancionActual].play();

            reproduciendo = true;
          }
        }
      }
    }
  }
}


// empieza el arrastre de una barra
void mousePressed() {
  // con la consola abierta los clics no llegan al juego
  if (consolaAbierta) {
    return;
  }
  if (mostrarAjustes) {
    if (mouseX > xBarraAmbiente &&
      mouseX < xBarraAmbiente + 300 &&
      mouseY > yBarraAmbiente - 15 &&
      mouseY < yBarraAmbiente + 25) {

      arrastrandoAmbiente = true;
    }
    if (mouseX > xBarraEfectos &&
      mouseX < xBarraEfectos + 300 &&
      mouseY > yBarraEfectos - 15 &&
      mouseY < yBarraEfectos + 25) {

      arrastrandoEfectos = true;
    }
    if (mouseX > xBarraMusica &&
      mouseX < xBarraMusica + 300 &&
      mouseY > yBarraMusica - 15 &&
      mouseY < yBarraMusica + 25) {

      arrastrandoMusica = true;
    }
  }
  if (mostrarTocaVinilo) {
    if (mouseX > xBarraCancion &&
      mouseX < xBarraCancion + 360 &&
      mouseY > yBarraCancion &&
      mouseY < yBarraCancion + 15) {

      arrastrandoCancion = true;
    }
  }
  // prueba 4: agarra una pieza del tablero
  if (pantalla == 21) {
    presionarP4();
  }
  // prueba 8: agarra un candado o aplasta un rastreador
  if (pantalla == 37) {
    presionarP8();
  }
}

void mouseReleased() {

  arrastrandoAmbiente = false;
  arrastrandoEfectos = false;
  arrastrandoMusica = false;

  if (arrastrandoCancion) {

    sonidosCargadosMusica[cancionActual].cue(posicionPrevisualizada);
  }

  arrastrandoCancion = false;

  // prueba 4: suelta la pieza del tablero
  if (pantalla == 21) {
    soltarP4();
  }
  // prueba 8: suelta el candado
  if (pantalla == 37) {
    soltarP8();
  }
}


// ENGRANAJE DE OPCIONES (arriba a la derecha del vestibulo): 8 dientes alrededor de un circulo con un hueco
// con el mouse encima se pone dorado y gira
void dibujarEngranajeVestibulo(boolean encima) {
  float cx = botonOpciones[0] + botonOpciones[2] / 2;
  float cy = botonOpciones[1] + botonOpciones[3] / 2;
  float r = botonOpciones[2] * 0.32;
  noStroke();
  fill(0, 130);
  ellipse(cx, cy, botonOpciones[2] * 1.2, botonOpciones[2] * 1.2);
  fill(240, 225, 195);
  float giro = 0;
  if (encima) {
    fill(255, 200, 0);
    giro = millis() * 0.002;
  }
  pushMatrix();
  translate(cx, cy);
  rotate(giro);
  for (int diente = 0; diente < 8; diente++) {
    rotate(TWO_PI / 8);
    rect(-r * 0.28, -r * 1.35, r * 0.56, r * 0.6);
  }
  ellipse(0, 0, r * 2.1, r * 2.1);
  fill(40, 25, 20);
  ellipse(0, 0, r * 0.8, r * 0.8);
  popMatrix();
}
