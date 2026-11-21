// PANTALLA 5 - INTRODUCCION

// VARIABLES PARA LA INTRODUCCION
int escenaIntro = 0;  // escena actual
String textoMostradoIntro = "";  // texto escrito hasta ahora
int letraIntro = 0;  // letras escritas
int tiempoLetraIntro = 0;  // cuadros desde la ultima letra
boolean textoIntroTerminado = false;  // true cuando la escena ya termino
// una escena por elemento (\n = salto de linea)
String[] textosIntro = {
  "Vaal era un influencer reconocido.",
  "Su vida parecía perfecta: \nreconocimiento, seguidores y admiración.",
  "Hasta que recibió una invitación...",
  "Un prestigioso teatro llamado Aporía.",
  "La obra se llamaba psyche.",
  "Tres actos. \nTres pruebas. \nUna pregunta.",
  "¿Quién controla realmente tus decisiones?"
};
int cantidadTextosIntro = 7;  // cantidad de escenas de la introduccion (si se agrega una, sumar 1)
int contadorSonidoTecla = 0;  // cuenta letras para el sonido del tecleo
int opacidadEnter = 150;  // transparencia de ENTER (tambien en: botones del acto 1, contexto)
boolean subirOpacidadEnter = true;  // true si la transparencia esta subiendo (tambien en: botones del acto 1, contexto)


// 5 - INTRODUCCION
void dibujarIntroduccion() {
  background(0);

  // una letra cada 3 cuadros, tecleo cada 2 letras
  if (!textoIntroTerminado && escenaIntro < cantidadTextosIntro) {

    tiempoLetraIntro++;

    if (tiempoLetraIntro >= 3) {

      tiempoLetraIntro = 0;

      if (letraIntro < textosIntro[escenaIntro].length()) {

        letraIntro++;

        textoMostradoIntro = textosIntro[escenaIntro].substring(0, letraIntro);

        contadorSonidoTecla++;

        if (contadorSonidoTecla >= 2) {

          sonidosCargadosSample[4].trigger();

          contadorSonidoTecla = 0;
        }
      } else {

        textoIntroTerminado = true;
      }
    }
  }

  fill(255);

  textFont(fuente);

  textAlign(CENTER);

  textSize(40);


  text(
    textoMostradoIntro,
    width/2,
    height/2
    );

  // parpadeo de ENTER
  if (textoIntroTerminado) {

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

    float anchoPresione = textWidth("Presione ");
    float anchoEnter = textWidth("ENTER");

    float inicio = width/2 - (textWidth("Presione ENTER para continuar.") / 2);


    fill(255, opacidadEnter);
    text("Presione ", inicio, height*0.8);


    fill(255, 200, 0, opacidadEnter);
    text("ENTER", inicio + anchoPresione, height*0.8);


    fill(255, opacidadEnter);
    text(" para continuar.", inicio + anchoPresione + anchoEnter, height*0.8);
  }
}


// teclas en la pantalla 5
// INTRODUCCION
void teclaIntroduccion() {
  if (keyCode == ENTER) {

    if (textoIntroTerminado) {

      escenaIntro++;

      textoMostradoIntro = "";

      letraIntro = 0;

      tiempoLetraIntro = 0;

      contadorSonidoTecla = 0;

      textoIntroTerminado = false;

      opacidadEnter = 150;

      subirOpacidadEnter = true;


      if (escenaIntro >= cantidadTextosIntro) {

        pantalla = 6;
      }
    }
  }
}
