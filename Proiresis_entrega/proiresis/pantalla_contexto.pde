// PANTALLA 10 - CONTEXTO DE LAS PRUEBAS (maquina de escribir)

// VARIABLES DEL CONTEXTO (la misma maquina de escribir de la introduccion)
int escenaContexto = 0;  // tambien en: botones del acto 1
String textoMostradoContexto = "";  // tambien en: botones del acto 1
int letraContexto = 0;  // tambien en: botones del acto 1
int tiempoLetraContexto = 0;  // tambien en: botones del acto 1
boolean textoContextoTerminado = false;  // tambien en: botones del acto 1
int contadorSonidoTeclaContexto = 0;  // tambien en: botones del acto 1
// una escena por elemento: solo la historia; los controles, el tiempo y las reglas los explica la guia de cada prueba
String[] textosContextoP1 = {  // tambien en: botones del acto 1
  "Prueba 1\nLa primera",
  "Es de noche. Estás en tu habitación\ny alguien tomó una fotografía.",
  "La cámara parece estar en la esquina superior izquierda,\napuntando hacia la cama."
};

String[] textosContextoP2 = {  // tambien en: botones del acto 1
  "Prueba 2\nSeis momentos",
  "Anoche subiste seis historias a Aporía.\nAlguien las vio... 14 veces.",
  "Cinco son tuyas. Una no la subiste tú:\nla sombra la metió en tu noche."
};

String[] textosContextoP3 = {  // tambien en: botones del acto 1
  "Prueba 3\nEl símbolo",
  "Tus amigos te etiquetaron\nen nueve fotografías.",
  "La sombra las revisa con una lupa,\nbuscando la pulsera con tu símbolo."
};

String[] textosContextoP4 = {  // tambien en: botones del acto 1
  "Prueba 4\nLa fotografía que no existe",
  "Alguien juntó tus publicaciones con ubicación\ny siguió el rastro hasta tu pasillo.",
  "La sombra viene detrás de ti,\ny sabe dónde vives."
};

String[] textosContextoP5 = {  // tambien en: botones del acto 2
  "Prueba 5\nEl en vivo",
  "Empiezas una transmisión en vivo en Aporía.\n1.204 personas te están viendo.",
  "Los comentarios no paran.\nUno dice que querer privacidad es culpa."
};

String[] textosContextoP6 = {  // tambien en: botones del acto 2
  "Prueba 6\nTérminos tramposos",
  "Aporía 2.0 ya está aquí.\nPara instalarla tienes que aceptar sus términos.",
  "Casi todo viene activado.\nY nadie lee la letra chica."
};

String[] textosContextoP7 = {  // tambien en: botones del acto 2
  "Prueba 7\nLluvia de notificaciones",
  "Lo que publicaste explotó.\nTienes más de 99 notificaciones.",
  "Todos te dicen qué hacer.\nNadie te pregunta qué quieres."
};

String[] textosContextoP8 = {  // tambien en: botones del acto 3
  "Prueba 8\nAduana de permisos",
  "Las apps quieren entrar a tu celular.\nCada una te pide algo.",
  "Algunas piden más de lo que necesitan.\nY Aporía 2.0 lo quiere todo."
};

String[] textosContextoP9 = {  // tambien en: botones del acto 3
  "Prueba 9\nLa cadena",
  "Todo empezó con una sola publicación.\nUn desconocido tiró del hilo.",
  "Ahora tú eres el Desconocido.\nSigue el rastro hasta tu propia puerta."
};

int pruebaActual = 0;                        // 0 = prueba 1 ... 8 = prueba 9 (tambien en: botones de los actos, contador)
String[] textosContexto = textosContextoP1;     // la lista que escribe la pantalla 10 (cambia segun la prueba) (tambien en: botones del acto 1)
int cantidadEscenasContexto = 3;                // escenas de la lista actual: 3 en cada prueba (tambien en: botones del acto 1)


// 10 - ACTO I - PRUEBA 1 - CONTEXTO
void dibujarContexto() {
  // CONTEXTO DE LA PRUEBA 1: misma maquina de escribir y mismo sonido que la introduccion (pantalla 5)
  background(0);

  if (!textoContextoTerminado && escenaContexto < cantidadEscenasContexto) {

    tiempoLetraContexto++;

    if (tiempoLetraContexto >= 3) {

      tiempoLetraContexto = 0;

      if (letraContexto < textosContexto[escenaContexto].length()) {

        letraContexto++;

        textoMostradoContexto = textosContexto[escenaContexto].substring(0, letraContexto);

        contadorSonidoTeclaContexto++;

        if (contadorSonidoTeclaContexto >= 2) {

          sonidosCargadosSample[4].trigger();

          contadorSonidoTeclaContexto = 0;
        }
      } else {

        textoContextoTerminado = true;
      }
    }
  }

  fill(255);
  textFont(fuente);
  textAlign(CENTER);
  textSize(40);
  text(textoMostradoContexto, width/2, height/2);

  if (textoContextoTerminado) {

    // parpadeo de "Presione ENTER para continuar." 
    if (subirOpacidadEnter) {

      opacidadEnter += 2;

      if (opacidadEnter >= 255) {

        opacidadEnter = 255;

        subirOpacidadEnter = false;
      }
    } else {

      opacidadEnter -= 2;

      if (opacidadEnter <= 120) {

        opacidadEnter = 120;

        subirOpacidadEnter = true;
      }
    }

    fill(255, opacidadEnter);
    textAlign(LEFT);
    textSize(28);

    float anchoPresioneContexto = textWidth("Presione ");
    float anchoEnterContexto = textWidth("ENTER");
    float inicioContexto = width/2 - (textWidth("Presione ENTER para continuar.") / 2);

    fill(255, opacidadEnter);
    text("Presione ", inicioContexto, height*0.8);

    fill(255, 200, 0, opacidadEnter);
    text("ENTER", inicioContexto + anchoPresioneContexto, height*0.8);

    fill(255, opacidadEnter);
    text(" para continuar.", inicioContexto + anchoPresioneContexto + anchoEnterContexto, height*0.8);
  }
}


// teclas en la pantalla 10
void teclaContexto() {
  // contexto de la prueba 1: ENTER pasa a la escena siguiente y, tras la ultima, a la prueba (pantalla 9)
  if (keyCode == ENTER || key == ENTER || key == RETURN) {

    if (textoContextoTerminado) {

      escenaContexto++;

      textoMostradoContexto = "";

      letraContexto = 0;

      tiempoLetraContexto = 0;

      contadorSonidoTeclaContexto = 0;

      textoContextoTerminado = false;

      opacidadEnter = 150;

      subirOpacidadEnter = true;

      if (escenaContexto >= cantidadEscenasContexto) {

        inicioPrueba = millis();   // aqui empieza a correr el contador de la prueba

        if (pruebaActual == 0) {
          iniciarP1();             // 50 s, telon, guia, musica y cuaderno de pistas
          pantalla = 9;
        } else {
          if (pruebaActual == 1) {
            iniciarP2();             // 60 s, historias barajadas
            pantalla = 14;
          } else {
            if (pruebaActual == 2) {
              iniciarP3();             // 3 rondas, primero 3 s para memorizar el simbolo
              pantalla = 18;
            } else {
              if (pruebaActual == 3) {
                iniciarP4();             // 70 s, el pasillo
                pantalla = 21;
              } else {
                if (pruebaActual == 4) {
                  iniciarP5();             // 50 s, el en vivo
                  pantalla = 27;
                } else {
                  if (pruebaActual == 5) {
                    iniciarP6();             // 60 s, terminos tramposos
                    pantalla = 30;
                  } else {
                    if (pruebaActual == 6) {
                      iniciarP7();             // sin tiempo, lluvia de notificaciones
                      pantalla = 33;
                    } else {
                      if (pruebaActual == 7) {
                        iniciarP8();             // 60 s, tres candados
                        pantalla = 37;
                      } else {
                        iniciarP9();             // 70 s, la cadena
                        pantalla = 40;
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
