// ARTE DE LA PRUEBA 5 (imagenes de la dibujante: el cuarto, el publico y los palcos)
// cada pieza se pega UNA sola vez en una imagen del tamano en que se ve (createGraphics) al empezar la prueba,
// y despues en cada cuadro solo se pega con image(x, y), que es rapidisimo
// (el publico tambien se usa en las pruebas 6 y 7 y en los finales)

PGraphics cuartoArteP5;                       // la pared de tu cuarto, detras del celular
PGraphics[] siluetaArteP5 = new PGraphics[5]; // 5 tipos de persona del publico
PGraphics palcoArteP5;                        // la baranda de un palco
boolean arteListoP5 = false;
color tintaP5 = color(24, 16, 34);             // color del contorno (tinta azul muy oscura, como en las fotos)


// arma todas las imagenes (solo la primera vez)
void prepararArteP5() {
  if (arteListoP5) {
    return;
  }
  float e = width / 1920.0;

  cuartoArteP5 = createGraphics(int(492 * e), int(772 * e));
  cuartoArteP5.beginDraw();
  cuartoArteP5.image(imagenesCargadas[135], 0, 0, cuartoArteP5.width, cuartoArteP5.height);
  cuartoArteP5.endDraw();

  // cada silueta cabe en una caja de 180 x 200 con la cabeza arriba (de y 10 a 200) y centrada
  for (int v = 0; v < 5; v++) {
    PImage silueta = imagenesCargadas[129 + v];
    float ancho = 190.0 * silueta.width / silueta.height;
    siluetaArteP5[v] = createGraphics(int(180 * e), int(200 * e));
    siluetaArteP5[v].beginDraw();
    siluetaArteP5[v].image(silueta, (90 - ancho / 2) * e, 10 * e, ancho * e, 190 * e);
    siluetaArteP5[v].endDraw();
  }

  palcoArteP5 = createGraphics(int(280 * e), int(110 * e));
  palcoArteP5.beginDraw();
  palcoArteP5.image(imagenesCargadas[134], 0, 0, palcoArteP5.width, palcoArteP5.height);
  palcoArteP5.endDraw();

  arteListoP5 = true;
}
