// PANTALLAS 46 Y 47 - LOS FINALES Y LA RESENA DE LA OBRA
// despues del expediente: el regreso (todos vuelven al teatro y te miran), el final del acto en que peor te fue
// (con un momento jugable), un cierre en negro y la resena de la obra
// el tono es incomodo y misterioso: nunca acusa al jugador, pero le recuerda que el tambien miro

// EL FINAL QUE TOCA: 0 Epithymetikon (rojo, Eros), 1 Thymoeides (amarillo, Thymos), 2 Logistikon (azul, Logos)
int finalElegido = 0;
int etapaFinal = 0;                 // 0 el regreso, 1 la historia del final, 2 el juego, 3 el desenlace, 4 "gracias por mirar"
int lineaFinal = 0;                 // linea de texto que se esta escribiendo
int inicioLineaFinal = 0;
int inicioEtapaFinal = 0;
boolean finalGanado = false;
int letrasSonadasFinal = 0;
PImage protaBorrosoF;               // el protagonista con la cara difuminada (se prepara una vez)
PGraphics vinetaF;                  // bordes oscuros de la pantalla (se prepara una vez)
int ultimoLatidoF = 0;
int proximoDestelloF = 0;           // el ojo que aparece por un instante
int inicioDestelloF = -10000;
int ultimoCuadroF = 0;

// puntos de cada acto (se anotan al cerrar cada acto)
int puntosInicioActo2 = 0;          // puntos que tenia al terminar el Acto I
int puntosInicioActo3 = 0;          // puntos que tenia al terminar el Acto II
int puntosFinActo3 = 0;             // puntos que tenia al terminar el Acto III

// TEXTOS DEL REGRESO (la linea 2 se completa con los minutos que lleva jugando)
String[] lineasRegreso = {
  "Se encendieron las luces.",
  "Todos volvieron a sus asientos.\nNadie aplaude.",
  "",
  "Viste su cuarto. Leíste sus historias.\nAbriste sus fotos. Seguiste sus pasos.",
  "Lo hiciste para protegerlo.",
  "Eso te dijiste.",
  "Ahora te miran a ti.",
  "Víctima o responsable?"
};
int cantidadLineasRegreso = 8;

String[] nombreFinal = {"EPITHYMETIKON", "THYMOEIDES", "LOGISTIKON"};
String[] subtituloFinal = {"El deseo", "El orgullo", "La razón"};
String[] historiaFinal1 = {
  "Alguien guardó sus fotos.\nLas de esa noche, en su cuarto.",
  "Sabías a qué hora dormía, dónde estudiaba,\nqué canción escuchaba antes de salir.",
  "Alguien está publicando con su nombre.\nCon su cara. Con todo lo que se fue juntando."
};
String[] historiaFinal2 = {
  "Tú también las viste. Más de una vez.\nAhora alguien quiere que las vea todo el mundo.",
  "Se escondió.\nDe ti.",
  "El abogado dejó un código para recuperar la cuenta.\nCada letra se corrió 3 lugares."
};
String[] instruccionFinal = {
  "Entre la gente hay un policía. Es el único que siempre camina contra la corriente.\nHaz clic en él antes de que se publiquen.",
  "La linterna se gasta. Escucha su respiración.\nHaz clic cuando lo alumbres.",
  "Escribe la palabra original y pulsa ENTER\nantes de que el perfil falso termine contigo."
};
String[] desenlaceGanado = {
  "Lo encontraste. Las fotos no salieron.\nEsta vez.",
  "Lo encontraste. Te miró como se mira a un extraño.\nDías después llegó una denuncia. Tenía tu nombre.",
  "Recuperaste la cuenta. El impostor desapareció.\nLo que publicó, no."
};
String[] desenlacePerdido = {
  "Las fotos salieron.\nAlguien las está mirando ahora mismo. Como tú.",
  "No lo encontraste.\nPero seguiste buscando. Toda la noche.",
  "El perfil falso ya tiene más seguidores que el real.\nNadie notó la diferencia."
};
String[] vidaRealFinal = {
  "Si alguien te amenaza con publicar tus fotos, no pagues ni envíes más: guarda las pruebas y denuncia.",
  "Seguir obsesivamente a alguien en redes también es acoso.",
  "Activa la verificación en dos pasos y no compartas tus códigos con nadie."
};

// colores de cada final
color colorFinal(int f) {
  if (f == 0) {
    return color(215, 70, 80);
  }
  if (f == 1) {
    return color(236, 190, 70);
  }
  return color(127, 212, 255);
}

color fondoFinal(int f) {
  if (f == 0) {
    return color(20, 4, 7);
  }
  if (f == 1) {
    return color(18, 14, 5);
  }
  return color(4, 8, 22);
}


// EL JUEGO ROJO: la multitud que camina, el policia que va al reves y el celular que sube las fotos
int cantidadGenteF = 28;            // 4 filas de 7
float[] genteXF = new float[28];
int[] miraF = new int[28];          // millis() en que esa persona se detuvo a mirarte (clic equivocado)
int policiaF = 0;
int intentosF = 3;
float[] marcaXF = new float[3];
float[] marcaYF = new float[3];
int[] marcaInicioF = new int[3];
int encontradoF = -10000;
float subidaF = 0;                  // de 0 a 100: cuanto lleva subido el celular
int filaVueltaF = -1;               // una fila que se da vuelta un rato para confundir
int inicioVueltaF = -10000;
int proximaVueltaF = 0;
int ultimoFlashF = -10000;
int proximoFlashF = 0;

// EL JUEGO AMARILLO: la linterna que se gasta, la persona que se cambia de asiento y tus propios mensajes en la oscuridad
PGraphics mascaraLinternaF;
float escondidoXF = 0;
float escondidoYF = 0;
int ultimaRespiracionF = 0;
int cercaDesdeF = -1;               // millis() desde que la luz anda cerca sin hacer clic (si tarda, se cambia de asiento)
int mudanzasF = 0;
int ultimaMudanzaF = -10000;
String[] mensajesTuyosF = {
  "a qué hora sales?",
  "jaja te vi en el parque",
  "por qué no contestas",
  "subiste otra foto",
  "sé dónde estudias",
  "solo quiero hablar",
  "te vi entrar",
  "contesta"
};
int cantidadMensajesF = 8;
float[] mensajeXF = new float[8];
float[] mensajeYF = new float[8];

// EL JUEGO AZUL: el codigo cesar mientras el perfil falso publica en tu nombre
String palabraF = "PRIVADO";
String cifradaF = "";
String escritoF = "";
int[] correctaLetraF = new int[7];
int errorCodigoF = -10000;
String avisoCodigoF = "";
String alfabetoF = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
float reputacionF = 100;
int seguidoresFalsosF = 0;
String[] publicacionesFalsasF = {
  "Las fotos de mis amigos, sin filtro.",
  "Hoy no fui a clase. Adivinen dónde estoy.",
  "Mi dirección nueva, para los que preguntaban.",
  "Ya no me importa lo que piensen.",
  "Esto es lo que de verdad pienso de ustedes.",
  "Cuenta nueva? No. Soy yo. Siempre fui yo."
};
int cantidadPublicacionesF = 6;
int publicadasF = 0;                // cuantas lleva el perfil falso
int ultimaPublicacionF = 0;
int ruidoLetraF = -1;               // la letra del codigo que se distorsiona un momento
int inicioRuidoF = -10000;


// cual final toca: el del acto con mas datos filtrados (en empate, el acto mas reciente)
int elegirFinal() {
  int filtrados1 = 0;
  for (int d = 0; d < 4; d++) {
    if (datoFiltrado[d]) {
      filtrados1++;
    }
  }
  int filtrados2 = 0;
  for (int k = 0; k < 3; k++) {
    if (datoFiltrado[datosActo2[k]]) {
      filtrados2++;
    }
  }
  int filtrados3 = 0;
  for (int k = 0; k < 2; k++) {
    if (datoFiltrado[datosActo3[k]]) {
      filtrados3++;
    }
  }
  float malo1 = filtrados1 / 4.0;
  float malo2 = filtrados2 / 3.0;
  float malo3 = filtrados3 / 2.0;
  int peor = 2;
  float valor = malo3;
  if (malo2 > valor) {
    peor = 1;
    valor = malo2;
  }
  if (malo1 > valor) {
    peor = 0;
  }
  return peor;
}


// cifra una palabra corriendo cada letra 3 lugares (con substring e indexOf)
String cifrarF(String palabra) {
  String resultado = "";
  for (int i = 0; i < palabra.length(); i++) {
    int lugar = alfabetoF.indexOf(palabra.substring(i, i + 1));
    int nuevo = (lugar + 3) % 26;
    resultado = resultado + alfabetoF.substring(nuevo, nuevo + 1);
  }
  return resultado;
}


// empieza los finales (lo llama el expediente)
void empezarFinal() {
  finalElegido = elegirFinal();
  pantalla = 46;
  etapaFinal = 0;
  lineaFinal = 0;
  inicioLineaFinal = millis() + 2200;
  inicioEtapaFinal = millis();
  letrasSonadasFinal = 0;
  finalGanado = false;
  proximoDestelloF = millis() + 7000;
  ultimoCuadroF = millis();
  borrarOjosF();
  proximoOjoF = millis() + 3500;
  proximoSucesoF = millis() + 5000;
  reanudarZumbidoF = -1;
  // la linea 2 dice cuanto tiempo lleva mirando (desde que se abrio el juego)
  int minutos = max(1, millis() / 60000);
  String palabraMinutos = " minutos";
  if (minutos == 1) {
    palabraMinutos = " minuto";
  }
  lineasRegreso[2] = "Llevas " + minutos + palabraMinutos + " mirando\nla vida de alguien más.";
  prepararArteP5();
  if (protaBorrosoF == null) {
    protaBorrosoF = imagenesCargadas[60].get();
    protaBorrosoF.resize(320, 0);
    protaBorrosoF.filter(BLUR, 6);
  }
  if (vinetaF == null) {
    prepararVinetaF();
  }
  for (int p = 0; p < cantidadGenteF; p++) {
    miraF[p] = -10000;
  }
  sonidosCargadosAmbiente[9].rewind();
  sonidosCargadosAmbiente[9].loop();
  sonidosCargadosAmbiente[9].shiftGain(-40, volumenAmbiente - 4, 4000);
}


// los bordes oscuros de la pantalla: transparente al centro y negro hacia las orillas (se hace una vez)
void prepararVinetaF() {
  vinetaF = createGraphics(480, 270);
  vinetaF.beginDraw();
  vinetaF.loadPixels();
  for (int py = 0; py < 270; py++) {
    for (int px = 0; px < 480; px++) {
      float dx = (px - 240) / 240.0;
      float dy = (py - 135) / 135.0;
      float d = sqrt(dx * dx + dy * dy);
      float oscuro = constrain((d - 0.55) / 0.6, 0, 1);
      vinetaF.pixels[py * 480 + px] = color(0, 235 * oscuro * oscuro);
    }
  }
  vinetaF.updatePixels();
  vinetaF.endDraw();
}


// LOS OJOS: aparecen en la oscuridad, siguen al mouse, parpadean; si te acercas se cierran y se esconden
// (y a veces vuelven de a dos en otro lugar)
int cantidadOjosF = 10;
boolean[] ojoActivoF = new boolean[10];
float[] ojoXF = new float[10];
float[] ojoYF = new float[10];
float[] ojoTamF = new float[10];
int[] ojoNaceF = new int[10];
int[] ojoVidaF = new int[10];
int[] ojoCierraF = new int[10];        // millis() en que empezo a cerrarse antes de tiempo (-1 = no)
int[] ojoParpadeoF = new int[10];      // millis() del proximo parpadeo
boolean[] ojoHuyeF = new boolean[10];  // ya se escondio una vez (al esconderse aparecen otros dos)
int proximoOjoF = 0;

// LOS SUCESOS: cada tanto pasa algo (un susurro, golpes, estatica, una cajita de musica, una risa, un respiro)
int proximoSucesoF = 0;
int sucesoF = -1;
int inicioSucesoF = -10000;
String palabraSucesoF = "";
float palabraXF = 0;
float palabraYF = 0;
String[] palabrasF = {"te veo", "sigues aquí", "mírame", "no te vayas", "ya lo sabías", "otra vez tú", "por qué miras"};
int cantidadPalabrasF = 7;
int reanudarZumbidoF = -1;             // millis() en que vuelve el zumbido despues de un silencio


// nace un ojo en (x, y) de tamano tam (medidas de 1920)
void nacerOjoF(float x, float y, float tam, int vida, boolean huye) {
  for (int o = 0; o < cantidadOjosF; o++) {
    if (!ojoActivoF[o]) {
      ojoActivoF[o] = true;
      ojoXF[o] = x;
      ojoYF[o] = y;
      ojoTamF[o] = tam;
      ojoNaceF[o] = millis();
      ojoVidaF[o] = vida;
      ojoCierraF[o] = -1;
      ojoParpadeoF[o] = millis() + int(random(900, 2200));
      ojoHuyeF[o] = huye;
      return;
    }
  }
}


// un lugar en los bordes de la pantalla (lejos del texto del centro)
void nacerOjoBordeF(float tam) {
  float x = random(140, 1780);
  float y = random(380, 980);
  if (random(1) < 0.5) {
    x = random(120, 420);
    if (random(1) < 0.5) {
      x = random(1500, 1800);
    }
    y = random(140, 980);
  }
  nacerOjoF(x, y, tam, int(random(3500, 6000)), false);
}


// borra los ojos (al cambiar de etapa)
void borrarOjosF() {
  for (int o = 0; o < cantidadOjosF; o++) {
    ojoActivoF[o] = false;
  }
}


// UN OJO: almendra palida con venitas, iris rojo oscuro y pupila que sigue al mouse (y se dilata si el mouse se mueve rapido)
void dibujarUnOjoF(float x, float y, float tam, float apertura, float opacidad) {
  float e = width / 1920.0;
  if (apertura <= 0.02) {
    // cerrado: solo la linea del parpado
    stroke(160, 140, 140, 120 * opacidad);
    strokeWeight(3 * e);
    line((x - tam * 0.5) * e, y * e, (x + tam * 0.5) * e, y * e);
    noStroke();
    return;
  }
  float ancho = tam;
  float alto = tam * 0.42 * apertura;
  noStroke();
  fill(0, 160 * opacidad);
  ellipse(x * e, y * e, (ancho + 30) * e, (alto + 30) * e);
  fill(232, 222, 218, 235 * opacidad);
  ellipse(x * e, y * e, ancho * e, alto * e);
  // venitas
  stroke(170, 40, 50, 110 * opacidad);
  strokeWeight(1.5 * e);
  for (int v = 0; v < 4; v++) {
    float lado = -1;
    if (v % 2 == 1) {
      lado = 1;
    }
    float a = (v / 2) * 0.5 - 0.25;
    line((x + lado * ancho * 0.48) * e, (y + a * alto) * e, (x + lado * ancho * 0.28) * e, (y + a * alto * 0.4) * e);
  }
  noStroke();
  // iris y pupila: miran al mouse
  float miraX = constrain((mouseX / e - x) / 18.0, -ancho * 0.22, ancho * 0.22);
  float miraY = constrain((mouseY / e - y) / 30.0, -alto * 0.18, alto * 0.18);
  float rapidez = dist(mouseX, mouseY, pmouseX, pmouseY);
  float pupila = tam * (0.12 + constrain(rapidez / 400.0, 0, 0.12));
  float iris = min(tam * 0.36, alto * 0.95);
  fill(110, 18, 24, 255 * opacidad);
  ellipse((x + miraX) * e, (y + miraY) * e, iris * e, iris * e);
  fill(5, 0, 0, 255 * opacidad);
  ellipse((x + miraX) * e, (y + miraY) * e, min(pupila, iris * 0.8) * e, min(pupila, iris * 0.8) * e);
  fill(255, 200 * opacidad);
  ellipse((x + miraX - iris * 0.18) * e, (y + miraY - iris * 0.18) * e, iris * 0.14 * e, iris * 0.14 * e);
  // parpados oscuros encima y abajo
  stroke(20, 10, 12, 220 * opacidad);
  strokeWeight(4 * e);
  noFill();
  arc(x * e, y * e, ancho * e, alto * e, PI + 0.15, TWO_PI - 0.15);
  arc(x * e, y * e, ancho * e, alto * e, 0.15, PI - 0.15);
  noStroke();
}


// mueve y dibuja los ojos: se abren, miran, parpadean y se cierran; si el mouse se acerca, se esconden
void dibujarOjosF(float e) {
  for (int o = 0; o < cantidadOjosF; o++) {
    if (ojoActivoF[o]) {
      int edad = millis() - ojoNaceF[o];
      float apertura = constrain(edad / 700.0, 0, 1);
      // se cierra al final de su vida, o antes si se esta escondiendo
      int faltan = ojoVidaF[o] - edad;
      if (faltan < 500) {
        apertura = min(apertura, constrain(faltan / 500.0, 0, 1));
      }
      if (ojoCierraF[o] >= 0) {
        apertura = min(apertura, 1 - constrain((millis() - ojoCierraF[o]) / 160.0, 0, 1));
        if (millis() - ojoCierraF[o] > 200) {
          ojoActivoF[o] = false;
          // se escondio: en un rato aparecen dos en otros lugares
          if (!ojoHuyeF[o]) {
            nacerOjoF(random(200, 1720), random(300, 950), ojoTamF[o] * 0.6, 2600, true);
            nacerOjoF(random(200, 1720), random(300, 950), ojoTamF[o] * 0.6, 2900, true);
          }
        }
      }
      if (faltan <= 0) {
        ojoActivoF[o] = false;
      }
      // parpadeo (con su sonido humedo)
      int pasadoParpadeo = millis() - ojoParpadeoF[o];
      if (pasadoParpadeo > 0 && pasadoParpadeo < 180) {
        apertura *= abs3F(pasadoParpadeo - 90) / 90.0;
      }
      if (pasadoParpadeo >= 180) {
        ojoParpadeoF[o] = millis() + int(random(1200, 3200));
        if (ojoTamF[o] > 100) {
          sonidosCargadosSample[59].trigger();
        }
      }
      // si el mouse se acerca, se esconde de golpe
      if (ojoCierraF[o] < 0 && apertura > 0.6 && dist(mouseX / e, mouseY / e, ojoXF[o], ojoYF[o]) < ojoTamF[o] * 0.9) {
        ojoCierraF[o] = millis();
        sonidosCargadosSample[59].trigger();
      }
      if (ojoActivoF[o]) {
        dibujarUnOjoF(ojoXF[o], ojoYF[o], ojoTamF[o], apertura, 1);
      }
    }
  }
}


// numero positivo sin abs
float abs3F(float v) {
  if (v < 0) {
    return -v;
  }
  return v;
}


// cuanta tension hay (0 a 1): sube con el tiempo en cada etapa
float tensionF() {
  return constrain((millis() - inicioEtapaFinal) / 30000.0, 0, 1);
}


// LO INCOMODO: grano, bordes que respiran, latido que se acelera, ojos, sucesos al azar y un destello de un ojo enorme
void dibujarInquietudF(float e, float fuerza) {
  noStroke();
  for (int g = 0; g < 160; g++) {
    fill(255, random(6, 22) * fuerza);
    rect(random(width), random(height), 2 * e, 2 * e);
  }

  // los ojos (en el juego amarillo viven en la oscuridad; en los otros juegos casi no salen)
  if (millis() > proximoOjoF) {
    proximoOjoF = millis() + int(random(5000, 9000));
    if (etapaFinal != 2 || random(1) < 0.35) {
      nacerOjoBordeF(random(110, 180));
    }
  }
  dibujarOjosF(e);

  // los bordes se cierran y se abren como si respirara (mas cerrados con mas tension)
  float respira = 1 + 0.04 * sin(millis() * 0.0016) - 0.05 * tensionF();
  pushMatrix();
  translate(width / 2, height / 2);
  scale(respira);
  tint(255, 255 * fuerza);
  image(vinetaF, -width / 2, -height / 2, width, height);
  noTint();
  popMatrix();

  // latido: cada vez mas seguido
  int ritmoLatido = int(lerp(1600, 750, tensionF()));
  if (millis() - ultimoLatidoF > ritmoLatido) {
    ultimoLatidoF = millis();
    sonidosCargadosSample[21].trigger();
  }

  // el zumbido vuelve despues de un silencio
  if (reanudarZumbidoF > 0 && millis() > reanudarZumbidoF) {
    reanudarZumbidoF = -1;
    sonidosCargadosAmbiente[9].loop();
  }

  // LOS SUCESOS
  if (millis() > proximoSucesoF) {
    proximoSucesoF = millis() + int(random(4000, 8000));
    sucesoF = int(random(6));
    inicioSucesoF = millis();
    if (sucesoF == 0) {
      sonidosCargadosSample[56].trigger();
      palabraSucesoF = palabrasF[int(random(cantidadPalabrasF))];
      palabraXF = constrain(mouseX / e + random(-160, 160), 200, 1720);
      palabraYF = constrain(mouseY / e + random(-120, 120), 160, 1000);
    }
    if (sucesoF == 1) {
      sonidosCargadosSample[57].trigger();
    }
    if (sucesoF == 2) {
      sonidosCargadosSample[58].trigger();
    }
    if (sucesoF == 3) {
      sonidosCargadosSample[60].trigger();
    }
    if (sucesoF == 4) {
      sonidosCargadosSample[61].trigger();
    }
    if (sucesoF == 5) {
      sonidosCargadosSample[63].trigger();
    }
  }
  int pasadoSuceso = millis() - inicioSucesoF;
  // susurro: una palabra aparece cerca del mouse y se desvanece
  if (sucesoF == 0 && pasadoSuceso < 2200) {
    float op = sin(constrain(pasadoSuceso / 2200.0, 0, 1) * PI);
    fill(200, 170, 170, 170 * op);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(30 * e);
    text(palabraSucesoF, (palabraXF + sin(millis() * 0.02) * 2) * e, palabraYF * e);
  }
  // golpes: la pantalla se sacude con cada golpe
  if (sucesoF == 1 && pasadoSuceso < 1400) {
    if (pasadoSuceso < 120 || (pasadoSuceso > 420 && pasadoSuceso < 520) || (pasadoSuceso > 950 && pasadoSuceso < 1050)) {
      fill(0, 90);
      rect(0, 0, width, height);
    }
  }
  // estatica: franjas de ruido
  if (sucesoF == 2 && pasadoSuceso < 650) {
    for (int f = 0; f < 14; f++) {
      fill(random(120, 255), random(40, 110));
      rect(0, random(height), width, random(2, 14) * e);
    }
  }
  // respiro: los bordes se oscurecen un momento, como si alguien se acercara
  if (sucesoF == 5 && pasadoSuceso < 2000) {
    float acerca = sin(constrain(pasadoSuceso / 2000.0, 0, 1) * PI);
    tint(255, 200 * acerca);
    image(vinetaF, -width * 0.05, -height * 0.05, width * 1.1, height * 1.1);
    noTint();
  }

  // un ojo enorme que aparece una fraccion de segundo (casi no se alcanza a ver)
  if (millis() > proximoDestelloF) {
    inicioDestelloF = millis();
    proximoDestelloF = millis() + int(random(7000, 13000));
    sonidosCargadosSample[20].trigger();
  }
  if (millis() - inicioDestelloF < 90) {
    fill(30, 0, 4, 200);
    rect(0, 0, width, height);
    dibujarUnOjoF(960, 540, 700, 1, 1);
  }
}


// un texto con fantasmas rojo y celeste que tiemblan (como una senal que se corta)
void textoInquietoF(String texto, float x, float y, float tam, color colorTexto, float ruido) {
  float e = width / 1920.0;
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(tam * e);
  if (random(1) < 0.12 * ruido) {
    fill(255, 40, 60, 120);
    text(texto, (x + random(-6, 6)) * e, y * e);
    fill(60, 220, 255, 120);
    text(texto, (x + random(-6, 6)) * e, y * e);
  }
  fill(0, 170);
  text(texto, (x + 3) * e, (y + 3) * e);
  fill(colorTexto);
  text(texto, x * e, y * e);
}


// empieza la parte jugable del final elegido
void empezarJuegoFinal() {
  borrarOjosF();
  etapaFinal = 2;
  inicioEtapaFinal = millis();
  ultimoCuadroF = millis();
  encontradoF = -10000;
  intentosF = 3;
  for (int m = 0; m < 3; m++) {
    marcaInicioF[m] = -10000;
  }
  if (finalElegido == 0) {
    for (int p = 0; p < cantidadGenteF; p++) {
      genteXF[p] = (p % 7) * 300 + (p / 7) * 110 + random(-40, 40);
      miraF[p] = -10000;
    }
    policiaF = int(random(cantidadGenteF));
    subidaF = 0;
    filaVueltaF = -1;
    proximaVueltaF = millis() + 3500;
    proximoFlashF = millis() + 2500;
  }
  if (finalElegido == 1) {
    elegirEsconditeF();
    ultimaRespiracionF = millis();
    cercaDesdeF = -1;
    mudanzasF = 0;
    for (int m = 0; m < cantidadMensajesF; m++) {
      mensajeXF[m] = random(300, 1620);
      mensajeYF[m] = random(240, 960);
    }
    if (mascaraLinternaF == null) {
      prepararLinternaF();
    }
  }
  if (finalElegido == 2) {
    cifradaF = cifrarF(palabraF);
    escritoF = "";
    for (int i = 0; i < 7; i++) {
      correctaLetraF[i] = -1;
    }
    avisoCodigoF = "";
    reputacionF = 100;
    seguidoresFalsosF = 120;
    publicadasF = 0;
    ultimaPublicacionF = millis();
  }
}


// la persona escondida elige un asiento al azar
void elegirEsconditeF() {
  int fila = int(random(3));
  int columna = int(random(7));
  escondidoXF = 330 + columna * 210;
  escondidoYF = 520 + fila * 170;
}


// la mascara de la linterna: transparente en el centro y negra hacia los bordes (se hace una vez)
void prepararLinternaF() {
  mascaraLinternaF = createGraphics(600, 600);
  mascaraLinternaF.beginDraw();
  mascaraLinternaF.loadPixels();
  for (int py = 0; py < 600; py++) {
    for (int px = 0; px < 600; px++) {
      float d = dist(px, py, 300, 300);
      float oscuro = constrain((d - 110) / 190.0, 0, 1);
      mascaraLinternaF.pixels[py * 600 + px] = color(0, 255 * oscuro);
    }
  }
  mascaraLinternaF.updatePixels();
  mascaraLinternaF.endDraw();
}


// termina el juego y pasa al desenlace
void terminarJuegoFinal(boolean gano) {
  if (etapaFinal != 2) {
    return;
  }
  finalGanado = gano;
  borrarOjosF();
  etapaFinal = 3;
  inicioEtapaFinal = millis();
  lineaFinal = 0;
  inicioLineaFinal = millis() + 1800;
  letrasSonadasFinal = 0;
  if (gano) {
    sonidosCargadosSample[14].trigger();
  } else {
    sonidosCargadosSample[15].trigger();
  }
}


// escribe un texto letra por letra (un poco despacio, con la maquina de escribir); devuelve lo que ya se ve
String escribirF(String texto, int inicio) {
  int letras = constrain((millis() - inicio) / 48, 0, texto.length());
  if (letras > letrasSonadasFinal + 1) {
    letrasSonadasFinal = letras;
    sonidosCargadosSample[4].trigger();
  }
  return texto.substring(0, letras);
}


boolean lineaTerminadaF(String texto) {
  return (millis() - inicioLineaFinal) / 48 >= texto.length();
}


// 46 - LOS FINALES
void dibujarFinales() {
  float e = width / 1920.0;
  float dt = constrain((millis() - ultimoCuadroF) / 1000.0, 0, 0.05);
  ultimoCuadroF = millis();
  // la camara se acerca muy despacio mientras dura cada escena
  pushMatrix();
  if (etapaFinal == 0 || etapaFinal == 1 || etapaFinal == 3) {
    float acerca = 1 + 0.045 * tensionF();
    translate(width / 2, height / 2);
    scale(acerca);
    rotate(sin(millis() * 0.0004) * 0.004 * tensionF());
    translate(-width / 2, -height / 2);
  }
  if (etapaFinal == 0) {
    dibujarRegresoF(e);
  }
  if (etapaFinal == 1) {
    dibujarHistoriaF(e);
  }
  if (etapaFinal == 2) {
    if (finalElegido == 0) {
      dibujarMultitudF(e, dt);
    }
    if (finalElegido == 1) {
      dibujarLinternaF(e);
    }
    if (finalElegido == 2) {
      dibujarCodigoF(e, dt);
    }
  }
  if (etapaFinal == 3) {
    dibujarDesenlaceF(e);
  }
  if (etapaFinal == 4) {
    dibujarGraciasF(e);
  }
  popMatrix();
  dibujarChispasA3(e);
  // durante los juegos lo incomodo es mas suave, para que se lean los textos de las esquinas
  if (etapaFinal == 2) {
    dibujarInquietudF(e, 0.5);
  }
  if (etapaFinal != 2 && etapaFinal != 4) {
    dibujarInquietudF(e, 1);
  }
}


// la gente del publico: siluetas a oscuras; desde "Ahora te miran a ti" se les abren los ojos y siguen al mouse
void dibujarPublicoF(float e, int pasado, boolean miran) {
  for (int fila = 0; fila < 3; fila++) {
    for (int k = 0; k < 9; k++) {
      int p = fila * 9 + k;
      float sube = reboteTelon((pasado - 600 - fila * 350 - k * 70) / 600.0);
      float x = 120 + k * 210 + (fila % 2) * 100;
      float y = 640 + fila * 140 + (1 - sube) * 300;
      if (sube > 0) {
        tint(170, 160, 160, 255 * constrain(sube, 0, 1));
        image(siluetaArteP5[(k + fila) % 5], (x - 90) * e, (y - 70) * e);
        noTint();
        // los ojos se abren uno por uno, despacio, y miran hacia el mouse
        if (miran) {
          float abre = constrain((millis() - inicioLineaFinal - p * 90) / 400.0, 0, 1);
          if (lineaFinal > 6) {
            abre = 1;
          }
          if (abre > 0) {
            float miraX = constrain((mouseX / e - x) / 120.0, -3, 3);
            float miraY = constrain((mouseY / e - y) / 120.0, -2, 2);
            noStroke();
            fill(240, 230, 225, 230 * abre);
            ellipse((x - 10) * e, (y + 2) * e, 11 * e, 7 * abre * e);
            ellipse((x + 10) * e, (y + 2) * e, 11 * e, 7 * abre * e);
            fill(20, 0, 0, 255 * abre);
            ellipse((x - 10 + miraX) * e, (y + 2 + miraY) * e, 4 * e, 4 * e);
            ellipse((x + 10 + miraX) * e, (y + 2 + miraY) * e, 4 * e, 4 * e);
          }
        }
      }
    }
  }
}


// EL REGRESO: casi a oscuras; el publico vuelve sin aplaudir, el texto te recuerda lo que miraste y despues todos te miran
void dibujarRegresoF(float e) {
  int pasado = millis() - inicioEtapaFinal;
  background(8, 5, 8);
  noStroke();
  float luz = constrain(pasado / 2500.0, 0, 1) * (0.85 + 0.15 * sin(millis() * 0.013) * sin(millis() * 0.007));
  fill(255, 230, 200, 16 * luz);
  triangle(960 * e, 0, 300 * e, 1080 * e, 1620 * e, 1080 * e);
  dibujarMotasCierre(color(255, 225, 200), 14);

  dibujarPublicoF(e, pasado, lineaFinal >= 6);

  // la persona de adelante: en la ultima linea un foco cae sobre ella (la cara borrosa)
  if (lineaFinal >= 7) {
    float foco = suaveTelon((millis() - inicioLineaFinal + 400) / 1400.0);
    fill(0, 170 * foco);
    rect(0, 0, width, height);
    fill(255, 240, 210, 36 * foco);
    triangle(960 * e, -20 * e, 720 * e, 1080 * e, 1200 * e, 1080 * e);
    fill(255, 240, 210, 26 * foco);
    ellipse(960 * e, 1000 * e, 480 * e, 80 * e);
    if (protaBorrosoF != null) {
      float alto = 320.0 * protaBorrosoF.height / protaBorrosoF.width;
      float tiembla = random(-1, 1) * foco;
      tint(220, 210, 215, 255 * foco);
      image(protaBorrosoF, (960 - 160 + tiembla) * e, (1010 - alto) * e, 320 * e, alto * e);
      noTint();
    }
  }

  dibujarTramaComic(color(150, 110, 100), 6);
  // las lineas: aparecen en el centro, una por una, despacio
  if (millis() > inicioLineaFinal && lineaFinal < cantidadLineasRegreso) {
    String texto = lineasRegreso[lineaFinal];
    String visible = escribirF(texto, inicioLineaFinal);
    float tam = 44;
    color colorTexto = color(235, 222, 210);
    if (lineaFinal == 5) {
      // "Eso te dijiste." aparece de golpe, mas chico, casi en un susurro
      visible = texto;
      tam = 34;
      colorTexto = color(170, 150, 150);
    }
    if (lineaFinal == 7) {
      tam = 78;
      colorTexto = colorFinal(finalElegido);
    }
    textoInquietoF(visible, 960, 230, tam, colorTexto, 1);
    if (lineaTerminadaF(texto) || lineaFinal == 5) {
      fill(200, 180, 170, 90 + 60 * sin(millis() * 0.004));
      textSize(24 * e);
      text("ENTER", 960 * e, 1040 * e);
    }
  }
  float abre = suaveTelon(pasado / 2400.0);
  dibujarCortinas(abre, abre, 0);
}


// LA HISTORIA DEL FINAL: el nombre cae letra por letra en su color y se cuenta, despacio, lo que paso
void dibujarHistoriaF(float e) {
  int pasado = millis() - inicioEtapaFinal;
  color colorF = colorFinal(finalElegido);
  background(fondoFinal(finalElegido));
  noStroke();
  // un solo foco que se mece, como una lampara colgando
  float puntaX = 960 + sin(millis() * 0.0009) * 260;
  fill(colorF, 14);
  triangle(960 * e, -20 * e, (puntaX - 300) * e, 1080 * e, (puntaX + 300) * e, 1080 * e);
  dibujarMotasCierre(colorF, 18);
  dibujarTramaComic(colorF, 8);

  dibujarLetrasCierre(nombreFinal[finalElegido], 960, 230, 130, pasado - 300, 90, colorF);
  if (pasado > 1700) {
    float aparece = constrain((pasado - 1700) / 900.0, 0, 1);
    fill(220, 210, 200, 200 * aparece);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(40 * e);
    text(subtituloFinal[finalElegido], 960 * e, 345 * e);
  }

  String[] lineas = {historiaFinal1[finalElegido], historiaFinal2[finalElegido], instruccionFinal[finalElegido]};
  for (int l = 0; l <= min(lineaFinal, 2); l++) {
    String visible = lineas[l];
    if (l == lineaFinal) {
      if (millis() < inicioLineaFinal) {
        visible = "";
      } else {
        visible = escribirF(lineas[l], inicioLineaFinal);
      }
    }
    float tam = 36;
    color colorTexto = color(232, 222, 212);
    if (l == 2) {
      tam = 28;
      colorTexto = colorF;
    }
    textoInquietoF(visible, 960, 500 + l * 160, tam, colorTexto, 0.5);
  }
  if (millis() > inicioLineaFinal && lineaTerminadaF(lineas[min(lineaFinal, 2)])) {
    fill(colorF, 100 + 60 * sin(millis() * 0.004));
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(24 * e);
    text("ENTER", 960 * e, 1030 * e);
  }
  float abre = suaveTelon(pasado / 1600.0);
  dibujarCortinas(abre, abre, 0);
}


// barra de lo que se acaba (arriba), con su nombre
void barraF(float e, String nombre, float lleno, color colorBarra) {
  noStroke();
  fill(0, 170);
  rect(660 * e, 28 * e, 600 * e, 24 * e);
  fill(colorBarra);
  rect(660 * e, 28 * e, 600 * e * constrain(lleno, 0, 1), 24 * e);
  fill(230, 220, 210);
  textFont(fuente);
  textAlign(RIGHT, CENTER);
  textSize(24 * e);
  text(nombre, 640 * e, 38 * e);
}


// EL JUEGO ROJO: la gente camina a la derecha; el policia siempre a la izquierda; a veces una fila entera se da vuelta
// para confundir; los flashes de camara encandilan; el celular sube las fotos y, si llega a 100, se publican
void dibujarMultitudF(float e, float dt) {
  boolean jugando = encontradoF < 0;
  background(24, 6, 10);
  noStroke();
  fill(255, 220, 220, 12);
  triangle(960 * e, 0, 200 * e, 1080 * e, 1720 * e, 1080 * e);

  if (jugando) {
    subidaF += dt * 100 / 20.0;             // 20 s para subir todo
    // una fila se da vuelta 1,4 s cada tanto
    if (millis() > proximaVueltaF) {
      filaVueltaF = int(random(4));
      inicioVueltaF = millis();
      proximaVueltaF = millis() + int(random(2800, 4200));
    }
    if (millis() - inicioVueltaF > 1400) {
      filaVueltaF = -1;
    }
    // el flash de una camara
    if (millis() > proximoFlashF) {
      ultimoFlashF = millis();
      proximoFlashF = millis() + int(random(2500, 4500));
      sonidosCargadosSample[29].trigger();
    }
    if (subidaF >= 100) {
      terminarJuegoFinal(false);
    }
  }

  float[] velocidadFila = {75, 105, 130, 90};
  for (int fila = 0; fila < 4; fila++) {
    fill(46, 12, 18);
    rect(0, (420 + fila * 150 + 70) * e, width, 8 * e);
    for (int k = 0; k < 7; k++) {
      int p = fila * 7 + k;
      float rapidez = velocidadFila[fila];
      if (fila == filaVueltaF) {
        rapidez = -rapidez;
      }
      if (p == policiaF) {
        rapidez = -velocidadFila[fila] * 0.9;
      }
      boolean mirando = millis() - miraF[p] < 2500;
      if (jugando && !mirando) {
        genteXF[p] += rapidez * dt;
        if (genteXF[p] > 2050) {
          genteXF[p] -= 2200;
        }
        if (genteXF[p] < -130) {
          genteXF[p] += 2200;
        }
      }
      float x = genteXF[p];
      float y = 420 + fila * 150;
      float paso = sin(millis() * 0.012 + p * 1.7) * 5;
      if (paso < 0) {
        paso = -paso;
      }
      if (mirando) {
        paso = 0;
      }
      float inclina = 0.07;
      if (rapidez < 0) {
        inclina = -0.07;
      }
      if (mirando) {
        inclina = 0;
      }
      pushMatrix();
      translate(x * e, (y - paso) * e);
      rotate(inclina);
      scale(0.75);
      tint(190, 170, 170);
      image(siluetaArteP5[p % 5], -90 * e, -70 * e);
      noTint();
      // el que clicaste mal se queda quieto y te mira
      if (mirando) {
        fill(245, 235, 230);
        ellipse(-10 * e, 2 * e, 12 * e, 8 * e);
        ellipse(10 * e, 2 * e, 12 * e, 8 * e);
        fill(120, 0, 10);
        ellipse(-10 * e, 2 * e, 5 * e, 5 * e);
        ellipse(10 * e, 2 * e, 5 * e, 5 * e);
      }
      popMatrix();
    }
  }

  // las X de los intentos equivocados
  for (int m = 0; m < 3; m++) {
    int pasadoMarca = millis() - marcaInicioF[m];
    if (pasadoMarca < 900) {
      float crece = reboteTelon(pasadoMarca / 200.0);
      stroke(230, 60, 60, 255 * (1 - pasadoMarca / 900.0));
      strokeWeight(12 * e);
      line((marcaXF[m] - 34 * crece) * e, (marcaYF[m] - 34 * crece) * e, (marcaXF[m] + 34 * crece) * e, (marcaYF[m] + 34 * crece) * e);
      line((marcaXF[m] + 34 * crece) * e, (marcaYF[m] - 34 * crece) * e, (marcaXF[m] - 34 * crece) * e, (marcaYF[m] + 34 * crece) * e);
      noStroke();
    }
  }

  // el flash encandila
  int pasadoFlash = millis() - ultimoFlashF;
  if (pasadoFlash < 260) {
    fill(255, 250, 245, 230 * (1 - pasadoFlash / 260.0));
    rect(0, 0, width, height);
  }

  // el celular que sube las fotos, abajo a la derecha
  pushMatrix();
  translate(1700 * e, 900 * e);
  rotate(-0.08 + sin(millis() * 0.004) * 0.02);
  // el celular de la prueba 7 (la version blanca, oscurecida para la escena roja)
  tint(80, 55, 60);
  image(imagenesCargadas[141], -87 * e, -130 * e, 174 * e, 260 * e);
  noTint();
  fill(215, 70, 80);
  rect(-58 * e, 60 * e, 116 * e * constrain(subidaF / 100.0, 0, 1), 14 * e);
  fill(230, 220, 210);
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(22 * e);
  text("Subiendo", 0, -60 * e);
  textSize(40 * e);
  text(int(constrain(subidaF, 0, 100)) + " %", 0, 0);
  popMatrix();

  // encontrado: todo se oscurece menos el policia, que muestra su placa
  if (!jugando) {
    int pasadoEncontrado = millis() - encontradoF;
    float x = genteXF[policiaF];
    float y = 420 + (policiaF / 7) * 150;
    fill(0, 190 * constrain(pasadoEncontrado / 300.0, 0, 1));
    rect(0, 0, width, height);
    fill(255, 240, 200, 50);
    triangle(x * e, -20 * e, (x - 200) * e, 1080 * e, (x + 200) * e, 1080 * e);
    pushMatrix();
    translate(x * e, y * e);
    scale(0.75 * (1 + 0.2 * reboteTelon(pasadoEncontrado / 400.0)));
    image(siluetaArteP5[policiaF % 5], -90 * e, -70 * e);
    popMatrix();
    float placa = reboteTelon((pasadoEncontrado - 300) / 400.0);
    if (pasadoEncontrado > 300) {
      pushMatrix();
      translate(x * e, (y - 140) * e);
      scale(placa);
      fill(14, 18, 40);
      ellipse(0, 0, 90 * e, 90 * e);
      fill(236, 190, 70);
      for (int punta = 0; punta < 5; punta++) {
        float a = -HALF_PI + punta * TWO_PI / 5;
        triangle(0, 0, cos(a - 0.4) * 22 * e, sin(a - 0.4) * 22 * e, cos(a) * 40 * e, sin(a) * 40 * e);
        triangle(0, 0, cos(a + 0.4) * 22 * e, sin(a + 0.4) * 22 * e, cos(a) * 40 * e, sin(a) * 40 * e);
      }
      fill(255);
      textFont(fuente);
      textAlign(CENTER, CENTER);
      textSize(30 * e);
      text("POLICÍA", 0, 70 * e);
      popMatrix();
    }
    if (pasadoEncontrado > 2400) {
      terminarJuegoFinal(true);
    }
  }

  textFont(fuente);
  textAlign(LEFT, CENTER);
  textSize(30 * e);
  fill(255, 210, 210);
  text("Intentos  " + intentosF, 80 * e, 45 * e);
  textoInquietoF("Quién camina siempre contra la corriente?", 960, 120, 30, color(240, 220, 215), 0.6);
  cursor(CROSS);
}


// EL JUEGO AMARILLO: la linterna se gasta y parpadea; si lo alumbras y no haces clic, se cambia de asiento;
// en la oscuridad flotan los mensajes que tu le mandaste
void dibujarLinternaF(float e) {
  boolean jugando = encontradoF < 0;
  int pasado = millis() - inicioEtapaFinal;
  float bateria = constrain(1 - pasado / 20000.0, 0, 1);    // 20 s
  background(20, 14, 9);
  noStroke();

  // tus mensajes, escritos en la oscuridad (solo se leen si los alumbras)
  textFont(fuente);
  textAlign(CENTER, CENTER);
  for (int m = 0; m < cantidadMensajesF; m++) {
    float flota = sin(millis() * 0.001 + m * 2) * 8;
    fill(60, 50, 40);
    rect((mensajeXF[m] - 130) * e, (mensajeYF[m] - 26 + flota) * e, 260 * e, 52 * e);
    fill(200, 190, 170);
    textSize(24 * e);
    text(mensajesTuyosF[m], mensajeXF[m] * e, (mensajeYF[m] - 3 + flota) * e);
  }

  // las filas de asientos y la cabeza que asoma
  for (int fila = 0; fila < 3; fila++) {
    for (int k = 0; k < 7; k++) {
      float x = 330 + k * 210;
      float y = 520 + fila * 170;
      if (x == escondidoXF && y == escondidoYF) {
        float asoma = sin(millis() * 0.003) * 4;
        fill(30, 22, 16);
        ellipse(x * e, (y - 62 + asoma) * e, 70 * e, 70 * e);
        fill(240, 230, 200);
        ellipse((x - 12) * e, (y - 64 + asoma) * e, 10 * e, 8 * e);
        ellipse((x + 12) * e, (y - 64 + asoma) * e, 10 * e, 8 * e);
      }
      // la butaca (la silla roja de la prueba 7)
      image(imagenesCargadas[142], (x - 75) * e, (y - 60) * e, 150 * e, 200 * e);
    }
  }

  if (jugando) {
    // la oscuridad: la linterna (cada vez mas chica y con parpadeos) y negro alrededor
    float mx = mouseX;
    float my = mouseY;
    float tam = (330 + 270 * bateria) * e;
    boolean apagon = random(1) < (1 - bateria) * 0.12;
    if (apagon) {
      fill(0);
      rect(0, 0, width, height);
    } else {
      image(mascaraLinternaF, mx - tam / 2, my - tam / 2, tam, tam);
      fill(0);
      rect(0, 0, width, my - tam / 2);
      rect(0, my + tam / 2, width, height);
      rect(0, my - tam / 2, mx - tam / 2, tam);
      rect(mx + tam / 2, my - tam / 2, width, tam);
    }
    // la respiracion, mas seguida cerca
    float distancia = dist(mx / e, my / e, escondidoXF, escondidoYF - 60);
    int ritmo = int(map(constrain(distancia, 0, 1400), 0, 1400, 420, 2400));
    if (millis() - ultimaRespiracionF > ritmo) {
      ultimaRespiracionF = millis();
      sonidosCargadosSample[18].trigger();
    }
    // si la luz anda cerca mucho rato sin que hagas clic, se escapa a otro asiento (hasta 2 veces)
    if (distancia < 160) {
      if (cercaDesdeF < 0) {
        cercaDesdeF = millis();
      }
      if (millis() - cercaDesdeF > 1300 && mudanzasF < 2) {
        mudanzasF++;
        ultimaMudanzaF = millis();
        elegirEsconditeF();
        cercaDesdeF = -1;
        sonidosCargadosSample[50].trigger();
      }
    } else {
      cercaDesdeF = -1;
    }
    // el susurro cuando se escapa
    if (millis() - ultimaMudanzaF < 1400) {
      fill(220, 200, 170, 200 * (1 - (millis() - ultimaMudanzaF) / 1400.0));
      textAlign(CENTER, CENTER);
      textSize(30 * e);
      text("no", (mx / e + 60) * e, (my / e - 70) * e);
    }
    barraF(e, "Linterna", bateria, color(236, 190, 70));
    if (bateria <= 0) {
      terminarJuegoFinal(false);
    }
    noCursor();
  } else {
    // encontrado: se encienden las luces poco a poco y la persona se queda quieta, mirandote
    int pasadoEncontrado = millis() - encontradoF;
    fill(0, 210 * (1 - constrain(pasadoEncontrado / 1200.0, 0, 1)));
    rect(0, 0, width, height);
    fill(236, 190, 70, 50);
    ellipse(escondidoXF * e, (escondidoYF - 62) * e, 180 * e, 180 * e);
    if (pasadoEncontrado > 2600) {
      terminarJuegoFinal(true);
    }
    cursor(ARROW);
  }
  textoInquietoF("Dónde se escondió?", 960, 120, 30, color(240, 225, 200), 0.6);
}


// EL JUEGO AZUL: la palabra cifrada y el alfabeto de ayuda; mientras tanto el perfil falso publica en tu nombre
// (las publicaciones se amontonan a los lados, sus seguidores suben y tu reputacion baja)
void dibujarCodigoF(float e, float dt) {
  background(4, 8, 22);
  noStroke();
  fill(150, 195, 255, 12);
  triangle(960 * e, 90 * e, 260 * e, 1080 * e, 1660 * e, 1080 * e);
  dibujarTramaComic(color(46, 107, 230), 8);
  color celeste = colorFinal(2);

  // el perfil falso publica cada 2,5 s y la reputacion baja sola (45 s)
  if (etapaFinal == 2) {
    reputacionF -= 100 / 45.0 * dt;
    if (millis() - ultimaPublicacionF > 2500) {
      ultimaPublicacionF = millis();
      publicadasF++;
      seguidoresFalsosF += int(random(80, 260));
      sonidosCargadosSample[6].trigger();
    }
    if (reputacionF <= 0) {
      terminarJuegoFinal(false);
    }
  }

  // las publicaciones falsas, amontonadas a los lados (las ultimas 4 de cada lado)
  for (int k = max(0, publicadasF - 8); k < publicadasF; k++) {
    boolean izquierda = k % 2 == 0;
    float x = 40;
    if (!izquierda) {
      x = 1480;
    }
    float y = 640 + ((k / 2) % 4) * 100 - (publicadasF - k) * 6;
    float entra = reboteTelon((millis() - ultimaPublicacionF) / 400.0);
    if (k < publicadasF - 1) {
      entra = 1;
    }
    float giro = (k % 3 - 1) * 0.04;
    pushMatrix();
    translate((x + 200) * e, y * e);
    rotate(giro);
    scale(entra);
    fill(10, 14, 30);
    rect(-206 * e, -46 * e, 412 * e, 92 * e);
    fill(235, 238, 248);
    rect(-200 * e, -40 * e, 400 * e, 80 * e);
    fill(180, 60, 70);
    ellipse(-176 * e, -18 * e, 26 * e, 26 * e);
    fill(60, 64, 90);
    textFont(fuente);
    textAlign(LEFT, CENTER);
    textSize(17 * e);
    text("Publicado por ti", -156 * e, -20 * e);
    fill(30, 34, 60);
    textSize(19 * e);
    text(publicacionesFalsasF[k % cantidadPublicacionesF], -186 * e, 12 * e);
    popMatrix();
  }

  textoInquietoF("El código del abogado", 960, 130, 34, color(235, 240, 255), 0.4);

  // la palabra cifrada; a veces una letra se distorsiona un momento
  if (millis() - inicioRuidoF > 2600 && random(1) < 0.02) {
    ruidoLetraF = int(random(7));
    inicioRuidoF = millis();
  }
  for (int i = 0; i < cifradaF.length(); i++) {
    float x = 960 + (i - 3) * 120;
    float flota = sin(millis() * 0.003 + i) * 4;
    String letra = cifradaF.substring(i, i + 1);
    boolean ruido = i == ruidoLetraF && millis() - inicioRuidoF < 250;
    if (ruido) {
      int otra = int(random(26));
      letra = alfabetoF.substring(otra, otra + 1);
    }
    fill(14, 18, 40);
    rect((x - 52) * e, (210 + flota) * e, 104 * e, 120 * e);
    fill(30, 58, 128);
    if (ruido) {
      fill(140, 40, 60);
    }
    rect((x - 46) * e, (216 + flota) * e, 92 * e, 108 * e);
    fill(255);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(70 * e);
    text(letra, x * e, (264 + flota) * e);
  }

  // el alfabeto de ayuda: la letra cifrada de abajo viene de la letra de arriba
  textSize(30 * e);
  int columnaMouse = -1;
  for (int k = 0; k < 26; k++) {
    float x = 210 + k * 58;
    boolean encima = mouseX > (x - 29) * e && mouseX < (x + 29) * e && mouseY > 400 * e && mouseY < 540 * e;
    if (encima) {
      columnaMouse = k;
      fill(celeste, 60);
      rect((x - 27) * e, 400 * e, 54 * e, 140 * e);
    }
    fill(220, 230, 255);
    text(alfabetoF.substring(k, k + 1), x * e, 430 * e);
    fill(celeste);
    text(alfabetoF.substring((k + 3) % 26, (k + 3) % 26 + 1), x * e, 510 * e);
  }
  stroke(celeste, 120);
  strokeWeight(2 * e);
  line(180 * e, 470 * e, 1740 * e, 470 * e);
  noStroke();
  fill(170, 190, 230);
  textSize(22 * e);
  text("Arriba la letra original, abajo cómo quedó cifrada", 960 * e, 570 * e);
  if (columnaMouse >= 0) {
    fill(255);
    textSize(26 * e);
    text(alfabetoF.substring((columnaMouse + 3) % 26, (columnaMouse + 3) % 26 + 1) + " viene de " + alfabetoF.substring(columnaMouse, columnaMouse + 1), 960 * e, 370 * e);
  }

  // lo que escribes: 7 casillas; despues de verificar, verdes las letras bien puestas
  float tiembla = 0;
  if (millis() - errorCodigoF < 400) {
    tiembla = sin(millis() * 0.08) * 10;
  }
  for (int i = 0; i < 7; i++) {
    float x = 960 + (i - 3) * 120 + tiembla;
    fill(14, 18, 40);
    rect((x - 52) * e, 680 * e, 104 * e, 120 * e);
    fill(240, 244, 255);
    if (correctaLetraF[i] == 1) {
      fill(130, 225, 150);
    }
    if (correctaLetraF[i] == 0) {
      fill(240, 150, 150);
    }
    rect((x - 46) * e, 686 * e, 92 * e, 108 * e);
    if (i < escritoF.length()) {
      fill(14, 18, 40);
      textSize(70 * e);
      text(escritoF.substring(i, i + 1), x * e, 734 * e);
    }
    if (i == escritoF.length() && millis() % 900 < 450) {
      fill(14, 18, 40);
      rect((x - 24) * e, 770 * e, 48 * e, 6 * e);
    }
  }
  fill(220, 230, 255);
  textSize(26 * e);
  text("Intentos  " + intentosF + "     ENTER para verificar", 960 * e, 850 * e);
  if (millis() - errorCodigoF < 2000 && avisoCodigoF.length() > 0) {
    fill(255, 140, 140);
    textSize(28 * e);
    text(avisoCodigoF, 960 * e, 910 * e);
  }
  // seguidores del perfil falso y tu reputacion
  fill(255, 150, 160);
  textAlign(LEFT, CENTER);
  textSize(24 * e);
  text("Perfil falso   " + seguidoresFalsosF + " seguidores", 60 * e, 45 * e);
  barraF(e, "Tu reputación", reputacionF / 100.0, lerpColor(color(230, 70, 70), celeste, reputacionF / 100.0));
  cursor(ARROW);
}


// EL DESENLACE: lo que paso (abierto, incomodo) y la tarjeta "En la vida real"
void dibujarDesenlaceF(float e) {
 int pasado = millis() - inicioEtapaFinal;
  color colorF = colorFinal(finalElegido);
  background(fondoFinal(finalElegido));
  noStroke();
  fill(colorF, 10);
  triangle(960 * e, 0, 360 * e, 1080 * e, 1560 * e, 1080 * e);
  dibujarMotasCierre(colorF, 14);
  dibujarTramaComic(colorF, 6);

  String texto = desenlaceGanado[finalElegido];
  if (!finalGanado) {
    texto = desenlacePerdido[finalElegido];
  }
  if (millis() > inicioLineaFinal) {
    textoInquietoF(escribirF(texto, inicioLineaFinal), 960, 330, 42, color(240, 230, 220), 0.6);
  }

  // la tarjeta "en la vida real" entra cuando termina el texto
  if (millis() > inicioLineaFinal && lineaTerminadaF(texto)) {
    int pasadoTarjeta = millis() - inicioLineaFinal - texto.length() * 48;
    float entra = reboteTelon((pasadoTarjeta - 600) / 500.0);
    if (pasadoTarjeta > 600) {
      pushMatrix();
      translate(960 * e, lerp(1300, 700, entra) * e);
      rotate(-0.015);
      fill(0, 120);
      rect(-492 * e, -122 * e, 1000 * e, 250 * e);
      fill(14, 18, 40);
      rect(-506 * e, -136 * e, 1012 * e, 262 * e);
      fill(26, 20, 18);
      rect(-500 * e, -130 * e, 1000 * e, 250 * e);
      fill(colorF);
      rect(-500 * e, -130 * e, 1000 * e, 8 * e);
      textFont(fuente);
      textAlign(CENTER, CENTER);
      textSize(28 * e);
      text("EN LA VIDA REAL", 0, -92 * e);
      fill(240, 230, 220);
      textSize(32 * e);
      text(vidaRealFinal[finalElegido], -440 * e, -60 * e, 880 * e, 160 * e);
      popMatrix();
    }
    if (pasadoTarjeta > 1500) {
      fill(colorF, 100 + 60 * sin(millis() * 0.004));
      textFont(fuente);
      textAlign(CENTER, CENTER);
      textSize(24 * e);
      text("ENTER", 960 * e, 1030 * e);
    }
  }
  cursor(ARROW);
}


// "GRACIAS POR MIRAR": todo en negro, el texto aparece despacio y un ojo se abre y se cierra
void dibujarGraciasF(float e) {
  int pasado = millis() - inicioEtapaFinal;
  background(0);
  float aparece = constrain((pasado - 900) / 1600.0, 0, 1);
  float se = 1 - constrain((pasado - 5600) / 900.0, 0, 1);
  fill(220, 210, 205, 255 * aparece * se);
  textFont(fuente);
  textAlign(CENTER, CENTER);
  textSize(48 * e);
  text("Gracias por mirar.", 960 * e, 400 * e);
  // el ojo grande: se abre muy despacio, te sigue, parpadea una vez (con su sonido) y se cierra al final
  float abre = constrain((pasado - 2200) / 2000.0, 0, 1);
  float cierra = constrain((pasado - 6200) / 900.0, 0, 1);
  float apertura = abre * (1 - cierra);
  int momentoParpadeo = pasado - 4800;
  if (momentoParpadeo > 0 && momentoParpadeo < 220) {
    apertura *= abs3F(momentoParpadeo - 110) / 110.0;
  }
  if (momentoParpadeo >= 0 && momentoParpadeo < 40) {
    sonidosCargadosSample[59].trigger();
  }
  if (pasado > 2200) {
    dibujarUnOjoF(960, 640, 340, apertura, 1);
  }
  // un grano muy fino para que no sea un negro limpio
  noStroke();
  for (int g = 0; g < 80; g++) {
    fill(255, random(4, 14));
    rect(random(width), random(height), 2 * e, 2 * e);
  }
  if (pasado > 7600) {
    empezarResena();
  }
}


// ENTER o clic: avanza las lineas de texto o pasa de etapa
void avanzarFinal() {
  if (etapaFinal == 0) {
    if (millis() < inicioLineaFinal) {
      return;
    }
    if (lineaFinal != 5 && !lineaTerminadaF(lineasRegreso[lineaFinal])) {
      inicioLineaFinal = millis() - lineasRegreso[lineaFinal].length() * 48;
      return;
    }
    lineaFinal++;
    letrasSonadasFinal = 0;
    // antes de "Eso te dijiste." hay un silencio largo
    inicioLineaFinal = millis() + 500;
    if (lineaFinal == 5) {
      inicioLineaFinal = millis() + 1600;
      sonidosCargadosAmbiente[9].pause();
      reanudarZumbidoF = millis() + 2800;
      sonidosCargadosSample[63].trigger();
    }
    if (lineaFinal == 6) {
      sonidosCargadosSample[20].trigger();
      for (int k = 0; k < 6; k++) {
        nacerOjoF(random(220, 1700), random(380, 620), random(60, 95), int(random(6000, 9000)), true);
      }
    }
    if (lineaFinal >= cantidadLineasRegreso) {
      etapaFinal = 1;
      inicioEtapaFinal = millis();
      lineaFinal = 0;
      inicioLineaFinal = millis() + 2600;
      sonidosCargadosSample[16].trigger();
    }
    return;
  }
  if (etapaFinal == 1) {
    String[] lineas = {historiaFinal1[finalElegido], historiaFinal2[finalElegido], instruccionFinal[finalElegido]};
    if (millis() < inicioLineaFinal) {
      return;
    }
    if (!lineaTerminadaF(lineas[lineaFinal])) {
      inicioLineaFinal = millis() - lineas[lineaFinal].length() * 48;
      return;
    }
    if (lineaFinal >= 2) {
      empezarJuegoFinal();
      sonidosCargadosSample[5].trigger();
      return;
    }
    lineaFinal++;
    letrasSonadasFinal = 0;
    inicioLineaFinal = millis() + 400;
    return;
  }
  if (etapaFinal == 3) {
    String texto = desenlaceGanado[finalElegido];
    if (!finalGanado) {
      texto = desenlacePerdido[finalElegido];
    }
    if (millis() < inicioLineaFinal) {
      return;
    }
    if (!lineaTerminadaF(texto)) {
      inicioLineaFinal = millis() - texto.length() * 48;
      return;
    }
    if (millis() - inicioLineaFinal - texto.length() * 48 > 1500) {
      etapaFinal = 4;
      inicioEtapaFinal = millis();
      borrarOjosF();
      sonidosCargadosSample[62].trigger();
      sonidosCargadosAmbiente[9].shiftGain(sonidosCargadosAmbiente[9].getGain(), -60, 1500);
    }
  }
}


// clic en los finales
void clicFinal() {
  if (etapaFinal != 2) {
    avanzarFinal();
    return;
  }
  float e = width / 1920.0;
  // rojo: clic en la gente
  if (finalElegido == 0 && encontradoF < 0) {
    float mx = mouseX / e;
    float my = mouseY / e;
    float px = genteXF[policiaF];
    float py = 420 + (policiaF / 7) * 150;
    if (dist(mx, my, px, py) < 75) {
      encontradoF = millis();
      sonidosCargadosSample[53].trigger();
      lanzarChispasA3(px, py - 140, 30, color(236, 190, 70), 600, 1);
      golpeA3(color(236, 190, 70));
      return;
    }
    // el que clicaste se detiene y te mira; las fotos suben mas rapido
    for (int p = 0; p < cantidadGenteF; p++) {
      if (dist(mx, my, genteXF[p], 420 + (p / 7) * 150) < 75) {
        miraF[p] = millis();
      }
    }
    intentosF--;
    subidaF += 8;
    marcaXF[intentosF % 3] = mx;
    marcaYF[intentosF % 3] = my;
    marcaInicioF[intentosF % 3] = millis();
    sonidosCargadosSample[9].trigger();
    sonidosCargadosSample[20].trigger();
    if (intentosF <= 0) {
      terminarJuegoFinal(false);
    }
  }
  // amarillo: clic cerca de la persona escondida
  if (finalElegido == 1 && encontradoF < 0) {
    if (dist(mouseX / e, mouseY / e, escondidoXF, escondidoYF - 60) < 80) {
      encontradoF = millis();
      sonidosCargadosSample[25].trigger();
      lanzarChispasA3(escondidoXF, escondidoYF - 60, 20, color(236, 190, 70), 450, 1);
    } else {
      sonidosCargadosSample[3].trigger();
    }
  }
}


// teclas en los finales: ENTER avanza; en el codigo se escriben letras, se borran y se verifica
void teclaFinal() {
  boolean enter = keyCode == ENTER || key == ENTER || key == RETURN;
  if (etapaFinal != 2) {
    if (enter) {
      avanzarFinal();
    }
    return;
  }
  if (finalElegido != 2) {
    return;
  }
  if (key == BACKSPACE && escritoF.length() > 0) {
    escritoF = escritoF.substring(0, escritoF.length() - 1);
    sonidosCargadosSample[4].trigger();
    return;
  }
  if (enter) {
    verificarCodigoF();
    return;
  }
  // solo letras (se pasan a mayuscula) y como maximo 7
  if (key != CODED) {
    String letra = ("" + key).toUpperCase();
    if (alfabetoF.indexOf(letra) >= 0 && letra.length() == 1 && escritoF.length() < 7) {
      escritoF = escritoF + letra;
      sonidosCargadosSample[4].trigger();
    }
  }
}


// verifica el codigo: largo exacto y letra por letra
void verificarCodigoF() {
  if (escritoF.length() != 7) {
    avisoCodigoF = "La palabra tiene 7 letras.";
    errorCodigoF = millis();
    sonidosCargadosSample[9].trigger();
    return;
  }
  if (escritoF.equals(palabraF)) {
    for (int i = 0; i < 7; i++) {
      correctaLetraF[i] = 1;
    }
    sonidosCargadosSample[53].trigger();
    lanzarChispasA3(960, 740, 40, colorFinal(2), 800, 1);
    golpeA3(colorFinal(2));
    terminarJuegoFinal(true);
    return;
  }
  for (int i = 0; i < 7; i++) {
    correctaLetraF[i] = 0;
    if (escritoF.substring(i, i + 1).equals(palabraF.substring(i, i + 1))) {
      correctaLetraF[i] = 1;
    }
  }
  intentosF--;
  reputacionF -= 15;
  errorCodigoF = millis();
  avisoCodigoF = "Todavía no. Las verdes ya están bien.";
  sonidosCargadosSample[9].trigger();
  if (intentosF <= 0) {
    terminarJuegoFinal(false);
  }
}


// ===================== LA RESENA DE LA OBRA (pantalla 47) =====================

String[] consejoPrueba = {
  "Antes de publicar, mira el fondo de tus fotos: una ventana dice dónde estás.",
  "Tus historias, juntas, cuentan tu rutina. Piensa quién las ve.",
  "Revisa las etiquetas antes de que aparezcan en tu perfil.",
  "No publiques tu ubicación en tiempo real ni detalles de dónde vives.",
  "Quien exige que muestres todo no es tu amigo. Puedes callar.",
  "Lee los permisos antes de aceptar. Lo que viene activado no siempre lo necesitas.",
  "Decide por ti, no por los aplausos ni por llevar la contraria.",
  "Dale a cada app solo los permisos de lo que de verdad hace.",
  "Corta la cadena temprano: publicaciones para amigos y etiquetas con revisión."
};
String[] consejoGeneral = {
  "Revisa tu configuración de privacidad cada cierto tiempo.",
  "Usa contraseñas distintas y activa la verificación en dos pasos.",
  "Si algo te hace sentir mal en redes, cuéntaselo a alguien de confianza."
};
int inicioResena = 0;
boolean selloSonadoResena = false;


void empezarResena() {
  pantalla = 47;
  inicioResena = millis();
  selloSonadoResena = false;
  sonidosCargadosAmbiente[9].shiftGain(sonidosCargadosAmbiente[9].getGain(), -50, 1500);
  sonidosCargadosSample[5].trigger();
}


// el perfil segun la partida
String perfilJugador() {
  if (exposicion < 25) {
    return "Guardián de su privacidad";
  }
  if (finalElegido == 1) {
    return "Buscador de aplausos";
  }
  if (finalElegido == 2) {
    return "Perfil expuesto";
  }
  return "Vida a la vista";
}


// 47 - LA RESENA DE LA OBRA: como un periodico de teatro
void dibujarResena() {
  float e = width / 1920.0;
  int pasado = millis() - inicioResena;
  background(12, 9, 8);
  noStroke();
  fill(255, 235, 200, 14);
  triangle(960 * e, 0, 260 * e, 1080 * e, 1660 * e, 1080 * e);
  dibujarMotasCierre(color(255, 225, 190), 18);

  // la hoja de periodico
  float cae = reboteTelon(pasado / 700.0);
  pushMatrix();
  translate(0, lerp(-1100, 0, cae) * e);
  fill(0, 130);
  rect(230 * e, 70 * e, 1480 * e, 960 * e);
  fill(14, 18, 40);
  rect(206 * e, 46 * e, 1508 * e, 988 * e);
  fill(238, 230, 210);
  rect(214 * e, 54 * e, 1492 * e, 972 * e);
  fill(60, 44, 32);
  textFont(fuenteTitulo);
  textAlign(CENTER, CENTER);
  textSize(76 * e);
  text("Reseña de la obra", 960 * e, 120 * e);
  stroke(60, 44, 32);
  strokeWeight(3 * e);
  line(260 * e, 172 * e, 1660 * e, 172 * e);
  line(960 * e, 190 * e, 960 * e, 990 * e);
  noStroke();

  // COLUMNA IZQUIERDA: los tres actos, la exposicion y los logros
  int puntosA1 = constrain(puntosInicioActo2, 0, 100);
  int puntosA2 = constrain(puntosInicioActo3 - puntosInicioActo2, 0, 100);
  int puntosA3 = constrain(puntosFinActo3 - puntosInicioActo3, 0, 100);
  int[] puntosActos = {puntosA1, puntosA2, puntosA3};
  String[] nombresActos = {"Acto I    Eros", "Acto II    Thymos", "Acto III    Logos"};
  color[] coloresActos = {color(200, 60, 70), color(220, 170, 50), color(60, 140, 220)};
  textFont(fuente);
  for (int a = 0; a < 3; a++) {
    float llena = puntosActos[a] / 100.0 * reboteTelon((pasado - 900 - a * 250) / 900.0);
    float y = 250 + a * 120;
    fill(60, 44, 32);
    textAlign(LEFT, CENTER);
    textSize(32 * e);
    text(nombresActos[a], 280 * e, y * e);
    textAlign(RIGHT, CENTER);
    text(round(llena * 100) + " %", 900 * e, y * e);
    fill(210, 198, 175);
    rect(280 * e, (y + 32) * e, 620 * e, 26 * e);
    fill(coloresActos[a]);
    rect(280 * e, (y + 32) * e, 620 * e * llena, 26 * e);
  }
  float exposicionLlena = exposicion / 100.0 * reboteTelon((pasado - 1700) / 1000.0);
  fill(60, 44, 32);
  textAlign(LEFT, CENTER);
  textSize(32 * e);
  text("Exposición final", 280 * e, 620 * e);
  textAlign(RIGHT, CENTER);
  text(round(exposicionLlena * 100) + " %", 900 * e, 620 * e);
  fill(210, 198, 175);
  rect(280 * e, 652 * e, 620 * e, 26 * e);
  fill(lerpColor(color(60, 160, 210), color(200, 40, 55), exposicionLlena));
  rect(280 * e, 652 * e, 620 * e * exposicionLlena, 26 * e);
  fill(60, 44, 32);
  textAlign(LEFT, CENTER);
  text("Logros   " + logrosGanados() + " de " + cantidadLogros, 280 * e, 740 * e);
  text("Final   " + nombreFinal[finalElegido], 280 * e, 800 * e);
  // el color del final, mas oscuro para que se lea sobre el papel
  fill(lerpColor(colorFinal(finalElegido), color(40, 30, 20), 0.45));
  if (finalGanado) {
    text("Lo lograste", 280 * e, 850 * e);
  } else {
    text("No lo lograste", 280 * e, 850 * e);
  }

  // COLUMNA DERECHA: el perfil (sello), los tres consejos y la frase del Acto II
  fill(60, 44, 32);
  textAlign(LEFT, CENTER);
  textSize(30 * e);
  text("Tu perfil", 1010 * e, 230 * e);
  int pasadoSello = pasado - 2300;
  if (pasadoSello > 0) {
    float avance = constrain(pasadoSello / 200.0, 0, 1);
    if (!selloSonadoResena && avance >= 1) {
      selloSonadoResena = true;
      sonidosCargadosSample[16].trigger();
    }
    pushMatrix();
    translate(1330 * e, 300 * e);
    rotate(-0.06);
    scale(lerp(2.2, 1, avance * avance));
    noFill();
    stroke(180, 40, 50, 230 * avance);
    strokeWeight(5 * e);
    rect(-300 * e, -42 * e, 600 * e, 84 * e);
    noStroke();
    fill(180, 40, 50, 230 * avance);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(40 * e);
    text(perfilJugador(), 0, -4 * e);
    popMatrix();
  }

  // los tres consejos: primero los de las pruebas perdidas, despues los generales
  String[] consejos = new String[3];
  int cantidadConsejos = 0;
  int[] resultados = {resultadoActo1[0], resultadoActo1[1], resultadoActo1[2], resultadoActo1[3], resultadoActo2[0], resultadoActo2[1], resultadoActo2[2], resultadoActo3[0], resultadoActo3[1]};
  for (int p = 0; p < 9; p++) {
    if (resultados[p] == 2 && cantidadConsejos < 3) {
      consejos[cantidadConsejos] = consejoPrueba[p];
      cantidadConsejos++;
    }
  }
  for (int g = 0; g < 3; g++) {
    if (cantidadConsejos < 3) {
      consejos[cantidadConsejos] = consejoGeneral[g];
      cantidadConsejos++;
    }
  }
  fill(60, 44, 32);
  textFont(fuente);
  textAlign(LEFT, CENTER);
  textSize(30 * e);
  text("Tres consejos", 1010 * e, 400 * e);
  for (int c = 0; c < 3; c++) {
    float aparece = constrain((pasado - 2700 - c * 300) / 400.0, 0, 1);
    fill(60, 44, 32, 255 * aparece);
    ellipse(1024 * e, (452 + c * 95) * e, 12 * e, 12 * e);
    textAlign(LEFT, TOP);
    textSize(23 * e);
    text(consejos[c], 1046 * e, (436 + c * 95) * e, 610 * e, 90 * e);
  }

  // la frase que escribio al final del Acto II
  fill(60, 44, 32);
  textAlign(LEFT, CENTER);
  textSize(30 * e);
  text("Lo que escribiste", 1010 * e, 760 * e);
  float aparece = constrain((pasado - 3800) / 500.0, 0, 1);
  fill(225, 214, 190, 255 * aparece);
  rect(1010 * e, 790 * e, 650 * e, 180 * e);
  fill(80, 60, 44, 255 * aparece);
  textSize(25 * e);
  textAlign(LEFT, TOP);
  String frase = trim(respuestaFinal);
  if (frase.length() == 0) {
    frase = "No escribiste nada.";
  }
  text(frase, 1030 * e, 805 * e, 610 * e, 150 * e);
  popMatrix();

  if (pasado > 4600) {
    fill(255, 225, 190, 150 + 80 * sin(millis() * 0.006));
    textFont(fuente);
    textAlign(CENTER, CENTER);
    textSize(26 * e);
    text("Presione ENTER para volver al menú", 960 * e, 1058 * e);
  }
  cursor(ARROW);
}


// ENTER en la resena: si todavia se esta armando, la adelanta; si no, vuelve al menu
void teclaResena() {
  if (keyCode == ENTER || key == ENTER || key == RETURN) {
    if (millis() - inicioResena < 4600) {
      inicioResena = millis() - 4600;
      selloSonadoResena = true;
      return;
    }
    sonidosCargadosAmbiente[9].pause();
    partidaEnCurso = false;   // la obra termino: ya no hay partida que continuar
    pantalla = 2;
  }
}
