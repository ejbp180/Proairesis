// TELON QUE SE ABRE AL EMPEZAR UNA PRUEBA (encima de todo, antes de la guia)
// linea de tiempo: 0 a 0,4 s cerrado (respira), 0,4 a 2,2 s se abre, 2,2 a 2,7 s sube la bambalina,
// hasta 3,4 s la prueba hace entrar sus cosas (cuerda, sombra...) y despues empieza la guia
// al quedar abierto, el telon recogido es el MISMO que dibuja la prueba a los lados: no desaparece, se queda

boolean telonAbreCompleto = false;     // true = al abrirse sale de la pantalla (no queda recogido a los lados)
boolean telonActivo = false;    // true mientras dura la entrada (el juego espera)
int inicioTelon = -100000;      // millis() en que empezo (muy atras = entrada ya terminada)
float jalonTelon = 0;           // pixeles que la mano de la sombra jala el borde del telon derecho hacia el centro (vuelve a 0 al dibujarlo)
float alturaJalonTelon = 540;   // altura (pixeles de pantalla) donde el borde se dobla: donde la mano lo agarra


void empezarTelon() {
  telonAbreCompleto = false;
  telonActivo = true;
  inicioTelon = millis();
  sonidosCargadosSample[5].trigger();   // tela que se desliza
  sonoSombraEntrada = false;
}


// suavizado fuerte: arranca lento, acelera en el medio y frena al final (0 a 1)
float suaveTelon(float x) {
  x = constrain(x, 0, 1);
  if (x < 0.5) {
    return 4 * x * x * x;
  }
  return 1 - pow(-2 * x + 2, 3) / 2;
}


// suavizado con rebote: se pasa un poco del final y vuelve (0 a 1)
float reboteTelon(float x) {
  x = constrain(x, 0, 1);
  return 1 + 2.70158 * pow(x - 1, 3) + 1.70158 * pow(x - 1, 2);
}


// las dos mitades del telon (imagen p2_telon); abre 0 = cerrado, 1 = recogido a 210 px de cada lado
void dibujarCortinas(float abre, float abreAbajo, float respiroTela) {
  float e = width / 1920.0;

  // recogido a 210 px de cada lado, o fuera de la pantalla si el telon se abre del todo
  float recogido = 210 * e;
  if (telonAbreCompleto) {
    recogido = -40 * e;
  }
  float bordeArriba = lerp(width / 2 + 10 * e, recogido, abre);
  float bordeAbajo = lerp(width / 2 + 10 * e, recogido, abreAbajo) + respiroTela;

  // la imagen del telon (mitad izquierda) se estira entre el borde de la pantalla y el borde que se mueve
  // el borde se dobla en alturaJalonTelon: ahi la mano de la sombra puede jalar el telon derecho hacia el centro
  PImage tela = imagenesCargadas[68];
  float vJalon = tela.height * alturaJalonTelon / height;   // la misma altura dentro de la imagen
  noStroke();
  for (int lado = 0; lado < 2; lado++) {

    // la mitad derecha es el espejo de la izquierda; solo ella se jala
    float jalon = 0;
    if (lado == 1) {
      jalon = jalonTelon;
    }
    float bordeMedio = lerp(bordeArriba, bordeAbajo, alturaJalonTelon / height) + jalon;
    float afuera = 0;
    float arriba = bordeArriba;
    float medio = bordeMedio;
    float abajo = bordeAbajo;
    if (lado == 1) {
      afuera = width;
      arriba = width - bordeArriba;
      medio = width - bordeMedio;
      abajo = width - bordeAbajo;
    }
    // dos cuadrilateros: de arriba hasta donde se jala, y de ahi hasta abajo
    beginShape(QUADS);
    texture(tela);
    vertex(afuera, 0, 0, 0);
    vertex(arriba, 0, tela.width, 0);
    vertex(medio, alturaJalonTelon, tela.width, vJalon);
    vertex(afuera, alturaJalonTelon, 0, vJalon);
    vertex(afuera, alturaJalonTelon, 0, vJalon);
    vertex(medio, alturaJalonTelon, tela.width, vJalon);
    vertex(abajo, height, tela.width, tela.height);
    vertex(afuera, height, 0, tela.height);
    endShape();

    // ribete dorado en el borde que se mueve (dos tramos, por si esta jalado)
    stroke(215, 170, 70);
    strokeWeight(7 * e);
    line(arriba, 0, medio, alturaJalonTelon);
    line(medio, alturaJalonTelon, abajo, height);
    noStroke();
  }
  strokeWeight(1);

  // el jalon se usa una sola vez: los demas telones (entrada, carteles, finales) salen rectos
  jalonTelon = 0;
}


void dibujarTelon() {
  if (telonActivo) {

    float e = width / 1920.0;
    int pasado = millis() - inicioTelon;
    inicioPrueba = millis();   // el reloj de la prueba no corre durante la entrada

    // la tela de abajo va 150 ms atrasada: parece tela pesada que se mece
    float abre = suaveTelon((pasado - 400) / 1800.0);
    float abreAbajo = suaveTelon((pasado - 550) / 1800.0);
    float subeBambalina = suaveTelon((pasado - 2200) / 500.0);

    // mientras esta cerrado, el borde de abajo respira un poco
    float respiroTela = sin(millis() * 0.004) * 6 * e * (1 - abre);

    // POLVO flotando en la luz que entra por la abertura
    float bordePolvo = lerp(width / 2, 210 * e, abre);
    noStroke();
    for (int mota = 0; mota < 40; mota++) {
      float motaX = (mota * 97) % 1920 * e;
      float motaY = (((mota * 53) % 900 + 150) - (pasado * 0.02 * (1 + mota % 3))) % 900;
      if (motaY < 0) {
        motaY = motaY + 900;
      }
      motaY = (motaY + 120) * e;
      if (motaX > bordePolvo && motaX < width - bordePolvo) {
        fill(255, 235, 200, 120 * abre * (1 - subeBambalina));
        ellipse(motaX, motaY, (3 + mota % 3) * e, (3 + mota % 3) * e);
      }
    }

    // ya abierto del todo, este telon deja de dibujarse: debajo queda el de la prueba, identico
    if (pasado < 2400) {
      dibujarCortinas(abre, abreAbajo, respiroTela);
    }

    // BAMBALINA: la franja de arriba con ondas y borde dorado; al final sube y desaparece
    float bambalinaY = -170 * e * subeBambalina;
    fill(120, 12, 26);
    rect(0, bambalinaY, width, 95 * e);
    for (int onda = 0; onda < 12; onda++) {
      float ondaX = (onda * 160 + 80) * e;
      noStroke();
      fill(120, 12, 26);
      ellipse(ondaX, bambalinaY + 95 * e, 170 * e, 70 * e);
      noFill();
      stroke(215, 170, 70);
      strokeWeight(4 * e);
      arc(ondaX, bambalinaY + 95 * e, 170 * e, 70 * e, 0, PI);
    }
    noStroke();
    strokeWeight(1);

    // la entrada termina cuando la prueba ya hizo entrar sus cosas
    if (pasado > 3400) {
      telonActivo = false;
    }
  }
}


// igual que empezarTelon, pero al abrirse sale del todo de la pantalla (para pruebas que usan toda la pantalla)
void empezarTelonCompleto() {
  empezarTelon();
  telonAbreCompleto = true;
}
