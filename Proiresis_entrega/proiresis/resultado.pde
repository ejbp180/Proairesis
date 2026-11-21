// PANTALLA DE RESULTADO COMUN (ganar o perder cualquier prueba)
// cada prueba llena los textos de abajo, sus lineas de puntos y su ilustracion, y llama a empezarResultado()

// lo que cada prueba llena antes de empezarResultado()
String tituloResultado = "";             // "Prueba superada", "Se acabó el tiempo"...
String subtituloResultado = "";
String selloIlustracion = "";            // sello que cae sobre la ilustracion de la izquierda
String explicacionIlustracion = "";      // texto debajo de la ilustracion (puede llevar \n)
String fraseVidaReal = "";               // tarjeta "EN LA VIDA REAL"
String consejoVidaReal = "";
int datoResultado = 0;                   // numero del dato en juego (de datoEnJuego)
int ilustracionResultado = 0;            // que se dibuja a la izquierda: 2 = historia falsa, 3 = pulsera
int puntosResultado = 0;                 // total de puntos de la prueba
String[] lineaTexto = new String[4];     // desglose de puntos: texto y puntos de cada linea
int[] lineaPuntos = new int[4];
int cantidadLineas = 0;

// animacion
int inicioResultado = 0;                 // millis() en que empezo la pantalla de resultado
int puntosMostrados = 0;                 // puntos que ya se contaron en pantalla
int ultimoTic = 0;                       // millis() del ultimo punto contado (para que el numero lata)
boolean sonoSello1 = false;              // el sello de la ilustracion ya sono
boolean sonoSello2 = false;              // el sello del dato ya sono
boolean[] lineaSonada = new boolean[4];
float[] confX = new float[60];           // confeti: posicion, velocidad y giro de cada papelito
float[] confY = new float[60];
float[] confVel = new float[60];
float[] confGiro = new float[60];
int cantidadConfeti = 60;


// empieza la pantalla de resultado: sonido de ganar o perder, la musica se desvanece y se prepara el confeti
void empezarResultado(boolean gano) {
  telonAbreCompleto = false;   // en el resultado el telon queda recogido a los lados
  cursor(ARROW);
  inicioResultado = millis();
  puntosMostrados = 0;
  ultimoTic = -10000;
  sonoSello1 = false;
  sonoSello2 = false;
  for (int l = 0; l < 4; l++) {
    lineaSonada[l] = false;
  }
  for (int c = 0; c < cantidadConfeti; c++) {
    confX[c] = random(0, 1920);
    confY[c] = random(-700, -20);
    confVel[c] = random(3, 7);
    confGiro[c] = random(TWO_PI);
  }
  if (gano) {
    sonidosCargadosSample[14].trigger();   // arpegio de victoria
  } else {
    sonidosCargadosSample[15].trigger();   // notas que bajan
  }
  sonidosCargadosAmbiente[3].shiftGain(sonidosCargadosAmbiente[3].getGain(), -50, 1200);
  bajarMusicaA3();   // la musica del acto 3 tambien se desvanece
}


// true cuando el resultado ya termino de contar y sale "Presione ENTER para volver" (antes ENTER no hace nada)
boolean resultadoTerminado() {
  int inicioTotal = 2700 + cantidadLineas * 450 + 300;
  return millis() - inicioResultado > inicioTotal + puntosResultado * 60 + 300;
}


// sello que cae girando desde grande y se clava (dura 0,18 s desde que pasadoSello llega a 0); x, y en medidas de 1920
void dibujarSello(String texto, float x, float y, color colorSello, int pasadoSello, float giro) {
  if (pasadoSello > 0) {
    float e = width / 1920.0;
    float avance = constrain(pasadoSello / 180.0, 0, 1);
    float escala = lerp(2.6, 1, avance * avance);

    pushMatrix();
    translate(x * e, y * e);
    rotate(giro);
    scale(escala);
    textFont(fuente);
    textSize(54 * e);
    float anchoSello = textWidth(texto);
    noFill();
    stroke(colorSello, 255 * avance);
    strokeWeight(6 * e);
    rect(-anchoSello / 2 - 22 * e, -40 * e, anchoSello + 44 * e, 80 * e, 10 * e);
    noStroke();
    fill(colorSello, 255 * avance);
    textAlign(CENTER, CENTER);
    text(texto, 0, -4 * e);
    popMatrix();
    strokeWeight(1);
  }
}


// la pantalla (la misma para ganar y perder, cambian los colores y los sellos)
void dibujarResultado(boolean gano) {
  float e = width / 1920.0;
  int pasado = millis() - inicioResultado;

  // al perder, la pantalla se sacude cuando cae el titulo
  pushMatrix();
  if (!gano && pasado > 450 && pasado < 750) {
    translate(random(-8, 8) * e, random(-8, 8) * e);
  }

  background(26, 5, 8);
  noStroke();
  fill(255, 230, 235, 16);
  triangle(960 * e, 0, 300 * e, 1080 * e, 1620 * e, 1080 * e);
  dibujarCortinas(1, 1, 0);

  color colorTitulo = color(255, 110, 110);
  color colorSello = color(225, 40, 55);
  String selloDato = "FILTRADO";
  String antesDelDato = "Ahora la sombra sabe que:";
  if (gano) {
    colorTitulo = color(255, 210, 90);
    colorSello = color(255, 200, 0);
    selloDato = "PROTEGIDO";
    antesDelDato = "La sombra no pudo saber que:";
  }

  // TITULO: cae desde arriba y rebota (0 a 0,6 s), con una sombra detras
  float tituloY = lerp(-120, 150, reboteTelon(pasado / 600.0));
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(84 * e);
  fill(0, 140);
  text(tituloResultado, width / 2 + 5 * e, (tituloY + 6) * e);
  fill(colorTitulo);
  text(tituloResultado, width / 2, tituloY * e);

  // subtitulo que aparece despacio
  fill(255, 255 * constrain((pasado - 500) / 400.0, 0, 1));
  textSize(32 * e);
  text(subtituloResultado, width / 2, 235 * e);

  // ILUSTRACION a la izquierda: entra deslizandose y girando; despues le cae el sello
  float entraIlustracion = reboteTelon((pasado - 300) / 700.0);
  pushMatrix();
  translate(lerp(-400, 560, entraIlustracion) * e, 455 * e);
  rotate(lerp(-0.6, -0.07, entraIlustracion));
  if (ilustracionResultado == 2) {
    dibujarTarjetaP2(5, -187 * e, -121 * e, 1.7 * e);   // la historia falsa
  }
  if (ilustracionResultado == 1) {
    dibujarFotoResultadoP1();                          // la foto de la habitacion
  }
  if (ilustracionResultado == 3) {
    dibujarPulseraP3(0, 0, 1);                         // el brazo con la pulsera (termina antes del texto de abajo)
  }
  if (ilustracionResultado == 4) {
    dibujarPuertaResultadoP4();                        // la puerta 17 con su placa
  }
  if (ilustracionResultado == 7) {
    dibujarIlustracionResultadoP7();                   // la campana silenciada bajo la luna
  }
  if (ilustracionResultado == 6) {
    dibujarIlustracionResultadoP6();                   // el celular con las opciones apagadas
  }
  if (ilustracionResultado == 8) {
    dibujarIlustracionResultadoP8();                   // el celular con tres candados
  }
  if (ilustracionResultado == 9) {
    dibujarIlustracionResultadoP9();                   // la cadena cortada
  }
  if (ilustracionResultado == 5) {
    dibujarIlustracionResultadoP5();                   // el celular con la voz A eliminada
  }
  dibujarSello(selloIlustracion, 0, 0, colorSello, pasado - 1100, -0.25);
  popMatrix();

  if (!sonoSello1 && pasado >= 1100) {
    sonidosCargadosSample[16].trigger();
    sonoSello1 = true;
  }

  fill(255, 255 * constrain((pasado - 1300) / 400.0, 0, 1));
  textFont(fuente);
  textSize(30 * e);
  text(explicacionIlustracion, 560 * e, 665 * e);

  // TARJETA "EN LA VIDA REAL" a la derecha: entra desde fuera de la pantalla
  float entraTarjeta = reboteTelon((pasado - 600) / 700.0);
  float tarjetaX = lerp(1950, 980, entraTarjeta);

  fill(20, 10, 12, 235);
  stroke(colorSello);
  strokeWeight(3 * e);
  rect(tarjetaX * e, 300 * e, 760 * e, 520 * e, 22 * e);
  noStroke();

  textAlign(CENTER, CENTER);
  fill(colorSello);
  textSize(28 * e);
  text("EN LA VIDA REAL", (tarjetaX + 380) * e, 340 * e);

  fill(255);
  textAlign(LEFT, TOP);
  textSize(30 * e);
  text(fraseVidaReal, (tarjetaX + 40) * e, 375 * e, 680 * e, 110 * e);

  fill(255, 22);
  rect((tarjetaX + 40) * e, 490 * e, 680 * e, 150 * e, 14 * e);
  fill(255, 220, 140);
  textSize(27 * e);
  text(consejoVidaReal, (tarjetaX + 60) * e, 502 * e, 640 * e, 130 * e);

  // el dato en juego se escribe letra por letra y despues le cae su sello
  fill(180);
  textSize(24 * e);
  text(antesDelDato, (tarjetaX + 40) * e, 660 * e);
  String dato = datoEnJuego[datoResultado];
  int letrasDato = constrain((pasado - 1600) / 30, 0, dato.length());
  fill(255);
  textSize(32 * e);
  text(dato.substring(0, letrasDato), (tarjetaX + 40) * e, 695 * e);

  dibujarSello(selloDato, tarjetaX + 560, 770, colorSello, pasado - 2400, -0.12);
  if (!sonoSello2 && pasado >= 2400) {
    sonidosCargadosSample[16].trigger();
    sonoSello2 = true;
  }

  // DESGLOSE: cada linea entra deslizandose con un tic; despues el total cuenta de uno en uno
  textFont(fuente);
  for (int l = 0; l < cantidadLineas; l++) {
    int pasadoLinea = pasado - (2700 + l * 450);
    if (pasadoLinea > 0) {
      if (!lineaSonada[l]) {
        sonidosCargadosSample[17].trigger();
        lineaSonada[l] = true;
      }
      float entraLinea = reboteTelon(pasadoLinea / 350.0);
      float lineaY = (760 + l * 40) * e;
      float deslizLinea = (1 - entraLinea) * -60;
      float opacidadLinea = 255 * constrain(pasadoLinea / 250.0, 0, 1);

      fill(255, opacidadLinea);
      textAlign(LEFT, CENTER);
      textSize(30 * e);
      text(lineaTexto[l], (330 + deslizLinea) * e, lineaY);

      // puntitos que unen el texto con el numero
      float finTexto = (330 + deslizLinea) * e + textWidth(lineaTexto[l]) + 12 * e;
      fill(255, opacidadLinea * 0.4);
      for (float punto = finTexto; punto < 750 * e; punto += 14 * e) {
        ellipse(punto, lineaY + 8 * e, 3 * e, 3 * e);
      }

      // los bonos no ganados se ven en gris
      if (lineaPuntos[l] > 0) {
        fill(255, 210, 90, opacidadLinea);
      } else {
        fill(130, opacidadLinea);
      }
      textAlign(RIGHT, CENTER);
      text(lineaPuntos[l], 800 * e, lineaY);
    }
  }

  int inicioTotal = 2700 + cantidadLineas * 450 + 300;
  float totalY = (760 + cantidadLineas * 40 + 30) * e;
  if (pasado > inicioTotal) {
    stroke(255, 210, 90, 160);
    strokeWeight(2 * e);
    line(330 * e, totalY - 28 * e, 800 * e, totalY - 28 * e);
    noStroke();

    int mostrar = min(puntosResultado, (pasado - inicioTotal) / 60);
    if (mostrar > puntosMostrados) {
      puntosMostrados = mostrar;
      ultimoTic = millis();
      sonidosCargadosSample[17].trigger();
    }
    float latido = 1 + 0.25 * max(0, 1 - (millis() - ultimoTic) / 150.0);
    fill(255, 210, 90);
    textAlign(LEFT, CENTER);
    textSize(38 * e);
    text("Total", 330 * e, totalY);
    textAlign(RIGHT, CENTER);
    textSize(44 * e);
    pushMatrix();
    translate(800 * e, totalY);
    scale(latido);
    text(puntosMostrados, 0, 0);
    popMatrix();
  }

  // aviso para volver, parpadeando, cuando ya termino de contar
  if (pasado > inicioTotal + puntosResultado * 60 + 300) {
    fill(255, 200, 0, 170 + 85 * sin(millis() * 0.006));
    textAlign(CENTER, CENTER);
    textSize(30 * e);
    text("Presione ENTER para volver", width / 2, 1040 * e);
  }

  // CONFETI al ganar
  if (gano) {
    for (int c = 0; c < cantidadConfeti; c++) {
      confY[c] += confVel[c];
      confGiro[c] += 0.08;
      if (confY[c] > 1100) {
        confY[c] = random(-200, -20);
      }
      if (c % 4 == 0) {
        fill(255, 210, 90);
      }
      if (c % 4 == 1) {
        fill(225, 40, 55);
      }
      if (c % 4 == 2) {
        fill(255);
      }
      if (c % 4 == 3) {
        fill(255, 150, 180);
      }
      pushMatrix();
      translate((confX[c] + sin(millis() * 0.002 + c) * 30) * e, confY[c] * e);
      rotate(confGiro[c]);
      rect(-7 * e, -4 * e, 14 * e, 8 * e);
      popMatrix();
    }
  }

  popMatrix();
}
