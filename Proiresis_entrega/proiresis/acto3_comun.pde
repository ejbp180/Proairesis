// ACTO III - COSAS COMUNES DE SUS PRUEBAS (fondo proyectado, iconos y candado)

color tintaA3 = color(14, 18, 40);            // contorno de las cosas del acto 3 (azul tinta)
color azulA3 = color(46, 107, 230);           // azul principal del acto
color celesteA3 = color(127, 212, 255);       // lo protegido
color rojoA3 = color(224, 64, 64);            // lo expuesto
color doradoA3 = color(236, 190, 70);         // candados y llaves

// ICONOS (numero de cada uno)
int ICONO_PUBLICACION = 0;
int ICONO_HISTORIA = 1;
int ICONO_FOTO = 2;
int ICONO_UBICACION = 3;
int ICONO_ETIQUETA = 4;
int ICONO_CONTACTOS = 5;
int ICONO_CAMARA = 6;
int ICONO_GALERIA = 7;
int ICONO_MICROFONO = 8;
int ICONO_CALENDARIO = 9;
int ICONO_PERFIL = 10;
int ICONO_CASA = 11;
int ICONO_TIJERA = 12;
int ICONO_LINTERNA = 13;
int ICONO_CALCULADORA = 14;


// CHISPAS: particulas de los efectos del acto (0 = punto, 1 = estrella, 2 = humo o polvo)
int cantidadChispasA3 = 200;
float[] chispaXA3 = new float[200];
float[] chispaYA3 = new float[200];
float[] chispaVXA3 = new float[200];
float[] chispaVYA3 = new float[200];
int[] chispaInicioA3 = new int[200];
int[] chispaVidaA3 = new int[200];
color[] chispaColorA3 = new color[200];
float[] chispaTamA3 = new float[200];
int[] chispaTipoA3 = new int[200];
int siguienteChispaA3 = 0;
int ultimoCuadroChispasA3 = 0;

// MUSICA DEL ACTO III (ambientes 5 a 8): pedidos, pelea con el jefe, serpiente y latido de la cadena
int musicaActualA3 = -1;


// cambia la musica: la que sonaba se apaga y la nueva entra subiendo (cual = 5, 6, 7 u 8)
void musicaA3(int cual) {
  sonidosCargadosAmbiente[3].pause();
  for (int m = 5; m <= 8; m++) {
    if (m != cual) {
      sonidosCargadosAmbiente[m].pause();
    }
  }
  if (musicaActualA3 != cual || !sonidosCargadosAmbiente[cual].isPlaying()) {
    sonidosCargadosAmbiente[cual].rewind();
    sonidosCargadosAmbiente[cual].loop();
    sonidosCargadosAmbiente[cual].shiftGain(-40, volumenAmbiente, 1500);
  }
  musicaActualA3 = cual;
}


// la musica se desvanece (al llegar a la pantalla de resultado)
void bajarMusicaA3() {
  for (int m = 5; m <= 8; m++) {
    if (sonidosCargadosAmbiente[m].isPlaying()) {
      sonidosCargadosAmbiente[m].shiftGain(sonidosCargadosAmbiente[m].getGain(), -50, 1200);
    }
  }
}


// apaga toda la musica del acto
void apagarMusicaA3() {
  for (int m = 5; m <= 8; m++) {
    sonidosCargadosAmbiente[m].pause();
  }
  musicaActualA3 = -1;
}


// GOLPES DE PANTALLA: un zoom corto y los bordes que destellan de un color
int golpePantallaA3 = -10000;
color colorGolpeA3 = color(255);


// borra todas las chispas y golpes (al empezar una prueba)
void reiniciarEfectosA3() {
  for (int c = 0; c < cantidadChispasA3; c++) {
    chispaInicioA3[c] = -100000;
    chispaVidaA3[c] = 1;
  }
  golpePantallaA3 = -10000;
  ultimoCuadroChispasA3 = millis();
}


// lanza chispas desde (x, y) en todas direcciones (medidas de 1920)
void lanzarChispasA3(float x, float y, int cantidad, color colorChispa, float fuerza, int tipo) {
  for (int k = 0; k < cantidad; k++) {
    int c = siguienteChispaA3;
    float angulo = random(TWO_PI);
    float rapidez = random(0.3, 1) * fuerza;
    chispaXA3[c] = x;
    chispaYA3[c] = y;
    chispaVXA3[c] = cos(angulo) * rapidez;
    chispaVYA3[c] = sin(angulo) * rapidez - fuerza * 0.3;
    chispaInicioA3[c] = millis();
    chispaVidaA3[c] = int(random(450, 900));
    chispaColorA3[c] = colorChispa;
    chispaTamA3[c] = random(6, 14);
    chispaTipoA3[c] = tipo;
    if (tipo == 2) {
      chispaVXA3[c] *= 0.25;
      chispaVYA3[c] = -random(20, 70);
      chispaTamA3[c] = random(14, 26);
    }
    siguienteChispaA3 = (siguienteChispaA3 + 1) % cantidadChispasA3;
  }
}


// mueve y dibuja las chispas: los puntos y estrellas caen con gravedad; el humo sube y crece
void dibujarChispasA3(float e) {
  float dt = constrain((millis() - ultimoCuadroChispasA3) / 1000.0, 0, 0.05);
  ultimoCuadroChispasA3 = millis();
  noStroke();
  for (int c = 0; c < cantidadChispasA3; c++) {
    int pasado = millis() - chispaInicioA3[c];
    if (pasado < chispaVidaA3[c]) {
      float vida = pasado / (float) chispaVidaA3[c];
      chispaXA3[c] += chispaVXA3[c] * dt;
      chispaYA3[c] += chispaVYA3[c] * dt;
      if (chispaTipoA3[c] != 2) {
        chispaVYA3[c] += 900 * dt;
        chispaVXA3[c] *= 0.98;
      }
      float tam = chispaTamA3[c] * (1 - vida);
      if (chispaTipoA3[c] == 2) {
        tam = chispaTamA3[c] * (0.6 + vida);
      }
      fill(chispaColorA3[c], 255 * (1 - vida));
      if (chispaTipoA3[c] == 1) {
        // estrella de 4 puntas que gira
        pushMatrix();
        translate(chispaXA3[c] * e, chispaYA3[c] * e);
        rotate(pasado * 0.01 + c);
        quad(0, -tam * 1.6 * e, tam * 0.4 * e, 0, 0, tam * 1.6 * e, -tam * 0.4 * e, 0);
        quad(-tam * 1.6 * e, 0, 0, tam * 0.4 * e, tam * 1.6 * e, 0, 0, -tam * 0.4 * e);
        popMatrix();
      } else {
        ellipse(chispaXA3[c] * e, chispaYA3[c] * e, tam * e, tam * e);
      }
    }
  }
}


// golpe de pantalla de un color
void golpeA3(color colorGolpe) {
  golpePantallaA3 = millis();
  colorGolpeA3 = colorGolpe;
}


// el zoom del golpe: se aplica a la escena (alrededor de su centro) antes de dibujarla
void zoomGolpeA3(float e) {
  float golpe = constrain(1 - (millis() - golpePantallaA3) / 220.0, 0, 1);
  translate(960 * e, 560 * e);
  scale(1 + 0.022 * golpe * golpe);
  translate(-960 * e, -560 * e);
}


// los bordes de la pantalla destellan del color del golpe
void dibujarBordesGolpeA3(float e) {
  int pasadoGolpe = millis() - golpePantallaA3;
  if (pasadoGolpe < 400) {
    float brillo = 1 - pasadoGolpe / 400.0;
    noFill();
    for (int capa = 0; capa < 4; capa++) {
      stroke(colorGolpeA3, 70 * brillo * (4 - capa) / 4.0);
      strokeWeight((30 + capa * 26) * e);
      rect(0, 0, width, height);
    }
    noStroke();
    strokeWeight(1);
  }
}


// FONDO DEL ACTO III: el telon cerrado en azul noche, con la cuenta proyectada encima
// (pliegues del telon, el haz del proyector que respira, polvo en la luz y lineas de escaneo)
void dibujarFondoActo3() {
  float e = width / 1920.0;
  background(5, 11, 28);
  noStroke();

  // pliegues del telon: franjas claras y oscuras que se mecen apenas
  for (int i = 0; i < 24; i++) {
    float meneo = sin(millis() * 0.0008 + i * 0.7) * 4;
    fill(12, 24, 62);
    rect((i * 80 + meneo) * e, 90 * e, 34 * e, 990 * e);
    fill(20, 38, 92);
    rect((i * 80 + 34 + meneo) * e, 90 * e, 10 * e, 990 * e);
  }

  // haz del proyector que cae desde arriba
  fill(150, 195, 255, 16 + 4 * sin(millis() * 0.0015));
  triangle(960 * e, 90 * e, 220 * e, 1080 * e, 1700 * e, 1080 * e);
  fill(150, 195, 255, 10);
  triangle(960 * e, 90 * e, 520 * e, 1080 * e, 1400 * e, 1080 * e);
  dibujarMotasCierre(color(170, 215, 255), 22);
  dibujarTramaComic(azulA3, 8);

  // lineas de escaneo muy suaves que bajan despacio
  stroke(255, 8);
  strokeWeight(1);
  float corrido = (millis() * 0.02) % 6;
  for (float y = 90 + corrido; y < 1080; y += 6) {
    line(0, y * e, width, y * e);
  }
  noStroke();
}


// una personita (cabeza y hombros) para los iconos de contactos y perfil; medidas de un icono de 100
void dibujarPersonitaA3(float cx, float cy, float t) {
  ellipse(cx, cy - t * 0.22, t * 0.34, t * 0.34);
  arc(cx, cy + t * 0.36, t * 0.62, t * 0.62, PI, TWO_PI);
}


// ICONO de lineas gruesas centrado en (cx, cy) de tam x tam (medidas de 1920)
// se dibuja en una caja de 100 x 100 que despues se escala
void dibujarIconoA3(int tipo, float cx, float cy, float tam, color colorIcono) {
  float e = width / 1920.0;
  pushMatrix();
  translate(cx * e, cy * e);
  scale(tam / 100.0 * e);
  stroke(colorIcono);
  strokeWeight(8);
  strokeJoin(ROUND);
  strokeCap(ROUND);
  noFill();

  if (tipo == ICONO_PUBLICACION) {
    // hoja con renglones
    rect(-34, -46, 68, 92);
    line(-18, -20, 18, -20);
    line(-18, 0, 18, 0);
    line(-18, 20, 8, 20);
  }
  if (tipo == ICONO_HISTORIA) {
    // anillo doble
    ellipse(0, 0, 92, 92);
    ellipse(0, 0, 58, 58);
  }
  if (tipo == ICONO_FOTO) {
    // marco con montanas y sol
    rect(-46, -36, 92, 72);
    line(-36, 26, -10, -4);
    line(-10, -4, 10, 16);
    line(10, 16, 22, 4);
    line(22, 4, 38, 26);
    ellipse(20, -16, 14, 14);
  }
  if (tipo == ICONO_UBICACION) {
    // pin
    arc(0, -14, 64, 64, PI - 0.5, TWO_PI + 0.5);
    line(-29, 0, 0, 46);
    line(29, 0, 0, 46);
    ellipse(0, -14, 18, 18);
  }
  if (tipo == ICONO_ETIQUETA) {
    beginShape();
    vertex(-46, -26);
    vertex(18, -26);
    vertex(46, 0);
    vertex(18, 26);
    vertex(-46, 26);
    endShape(CLOSE);
    ellipse(-26, 0, 12, 12);
  }
  if (tipo == ICONO_CONTACTOS) {
    dibujarPersonitaA3(-20, 0, 80);
    dibujarPersonitaA3(22, 4, 80);
  }
  if (tipo == ICONO_CAMARA) {
    rect(-46, -26, 92, 62);
    rect(-22, -38, 26, 12);
    ellipse(0, 6, 38, 38);
  }
  if (tipo == ICONO_GALERIA) {
    // dos fotos encimadas
    rect(-34, -42, 80, 60);
    rect(-46, -26, 80, 62);
    line(-38, 28, -18, 4);
    line(-18, 4, 0, 22);
    line(0, 22, 24, 28);
  }
  if (tipo == ICONO_MICROFONO) {
    rect(-14, -46, 28, 54);
    arc(0, -6, 52, 52, 0, PI);
    line(0, 20, 0, 40);
    line(-16, 40, 16, 40);
  }
  if (tipo == ICONO_CALENDARIO) {
    rect(-46, -34, 92, 78);
    line(-46, -12, 46, -12);
    line(-22, -44, -22, -26);
    line(22, -44, 22, -26);
    noStroke();
    fill(colorIcono);
    for (int fila = 0; fila < 2; fila++) {
      for (int columna = 0; columna < 3; columna++) {
        rect(-30 + columna * 24, 2 + fila * 20, 12, 10);
      }
    }
  }
  if (tipo == ICONO_PERFIL) {
    ellipse(0, 0, 96, 96);
    dibujarPersonitaA3(0, 4, 74);
  }
  if (tipo == ICONO_CASA) {
    line(-46, 0, 0, -44);
    line(0, -44, 46, 0);
    rect(-34, -4, 68, 48);
    rect(-9, 18, 18, 26);
  }
  if (tipo == ICONO_TIJERA) {
    ellipse(-20, 30, 26, 26);
    ellipse(20, 30, 26, 26);
    line(-12, 18, 28, -44);
    line(12, 18, -28, -44);
  }
  if (tipo == ICONO_LINTERNA) {
    // el mango, la cabeza y los rayos de luz
    rect(-12, 4, 24, 42);
    quad(-24, -22, 24, -22, 12, 4, -12, 4);
    line(-30, -36, -40, -48);
    line(0, -36, 0, -50);
    line(30, -36, 40, -48);
  }
  if (tipo == ICONO_CALCULADORA) {
    rect(-34, -46, 68, 92);
    rect(-22, -34, 44, 20);
    noStroke();
    fill(colorIcono);
    for (int fila = 0; fila < 3; fila++) {
      for (int columna = 0; columna < 3; columna++) {
        rect(-22 + columna * 17, -2 + fila * 16, 10, 10);
      }
    }
  }
  popMatrix();
  strokeWeight(1);
  strokeCap(ROUND);
}


// CANDADO DORADO de historieta centrado en (cx, cy), de 90 x 110 por escala (medidas de 1920)
// abierto = el arco levantado; brillo de 0 a 1 = destello blanco encima
void dibujarCandadoA3(float cx, float cy, float escala, boolean abierto, float brillo) {
  float e = width / 1920.0;
  pushMatrix();
  translate(cx * e, cy * e);
  scale(escala * e);

  // sombra en el piso
  noStroke();
  fill(0, 90);
  ellipse(6, 62, 90, 18);

  // el candado (imagen de la prueba 8): las dos imagenes tienen el cuerpo en el mismo lugar
  // (el cuerpo amarillo va de y 5 a 60 y de x -36 a 36)
  int imagen = 149;
  if (abierto) {
    imagen = 148;
  }
  image(imagenesCargadas[imagen], -38, -54.8, 76.2, 114.8);

  // destello
  if (brillo > 0) {
    fill(255, 255 * brillo);
    rect(-34, 8, 68, 48);
  }
  popMatrix();
  strokeCap(ROUND);
  strokeWeight(1);
}


// distancia de un punto a un segmento (para saber si el tajo del mouse paso por encima de una burbuja)
float distSegmentoA3(float px, float py, float ax, float ay, float bx, float by) {
  float dx = bx - ax;
  float dy = by - ay;
  float largo2 = dx * dx + dy * dy;
  float t = 0;
  if (largo2 > 0) {
    t = constrain(((px - ax) * dx + (py - ay) * dy) / largo2, 0, 1);
  }
  return dist(px, py, ax + t * dx, ay + t * dy);
}
