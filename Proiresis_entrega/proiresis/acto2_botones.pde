// PANTALLAS 24 Y 26 - CIERRE DE UN ACTO (I o II) Y BOTONES DEL ACTO II

// CIERRE DE UN ACTO (pantalla 24): la misma pantalla cierra el Acto I y el Acto II
int actoCierre = 1;                // acto que se esta cerrando: 1 (rojo, sigue el Acto II), 2 (dorado, sigue el Acto III) o 3 (azul, el expediente)
int[] datosActo2 = {4, 6, 7};      // dato en juego de cada prueba del Acto II (el 5 no se usa)
int etapaCierreActo1 = 0;          // 0 = resumen del acto, 1 = cartel del acto que sigue
int inicioCierreActo1 = 0;         // millis() en que empezo la etapa actual
boolean[] filaSonadaCierre = new boolean[4];   // la tarjeta de cada prueba ya sono
int puntosCierreActo1 = 0;         // puntos que ya se contaron en pantalla
int ultimoTicCierre = 0;           // millis() del ultimo punto contado
boolean[] selloSonadoCierre = new boolean[4];  // el sello de cada tarjeta ya cayo
boolean puntosTerminadosCierre = false;   // los puntos ya terminaron de contar (salto final)
int letrasSonadasCierre = 0;       // letras que ya sonaron con la maquina de escribir
int inicioSalidaCierre = -1;       // millis() en que empezo a cerrarse el telon (-1 = todavia no)
boolean sonoActo2Cierre = false;   // ya sono el golpe del cartel ACTO II

// BOTONES DEL ACTO II (pantalla 26)
String[] nombresPruebasActo2 = {
  "El en vivo",                    // boton 1
  "Términos tramposos",            // boton 2
  "Lluvia de notificaciones"       // boton 3
};
String[] subtitulosPruebasActo2 = {
  "Elimina la voz que te presiona",
  "Lee antes de aceptar",
  "Resiste el último aplauso"
};
int[] resultadoActo2 = new int[3];      // 0 = sin jugar, 1 = ganada, 2 = perdida (tambien en: prueba 5)
int pruebasCompletadasActo2 = 0;        // cada prueba completada desbloquea la siguiente (tambien en: prueba 5)
int cantidadBotonesActo2 = 3;           // cantidad de botones del Acto II
int cantidadHechasActo2 = 3;            // pruebas del Acto II que ya estan programadas (sube conforme se hacen)
int inicioPantallaActo2 = 0;            // millis() en que se entro a los botones (para que entren animados)
int inicioAvisoActo2 = -10000;          // millis() del ultimo aviso
String avisoActo2 = "";                 // texto del aviso


PFont fuenteTitulo;   // Whimsical a 180 para las letras grandes que caen (se crea en setup)


// se llama al terminar la ultima prueba de un acto (1 o 2)
void empezarCierreActo(int acto) {
  actoCierre = acto;
  // se anotan los puntos que habia al terminar cada acto (para la resena de la obra)
  if (acto == 1) {
    puntosInicioActo2 = puntosJugador;
  }
  if (acto == 2) {
    puntosInicioActo3 = puntosJugador;
  }
  if (acto == 3) {
    puntosFinActo3 = puntosJugador;
  }
  pantalla = 24;
  etapaCierreActo1 = 0;
  inicioCierreActo1 = millis();
  puntosCierreActo1 = 0;
  ultimoTicCierre = -10000;
  for (int i = 0; i < 4; i++) {
    filaSonadaCierre[i] = false;
    selloSonadoCierre[i] = false;
  }
  puntosTerminadosCierre = false;
  letrasSonadasCierre = 0;
  inicioSalidaCierre = -1;
  sonoActo2Cierre = false;
  for (int k = 0; k < cantidadDatosJuego; k++) {
    selloSonadoExpediente[k] = false;
  }
  sombraMiraX = -1;
  sombraAnsia = 0;
  telonAbreCompleto = false;
  sonidosCargadosSample[14].trigger();
}


// escribe un texto letra por letra: cada letra cae desde arriba girando y rebota (paso = ms entre letras)
// despues se queda flotando suave; centroX, centroY y tam en medidas de 1920
void dibujarLetrasCierre(String texto, float centroX, float centroY, float tam, int pasado, int paso, color colorLetra) {
  float e = width / 1920.0;
  textFont(fuenteTitulo);
  textSize(tam * e);
  textAlign(LEFT, CENTER);
  float x = centroX * e - textWidth(texto) / 2;
  for (int l = 0; l < texto.length(); l++) {
    String letra = texto.substring(l, l + 1);
    float anchoLetra = textWidth(letra);
    int pasadoLetra = pasado - l * paso;
    if (pasadoLetra > 0) {
      float baja = reboteTelon(pasadoLetra / 450.0);
      float opacidad = 255 * constrain(pasadoLetra / 150.0, 0, 1);
      float letraY = lerp(centroY - 170, centroY, baja) + sin(millis() * 0.002 + l * 0.6) * 3;
      float giro = (1 - baja) * 0.6 * ((l % 2) * 2 - 1);
      pushMatrix();
      translate(x + anchoLetra / 2, letraY * e);
      rotate(giro);
      fill(0, 150 * opacidad / 255);
      text(letra, -anchoLetra / 2 + tam * 0.06 * e, tam * 0.07 * e);
      fill(colorLetra, opacidad);
      text(letra, -anchoLetra / 2, 0);
      popMatrix();
    }
    x += anchoLetra;
  }
}


// motas de polvo que suben despacio por la luz (como en la pantalla de carga)
void dibujarMotasCierre(color colorMota, int cantidad) {
  float e = width / 1920.0;
  noStroke();
  for (int mota = 0; mota < cantidad; mota++) {
    float velocidad = 1 + mota % 3;
    float motaX = width / 2 + sin(mota * 12.9 + millis() * 0.0003 * velocidad) * (120 + mota * 16) * e;
    float motaY = height - ((millis() * 0.03 * velocidad + mota * 97) % (height + 40));
    fill(colorMota, 60 + 50 * sin(mota + millis() * 0.002));
    float tamMota = (2 + mota % 3) * e;
    ellipse(motaX, motaY, tamMota, tamMota);
  }
}


// 24 - CIERRE DE UN ACTO
void dibujarCierreActo() {
  float e = width / 1920.0;
  int pasado = millis() - inicioCierreActo1;

  // lo que cambia segun el acto que se cierra (Acto I: vino y rojo; Acto II: cafe y dorado)
  int cantidadFilas = 4;
  String tituloCierre = "Fin del Acto I";
  color colorFondo = color(26, 5, 8);
  color colorTitulo = color(205, 75, 85);
  color colorTrama = color(150, 30, 45);
  color colorTarjeta = color(32, 10, 14);
  color colorProtegido = color(215, 180, 130);
  if (actoCierre == 2) {
    cantidadFilas = 3;
    tituloCierre = "Fin del Acto II";
    colorFondo = color(24, 19, 6);
    colorTitulo = color(228, 188, 106);
    colorTrama = color(150, 120, 40);
    colorTarjeta = color(34, 27, 10);
    colorProtegido = color(228, 188, 106);
  }
  if (actoCierre == 3) {
    cantidadFilas = 2;
    tituloCierre = "Fin del Acto III";
    colorFondo = color(5, 11, 28);
    colorTitulo = color(127, 212, 255);
    colorTrama = color(46, 107, 230);
    colorTarjeta = color(10, 20, 46);
    colorProtegido = color(127, 212, 255);
  }

  if (etapaCierreActo1 == 0) {

    // fondo del color del acto con el foco de luz que respira
    background(colorFondo);
    noStroke();
    fill(255, 230, 235, 13 + 5 * sin(millis() * 0.0015));
    triangle(960 * e, 0, 300 * e, 1080 * e, 1620 * e, 1080 * e);
    dibujarMotasCierre(color(255, 220, 210), 24);

    // la sombra asomada a la derecha: cuanto mas expuesto, mas se asoma; sigue con el ojo lo que se va sellando
    sombraAnsia = lerp(sombraAnsia, 0, 0.03);
    dibujarSombraYTelon(0);
    dibujarTramaComic(colorTrama, 14);

    // TITULO: cada letra cae girando y rebota
    dibujarLetrasCierre(tituloCierre, 960, 120, 100, pasado, 55, colorTitulo);

    // subtitulo que sube despacio
    float subeSubtitulo = suaveTelon((pasado - 800) / 600.0);
    fill(230, 210, 200, 255 * subeSubtitulo);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(30 * e);
    text("Esto es lo que la sombra sabe de ti.", width / 2, (235 - 20 * subeSubtitulo) * e);

    // TARJETAS: entran desde la izquierda inclinadas, se enderezan, y despues les cae el sello
    int aciertos = 0;
    for (int i = 0; i < cantidadFilas; i++) {
      // la prueba de esta fila (del Acto I o del Acto II)
      int resultadoFila = resultadoActo1[i];
      String nombreFila = nombresPruebasActo1[i];
      int datoFila = i;
      if (actoCierre == 2) {
        resultadoFila = resultadoActo2[i];
        nombreFila = nombresPruebasActo2[i];
        datoFila = datosActo2[i];
      }
      if (actoCierre == 3) {
        resultadoFila = resultadoActo3[i];
        nombreFila = nombresPruebasActo3[i];
        datoFila = datosActo3[i];
      }
      if (resultadoFila == 1) {
        aciertos++;
      }
      int pasadoFila = pasado - (1300 + i * 500);
      if (pasadoFila > 0) {
        if (!filaSonadaCierre[i]) {
          sonidosCargadosSample[17].trigger();
          filaSonadaCierre[i] = true;
        }
        boolean ganada = resultadoFila == 1;
        color colorFila = color(165, 40, 55);
        String sello = "FILTRADO";
        if (ganada) {
          colorFila = colorProtegido;
          sello = "PROTEGIDO";
        }

        float entra = reboteTelon(pasadoFila / 450.0);
        float flota = sin(millis() * 0.0018 + i * 1.3) * 3;
        float filaX = lerp(-900, 270, entra);
        float filaY = 270 + i * 120 + flota;
        float opacidad = 255 * constrain(pasadoFila / 250.0, 0, 1);

        // el sello cae 450 ms despues; al clavarse la tarjeta tiembla, salpica tinta y la sombra reacciona
        int pasadoSello = pasadoFila - 450;
        float temblor = 0;
        if (pasadoSello > 180 && pasadoSello < 420) {
          temblor = random(-6, 6) * (1 - (pasadoSello - 180) / 240.0);
        }
        if (pasadoSello >= 180 && !selloSonadoCierre[i]) {
          selloSonadoCierre[i] = true;
          sonidosCargadosSample[16].trigger();
          sombraMiraX = filaX + 930;
          sombraMiraY = filaY + 50;
          if (ganada) {
            sombraReacciona(1);
          } else {
            sombraReacciona(2);
            sombraAnsia = 1;
          }
        }

        pushMatrix();
        translate((filaX + 550 + temblor) * e, (filaY + 50) * e);
        rotate((1 - entra) * -0.12);
        float cx = -550 * e;
        float cy = -50 * e;

        // tarjeta con sombra y borde del color del resultado
        noStroke();
        fill(0, 120);
        rect(cx + 8 * e, cy + 9 * e, 1100 * e, 100 * e);
        fill(colorTarjeta, 235);
        stroke(colorFila, 170);
        strokeWeight(2 * e);
        rect(cx, cy, 1100 * e, 100 * e);
        noStroke();

        // filtrado: el borde late en rojo despues del sello
        if (!ganada && pasadoSello > 180) {
          noFill();
          stroke(200, 30, 45, 60 + 50 * sin(millis() * 0.005 + i));
          strokeWeight(6 * e);
          rect(cx - 3 * e, cy - 3 * e, 1106 * e, 106 * e);
          noStroke();
        }

        // protegido: un brillo cruza la tarjeta cada 4 s
        if (ganada && pasadoSello > 180) {
          float brillo = ((millis() + i * 900) % 4000) / 700.0;
          if (brillo < 1) {
            float bx = cx + (40 + brillo * 960) * e;
            fill(255, 240, 210, 22);
            quad(bx, cy + 2 * e, bx + 70 * e, cy + 2 * e, bx + 30 * e, cy + 98 * e, bx - 40 * e, cy + 98 * e);
          }
        }

        // numero de la prueba
        fill(colorFila, opacidad);
        textFont(fuente);
        textAlign(CENTER, CENTER);
        textSize(64 * e);
        text(i + 1, cx + 55 * e, cy + 46 * e);

        textAlign(LEFT, CENTER);
        fill(240, 228, 220, opacidad);
        textSize(36 * e);
        text(nombreFila, cx + 115 * e, cy + 32 * e);

        // el dato: si se filtro, a ratos se "rompe" con una copia roja corrida
        textSize(25 * e);
        if (!ganada && pasadoSello > 180 && (millis() + i * 700) % 1900 < 130) {
          fill(200, 30, 45, 200);
          text(datoEnJuego[datoFila], cx + 119 * e + random(-3, 3) * e, cy + 72 * e);
        }
        fill(160, 135, 135, opacidad);
        text(datoEnJuego[datoFila], cx + 115 * e, cy + 72 * e);

        // sello: cae girando desde grande y se clava
        if (pasadoSello > 0) {
          float avance = constrain(pasadoSello / 180.0, 0, 1);
          float escala = lerp(2.6, 1, avance * avance);
          pushMatrix();
          translate(cx + 930 * e, cy + 50 * e);
          rotate(-0.1 - (1 - avance) * 0.3);
          scale(escala);
          noFill();
          stroke(colorFila, 210 * avance);
          strokeWeight(3 * e);
          rect(-120 * e, -28 * e, 240 * e, 56 * e);
          noStroke();
          fill(colorFila, 220 * avance);
          textAlign(CENTER, CENTER);
          textSize(34 * e);
          text(sello, 0, -3 * e);
          popMatrix();

          // salpicadura de tinta al clavarse (0,35 s)
          int pasadoTinta = pasadoSello - 180;
          if (pasadoTinta > 0 && pasadoTinta < 350) {
            float avanceTinta = pasadoTinta / 350.0;
            fill(colorFila, 220 * (1 - avanceTinta));
            for (int gota = 0; gota < 10; gota++) {
              float anguloGota = gota * TWO_PI / 10 + i;
              float distanciaGota = (130 + 60 * avanceTinta) * (0.8 + 0.2 * (gota % 3));
              float gx = cx + 930 * e + cos(anguloGota) * distanciaGota * e;
              float gy = cy + 50 * e + sin(anguloGota) * distanciaGota * 0.45 * e;
              float tamGota = (4 + gota % 3 * 2) * (1 - avanceTinta) * e;
              ellipse(gx, gy, tamGota, tamGota);
            }
          }
        }
        popMatrix();
      }
    }
    strokeWeight(1);

    // PUNTOS: cuentan hacia arriba en 1,3 s; al terminar el numero salta
    if (pasado > 3600) {
      float opacidadTotal = 255 * constrain((pasado - 3600) / 400.0, 0, 1);
      int mostrar = int(puntosJugador * constrain((pasado - 3700) / 1300.0, 0, 1));
      if (mostrar > puntosCierreActo1) {
        puntosCierreActo1 = mostrar;
        if (millis() - ultimoTicCierre > 45) {
          ultimoTicCierre = millis();
          sonidosCargadosSample[17].trigger();
        }
      }
      if (!puntosTerminadosCierre && puntosCierreActo1 >= puntosJugador && pasado > 3700) {
        puntosTerminadosCierre = true;
        ultimoTicCierre = millis() + 150;
        sonidosCargadosSample[16].trigger();
      }
      float latido = 1 + 0.25 * constrain(1 - (millis() - ultimoTicCierre) / 150.0, 0, 1.6);
      float subePuntos = suaveTelon((pasado - 3600) / 500.0);
      textFont(fuente);
      textAlign(LEFT, CENTER);
      fill(230, 210, 200, opacidadTotal);
      textSize(36 * e);
      text("Puntos", 270 * e, (820 - 20 * subePuntos) * e);
      pushMatrix();
      translate(450 * e, (820 - 20 * subePuntos) * e);
      scale(latido);
      fill(215, 180, 130, 40 * (latido - 1) * 4);
      ellipse(45 * e, 0, 150 * e, 90 * e);
      fill(215, 180, 130, opacidadTotal);
      textSize(64 * e);
      text(puntosCierreActo1, 0, 0);
      popMatrix();
      fill(190, 165, 160, opacidadTotal);
      textSize(30 * e);
      text("Pruebas superadas  " + aciertos + " de " + cantidadFilas, 270 * e, (880 - 20 * subePuntos) * e);
    }

    // EXPOSICION: la barra se llena con rebote, un brillo la recorre y la punta late
    if (pasado > 4000) {
      if (pasado < 5300) {
        sombraMiraX = 1065;
        sombraMiraY = 850;
      }
      float opacidadBarra = 255 * constrain((pasado - 4000) / 400.0, 0, 1);
      float llena = exposicion / 100.0 * reboteTelon((pasado - 4100) / 1200.0);
      textFont(fuente);
      textAlign(LEFT, CENTER);
      fill(230, 210, 200, opacidadBarra);
      textSize(36 * e);
      text("Exposición  " + round(llena * 100) + " %", 760 * e, 800 * e);
      noStroke();
      fill(255, 25);
      rect(760 * e, 835 * e, 610 * e, 34 * e);
      fill(lerpColor(color(120, 45, 55), color(200, 35, 50), llena));
      rect(760 * e, 835 * e, 610 * e * llena, 34 * e);
      fill(255, 30);
      rect(760 * e, 835 * e, 610 * e * llena, 10 * e);
      float franja = 760 + (millis() * 0.35) % 700 - 60;
      if (franja > 760 && franja + 40 < 760 + 610 * llena) {
        fill(255, 230, 220, 35);
        quad(franja * e, 835 * e, (franja + 30) * e, 835 * e, (franja + 15) * e, 869 * e, (franja - 15) * e, 869 * e);
      }
      if (llena > 0.01) {
        fill(255, 200, 200, 110 + 90 * sin(millis() * 0.008));
        rect((760 + 610 * llena - 3) * e, 828 * e, 6 * e, 48 * e);
      }
    }

    // VEREDICTO: se escribe letra por letra; si la exposicion es alta, tiembla
    if (pasado > 5300) {
      sombraMiraX = 960;
      sombraMiraY = 930;
      String veredicto = "Casi no saben nada de ti.";
      if (exposicion >= 25) {
        veredicto = "La sombra te tiene en la mira.";
      }
      if (exposicion >= 55) {
        veredicto = "La sombra ya sabe demasiado.";
      }
      int letras = constrain((pasado - 5300) / 35, 0, veredicto.length());
      if (letras > letrasSonadasCierre + 1) {
        letrasSonadasCierre = letras;
        sonidosCargadosSample[4].trigger();
      }
      float tiembla = 0;
      if (exposicion >= 55) {
        tiembla = random(-1.5, 1.5);
      }
      String escrito = veredicto.substring(0, letras);
      textFont(fuente);
      textAlign(CENTER, CENTER);
      textSize(40 * e);
      fill(0, 150);
      text(escrito, width / 2 + (3 + tiembla) * e, 933 * e);
      fill(230, 205, 190);
      text(escrito, width / 2 + tiembla * e, 930 * e);
    }

    if (pasado > 6500) {
      fill(215, 180, 130, 150 + 80 * sin(millis() * 0.006));
      textAlign(CENTER, CENTER);
      textSize(30 * e);
      text("Presione ENTER para continuar", width / 2, 1015 * e);
    }

    // SALIDA: el telon se cierra y pasa al cartel del Acto II
    if (inicioSalidaCierre >= 0) {
      float cierra = suaveTelon((millis() - inicioSalidaCierre) / 900.0);
      dibujarCortinas(1 - cierra, 1 - cierra, 0);
      if (millis() - inicioSalidaCierre > 1100) {
        etapaCierreActo1 = 1;
        inicioCierreActo1 = millis();
        inicioSalidaCierre = -1;
        letrasSonadasCierre = 0;
        sonoActo2Cierre = false;
        sonidosCargadosSample[5].trigger();
      }
    }
  } else {

    // al cerrar el Acto III no hay acto que siga: se abre el expediente completo
    if (actoCierre == 3) {
      dibujarExpedienteFinal(e, pasado);
      strokeWeight(1);
      return;
    }

    // CARTEL DEL ACTO QUE SIGUE: Acto II (cafe y dorado) o Acto III (azul noche y celeste)
    String cartelActo = "ACTO II";
    String nombreActo = "Thymos";
    String fraseActo = "Ahora son los demás quienes opinan.\nY aplauden lo que no deberían.";
    color fondoCartel = color(28, 22, 5);
    color colorFoco = color(242, 194, 48);
    color colorMota = color(255, 215, 120);
    color colorFrase = color(255, 225, 150);
    if (actoCierre == 2) {
      cartelActo = "ACTO III";
      nombreActo = "Logos";
      fraseActo = "El público se fue y el telón se cerró.\nAhora solo quedan tu cuenta y quien quiere abrirla.";
      fondoCartel = color(5, 11, 28);
      colorFoco = color(127, 212, 255);
      colorMota = color(170, 215, 255);
      colorFrase = color(190, 225, 255);
    }

    // fondo con dos focos que se mecen y polvo de luz
    background(fondoCartel);
    noStroke();
    for (int foco = 0; foco < 2; foco++) {
      float focoX = 640 + foco * 640;
      float giroFoco = sin(millis() * 0.0007 + foco * 2.1) * 0.22;
      float puntaX = focoX + sin(giroFoco) * 1100;
      fill(colorFoco, 16);
      triangle(focoX * e, -20 * e, (puntaX - 260) * e, 1080 * e, (puntaX + 260) * e, 1080 * e);
    }
    dibujarMotasCierre(colorMota, 30);
    dibujarTramaComic(colorFoco, 10);

    // ACTO II o III: las letras caen y, al llegar la ultima, suena el golpe
    dibujarLetrasCierre(cartelActo, 960, 420, 180, pasado - 500, 90, colorFoco);
    if (!sonoActo2Cierre && pasado > 500 + (cartelActo.length() - 1) * 90 + 300) {
      sonoActo2Cierre = true;
      sonidosCargadosSample[16].trigger();
    }

    // el nombre del acto: aparece creciendo con rebote y una linea que se abre debajo
    float creceNombre = reboteTelon((pasado - 1500) / 500.0);
    if (pasado > 1500) {
      pushMatrix();
      translate(width / 2, 590 * e);
      scale(0.3 + 0.7 * creceNombre);
      textFont(fuente);
      textAlign(CENTER, CENTER);
      textSize(64 * e);
      fill(0, 150);
      text(nombreActo, 4 * e, 5 * e);
      fill(255, 240, 210);
      if (actoCierre == 2) {
        fill(225, 240, 255);
      }
      text(nombreActo, 0, 0);
      popMatrix();
    }
    float abreLinea = suaveTelon((pasado - 1800) / 500.0);
    stroke(colorFoco, 170);
    strokeWeight(2 * e);
    line((960 - 220 * abreLinea) * e, 650 * e, (960 + 220 * abreLinea) * e, 650 * e);
    noStroke();

    // la frase se escribe letra por letra
    if (pasado > 2100) {
      int letras = constrain((pasado - 2100) / 30, 0, fraseActo.length());
      if (letras > letrasSonadasCierre + 1) {
        letrasSonadasCierre = letras;
        sonidosCargadosSample[4].trigger();
      }
      textFont(fuente);
      textAlign(CENTER, TOP);
      textSize(32 * e);
      fill(colorFrase);
      text(fraseActo.substring(0, letras), width / 2, 690 * e);
    }

    if (pasado > 4300) {
      fill(colorFoco, 150 + 80 * sin(millis() * 0.006));
      textAlign(CENTER, CENTER);
      textSize(30 * e);
      text("Presione ENTER para continuar", width / 2, 1000 * e);
    }

    // el telon se abre al empezar el cartel y queda recogido a los lados
    float abre = suaveTelon(pasado / 1100.0);
    dibujarCortinas(abre, abre, 0);
  }
  strokeWeight(1);
}


// ENTER en la pantalla 24: si la animacion no termino, la adelanta; si termino, avanza
void teclaCierreActo() {
  if (keyCode == ENTER || key == ENTER || key == RETURN) {
    int pasado = millis() - inicioCierreActo1;
    if (etapaCierreActo1 == 0) {
      if (pasado < 6500) {
        inicioCierreActo1 = millis() - 6500;
        for (int i = 0; i < 4; i++) {
          filaSonadaCierre[i] = true;
          selloSonadoCierre[i] = true;
        }
        puntosCierreActo1 = puntosJugador;
        puntosTerminadosCierre = true;
        letrasSonadasCierre = 100;
      } else {
        if (inicioSalidaCierre < 0) {
          inicioSalidaCierre = millis();
          sonidosCargadosSample[5].trigger();
        }
      }
    } else {
      // el expediente del Acto III: ENTER adelanta la animacion y despues empiezan los finales
      if (actoCierre == 3) {
        if (pasado < 6800) {
          inicioCierreActo1 = millis() - 6800;
          for (int k = 0; k < cantidadDatosJuego; k++) {
            selloSonadoExpediente[k] = true;
          }
          letrasSonadasCierre = 100;
        } else {
          empezarFinal();
        }
        return;
      }
      if (pasado < 4300) {
        inicioCierreActo1 = millis() - 4300;
        letrasSonadasCierre = 100;
        sonoActo2Cierre = true;
      } else {
        if (actoCierre == 1) {
          pantalla = 26;
          inicioPantallaActo2 = millis();
        } else {
          pantalla = 36;
          inicioPantallaActo3 = millis();
        }
      }
    }
  }
}


// posicion de la tarjeta de cada prueba (medidas de 1920)
float tarjetaXActo2(int i) {
  return 150 + i * 560;
}


// 26 - ACTO II - BOTONES
void dibujarBotonesActo2() {
  float e = width / 1920.0;
  int pasado = millis() - inicioPantallaActo2;

  background(28, 22, 5);
  noStroke();
  fill(242, 194, 48, 20);
  triangle(960 * e, 0, 300 * e, 1080 * e, 1620 * e, 1080 * e);
  dibujarCortinas(1, 1, 0);

  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(84 * e);
  fill(0, 140);
  text("Acto II", width / 2 + 4 * e, 144 * e);
  fill(242, 194, 48);
  text("Acto II", width / 2, 140 * e);
  textSize(30 * e);
  fill(255, 225, 150);
  text("Elige una prueba", width / 2, 215 * e);

  int seleccionado = -1;
  for (int i = 0; i < cantidadBotonesActo2; i++) {

    float entra = reboteTelon((pasado - 200 - i * 200) / 600.0);
    float x = tarjetaXActo2(i);
    float y = lerp(1200, 330, entra);
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

    boolean bloqueada = i > pruebasCompletadasActo2;
    boolean jugada = resultadoActo2[i] != 0;

    pushMatrix();
    translate((x + ancho / 2) * e, (y + alto / 2) * e);
    scale(aumento);

    // tarjeta
    fill(0, 120);
    rect((-ancho / 2 + 10) * e, (-alto / 2 + 14) * e, ancho * e, alto * e);
    if (bloqueada) {
      fill(40, 36, 28);
    } else {
      fill(60, 46, 10);
    }
    float opBloqueada = 1;
    if (bloqueada) {
      opBloqueada = 0.35;
    }
    stroke(242, 194, 48, 255 * opBloqueada);
    strokeWeight(5 * e);
    rect(-ancho / 2 * e, -alto / 2 * e, ancho * e, alto * e);
    noStroke();

    // numero grande (fuenteTitulo: la de 70 se ve borrosa a este tamaño)
    // el numero sigue la cuenta del juego: el Acto II tiene las pruebas 5, 6 y 7
    textFont(fuenteTitulo);
    textAlign(CENTER, CENTER);
    textSize(200 * e);
    fill(242, 194, 48, 255 * opBloqueada);
    text(i + 5, 0, -120 * e);

    // nombre
    textFont(fuente);
    textSize(46 * e);
    fill(255, 255 * opBloqueada);
    text(nombresPruebasActo2[i], -ancho / 2 * e + 20 * e, 40 * e, (ancho - 40) * e, 130 * e);
    textSize(26 * e);
    fill(255, 225, 150, 230 * opBloqueada);
    text(subtitulosPruebasActo2[i], -ancho / 2 * e + 30 * e, 130 * e, (ancho - 60) * e, 90 * e);

    // estado
    textSize(30 * e);
    if (jugada) {
      if (resultadoActo2[i] == 1) {
        fill(255, 210, 90);
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
        if (i >= cantidadHechasActo2) {
          fill(200, 190);
          text("En construcción", 0, 235 * e);
        } else {
          fill(255, 200, 0, 170 + 85 * sin(millis() * 0.006));
          text("Haz clic para entrar", 0, 235 * e);
        }
      }
    }
    popMatrix();
  }

  // aviso
  int pasadoAviso = millis() - inicioAvisoActo2;
  if (pasadoAviso < 2500) {
    float opacidad = 255 * (1 - constrain((pasadoAviso - 1800) / 700.0, 0, 1));
    textFont(fuente);
    textSize(34 * e);
    textAlign(CENTER, CENTER);
    float anchoAviso = textWidth(avisoActo2);
    fill(0, opacidad * 0.7);
    rect(width / 2 - anchoAviso / 2 - 30 * e, 960 * e, anchoAviso + 60 * e, 70 * e);
    fill(255, opacidad);
    text(avisoActo2, width / 2, 995 * e);
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


// clic en la pantalla 26
void clicBotonesActo2() {
  if (clicBotonSalirLobby()) {
    return;
  }
  float e = width / 1920.0;
  for (int i = 0; i < cantidadBotonesActo2; i++) {
    float x = tarjetaXActo2(i);
    boolean encima = mouseX > x * e && mouseX < (x + 500) * e && mouseY > 330 * e && mouseY < 890 * e;
    if (encima && millis() - inicioPantallaActo2 > 1200) {
      if (i > pruebasCompletadasActo2) {
        avisoActo2 = "Para desbloquear esto completa: " + nombresPruebasActo2[i - 1];
        inicioAvisoActo2 = millis();
      } else {
        if (resultadoActo2[i] != 0) {
          avisoActo2 = "Esta prueba ya no se puede jugar";
          inicioAvisoActo2 = millis();
        } else {
          if (i >= cantidadHechasActo2) {
            avisoActo2 = "Esta prueba todavía está en construcción";
            inicioAvisoActo2 = millis();
          } else {
            pruebaActual = 4 + i;
            if (i == 0) {
              textosContexto = textosContextoP5;
            }
            if (i == 1) {
              textosContexto = textosContextoP6;
            }
            if (i == 2) {
              textosContexto = textosContextoP7;
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
