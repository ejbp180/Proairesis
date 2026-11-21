// PANTALLAS 6 Y 7 - TEATRO, ACTO I Y MAGO

// VARIABLES PARA EL TEATRO
float opacidadTeatro = 0;  // transparencia del teatro
boolean sonidoTeatro = false;  // true cuando ya suena el publico
int inicioTeatro = 0;  // millis() en que se entro al teatro (el primer segundo y medio no se puede saltar)
boolean mostrarActo = false;  // true cuando toca mostrar el cartel del ACTO I
int inicioCartelActo1 = -1;  // millis() en que empezo el cartel (-1 = todavia no)
int letrasSonadasActo1 = 0;  // letras de la frase que ya sonaron con la maquina de escribir
boolean sonoGolpeActo1 = false;  // ya sono el golpe al caer la ultima letra de ACTO I

// SUBTITULOS DE LA NARRACION (empiezan cuando termina personashablando.mp3)
boolean narracionIniciada = false;  // true cuando empezo la narracion
int finPersonasHablando = -1; // -1 = todavia no termino
int esperaNarracion = 2000; // ms entre que terminan las personas y empieza la narracion (dura lo mismo el zoom)
String[] subtitulosTeatro = {
  "Damas y caballeros... sean bienvenidos al Teatro Aporía.",
  "Esta noche serán testigos de una obra diferente a cualquier otra.",
  "Una historia donde la realidad y la percepción se mezclan...",
  "Donde cada acto revelará una nueva prueba.",
  "Pero recuerden... en este escenario, nada es lo que parece.",
  "La obra que están a punto de presenciar lleva por nombre... psyche.",
  "Tres actos serán presentados ante ustedes.",
  "Tres pruebas diseñadas para cuestionar aquello que creen conocer.",
  "Porque al final, la pregunta no será si lograron superar la obra...",
  "Sino si alguna vez tuvieron el control de sus propias decisiones.",
  "El tiempo de observar ha terminado.",
  "Ahora solo queda presenciar.",
  "Cada palabra, cada acción y cada elección formarán parte de esta obra.",
  "Porque una vez iniciado el primer acto...",
  "Ya no existe vuelta atrás.",
  "Comienza el Acto I."
};
// inicio de cada frase en ms desde el comienzo de narracionteatro.mp3
int[] tiemposSubtitulos = {255, 5387, 9450, 13583, 16811, 22569, 27445, 30534, 34783, 39148, 44164, 47090, 49249, 55356, 58142, 60789};
int cantidadSubtitulos = 16;  // cantidad de subtitulos y de tiempos (las dos listas deben tener la misma)


// 6 - TEATRO
void dibujarTeatro() {
  background(0);


  // publico y narracion
  if (!mostrarActo) {
    if (!sonidoTeatro) {

      sonidosCargadosAmbiente[1].play();

      sonidoTeatro = true;
      inicioTeatro = millis();
    } else {
      if (!narracionIniciada && !sonidosCargadosAmbiente[1].isPlaying()) {

        if (finPersonasHablando < 0) {

          // primer frame en que ya no suena: guardar la hora
          finPersonasHablando = millis();
        } else {
          if (millis() - finPersonasHablando >= esperaNarracion) {

            // paso la espera: empieza la narracion
            narracionIniciada = true;

            sonidosCargadosAmbiente[2].rewind();
            sonidosCargadosAmbiente[2].play();
          }
        }
      }
    }

    // el teatro aparece poco a poco
    tint(255, opacidadTeatro);

    // zoom: avanza de 0 a 1 durante la espera y se suaviza al inicio y al final
    float zoom = 0;

    if (finPersonasHablando >= 0) {

      zoom = constrain((millis() - finPersonasHablando) / (float) esperaNarracion, 0, 1);
      zoom = zoom * zoom * (3 - 2 * zoom);
    }

    if (zoom >= 1) {

      // llego al encuadre final: se queda en teatrozoom.png
      image(imagenesCargadas[22], 0, 0, width, height);
    } else {

      // region de teatro.png que coincide con teatrozoom.png (en fracciones de la imagen)
      PImage teatro = imagenesCargadas[2];

      float x0 = lerp(0, 0.2399, zoom) * teatro.width;
      float y0 = lerp(0, 0.0940, zoom) * teatro.height;
      float x1 = lerp(1, 0.7743, zoom) * teatro.width;
      float y1 = lerp(1, 0.6475, zoom) * teatro.height;

      image(teatro, 0, 0, width, height, (int) x0, (int) y0, (int) x1, (int) y1);
    }

    noTint();

    opacidadTeatro += 0.8;

    if (opacidadTeatro > 255) {

      opacidadTeatro = 255;
    }

    // subtitulo actual
    if (narracionIniciada) {

      String subtitulo = "";

      int ms = sonidosCargadosAmbiente[2].position();

      for (int i = 0; i < cantidadSubtitulos; i++) {
        if (tiemposSubtitulos[i] <= ms) {
          subtitulo = subtitulosTeatro[i];
        }
      }

      if (subtitulo.length() > 0) {

        textFont(fuente);
        textSize(38);
        textAlign(CENTER, CENTER);

        fill(0, 160);
        noStroke();
        rect(0, height*0.85, width, height*0.12);

        fill(255);
        text(subtitulo, width/2, height*0.91);
        textAlign(CENTER, BASELINE);
      }
    }

    // aviso para saltar, arriba a la derecha (aparece cuando ya se puede saltar)
    if (millis() - inicioTeatro > 1500) {
      textFont(fuente);
      textSize(24);
      textAlign(RIGHT, TOP);
      fill(255, 140);
      if (narracionIniciada) {
        text("ENTER para saltar la narración", width - 30, 25);
      } else {
        text("ENTER para saltar al narrador", width - 30, 25);
      }
      textAlign(CENTER, BASELINE);
    }
  }
  // al terminar la narracion sale ACTO I
  if (narracionIniciada && !sonidosCargadosAmbiente[2].isPlaying()) {

    mostrarActo = true;
  }

  // CARTEL DEL ACTO I (igual al del Acto II, pero en rojo): el telon se abre, caen las letras y se escribe la frase
  if (mostrarActo) {
    dibujarCartelActo1();
  }
}


// el cartel del Acto I: fondo vino con dos focos rojos que se mecen, polvo, letras que caen y la frase a maquina
void dibujarCartelActo1() {
  float e = width / 1920.0;
  if (inicioCartelActo1 < 0) {
    inicioCartelActo1 = millis();
    telonAbreCompleto = false;
    sonidosCargadosSample[5].trigger();   // tela que se desliza
  }
  int pasado = millis() - inicioCartelActo1;

  background(26, 5, 8);
  noStroke();
  for (int foco = 0; foco < 2; foco++) {
    float focoX = 640 + foco * 640;
    float giroFoco = sin(millis() * 0.0007 + foco * 2.1) * 0.22;
    float puntaX = focoX + sin(giroFoco) * 1100;
    fill(255, 120, 130, 14);
    triangle(focoX * e, -20 * e, (puntaX - 260) * e, 1080 * e, (puntaX + 260) * e, 1080 * e);
  }
  dibujarMotasCierre(color(255, 200, 200), 30);
  dibujarTramaComic(color(150, 30, 45), 12);

  // ACTO I: las letras caen y, al llegar la ultima, suena el golpe
  dibujarLetrasCierre("ACTO I", 960, 420, 180, pasado - 500, 90, color(205, 60, 75));
  if (!sonoGolpeActo1 && pasado > 500 + 5 * 90 + 300) {
    sonoGolpeActo1 = true;
    sonidosCargadosSample[16].trigger();
  }

  // Eros: aparece creciendo con rebote y una linea que se abre debajo
  float creceEros = reboteTelon((pasado - 1500) / 500.0);
  if (pasado > 1500) {
    pushMatrix();
    translate(width / 2, 590 * e);
    scale(0.3 + 0.7 * creceEros);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(64 * e);
    fill(0, 150);
    text("Eros", 4 * e, 5 * e);
    fill(240, 225, 215);
    text("Eros", 0, 0);
    popMatrix();
  }
  float abreLinea = suaveTelon((pasado - 1800) / 500.0);
  stroke(205, 60, 75, 170);
  strokeWeight(2 * e);
  line((960 - 220 * abreLinea) * e, 650 * e, (960 + 220 * abreLinea) * e, 650 * e);
  noStroke();

  // la frase se escribe letra por letra
  if (pasado > 2100) {
    String frase = "Todo empieza con lo que decides mostrar.\nY con quién mira sin que lo sepas.";
    int letras = constrain((pasado - 2100) / 30, 0, frase.length());
    if (letras > letrasSonadasActo1 + 1) {
      letrasSonadasActo1 = letras;
      sonidosCargadosSample[4].trigger();
    }
    textFont(fuente);
    textAlign(CENTER, TOP);
    textSize(32 * e);
    fill(235, 200, 190);
    text(frase.substring(0, letras), width / 2, 690 * e);
  }

  if (pasado > 4300) {
    fill(215, 180, 130, 150 + 80 * sin(millis() * 0.006));
    textAlign(CENTER, CENTER);
    textSize(30 * e);
    text("Presione ENTER para continuar", width / 2, 1000 * e);
  }

  // el telon se abre al empezar y queda recogido a los lados
  float abre = suaveTelon(pasado / 1100.0);
  dibujarCortinas(abre, abre, 0);
  textAlign(CENTER, BASELINE);
  strokeWeight(1);
}


// 7 - TEATRO - ACTO I
// MAGO: un clic pasa a los botones
void dibujarMago() {
  background(0);
  image(imagenesCargadas[23], 0, 0, width, height);
}


// clic en la pantalla 7
void clicMago() {
  // un clic en el mago pasa a la pantalla de los botones
  pantalla = 8;
}


// teclas en la pantalla 6
void teclaTeatro() {
  // el primer segundo y medio no se puede saltar: asi el ENTER de la introduccion no se salta el teatro
  if (millis() - inicioTeatro < 1500) {
    return;
  }
  // teatro: ENTER salta por partes
  if (!mostrarActo) {
    if (keyCode == ENTER || key == ENTER || key == RETURN) {
      if (!narracionIniciada) {
        // durante el publico: se calla el publico, viene el zoom y empieza el narrador
        sonidosCargadosAmbiente[1].pause();
      } else {
        // durante el narrador: va directo al cartel del ACTO I
        sonidosCargadosAmbiente[2].pause();
        mostrarActo = true;
      }
    }
  } else {
    // en el cartel: ENTER adelanta la animacion; si ya termino, pasa al mago
    if ((keyCode == ENTER || key == ENTER || key == RETURN) && inicioCartelActo1 >= 0) {
      if (millis() - inicioCartelActo1 < 4300) {
        inicioCartelActo1 = millis() - 4300;
        letrasSonadasActo1 = 100;
        sonoGolpeActo1 = true;
      } else {
        pantalla = 7;
      }
    }
  }
}
