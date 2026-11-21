// CONTADOR DE LAS PRUEBAS (la barra de tiempo de arriba)

int duracionPrueba = 50000;     // duracion de la prueba en milisegundos (tambien en: contexto)
int inicioPrueba = 0;           // millis() del momento en que empieza a correr (tambien en: contexto)


// barra de tiempo y numero de segundos; al agotarse el tiempo pasa a la pantalla de perder
void dibujarContador() {
  // CONTADOR de las pruebas: corre en la prueba 1 (9 y 11), en la prueba 2 (14) y en la prueba 3 (18)
  if (pantalla == 9 || pantalla == 11 || pantalla == 14 || (pantalla == 18 && faseP3 != 2) || (pantalla == 21 && faseP4 <= 1) || (pantalla == 27 && faseP5 != 3) || (pantalla == 30 && faseP6 != 3) || (pantalla == 37 && faseP8 >= 1 && faseP8 != 4) || (pantalla == 40 && faseP9 >= 1 && faseP9 <= 3)) {

    int restanteMs = duracionPrueba - (millis() - inicioPrueba);

    if (restanteMs <= 0) {

      // se acabo el tiempo: perder tambien cuenta como jugada (no se repite y se desbloquea la siguiente)
      if (pruebaActual == 0) {
        tiempoAgotadoP1();
      } else {
        if (pruebaActual == 1) {
          tiempoAgotadoP2();
        } else {
          if (pruebaActual == 2) {
            tiempoAgotadoP3();
          } else {
            if (pruebaActual == 3) {
              tiempoAgotadoP4();
            } else {
              if (pruebaActual == 4) {
                tiempoAgotadoP5();
              } else {
                if (pruebaActual == 5) {
                  tiempoAgotadoP6();
                } else {
                  if (pruebaActual == 6) {
                    tiempoAgotadoP7();
                  } else {
                    if (pruebaActual == 7) {
                      tiempoAgotadoP8();
                    } else {
                      tiempoAgotadoP9();
                    }
                  }
                }
              }
            }
          }
        }
      }
    } else {

      int segundosRestantes = ceil(restanteMs / 1000.0);
      float fraccionTiempo = restanteMs / (float) duracionPrueba;   // 1 al inicio, 0 al final

      float barraAncho = 500;
      float barraAlto = 14;
      float barraX = width/2 - barraAncho/2;
      float barraY = 40;

      noStroke();
      fill(0, 150);
      rect(barraX, barraY, barraAncho, barraAlto, 7);

      // barra que se vacia: amarilla, roja en los ultimos 10 segundos
      if (segundosRestantes <= 10) {
        fill(255, 100, 100);
      } else {
        fill(255, 200, 0);
      }
      rect(barraX, barraY, barraAncho * fraccionTiempo, barraAlto, 7);

      // numero de segundos, del mismo color
      textFont(fuente);
      textAlign(CENTER, BASELINE);
      textSize(40);
      text(segundosRestantes, width/2, barraY + 60);
    }
  }
}
