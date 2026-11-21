// MODO DESARROLLADOR
// la tecla de arriba a la izquierda (la que esta al lado del 1: | o º) abre un panel con botones
// sirve para saltar a cualquier prueba, final o pantalla sin jugar todo desde el principio
// PARA LA ENTREGA: poner modoDesarrollador = false y la tecla deja de abrir el panel

boolean modoDesarrollador = true;           // false = el panel no se puede abrir
boolean consolaAbierta = false;             // true mientras se ve el panel (el juego no recibe teclas ni clics)
int inicioConsola = 0;                      // millis() en que se abrio (aparece suave)
boolean mostrarFps = false;                 // cuadros por segundo abajo a la derecha
boolean empezarPorContexto = false;         // true = los botones de las pruebas entran por la pantalla de contexto
String mensajeConsola = "Elige a donde ir. Al saltar, todo empieza desde cero.";   // aviso de abajo
color colorMensajeConsola = color(150, 160, 190);

// BOTONES: texto, lo que hace, fila y color (0 acto I, 1 acto II, 2 acto III, 3 general)
int cantidadBotonesConsola = 44;
String[] textoBotonConsola = {
  "Prueba 1", "Prueba 2", "Prueba 3", "Prueba 4", "Prueba 5", "Prueba 6", "Prueba 7", "Prueba 8", "Prueba 9",
  "Empezar por el contexto",
  "Acto I", "Acto II", "Acto III", "Cierre I", "Cierre II", "Cierre III",
  "Final rojo", "Final amarillo", "Final azul", "El que toca", "Resena roja", "Resena amarilla", "Resena azul",
  "Logo", "Menu", "Vestibulo", "Teatro",
  "0", "1", "2", "3", "4", "5",
  "0 %", "25 %", "50 %", "75 %", "100 %",
  "Quedan 10 s", "Quedan 3 s",
  "Ver fps", "Borrar logros", "Ganar logros", "Cerrar"
};
String[] comandoBotonConsola = {
  "prueba 1", "prueba 2", "prueba 3", "prueba 4", "prueba 5", "prueba 6", "prueba 7", "prueba 8", "prueba 9",
  "contexto",
  "acto 1", "acto 2", "acto 3", "cierre 1", "cierre 2", "cierre 3",
  "final 1", "final 2", "final 3", "final", "resena 1", "resena 2", "resena 3",
  "inicio", "menu", "vestibulo", "teatro",
  "palitos 0", "palitos 1", "palitos 2", "palitos 3", "palitos 4", "palitos 5",
  "expo 0", "expo 25", "expo 50", "expo 75", "expo 100",
  "tiempo 10", "tiempo 3",
  "fps", "logros borrar", "logros todos", "cerrar"
};
int[] filaBotonConsola = {
  0, 0, 0, 0, 0, 0, 0, 0, 0,
  1,
  2, 2, 2, 2, 2, 2,
  3, 3, 3, 3, 3, 3, 3,
  4, 4, 4, 4,
  5, 5, 5, 5, 5, 5,
  6, 6, 6, 6, 6,
  7, 7,
  8, 8, 8, 8
};
int[] colorBotonConsola = {
  0, 0, 0, 0, 1, 1, 1, 2, 2,
  3,
  0, 1, 2, 0, 1, 2,
  0, 1, 2, 3, 0, 1, 2,
  3, 3, 3, 3,
  3, 3, 3, 3, 3, 3,
  3, 3, 3, 3, 3,
  3, 3,
  3, 3, 3, 3
};
// donde quedo cada boton en pantalla (se calcula al dibujar y se usa en el clic)
float[] botonXConsola = new float[44];
float[] botonYConsola = new float[44];
float[] botonAnchoConsola = new float[44];
float altoBotonConsola = 0;

// FILAS: nombre a la izquierda y altura (medidas de 1920)
int cantidadFilasConsola = 9;
String[] nombreFilaConsola = {"Pruebas", "", "Actos", "Finales", "Volver a", "Palitos", "Exposicion", "Tiempo", "Otros"};
float[] yFilaConsola = {230, 296, 386, 452, 518, 608, 674, 740, 830};


// TECLAS: se llama al principio de keyPressed()
// devuelve true si la tecla es del panel (asi el juego no la recibe)
boolean teclaConsola() {
  if (!modoDesarrollador) {
    return false;
  }
  // abrir o cerrar con la tecla de al lado del 1 (teclado latino: | y °, teclado de España: º, ingles: `)
  if (key == '|' || key == '°' || key == 'º' || key == '`') {
    consolaAbierta = !consolaAbierta;
    inicioConsola = millis();
    teclaMantenida = false;
    return true;
  }
  if (!consolaAbierta) {
    return false;
  }
  teclaMantenida = false;   // que la tecla no se repita dentro del juego (el interrogante de la prueba 1 repite teclas)
  // ESC cierra el panel (key = 0 evita que Processing cierre el juego)
  if (key == ESC) {
    key = 0;
    consolaAbierta = false;
  }
  return true;
}


// aviso de abajo del panel
void escribirConsola(String texto, color colorTexto) {
  mensajeConsola = texto;
  colorMensajeConsola = colorTexto;
}


// REINICIO: deja la partida como nueva (tambien en: nueva partida de la pantalla 4)
// las primeras "jugadas" pruebas (de 0 a 9) quedan como ganadas, como si ya las hubieras jugado
void reiniciarPartida(int jugadas) {
  // apaga toda la musica de fondo (menu, pruebas, acto 3, finales) y la deja al principio
  for (int i = 0; i < cantidadSonidosAmbiente; i++) {
    sonidosCargadosAmbiente[i].pause();
    sonidosCargadosAmbiente[i].rewind();
  }
  musicaMenuIniciada = false;
  partidaEnCurso = false;

  // la introduccion y el teatro vuelven a empezar
  escenaIntro = 0;
  textoMostradoIntro = "";
  letraIntro = 0;
  tiempoLetraIntro = 0;
  textoIntroTerminado = false;
  contadorSonidoTecla = 0;
  opacidadTeatro = 0;
  sonidoTeatro = false;
  mostrarActo = false;
  inicioCartelActo1 = -1;
  letrasSonadasActo1 = 0;
  sonoGolpeActo1 = false;
  narracionIniciada = false;
  finPersonasHablando = -1;

  // valores generales
  palitos = 5;
  exposicion = 0;
  exposicionMostrada = 0;
  puntosJugador = 0;
  puntosInicioActo2 = 0;
  puntosInicioActo3 = 0;
  puntosFinActo3 = 0;
  respuestaFinal = "";
  mensajePrueba = "";
  for (int d = 0; d < cantidadDatos; d++) {
    datoFiltrado[d] = false;
  }

  // ninguna prueba jugada
  for (int i = 0; i < 4; i++) {
    resultadoActo1[i] = 0;
  }
  for (int i = 0; i < 3; i++) {
    resultadoActo2[i] = 0;
  }
  for (int i = 0; i < 2; i++) {
    resultadoActo3[i] = 0;
  }
  pruebasCompletadasActo1 = 0;
  pruebasCompletadasActo2 = 0;
  pruebasCompletadasActo3 = 0;

  // pantallas encima y efectos
  telonActivo = false;
  guiaActiva = false;
  mostrarLogros = false;
  reiniciarEfectosA3();
  cursor(ARROW);

  // las pruebas anteriores cuentan como ganadas (con 0 puntos)
  for (int p = 0; p < jugadas; p++) {
    if (p < 4) {
      resultadoActo1[p] = 1;
      pruebasCompletadasActo1 = p + 1;
    }
    if (p >= 4 && p < 7) {
      resultadoActo2[p - 4] = 1;
      pruebasCompletadasActo2 = p - 3;
    }
    if (p >= 7) {
      resultadoActo3[p - 7] = 1;
      pruebasCompletadasActo3 = p - 6;
    }
  }

  // la explicacion general (palitos, exposicion...) solo sale si empiezas desde la primera prueba
  for (int g = 0; g < cantidadGenerales; g++) {
    generalExplicado[g] = jugadas > 0;
  }
}


// entra directo a una prueba (0 = prueba 1 ... 8 = prueba 9), igual que despues del contexto
void entrarPruebaConsola(int p) {
  pruebaActual = p;
  inicioPrueba = millis();
  if (p == 0) {
    iniciarP1();
    pantalla = 9;
  }
  if (p == 1) {
    iniciarP2();
    pantalla = 14;
  }
  if (p == 2) {
    iniciarP3();
    pantalla = 18;
  }
  if (p == 3) {
    iniciarP4();
    pantalla = 21;
  }
  if (p == 4) {
    iniciarP5();
    pantalla = 27;
  }
  if (p == 5) {
    iniciarP6();
    pantalla = 30;
  }
  if (p == 6) {
    iniciarP7();
    pantalla = 33;
  }
  if (p == 7) {
    iniciarP8();
    pantalla = 37;
  }
  if (p == 8) {
    iniciarP9();
    pantalla = 40;
  }
}


// entra a la pantalla de contexto de una prueba (igual que el clic en su boton)
void entrarContextoConsola(int p) {
  pruebaActual = p;
  if (p == 0) {
    textosContexto = textosContextoP1;
  }
  if (p == 1) {
    textosContexto = textosContextoP2;
  }
  if (p == 2) {
    textosContexto = textosContextoP3;
  }
  if (p == 3) {
    textosContexto = textosContextoP4;
  }
  if (p == 4) {
    textosContexto = textosContextoP5;
  }
  if (p == 5) {
    textosContexto = textosContextoP6;
  }
  if (p == 6) {
    textosContexto = textosContextoP7;
  }
  if (p == 7) {
    textosContexto = textosContextoP8;
  }
  if (p == 8) {
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
  pantalla = 3;
}


// CLIC: se llama desde mouseClicked() mientras el panel esta abierto
void clicConsola() {
  for (int i = 0; i < cantidadBotonesConsola; i++) {
    boolean encima = mouseX > botonXConsola[i] && mouseX < botonXConsola[i] + botonAnchoConsola[i] && mouseY > botonYConsola[i] && mouseY < botonYConsola[i] + altoBotonConsola;
    if (encima) {
      sonidosCargadosSample[3].trigger();
      accionConsola(comandoBotonConsola[i]);
    }
  }
}


// LO QUE HACE CADA BOTON
// la accion se separa en nombre y numero: "prueba 8" = nombre "prueba" y numero 8 (-1 si no tiene)
void accionConsola(String accion) {
  String nombre = accion;
  int numero = -1;
  int espacio = accion.indexOf(" ");
  if (espacio >= 0) {
    nombre = accion.substring(0, espacio);
    numero = int(accion.substring(espacio + 1));   // en "logros borrar" da 0 (no se usa)
  }

  // PRUEBAS: todo desde cero y las anteriores ganadas
  if (nombre.equals("prueba")) {
    reiniciarPartida(numero - 1);
    if (empezarPorContexto) {
      entrarContextoConsola(numero - 1);
    } else {
      entrarPruebaConsola(numero - 1);
    }
    consolaAbierta = false;
    escribirConsola("Prueba " + numero + " desde cero. Las anteriores cuentan como ganadas.", colorBienConsola());
  }
  if (nombre.equals("contexto")) {
    empezarPorContexto = !empezarPorContexto;
    if (empezarPorContexto) {
      escribirConsola("Las pruebas empiezan por su contexto.", colorBienConsola());
    } else {
      escribirConsola("Las pruebas empiezan directo.", colorBienConsola());
    }
  }

  // ACTOS: los botones del acto, con los actos anteriores ganados
  if (nombre.equals("acto")) {
    if (numero == 1) {
      reiniciarPartida(0);
      pantalla = 8;
    }
    if (numero == 2) {
      reiniciarPartida(4);
      pantalla = 26;
      inicioPantallaActo2 = millis();
    }
    if (numero == 3) {
      reiniciarPartida(7);
      pantalla = 36;
      inicioPantallaActo3 = millis();
    }
    consolaAbierta = false;
    escribirConsola("Acto " + numero + " desde cero.", colorBienConsola());
  }

  // CIERRE DE UN ACTO: con todas sus pruebas ganadas (el cierre III lleva al expediente y a los finales)
  if (nombre.equals("cierre")) {
    if (numero == 1) {
      reiniciarPartida(4);
    }
    if (numero == 2) {
      reiniciarPartida(7);
    }
    if (numero == 3) {
      reiniciarPartida(9);
    }
    empezarCierreActo(numero);
    consolaAbierta = false;
    escribirConsola("Cierre del acto " + numero + ".", colorBienConsola());
  }

  // FINALES Y RESENA ("final" sin numero = el que toque segun la partida)
  if (nombre.equals("final") || nombre.equals("resena")) {
    reiniciarPartida(9);
    empezarFinal();
    if (numero >= 1) {
      finalElegido = numero - 1;
    }
    if (nombre.equals("resena")) {
      empezarResena();
    }
    consolaAbierta = false;
    escribirConsola("Final " + (finalElegido + 1) + ": " + nombreFinal[finalElegido], colorBienConsola());
  }

  // PANTALLAS DEL PRINCIPIO
  if (nombre.equals("inicio")) {
    reiniciarPartida(0);
    pantalla = 1;
    faseLogo = 0;
    opacidadLogo = 0;
    tiempo = 0;
    consolaAbierta = false;
  }
  if (nombre.equals("menu")) {
    reiniciarPartida(0);
    pantalla = 2;
    consolaAbierta = false;
  }
  if (nombre.equals("vestibulo")) {
    reiniciarPartida(0);
    pantalla = 3;
    consolaAbierta = false;
  }
  if (nombre.equals("teatro")) {
    // el teatro con el publico y el narrador (despues sale el cartel del ACTO I)
    reiniciarPartida(0);
    pantalla = 6;
    consolaAbierta = false;
  }

  // VALORES: cambian en el momento, sin reiniciar nada
  if (nombre.equals("palitos")) {
    palitos = numero;
    escribirConsola("Palitos: " + palitos + ". Con 0 la prueba se pierde.", colorBienConsola());
  }
  if (nombre.equals("expo")) {
    exposicion = numero;
    escribirConsola("Exposicion: " + numero + " %", colorBienConsola());
  }
  if (nombre.equals("tiempo")) {
    // el contador calcula lo que queda con inicioPrueba: se corre hacia atras para que queden esos segundos
    inicioPrueba = millis() - duracionPrueba + numero * 1000;
    escribirConsola("Quedan " + numero + " s (si la prueba tiene tiempo).", colorBienConsola());
  }

  // OTROS
  if (nombre.equals("fps")) {
    mostrarFps = !mostrarFps;
  }
  if (accion.equals("logros borrar") || accion.equals("logros todos")) {
    for (int i = 0; i < cantidadLogros; i++) {
      logroGanado[i] = accion.equals("logros todos");
    }
    guardarLogros();
    if (accion.equals("logros todos")) {
      escribirConsola("Todos los logros ganados.", colorBienConsola());
    } else {
      escribirConsola("Logros borrados.", colorBienConsola());
    }
  }
  if (nombre.equals("cerrar")) {
    consolaAbierta = false;
  }
}


color colorBienConsola() {
  return color(127, 212, 255);
}


// color de fondo de un boton segun su acto
color fondoBotonConsola(int tipo) {
  if (tipo == 0) {
    return color(130, 34, 48);
  }
  if (tipo == 1) {
    return color(140, 104, 26);
  }
  if (tipo == 2) {
    return color(34, 74, 160);
  }
  return color(42, 48, 76);
}


// true si el boton muestra algo que esta activo ahora (se dibuja con borde blanco)
boolean botonActivoConsola(int i) {
  String accion = comandoBotonConsola[i];
  if (accion.equals("contexto")) {
    return empezarPorContexto;
  }
  if (accion.equals("fps")) {
    return mostrarFps;
  }
  if (accion.equals("palitos " + palitos)) {
    return true;
  }
  return false;
}


// DIBUJO: se llama al final de draw(), encima de todo
void dibujarConsola() {
  float e = width / 1920.0;
  pushStyle();
  textFont(fuenteTexto);

  // cuadros por segundo
  if (mostrarFps) {
    fill(255, 220);
    textAlign(RIGHT, BOTTOM);
    textSize(22 * e);
    text(int(frameRate) + " fps", width - 20 * e, height - 10 * e);
  }

  if (consolaAbierta) {
    float aparece = suaveTelon(constrain((millis() - inicioConsola) / 200.0, 0, 1));

    // fondo oscuro y panel
    noStroke();
    fill(0, 170 * aparece);
    rect(0, 0, width, height);
    fill(10, 12, 28, 245 * aparece);
    stroke(colorBienConsola());
    strokeWeight(3 * e);
    rect(100 * e, 90 * e, 1720 * e, 920 * e);

    // titulo y estado del juego
    noStroke();
    textAlign(LEFT, BASELINE);
    textSize(34 * e);
    fill(colorBienConsola());
    text("MODO DESARROLLADOR", 140 * e, 150 * e);
    textAlign(RIGHT, BASELINE);
    textSize(20 * e);
    fill(170, 180, 210);
    text("pantalla " + pantalla + "     palitos " + palitos + "     exposicion " + int(exposicion) + " %     puntos " + puntosJugador,
      1780 * e, 148 * e);

    // nombres de las filas
    textAlign(LEFT, CENTER);
    textSize(22 * e);
    fill(150, 160, 190);
    for (int f = 0; f < cantidadFilasConsola; f++) {
      text(nombreFilaConsola[f], 140 * e, (yFilaConsola[f] + 26) * e);
    }

    // botones: cada fila empieza a la izquierda; el ancho depende del texto
    altoBotonConsola = 52 * e;
    textSize(21 * e);
    float x = 0;
    for (int i = 0; i < cantidadBotonesConsola; i++) {
      String texto = textoBotonConsola[i];
      if (comandoBotonConsola[i].equals("contexto")) {
        texto = "Empezar por el contexto: " + (empezarPorContexto ? "SI" : "NO");
      }
      if (comandoBotonConsola[i].equals("fps")) {
        texto = mostrarFps ? "Ocultar fps" : "Ver fps";
      }
      // primera de la fila: vuelve a la izquierda; si cambia el tipo de accion (acto / cierre) deja un espacio mas
      if (i == 0 || filaBotonConsola[i] != filaBotonConsola[i - 1]) {
        x = 330 * e;
      } else {
        String antes = comandoBotonConsola[i - 1];
        String ahora = comandoBotonConsola[i];
        if (!split(antes, ' ')[0].equals(split(ahora, ' ')[0])) {
          x += 30 * e;
        }
      }
      float ancho = max(110 * e, textWidth(texto) + 40 * e);
      float y = yFilaConsola[filaBotonConsola[i]] * e;
      botonXConsola[i] = x;
      botonYConsola[i] = y;
      botonAnchoConsola[i] = ancho;

      boolean encima = mouseX > x && mouseX < x + ancho && mouseY > y && mouseY < y + altoBotonConsola;
      color fondo = fondoBotonConsola(colorBotonConsola[i]);
      if (encima) {
        fondo = lerpColor(fondo, color(255), 0.25);
      }
      fill(fondo);
      if (botonActivoConsola(i)) {
        stroke(255);
        strokeWeight(3 * e);
      } else {
        stroke(255, 40);
        strokeWeight(1 * e);
      }
      rect(x, y, ancho, altoBotonConsola);
      noStroke();
      fill(255);
      textAlign(CENTER, CENTER);
      text(texto, x + ancho / 2, y + altoBotonConsola / 2 - 2 * e);
      x += ancho + 12 * e;
    }

    // aviso de abajo
    textAlign(LEFT, BASELINE);
    textSize(21 * e);
    fill(colorMensajeConsola);
    text(mensajeConsola, 140 * e, 940 * e);
    fill(110, 120, 150);
    textAlign(RIGHT, BASELINE);
    text("ESC o la tecla de al lado del 1 para cerrar", 1780 * e, 980 * e);
  }
  popStyle();
}
