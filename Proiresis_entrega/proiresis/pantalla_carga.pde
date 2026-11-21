// PANTALLA 0 - CARGA

int inicioCarga = 0;  // momento en que empezo la carga (tambien en: setup)
int archivoActual = 0;  // archivo que se esta cargando
float porcentaje;  // ancho de la barra de carga
float barraSuaveCarga = 0;  // lo que muestra la barra: se acerca suave al avance real
boolean archivosCargados = false;  // true cuando termino de cargar


// 0 - CARGA
void dibujarCarga() {
  background(20, 5, 9);

  if (millis() - inicioCarga > 1000) {

    if (!archivosCargados) {

      // primero imagenes, luego efectos, ambiente y musica
      if (archivoActual < cantidadImagenes) {

        imagenesCargadas[archivoActual] = loadImage(imagenes[archivoActual]);

        archivoActual++;
      } else {
        if (archivoActual < cantidadImagenes + cantidadSonidosSample) {

          sonidosCargadosSample[archivoActual - cantidadImagenes] = minim.loadSample(sonidosSample[archivoActual - cantidadImagenes]);

          archivoActual++;
        } else {
          if (archivoActual < cantidadImagenes + cantidadSonidosSample + cantidadSonidosAmbiente) {

            sonidosCargadosAmbiente[archivoActual - cantidadImagenes - cantidadSonidosSample] = minim.loadFile(sonidosAmbiente[archivoActual - cantidadImagenes - cantidadSonidosSample]);

            archivoActual++;
          } else {
            if (archivoActual < cantidadImagenes + cantidadSonidosSample + cantidadSonidosAmbiente + cantidadCanciones) {

              sonidosCargadosMusica[archivoActual - cantidadImagenes - cantidadSonidosSample - cantidadSonidosAmbiente] = minim.loadFile(sonidosMusica[archivoActual - cantidadImagenes - cantidadSonidosSample - cantidadSonidosAmbiente]);

              archivoActual++;
            } else {

              // termino de cargar: se aplican los volumenes
              archivosCargados = true;

              volumenEfectos = map(porcentajeEfectos, 0, 100, -60, 10);

              for (int i = 0; i < cantidadSonidosSample; i++) {

                sonidosCargadosSample[i].setGain(volumenEfectos);
              }

              volumenAmbiente = map(porcentajeAmbiente, 0, 100, -60, 10);

              for (int i = 0; i < cantidadSonidosAmbiente; i++) {

                sonidosCargadosAmbiente[i].setGain(volumenAmbiente);
              }

              volumenMusica = map(porcentajeMusica, 0, 100, -60, 10);

              for (int i = 0; i < cantidadCanciones; i++) {

                sonidosCargadosMusica[i].setGain(volumenMusica);
              }

              // termina de cargar: empieza el juego en el menu (el logo se salta; para verlo, poner pantalla = 1)
              // (para saltar a una prueba o a un final: modo desarrollador, tecla de al lado del 1)
              pantalla = 2;
            }
          }
        }
      }
    }
  }

  // TEXTO Y BARRA (la carga de arriba no cambia: esto solo dibuja)
  float e = width / 1920.0;
  int totalArchivos = cantidadImagenes + cantidadSonidosSample + cantidadSonidosAmbiente + cantidadCanciones;
  porcentaje = map(archivoActual, 0, totalArchivos, 0, 300);   // (se conserva por si otra pantalla lo usa)
  barraSuaveCarga = lerp(barraSuaveCarga, archivoActual / (float) totalArchivos, 0.12);   // la barra avanza suave

  // fondo: vino oscuro con un foco de luz que cae desde arriba
  background(20, 5, 9);
  noStroke();
  fill(255, 225, 200, 16);
  triangle(width/2, 0, width/2 - 560 * e, height, width/2 + 560 * e, height);
  fill(255, 225, 200, 12);
  triangle(width/2, 0, width/2 - 300 * e, height, width/2 + 300 * e, height);

  // motas de polvo que suben despacio por la luz
  for (int mota = 0; mota < 24; mota++) {
    float velocidad = 1 + mota % 3;
    float motaX = width/2 + sin(mota * 12.9 + millis() * 0.0003 * velocidad) * (120 + mota * 14) * e;
    float motaY = height - ((millis() * 0.03 * velocidad + mota * 97) % (height + 40));
    fill(255, 230, 200, 60 + 50 * sin(mota + millis() * 0.002));
    ellipse(motaX, motaY, (2 + mota % 3) * e, (2 + mota % 3) * e);
  }

  // titulo con un brillo dorado que respira
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(130 * e);
  fill(255, 200, 0, 28 + 22 * sin(millis() * 0.003));
  for (int k = 0; k < 8; k++) {
    text("Proairesis", width/2 + cos(k * PI / 4) * 5 * e, height * 0.36 + sin(k * PI / 4) * 5 * e);
  }
  fill(255, 236, 190);
  text("Proairesis", width/2, height * 0.36);

  // linea dorada fina bajo el titulo
  stroke(255, 200, 0, 150);
  strokeWeight(2 * e);
  line(width/2 - 170 * e, height * 0.36 + 85 * e, width/2 + 170 * e, height * 0.36 + 85 * e);
  noStroke();

  // barra redondeada: fondo oscuro con borde dorado y relleno dorado con un brillo claro arriba
  float barraAncho = 620 * e;
  float barraAlto = 22 * e;
  float barraX = width/2 - barraAncho / 2;
  float barraY = height * 0.62;
  fill(0, 120);
  stroke(255, 200, 0, 180);
  strokeWeight(2 * e);
  rect(barraX, barraY, barraAncho, barraAlto, barraAlto / 2);
  noStroke();
  float rellenoAncho = max(barraAlto, barraAncho * barraSuaveCarga);
  fill(240, 175, 20);
  rect(barraX, barraY, rellenoAncho, barraAlto, barraAlto / 2);
  fill(255, 235, 150, 170);
  rect(barraX + barraAlto / 3, barraY + barraAlto * 0.15, max(1, rellenoAncho - barraAlto * 0.66), barraAlto * 0.28, barraAlto / 4);

  // "Cargando" con puntos que van y vienen, y el porcentaje a la derecha
  fill(255, 225);
  textAlign(LEFT, CENTER);
  textSize(30 * e);
  text("Cargando" + "...".substring(0, (millis() / 400) % 4), barraX, barraY + 55 * e);
  textAlign(RIGHT, CENTER);
  text(int(barraSuaveCarga * 100) + " %", barraX + barraAncho, barraY + 55 * e);
}
