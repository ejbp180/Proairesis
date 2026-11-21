// LOGROS: se ganan jugando, salen en un aviso arriba y se ven en el vestibulo ("Ver logros")
// se guardan en data/logros.txt para que no se pierdan al cerrar el juego

String[] nombreLogro = {
  "Ojo de detective",
  "La noche en orden",
  "Sin pulsera",
  "La fotografía imposible",
  "Máscara rota",
  "Letra chica",
  "Sin aplausos",
  "Aduana impecable",
  "Tajo maestro",
  "Tras la cadena",
  "Primer acto",
  "Segundo acto",
  "Tercer acto",
  "Todo encaja",
  "Invisible"
};
String[] descripcionLogro = {
  "Supera la prueba 1 sin fallar.",
  "Supera la prueba 2.",
  "Supera la prueba 3 sin errores.",
  "Supera la prueba 4.",
  "Derrota a VerdadAbsoluta.",
  "Supera la prueba 6 sin errores.",
  "Decide en la prueba 7 sin satisfacerlos ni llevarles la contraria.",
  "Decide bien los 13 permisos de la aduana.",
  "Corta 3 burbujas de un tajo contra Aporía 2.0.",
  "Corta la cadena en la publicación.",
  "Supera las 4 pruebas del Acto I.",
  "Supera las 3 pruebas del Acto II.",
  "Supera las 2 pruebas del Acto III.",
  "Supera las 9 pruebas.",
  "Termina el juego con menos de 25 % de exposición."
};
int cantidadLogros = 15;
boolean[] logroGanado = new boolean[15];

// AVISO: los logros nuevos esperan en una fila y salen de a uno
int[] colaLogros = new int[15];
int cantidadColaLogros = 0;
int logroMostrando = -1;               // logro que se esta mostrando (-1 = ninguno)
int inicioAvisoLogro = 0;

// PANEL DEL VESTIBULO
boolean mostrarLogros = false;         // true mientras se ve el panel (tambien en: vestibulo)
int inicioPanelLogros = 0;


// lee los logros guardados (si el archivo no existe, empiezan todos sin ganar)
void cargarLogros() {
  String[] lineas = loadStrings("logros.txt");
  if (lineas == null) {
    return;
  }
  // cada linea es un 1 (ganado) o un 0; se lee hasta donde alcance el archivo
  int leidas = 0;
  for (String linea : lineas) {
    if (leidas < cantidadLogros) {
      logroGanado[leidas] = linea.trim().equals("1");
    }
    leidas++;
  }
}


// guarda los logros (un 1 o un 0 por linea)
void guardarLogros() {
  String[] lineas = new String[cantidadLogros];
  for (int i = 0; i < cantidadLogros; i++) {
    lineas[i] = "0";
    if (logroGanado[i]) {
      lineas[i] = "1";
    }
  }
  saveStrings(dataPath("logros.txt"), lineas);
}


// gana un logro (si ya lo tenia, no pasa nada): se guarda y queda en la fila del aviso
void ganarLogro(int i) {
  if (logroGanado[i]) {
    return;
  }
  logroGanado[i] = true;
  guardarLogros();
  if (cantidadColaLogros < 15) {
    colaLogros[cantidadColaLogros] = i;
    cantidadColaLogros++;
  }
}


// revisa los logros de completar actos (se llama despues de ganar cualquier prueba)
void revisarLogrosActos() {
  boolean acto1 = true;
  for (int i = 0; i < 4; i++) {
    if (resultadoActo1[i] != 1) {
      acto1 = false;
    }
  }
  boolean acto2 = true;
  for (int i = 0; i < 3; i++) {
    if (resultadoActo2[i] != 1) {
      acto2 = false;
    }
  }
  boolean acto3 = true;
  for (int i = 0; i < 2; i++) {
    if (resultadoActo3[i] != 1) {
      acto3 = false;
    }
  }
  if (acto1) {
    ganarLogro(10);
  }
  if (acto2) {
    ganarLogro(11);
  }
  if (acto3) {
    ganarLogro(12);
  }
  if (acto1 && acto2 && acto3) {
    ganarLogro(13);
  }
}


// cuantos logros se han ganado
int logrosGanados() {
  int total = 0;
  for (int i = 0; i < cantidadLogros; i++) {
    if (logroGanado[i]) {
      total++;
    }
  }
  return total;
}


// TROFEO dibujado en (cx, cy) de tam (medidas de 1920): dorado si esta ganado, gris con candado si no
void dibujarTrofeoLogro(float cx, float cy, float tam, boolean ganado) {
  float e = width / 1920.0;
  pushMatrix();
  translate(cx * e, cy * e);
  scale(tam / 100.0 * e);
  noStroke();
  color metal = color(236, 190, 70);
  color sombraMetal = color(190, 135, 40);
  if (!ganado) {
    metal = color(90, 92, 105);
    sombraMetal = color(65, 66, 78);
  }
  // asas
  noFill();
  stroke(14, 18, 40);
  strokeWeight(16);
  arc(-34, -18, 34, 40, HALF_PI, PI + HALF_PI);
  arc(34, -18, 34, 40, -HALF_PI, HALF_PI);
  stroke(metal);
  strokeWeight(8);
  arc(-34, -18, 34, 40, HALF_PI, PI + HALF_PI);
  arc(34, -18, 34, 40, -HALF_PI, HALF_PI);
  noStroke();
  // copa
  fill(14, 18, 40);
  arc(0, -42, 84, 110, 0, PI);
  rect(-42, -48, 84, 8);
  fill(metal);
  arc(0, -42, 72, 96, 0, PI);
  rect(-36, -44, 72, 4);
  fill(255, 120);
  if (ganado) {
    rect(-24, -36, 8, 28);
  }
  // pie
  fill(14, 18, 40);
  rect(-10, 4, 20, 20);
  rect(-30, 22, 60, 20);
  fill(sombraMetal);
  rect(-6, 6, 12, 18);
  rect(-26, 26, 52, 12);
  // candado chico si no esta ganado
  if (!ganado) {
    image(imagenesCargadas[149], -15.2, -53.8, 30.4, 45.8);   // candado de la prueba 8
  }
  popMatrix();
  strokeWeight(1);
}


// EL AVISO: baja desde arriba a la derecha, se queda 2,6 s y se va; despues sale el siguiente de la fila
void dibujarAvisoLogro() {
  float e = width / 1920.0;
  if (logroMostrando == -1 && cantidadColaLogros > 0) {
    logroMostrando = colaLogros[0];
    for (int k = 0; k < cantidadColaLogros - 1; k++) {
      colaLogros[k] = colaLogros[k + 1];
    }
    cantidadColaLogros--;
    inicioAvisoLogro = millis();
    sonidosCargadosSample[53].trigger();
  }
  if (logroMostrando == -1) {
    return;
  }
  int pasado = millis() - inicioAvisoLogro;
  if (pasado > 3200) {
    logroMostrando = -1;
    return;
  }
  float baja = reboteTelon(pasado / 500.0);
  float sube = suaveTelon((pasado - 2700) / 500.0);
  float y = lerp(-160, 120, baja) - 300 * sube;
  float x = 1880 - 560;

  pushMatrix();
  translate(0, y * e);
  noStroke();
  fill(0, 130);
  rect((x + 8) * e, 10 * e, 560 * e, 130 * e);
  fill(14, 18, 40);
  rect((x - 6) * e, -6 * e, 572 * e, 142 * e);
  fill(30, 26, 18);
  rect(x * e, 0, 560 * e, 130 * e);
  fill(236, 190, 70);
  rect(x * e, 0, 560 * e, 8 * e);
  // un brillo que cruza el aviso
  float brillo = ((pasado - 300) % 1400) / 1400.0;
  if (pasado > 300) {
    fill(255, 240, 200, 30);
    quad((x + brillo * 640 - 80) * e, 0, (x + brillo * 640) * e, 0, (x + brillo * 640 - 40) * e, 130 * e, (x + brillo * 640 - 120) * e, 130 * e);
  }
  popMatrix();
  // el trofeo salta al aparecer
  float salta = 1 + 0.3 * constrain(1 - (pasado - 300) / 300.0, 0, 1);
  dibujarTrofeoLogro(x + 70, y + 72, 90 * salta, true);
  pushMatrix();
  translate(0, y * e);
  fill(236, 190, 70);
  textFont(fuente);
  textAlign(LEFT, CENTER);
  textSize(24 * e);
  text("Logro desbloqueado", (x + 140) * e, 34 * e);
  fill(255, 245, 225);
  textSize(36 * e);
  text(nombreLogro[logroMostrando], (x + 140) * e, 76 * e);
  fill(200, 185, 160);
  textSize(19 * e);
  text(descripcionLogro[logroMostrando], (x + 140) * e, 110 * e);
  popMatrix();
}


// EL PANEL DEL VESTIBULO: los 15 logros en 3 columnas; los ganados en dorado, los que faltan con candado
void dibujarPanelLogros() {
  float e = width / 1920.0;
  int pasado = millis() - inicioPanelLogros;
  float entra = reboteTelon(pasado / 450.0);

  fill(0, 190 * constrain(pasado / 250.0, 0, 1));
  noStroke();
  rect(0, 0, width, height);

  pushMatrix();
  translate(960 * e, 540 * e);
  scale(0.6 + 0.4 * entra);
  translate(-960 * e, -540 * e);
  fill(0, 120);
  rect(170 * e, 90 * e, 1600 * e, 920 * e);
  fill(14, 18, 40);
  rect(150 * e, 70 * e, 1620 * e, 940 * e);
  fill(30, 22, 16);
  rect(160 * e, 80 * e, 1600 * e, 920 * e);
  fill(236, 190, 70);
  rect(160 * e, 80 * e, 1600 * e, 8 * e);

  fill(236, 190, 70);
  textFont(fuenteTitulo);
  textAlign(CENTER, CENTER);
  textSize(72 * e);
  text("Logros", 960 * e, 150 * e);
  fill(220, 200, 170);
  textFont(fuente);
  textSize(28 * e);
  text(logrosGanados() + " de " + cantidadLogros, 960 * e, 210 * e);

  for (int i = 0; i < cantidadLogros; i++) {
    float aparece = constrain((pasado - 150 - i * 40) / 300.0, 0, 1);
    float x = 210 + (i % 3) * 510;
    float y = 255 + (i / 3) * 145;
    boolean ganado = logroGanado[i];
    boolean encima = mouseX > x * e && mouseX < (x + 480) * e && mouseY > y * e && mouseY < (y + 128) * e;
    pushMatrix();
    translate(0, (1 - suaveTelon(aparece)) * 30 * e);
    fill(14, 18, 40, 255 * aparece);
    rect((x - 4) * e, (y - 4) * e, 488 * e, 136 * e);
    fill(46, 36, 24, 255 * aparece);
    if (!ganado) {
      fill(28, 26, 30, 255 * aparece);
    }
    if (encima) {
      fill(64, 50, 30, 255 * aparece);
    }
    rect(x * e, y * e, 480 * e, 128 * e);
    // brillo que cruza los ganados
    if (ganado) {
      float brillo = ((millis() + i * 300) % 3000) / 700.0;
      if (brillo < 1) {
        fill(255, 230, 170, 22 * aparece);
        quad((x + brillo * 560 - 80) * e, y * e, (x + brillo * 560) * e, y * e, (x + brillo * 560 - 40) * e, (y + 128) * e, (x + brillo * 560 - 120) * e, (y + 128) * e);
      }
    }
    popMatrix();
    if (aparece > 0) {
      float salta = 0;
      if (encima) {
        salta = sin(millis() * 0.012) * 4;
      }
      dibujarTrofeoLogro(x + 62, y + 70 + (1 - suaveTelon(aparece)) * 30 + salta, 78, ganado);
      fill(255, 245, 225, 255 * aparece);
      if (!ganado) {
        fill(150, 145, 150, 255 * aparece);
      }
      textFont(fuente);
      textAlign(LEFT, TOP);
      textSize(28 * e);
      text(nombreLogro[i], (x + 118) * e, (y + 14 + (1 - suaveTelon(aparece)) * 30) * e);
      fill(210, 195, 170, 255 * aparece);
      if (!ganado) {
        fill(120, 118, 125, 255 * aparece);
      }
      textSize(19 * e);
      text(descripcionLogro[i], (x + 118) * e, (y + 54 + (1 - suaveTelon(aparece)) * 30) * e, 350 * e, 70 * e);
    }
  }

  fill(220, 200, 170, 150 + 80 * sin(millis() * 0.006));
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(26 * e);
  text("Haz clic para volver", 960 * e, 975 * e);
  popMatrix();
}


// clic con el panel abierto: se cierra
void clicLogros() {
  if (millis() - inicioPanelLogros > 400) {
    mostrarLogros = false;
    sonidosCargadosSample[3].trigger();
  }
}
