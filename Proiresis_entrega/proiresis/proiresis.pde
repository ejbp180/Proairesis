// libreria de sonido (Minim)
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


//PANTALLAS
int pantalla = 0;  // pantalla en la que esta el juego
// 0 - CARGA
// 1 - LOGO
// 2 - MENU
// 3 - VESTIBULO
// 4 - INICIAR/CARGAR PARTIDA
// 5 - INTRODUCCION
// 6 - TEATRO
// 7 - TEATRO - ACTO I
// 8 - ACTO I - BOTONES
// 9 - ACTO I - PRUEBA 1
// 10 - ACTO I - PRUEBA 1 - CONTEXTO
// 11 - ACTO I - PRUEBA 1 - INTERROGANTE
// 12 - ACTO I - PRUEBA 1 - TIEMPO AGOTADO
// 13 - ACTO I - PRUEBA 1 - PRUEBA SUPERADA
// 14 - ACTO I - PRUEBA 2 - HISTORIAS DE LA NOCHE
// 15 - (sin usar)
// 16 - ACTO I - PRUEBA 2 - PRUEBA PERDIDA
// 17 - ACTO I - PRUEBA 2 - PRUEBA SUPERADA
// 18 - ACTO I - PRUEBA 3 - ETIQUETADO
// 19 - ACTO I - PRUEBA 3 - PRUEBA PERDIDA
// 20 - ACTO I - PRUEBA 3 - PRUEBA SUPERADA
// 21 - ACTO I - PRUEBA 4 - EL PASILLO
// 22 - ACTO I - PRUEBA 4 - PRUEBA PERDIDA
// 23 - ACTO I - PRUEBA 4 - PRUEBA SUPERADA
// 24 - ACTO I - CIERRE
// 26 - ACTO II - BOTONES
// 27 - ACTO II - PRUEBA 1 - EL EN VIVO
// 28 - ACTO II - PRUEBA 1 - PRUEBA PERDIDA
// 29 - ACTO II - PRUEBA 1 - PRUEBA SUPERADA
// 30 - ACTO II - PRUEBA 2 - TERMINOS TRAMPOSOS
// 31 - ACTO II - PRUEBA 2 - PRUEBA PERDIDA
// 32 - ACTO II - PRUEBA 2 - PRUEBA SUPERADA
// 33 - ACTO II - PRUEBA 3 - LLUVIA DE NOTIFICACIONES
// 34 - ACTO II - PRUEBA 3 - PRUEBA PERDIDA
// 35 - ACTO II - PRUEBA 3 - PRUEBA SUPERADA
// 36 - ACTO III - BOTONES
// 37 - ACTO III - PRUEBA 1 - LA ADUANA DE PERMISOS
// 38 - ACTO III - PRUEBA 1 - PRUEBA PERDIDA
// 39 - ACTO III - PRUEBA 1 - PRUEBA SUPERADA
// 40 - ACTO III - PRUEBA 2 - LA CADENA
// 41 - ACTO III - PRUEBA 2 - PRUEBA PERDIDA
// 42 - ACTO III - PRUEBA 2 - PRUEBA SUPERADA
// 46 - FINALES
// 47 - RESENA DE LA OBRA


void setup() {
  fullScreen(P2D);  // pantalla completa

  minim = new Minim(this);  // inicia Minim
  fuente = createFont("Whimsical.otf", 70);  // carga la fuente
  fuenteTitulo = createFont("Whimsical.otf", 180);  // fuente grande para los carteles (la de 70 se ve pixelada al agrandarla)
  cargarLogros();  // los logros ganados en partidas anteriores
  fuenteTexto = createFont("Whimsical.otf", 40);  // fuente de la interfaz de las pruebas (no tiene: ¿ ¡ - ( ) ' / · … # @ _ + = ni flechas)
  inicioCarga = millis();  // inicia el contador de carga

  // posicion de las barras
  xBarraAmbiente = width/2 - 150;
  yBarraAmbiente = height/2 - 170;

  xBarraEfectos = width/2 - 150;
  yBarraEfectos = height/2  - 60;

  xBarraMusica = width/2 - 150;
  yBarraMusica = height/2 + 50;

  xBarraCancion = width/2-185;
  yBarraCancion = height/2+125;

  // botones: x, y, ancho y alto como fraccion de la pantalla
  //BOTON ENTRAR
  botonEntrar[0] = width * 0.3810625;            // X
  botonEntrar[1] = height * 0.646666666667;      // Y
  botonEntrar[2] = width * 0.130479166667;       // ANCHO
  botonEntrar[3] = height * 0.087;               // ALTO

  //BOTON SALIR
  botonSalir[0] = width * 0.871875;              // X
  botonSalir[1] = height * 0.834814814815;       // Y
  botonSalir[2] = width * 0.0834166666667;       // ANCHO
  botonSalir[3] = height * 0.157407407407;       // ALTO

  // VESTIBULO (medidas sacadas del contorno blanco de cada imagen iluminada)
  //BOTON PUERTA (el arco de la izquierda)
  botonPuerta[0] = width * 0.0365;               // X
  botonPuerta[1] = height * 0.3719;              // Y
  botonPuerta[2] = width * 0.0892;               // ANCHO
  botonPuerta[3] = height * 0.6119;              // ALTO

  //BOTON LOGROS (la vitrina del centro)
  botonLogros[0] = width * 0.4048;               // X
  botonLogros[1] = height * 0.2232;              // Y
  botonLogros[2] = width * 0.2272;               // ANCHO
  botonLogros[3] = height * 0.6999;              // ALTO

  //BOTON OPCIONES (el engranaje de arriba a la derecha)
  botonOpciones[0] = width * 0.94;               // X
  botonOpciones[1] = height * 0.05;              // Y
  botonOpciones[2] = width * 0.04;               // ANCHO
  botonOpciones[3] = width * 0.04;               // ALTO (cuadrado)

  //BOTON VOLVER OPCIONES
  botonVolver_Opciones[0] = width * 0.478125;    // X
  botonVolver_Opciones[1] = height * 0.731481;   // Y
  botonVolver_Opciones[2] = width * 0.0458333;   // ANCHO
  botonVolver_Opciones[3] = height * 0.034259;   // ALTO

  //BOTON RESTAURAR
  botonRestaurar[0] = width * 0.4265625;         // X
  botonRestaurar[1] = height * 0.683333;         // Y
  botonRestaurar[2] = width * 0.1479166;         // ANCHO
  botonRestaurar[3] = height * 0.026851;         // ALTO

  //BOTON TOCA VINILO (el tocadiscos)
  botonTocaVinilo[0] = width * 0.8592;           // X
  botonTocaVinilo[1] = height * 0.5433;          // Y
  botonTocaVinilo[2] = width * 0.1275;           // ANCHO
  botonTocaVinilo[3] = height * 0.4489;          // ALTO

  //BOTON VOLVER VESTIBULO (la puerta de la derecha; donde se cruza con el tocadiscos, gana el tocadiscos)
  botonVolver_Vestibulo[0] = width * 0.6910;         // X
  botonVolver_Vestibulo[1] = height * 0.2794;        // Y
  botonVolver_Vestibulo[2] = width * 0.2286;         // ANCHO
  botonVolver_Vestibulo[3] = height * 0.6404;        // ALTO

  // BOTON VOLVER TOCA VINILO
  botonVolver_TocaVinilo[0] = width * 0.476041;      // X
  botonVolver_TocaVinilo[1] = height * 0.66851;      // Y
  botonVolver_TocaVinilo[2] = width * 0.04843;       // ANCHO
  botonVolver_TocaVinilo[3] = height * 0.03240;      // ALTO

  // BOTON ANTERIOR
  botonAnterior[0] = width * 0.423958;           // X
  botonAnterior[1] = height * 0.5444444444;      // Y
  botonAnterior[2] = width * 0.026041666666;     // ANCHO
  botonAnterior[3] = height * 0.038;             // ALTO

  // BOTON SIGUIENTE
  botonSiguiente[0] = width * 0.5457083;        // X
  botonSiguiente[1] = height * 0.5444444444;    // Y
  botonSiguiente[2] = width * 0.02604166666;    // ANCHO
  botonSiguiente[3] = height * 0.038;           // ALTO

  // BOTON PLAY
  botonPlay[0] = width * 0.482291666667;        // X
  botonPlay[1] = height * 0.5407407407;         // Y
  botonPlay[2] = width * 0.03229166666;         // ANCHO
  botonPlay[3] = height * 0.05;                 // ALTO

  // NUEVA PARTIDA
  botonNuevaPartida[0] = width*0.40;            // X
  botonNuevaPartida[1] = height*0.35;           // Y
  botonNuevaPartida[2] = width*0.20;            // ANCHO
  botonNuevaPartida[3] = height*0.08;           // ALTO


  // CARGAR PARTIDA
  botonCargarPartida[0] = width*0.40;           // X
  botonCargarPartida[1] = height*0.48;          // Y
  botonCargarPartida[2] = width*0.20;           // ANCHO
  botonCargarPartida[3] = height*0.08;          // ALTO


  // VOLVER
  botonVolverInicio[0] = width*0.40;            // X
  botonVolverInicio[1] = height*0.61;           // Y
  botonVolverInicio[2] = width*0.20;            // ANCHO
  botonVolverInicio[3] = height*0.08;           // ALTO

  // los 4 botones del acto 1 conservan su forma de antes, movidos para quedar centrados en la pantalla
  // BOTON 1 ACTO 1 (arriba, ancho)
  boton1Acto1[0] = width * 0.348062;           // X
  boton1Acto1[1] = height * 0.306507;          // Y
  boton1Acto1[2] = width * 0.207813;           // ANCHO
  boton1Acto1[3] = height * 0.169565;          // ALTO

  // BOTON 2 ACTO 1 (centro, izquierda)
  boton2Acto1[0] = width * 0.348062;           // X
  boton2Acto1[1] = height * 0.486217;          // Y
  boton2Acto1[2] = width * 0.103906;           // ANCHO
  boton2Acto1[3] = height * 0.182609;          // ALTO

  // BOTON 3 ACTO 1 (centro)
  boton3Acto1[0] = width * 0.458219;           // X
  boton3Acto1[1] = height * 0.486217;          // Y
  boton3Acto1[2] = width * 0.098437;           // ANCHO
  boton3Acto1[3] = height * 0.197101;          // ALTO

  // BOTON 4 ACTO 1 (derecha, alto)
  boton4Acto1[0] = width * 0.560562;           // X
  boton4Acto1[1] = height * 0.307957;          // Y
  boton4Acto1[2] = width * 0.091406;           // ANCHO
  boton4Acto1[3] = height * 0.385507;          // ALTO

  // BOTON RESPONDER ACTO 1
  BotonResolverP1[0] = width * 0.38;
  BotonResolverP1[1] = height * 0.88;
  BotonResolverP1[2] = width * 0.24;
  BotonResolverP1[3] = height * 0.07;
}


void draw() {


  // cada case es una pantalla
  switch (pantalla) {
  case 0:
    dibujarCarga();
    break;
  case 1:
    dibujarLogo();
    break;
  case 2:
    dibujarMenu();
    break;
  case 3:
    dibujarVestibulo();
    if (mostrarLogros) {
      dibujarPanelLogros();
    }
    break;
  case 4:
    dibujarIniciarPartida();
    break;
  case 5:
    dibujarIntroduccion();
    break;
  case 6:
    dibujarTeatro();
    break;
  case 7:
    dibujarMago();
    break;
  case 8:
    dibujarBotonesActo1();
    break;
  case 9:
    dibujarPrueba1();
    break;
  case 10:
    dibujarContexto();
    break;
  case 11:
    dibujarInterroganteP1();
    break;
  case 12:
    dibujarTiempoAgotadoP1();
    break;
  case 13:
    dibujarSuperadaP1();
    break;
  case 14:
    dibujarHistoriasP2();
    break;
  case 16:
    dibujarPerdidaP2();
    break;
  case 17:
    dibujarSuperadaP2();
    break;
  case 18:
    dibujarEtiquetadoP3();
    break;
  case 19:
    dibujarPerdidaP3();
    break;
  case 20:
    dibujarSuperadaP3();
    break;
  case 21:
    dibujarPasilloP4();
    break;
  case 22:
    dibujarPerdidaP4();
    break;
  case 23:
    dibujarSuperadaP4();
    break;
  case 24:
    dibujarCierreActo();
    break;
  case 26:
    dibujarBotonesActo2();
    break;
  case 27:
    dibujarEnVivoP5();
    break;
  case 28:
    dibujarPerdidaP5();
    break;
  case 29:
    dibujarSuperadaP5();
    break;
  case 30:
    dibujarTerminosP6();
    break;
  case 31:
    dibujarPerdidaP6();
    break;
  case 32:
    dibujarSuperadaP6();
    break;
  case 33:
    dibujarLluviaP7();
    break;
  case 34:
    dibujarPerdidaP7();
    break;
  case 35:
    dibujarSuperadaP7();
    break;
  case 36:
    dibujarBotonesActo3();
    break;
  case 37:
    dibujarCandadosP8();
    break;
  case 38:
    dibujarPerdidaP8();
    break;
  case 39:
    dibujarSuperadaP8();
    break;
  case 46:
    dibujarFinales();
    break;
  case 47:
    dibujarResena();
    break;
  case 40:
    dibujarCadenaP9();
    break;
  case 41:
    dibujarPerdidaP9();
    break;
  case 42:
    dibujarSuperadaP9();
    break;
  }

  // barra de tiempo de las pruebas (solo se ve en las pantallas de prueba)
  dibujarContador();

  // telon que se abre al empezar una prueba, y despues la guia que explica la pantalla (cada uno solo se ve cuando esta activo)
  dibujarTelon();
  dibujarGuia();

  // aviso de logro nuevo (encima de todo)
  dibujarAvisoLogro();

  // modo desarrollador: la consola y los fps
  dibujarConsola();
}
