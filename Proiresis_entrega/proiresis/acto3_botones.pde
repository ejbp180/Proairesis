// PANTALLA 36 - BOTONES DEL ACTO III

String[] nombresPruebasActo3 = {
  "Aduana de permisos",            // boton 1
  "La cadena"                      // boton 2
};
String[] subtitulosPruebasActo3 = {
  "Dale a cada app solo lo que necesita",
  "Rompe el rastro a tiempo"
};
int[] datosActo3 = {9, 10};             // dato en juego de cada prueba del Acto III (el 8 y el 11 no se usan)
int[] resultadoActo3 = new int[2];      // 0 = sin jugar, 1 = ganada, 2 = perdida (tambien en: pruebas 8 y 9)
int pruebasCompletadasActo3 = 0;        // cada prueba completada desbloquea la siguiente (tambien en: pruebas 8 y 9)
int cantidadBotonesActo3 = 2;           // cantidad de botones del Acto III (2 pruebas, cada una vale 50)
int cantidadHechasActo3 = 2;            // pruebas del Acto III que ya estan programadas
int inicioPantallaActo3 = 0;            // millis() en que se entro a los botones (para que entren animados)
int inicioAvisoActo3 = -10000;          // millis() del ultimo aviso
String avisoActo3 = "";                 // texto del aviso


// 36 - ACTO III - BOTONES
void dibujarBotonesActo3() {
  float e = width / 1920.0;
  int pasado = millis() - inicioPantallaActo3;

  dibujarFondoActo3();
  dibujarCortinas(1, 1, 0);

  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(84 * e);
  fill(0, 140);
  text("Acto III", width / 2 + 4 * e, 144 * e);
  fill(celesteA3);
  text("Acto III", width / 2, 140 * e);
  textSize(30 * e);
  fill(200, 225, 255);
  text("Elige una prueba", width / 2, 215 * e);

  int seleccionado = -1;
  for (int i = 0; i < cantidadBotonesActo3; i++) {

    float entra = reboteTelon((pasado - 200 - i * 200) / 600.0);
    float x = 410 + i * 600;
    float y = lerp(1200, 330, entra) + sin(millis() * 0.0015 + i * 1.7) * 4;
    float ancho = 500;
    float alto = 560;

    boolean encima = mouseX > x * e && mouseX < (x + ancho) * e && mouseY > y * e && mouseY < (y + alto) * e;
    if (encima && pasado > 1200) {
      seleccionado = i;
    }
    float aumento = 1;
    if (seleccionado == i) {
      aumento = 1.05;
    }

    boolean bloqueada = i > pruebasCompletadasActo3;
    boolean jugada = resultadoActo3[i] != 0;
    float opBloqueada = 1;
    if (bloqueada) {
      opBloqueada = 0.35;
    }

    pushMatrix();
    translate((x + ancho / 2) * e, (y + alto / 2) * e);
    scale(aumento);

    // tarjeta con contorno de tinta, como una ventana proyectada
    noStroke();
    fill(0, 120);
    rect((-ancho / 2 + 10) * e, (-alto / 2 + 14) * e, ancho * e, alto * e);
    fill(tintaA3);
    rect((-ancho / 2 - 6) * e, (-alto / 2 - 6) * e, (ancho + 12) * e, (alto + 12) * e);
    fill(14, 30, 72);
    if (bloqueada) {
      fill(24, 28, 40);
    }
    stroke(celesteA3, 255 * opBloqueada);
    strokeWeight(4 * e);
    rect(-ancho / 2 * e, -alto / 2 * e, ancho * e, alto * e);
    noStroke();

    // brillo de proyector que cruza la tarjeta elegida
    if (seleccionado == i) {
      float brillo = (millis() % 1600) / 1600.0;
      fill(255, 25);
      quad((-ancho / 2 + brillo * ancho) * e, -alto / 2 * e, (-ancho / 2 + brillo * ancho + 80) * e, -alto / 2 * e,
        (-ancho / 2 + brillo * ancho + 20) * e, alto / 2 * e, (-ancho / 2 + brillo * ancho - 60) * e, alto / 2 * e);
    }

    // numero grande (fuenteTitulo: la de 70 se ve borrosa a este tamaño)
    textFont(fuenteTitulo);
    textAlign(CENTER, CENTER);
    textSize(200 * e);
    fill(celesteA3, 255 * opBloqueada);
    text(i + 8, 0, -120 * e);

    // nombre y subtitulo
    textFont(fuente);
    textSize(46 * e);
    fill(255, 255 * opBloqueada);
    text(nombresPruebasActo3[i], -ancho / 2 * e + 20 * e, 40 * e, (ancho - 40) * e, 130 * e);
    textSize(26 * e);
    fill(200, 225, 255, 230 * opBloqueada);
    text(subtitulosPruebasActo3[i], -ancho / 2 * e + 30 * e, 130 * e, (ancho - 60) * e, 90 * e);

    // estado
    textSize(30 * e);
    if (jugada) {
      if (resultadoActo3[i] == 1) {
        fill(celesteA3);
        text("Superada", 0, 235 * e);
      } else {
        fill(255, 110, 110);
        text("Perdida", 0, 235 * e);
      }
    } else {
      if (bloqueada) {
        fill(200, 160);
        text("Bloqueada", 0, 235 * e);
      } else {
        if (i >= cantidadHechasActo3) {
          fill(200, 190);
          text("En construcción", 0, 235 * e);
        } else {
          fill(celesteA3, 170 + 85 * sin(millis() * 0.006));
          text("Haz clic para entrar", 0, 235 * e);
        }
      }
    }
    popMatrix();
  }
  if (seleccionado >= 0) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }

  // aviso
  int pasadoAviso = millis() - inicioAvisoActo3;
  if (pasadoAviso < 2500) {
    float opacidad = 255 * (1 - constrain((pasadoAviso - 1800) / 700.0, 0, 1));
    textFont(fuente);
    textSize(34 * e);
    textAlign(CENTER, CENTER);
    float anchoAviso = textWidth(avisoActo3);
    fill(0, opacidad * 0.7);
    rect(width / 2 - anchoAviso / 2 - 30 * e, 960 * e, anchoAviso + 60 * e, 70 * e);
    fill(255, opacidad);
    text(avisoActo3, width / 2, 995 * e);
  }

  // puntos
  textFont(fuente);
  textSize(40 * e);
  textAlign(RIGHT, CENTER);
  fill(255);
  text("Puntos: " + puntosJugador, width - 60 * e, 60 * e);
  strokeWeight(1);

  // boton para salir al vestibulo (acto1_botones)
  dibujarBotonSalirLobby();
}


// clic en la pantalla 36
void clicBotonesActo3() {
  if (clicBotonSalirLobby()) {
    return;
  }
  float e = width / 1920.0;
  for (int i = 0; i < cantidadBotonesActo3; i++) {
    float x = 410 + i * 600;
    boolean encima = mouseX > x * e && mouseX < (x + 500) * e && mouseY > 330 * e && mouseY < 890 * e;
    if (encima && millis() - inicioPantallaActo3 > 1200) {
      if (i > pruebasCompletadasActo3) {
        avisoActo3 = "Para desbloquear esto completa: " + nombresPruebasActo3[i - 1];
        inicioAvisoActo3 = millis();
      } else {
        if (resultadoActo3[i] != 0) {
          avisoActo3 = "Esta prueba ya no se puede jugar";
          inicioAvisoActo3 = millis();
        } else {
          if (i >= cantidadHechasActo3) {
            avisoActo3 = "Esta prueba todavía está en construcción";
            inicioAvisoActo3 = millis();
          } else {
            cursor(ARROW);
            pruebaActual = 7 + i;
            if (i == 0) {
              textosContexto = textosContextoP8;
            }
            if (i == 1) {
              textosContexto = textosContextoP9;
            }
            cantidadEscenasContexto = 3;
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
        }
      }
    }
  }
}


// EL EXPEDIENTE FINAL (despues del cierre del Acto III): todo lo que la sombra sabe de ti en el juego
int[] datosJuego = {0, 1, 2, 3, 4, 6, 7, 9, 10};   // los datos que estuvieron en juego en las 9 pruebas
String[] actoDatoJuego = {"Acto I", "Acto I", "Acto I", "Acto I", "Acto II", "Acto II", "Acto II", "Acto III", "Acto III"};
int cantidadDatosJuego = 9;
boolean[] selloSonadoExpediente = new boolean[9];


// la carpeta cae, se abre, y los datos se sellan uno por uno; al final la exposicion y el veredicto
void dibujarExpedienteFinal(float e, int pasado) {
  background(8, 6, 14);
  noStroke();
  fill(255, 235, 200, 14 + 5 * sin(millis() * 0.0015));
  triangle(960 * e, 0, 260 * e, 1080 * e, 1660 * e, 1080 * e);
  dibujarMotasCierre(color(255, 225, 190), 26);
  dibujarTramaComic(color(140, 110, 70), 10);

  float cae = reboteTelon(pasado / 700.0);
  float abre = suaveTelon((pasado - 900) / 600.0);
  float carpetaY = lerp(-900, 0, cae);

  pushMatrix();
  translate(0, carpetaY * e);
  rotate(-0.01);

  // la hoja de adentro (y la parte de atras de la carpeta)
  fill(0, 120);
  rect(534 * e, 164 * e, 880 * e, 810 * e);
  fill(tintaA3);
  rect(512 * e, 142 * e, 896 * e, 826 * e);
  fill(196, 160, 96);
  rect(520 * e, 150 * e, 880 * e, 810 * e);
  fill(244, 236, 216);
  rect(548 * e, 176 * e, 824 * e, 760 * e);

  // la tapa: se da vuelta hacia la izquierda (se achica de costado) y deja ver la hoja
  if (abre < 1) {
    float ancho = 880 * (1 - abre);
    fill(tintaA3);
    rect(512 * e, 142 * e, (ancho + 16) * e, 826 * e);
    fill(214, 176, 108);
    rect(520 * e, 150 * e, ancho * e, 810 * e);
    fill(196, 160, 96);
    rect(520 * e, 150 * e, ancho * e, 60 * e);
    // la etiqueta EXPEDIENTE estampada en rojo
    if (ancho > 300) {
      pushMatrix();
      translate((520 + ancho / 2) * e, 520 * e);
      rotate(-0.12);
      noFill();
      stroke(190, 40, 50);
      strokeWeight(8 * e);
      rect(-260 * e, -60 * e, 520 * e, 120 * e);
      noStroke();
      fill(190, 40, 50);
      textFont(fuenteTitulo);
      textAlign(CENTER, CENTER);
      textSize(84 * e);
      text("EXPEDIENTE", 0, -8 * e);
      popMatrix();
    }
  }

  if (abre >= 1) {
    // titulo de la hoja
    fill(60, 40, 30);
    textFont(fuenteTitulo);
    textAlign(LEFT, CENTER);
    textSize(52 * e);
    text("Lo que la sombra sabe de ti", 590 * e, 236 * e);
    stroke(150, 120, 90);
    strokeWeight(3 * e);
    line(590 * e, 282 * e, 1330 * e, 282 * e);
    noStroke();

    // los datos: entran uno por uno y les cae un sello (FILTRADO en rojo, PROTEGIDO en celeste y tachado)
    for (int k = 0; k < cantidadDatosJuego; k++) {
      int pasadoFila = pasado - (1700 + k * 300);
      if (pasadoFila > 0) {
        int d = datosJuego[k];
        boolean filtrado = datoFiltrado[d];
        float entra = constrain(pasadoFila / 200.0, 0, 1);
        float y = 330 + k * 60;
        fill(140, 120, 100, 255 * entra);
        textFont(fuenteTexto);
        textAlign(LEFT, CENTER);
        textSize(22 * e);
        text(actoDatoJuego[k], 590 * e, y * e);
        fill(50, 36, 28, 255 * entra);
        if (!filtrado) {
          fill(150, 140, 130, 255 * entra);
        }
        textSize(30 * e);
        text(datoEnJuego[d], (700 + 30 * (1 - entra)) * e, y * e);
        int pasadoSello = pasadoFila - 180;
        if (pasadoSello > 0) {
          float avance = constrain(pasadoSello / 160.0, 0, 1);
          if (!selloSonadoExpediente[k] && avance >= 1) {
            selloSonadoExpediente[k] = true;
            sonidosCargadosSample[16].trigger();
          }
          if (!filtrado) {
            // tachado
            stroke(110, 100, 95, 255 * avance);
            strokeWeight(4 * e);
            line(696 * e, y * e, (700 + textWidth(datoEnJuego[d]) / e) * e * avance + 696 * e * (1 - avance), y * e);
            noStroke();
          }
          color colorSello = color(200, 40, 55);
          String sello = "FILTRADO";
          if (!filtrado) {
            colorSello = color(40, 140, 200);
            sello = "PROTEGIDO";
          }
          pushMatrix();
          translate(1230 * e, y * e);
          rotate(-0.12);
          scale(lerp(2.2, 1, avance * avance));
          noFill();
          stroke(colorSello, 230 * avance);
          strokeWeight(4 * e);
          rect(-100 * e, -22 * e, 200 * e, 44 * e);
          noStroke();
          fill(colorSello, 230 * avance);
          textFont(fuente);
          textAlign(CENTER, CENTER);
          textSize(28 * e);
          text(sello, 0, -3 * e);
          popMatrix();
        }
      }
    }

    // la exposicion final: la barra se llena con rebote
    if (pasado > 4700) {
      float llena = exposicion / 100.0 * reboteTelon((pasado - 4700) / 1200.0);
      fill(60, 40, 30);
      textFont(fuenteTexto);
      textAlign(LEFT, CENTER);
      textSize(28 * e);
      text("Exposición final  " + round(llena * 100) + " %", 590 * e, 880 * e);
      fill(210, 200, 185);
      rect(940 * e, 868 * e, 390 * e, 26 * e);
      fill(lerpColor(color(60, 160, 210), color(200, 40, 55), llena));
      rect(940 * e, 868 * e, 390 * e * llena, 26 * e);
    }
  }
  popMatrix();

  // EL VEREDICTO: se escribe letra por letra
  if (pasado > 6000) {
    if (exposicion < 25) {
      ganarLogro(14);
    }
    String veredicto = "Casi no sabe nada de ti.";
    if (exposicion >= 25) {
      veredicto = "Sabe más de lo que crees.";
    }
    if (exposicion >= 55) {
      veredicto = "La sombra lo sabe todo.";
    }
    int letras = constrain((pasado - 6000) / 40, 0, veredicto.length());
    if (letras > letrasSonadasCierre + 1) {
      letrasSonadasCierre = letras;
      sonidosCargadosSample[4].trigger();
    }
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(44 * e);
    fill(0, 160);
    text(veredicto.substring(0, letras), (960 + 3) * e, 1013 * e);
    fill(255, 230, 200);
    text(veredicto.substring(0, letras), 960 * e, 1010 * e);
  }
  if (pasado > 6800) {
    fill(255, 225, 190, 150 + 80 * sin(millis() * 0.006));
    textFont(fuente);
    textAlign(RIGHT, CENTER);
    textSize(26 * e);
    text("Presione ENTER", 1880 * e, 1050 * e);
  }

  // el telon se abre al empezar
  float telon = suaveTelon(pasado / 1100.0);
  dibujarCortinas(telon, telon, 0);
}
