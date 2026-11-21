// NOMBRES DE ARCHIVOS
// el numero es el indice de cada imagen
String[] imagenes = {
  "imagenmenu.png", //menu 0
  "vestibulo.jpg", //vestibulo 1
  "teatro.png", //teatro 2
  "equipo3.png", //equipo 3
  "menupuertaabierta.png", //menu puerta abierta 4
  "salirapagado.png", //salir apagado 5
  "salirencendido.png", //salir encendido 6
  "entrarapagado.png", //entrar apagado 7
  "entrarencendido.png", //entrar encendido 8
  "menuapagado.png", //menu apagado 9
  "teatrobotones.jpeg", //teatro botones 10
  "vestibulo_puertailuminada.jpg", //vestibulo puerta iluminada 11
  "vestibulo_logrosiluminado.jpg", //vestibulo logros iluminados 12
  "vestibulo_recuerdosiluminado.jpg", //vestibulo recuerdos iluminados 13
  "vestibulo_opcionesiluminado.jpg", //vestibulo opciones iluminadas 14
  "vestibulo_tocavinilosiluminado.jpg", //vestibulo toca vinilo iluminado 15
  "vestibulo_volver.jpg", //vestibulo volver iluminado 16
  "imagenvinilo.png", //imagen vinilo 17
  "botonnextR.png", //boton next 18
  "botonnextL.png", //boton next 19
  "botonplay.png", //boton play 20
  "botonpausa.png", //boton pausa 21
  "teatrozoom.png", //teatro zoom 22
  "teatromago1.png", //teatro mago 23
  "acto1boton1.png", //acto 1 boton 1 24
  "acto1boton2.png", //acto 1 boton 2 25
  "acto1boton3.png", //acto 1 boton 3 26
  "acto1boton4.png", //acto 1 boton 4 27
  "acto1boton5.png", //acto 1 boton 5 28
  "acto1boton6.png", //acto 1 boton 6 29
  "acto1boton1bloqueado.png", //acto 1 boton 1 bloqueado 30
  "acto1boton2bloqueado.png", //acto 1 boton 2 bloqueado 31
  "acto1boton3bloqueado.png", //acto 1 boton 3 bloqueado 32
  "acto1boton4bloqueado.png", //acto 1 boton 4 bloqueado 33
  "acto1boton5bloqueado.png", //acto 1 boton 5 bloqueado 34
  "acto1boton6bloqueado.png", //acto 1 boton 6 bloqueado 35
  "acto1prueba1_normal.jpeg", //acto 1 prueba 1 normal 36
  "acto1prueba1_celular.jpeg", //acto 1 prueba 1 celular 37
  "acto1prueba1_ventana.jpeg", //acto 1 prueba 1 ventana 38
  "acto1prueba1_espejo.jpeg", //acto 1 prueba 1 espejo 39
  "acto1prueba1_pintura.jpeg", //acto 1 prueba 1 pintura 40
  "acto1prueba1_celularzoom.jpeg", //acto 1 prueba 1 zoom celular 41
  "acto1prueba1_ventanazoom.jpeg", //acto 1 prueba 1 zoom ventana 42
  "acto1prueba1_espejozoom.jpeg", //acto 1 prueba 1 zoom espejo 43
  "acto1prueba1_pinturazoom.png", //acto 1 prueba 1 zoom pintura 44
  "acto1prueba2_fotoA.jpeg", //acto 1 prueba 2 foto A 45
  "acto1prueba2_fotoB.jpeg", //acto 1 prueba 2 foto B 46
  "acto1prueba2_fotoC.jpeg", //acto 1 prueba 2 foto C 47
  "acto1prueba2_fotoD.jpeg", //acto 1 prueba 2 foto D 48
  "acto1prueba2_fotoE.jpeg", //acto 1 prueba 2 foto E 49
  "acto1prueba2_fotoF.jpeg", //acto 1 prueba 2 foto F 50
  "acto1prueba3_fondo.jpeg", //acto 1 prueba 3 fondo 51
  "acto1prueba3_fotoA.png", //acto 1 prueba 3 foto A 52
  "acto1prueba3_fotoB.png", //acto 1 prueba 3 foto B 53
  "acto1prueba3_fotoC.png", //acto 1 prueba 3 foto C 54
  "acto1prueba3_fotoD.png", //acto 1 prueba 3 foto D 55
  "acto1prueba3_fotoE.png", //acto 1 prueba 3 foto E 56
  "acto1prueba3_fotoF.png", //acto 1 prueba 3 foto F 57
  "acto1prueba3_fotoG.png", //acto 1 prueba 3 foto G 58
  "acto1prueba3_fotoH.png", //acto 1 prueba 3 foto H 59
  "p5_protagonista.png", //el protagonista con su hoodie, sin fondo (prueba 5) 60
  "p5_cara_alegre.png", //expresiones del protagonista (prueba 5): alegre 61
  "p5_cara_enojado.png", //enojado 62
  "p5_cara_sorprendido.png", //sorprendido 63
  "p5_cara_triste.png", //triste 64
  "p5_cara_pensativo.png", //pensativo 65
  "p5_cara_cansado.png", //cansado 66
  "p2_fondo.jpg", //prueba 2: fondo del escenario 67
  "p2_telon.png", //telon (mitad izquierda; la derecha es su espejo) 68
  "p2_sombra.png", //la sombra que se asoma detras del telon derecho 69
  "p2_mano.png", //mano de la sombra (los dedos miran a la derecha) 70
  "p2_cesto.png", //cesto para reportar, con su bandera 71
  "p2_letrero.png", //letrero de madera vacio 72
  "p2_poste.png", //poste de la cuerda 73
  "p2_pinza.png", //pinza de madera 74
  "p2_plato.png", //plato de la barra de arriba 75
  "p2_palito.png", //palito de zanahoria 76
  "p2_moneda.png", //moneda que vuela al marcador 77
  "p2_estrella.png", //estrella del marcador 78
  "p3_foto0.jpg", //prueba 3: foto de la fiesta 79
  "p3_foto1.jpg", //playa 80
  "p3_foto2.jpg", //salon de clases 81
  "p3_foto3.jpg", //concierto 82
  "p3_foto4.jpg", //parque 83
  "p3_foto5.jpg", //cumpleanos 84
  "p3_foto6.jpg", //ciudad de noche 85
  "p3_foto7.jpg", //piscina 86
  "p3_foto8.jpg", //campamento 87
  "p3_brazo.png", //brazo con el puno cerrado 88
  "p3_pulsera.png", //pulsera (el simbolo lo dibuja el programa en su cara) 89
  "p3_manga.png", //manga gris (se pinta con tint del color de cada amigo) 90
  "p3_carta.png", //carta de amor del mago 91
  "p3_guante.png", //mano del mago con su manga (los dedos miran a la izquierda) 92
  "p3_aro_lupa.png", //aro de la lupa (hueco transparente) 93
  "p3_mango_lupa.png", //mango de la lupa (horizontal, la punta que se une al aro a la izquierda) 94
  "p3_ojo.png", //ojo de la sombra dentro de la lupa 95
  "p3_iris.png", //iris rojo del ojo 96
  "p4_fondo.jpg", //pared y piso del pasillo (se repite en espejo) 97
  "p4_cuarto.jpg", //cuarto vacio de la puerta equivocada 98
  "p4_foco.png", //bombillo de las lamparas del techo 99
  "p4_caja.png", //caja de carton 100
  "p4_carta.png", //carta de amor 101
  "p4_marco_cuadro.png", //marco de los retratos 102
  "p4_retrato.png", //retrato con la cara del chico (vuelta 3) 103
  "p4_polaroid.png", //foto con chincheta de los pines 104
  "p4_pin.png", //pin de ubicacion 105
  "p4_espejo.png", //espejo 106
  "p4_placa.png", //placa de las puertas (sin numero) 107
  "p4_placa17.png", //placa de la prueba 17 108
  "p4_camara.png", //camara del techo 109
  "p4_puerta.png", //puerta cerrada 110
  "p4_puerta_luz.png", //puerta con luz (vecino y salida con las 3 pruebas) 111
  "p4_puerta_oscura.png", //salida apagada 112
  "p4_vecino.png", //vecino que mira 113
  "p4_tablero.png", //tablero de corcho 114
  "p4_foto_final.png", //la foto que no existe 115
  "p4_cabeza.png", //el chico: cabeza 116
  "p4_torso.png", //el chico: torso 117
  "p4_pierna.png", //el chico: pierna (la misma para las dos) 118
  "p4_brazo_atras.png", //el chico: brazo de atras 119
  "p4_brazo_adelante.png", //el chico: brazo de adelante con la pulsera 120
  "p4_s_cuerpo.png", //la sombra: cuerpo 121
  "p4_s_brazo.png", //la sombra: brazo con la mano 122
  "p4_s_capucha.png", //la sombra: capucha 123
  "p4_s_ojo.png", //la sombra: ojo 124
  "p4_s_boca.png", //la sombra: boca 125
  "p5_jefe_riendo.png", //avatar del jefe (normal) 126
  "p5_jefe_enojado.png", //avatar del jefe (furioso) 127
  "p5_jefe_roto.png", //avatar del jefe (golpeado) 128
  "p5_publico0.png", //silueta del publico 129
  "p5_publico1.png", //silueta del publico 130
  "p5_publico2.png", //silueta del publico 131
  "p5_publico3.png", //silueta del publico 132
  "p5_publico4.png", //silueta del publico 133
  "p5_palco.png", //baranda del palco 134
  "p5_cuarto.jpg", //tu cuarto (detras del celular) 135
  "p6_guante_senala.png", //guante que senala (dedo a la izquierda) 136
  "p6_guante_abierto.png", //guante abierto (dedos a la izquierda) 137
  "p6_logo_aporia.png", //logo de Aporia (tambien en la prueba 8) 138
  "p7_campana.png", //campana de notificaciones 139
  "p7_celular.png", //celular del publico (pantalla azul) 140
  "p7_celular_blanco.png", //celular del publico (pantalla blanca, cuando brilla) 141
  "p7_silla.png", //la silla bajo el foco 142
  "p8_aporia_normal.png", //Aporia 2.0: cara normal 143
  "p8_aporia_mareada.png", //Aporia 2.0: mareada 144
  "p8_aporia_risa.png", //Aporia 2.0: se rie 145
  "p8_aporia_golpe.png", //Aporia 2.0: golpeada 146
  "p8_regalo.png", //regalo abierto 147
  "p8_candado_abierto.png", //candado abierto (tambien en la prueba 5) 148
  "p8_candado.png", //candado cerrado (tambien en la prueba 5 y los logros) 149
  "p9_casa.png", //tu casa 150
  "p9_desconocido_paso1.png", //el Desconocido caminando (paso 1) 151
  "p9_desconocido_paso2.png", //el Desconocido caminando (paso 2) 152
  "p9_desconocido_varado.png", //el Desconocido sin camino 153
  "p9_desconocido.png", //el Desconocido quieto 154
  "p9_cabeza.png" //cabeza de la serpiente (mira a la derecha) 155
};
int cantidadImagenes = 156;  // cantidad de imagenes (si se agrega una, sumar 1)

// efectos cortos
String[] sonidosSample = {
  "dooropening.wav", //0
  "doorclosing.wav", //1
  "apagarluz.wav", //2
  "seleccionar_si_no.wav", //3
  "tecleo.wav", //4VESTIBULO
  "p2_telon.wav", //5 telon que se abre
  "p2_entra.wav", //6 historia que entra
  "p2_mover.wav", //7 mover la historia
  "p2_pinza.wav", //8 historia colgada en la pinza
  "p2_error.wav", //9 error (se pierde un palito)
  "p2_reportar.wav", //10 historia falsa reportada
  "p2_intercambio.wav", //11 intercambio de historias
  "p2_sacude.wav", //12 la cuerda se sacude
  "p2_lupa.wav", //13 lupa que se abre o se cierra
  "p2_victoria.wav", //14 prueba superada
  "p2_derrota.wav", //15 prueba perdida
  "p2_sello.wav", //16 sello que cae
  "p2_tic.wav", //17 tic de los puntos al contar
  "p2_sombra.wav", //18 la sombra aparece
  "p2_acierto.wav", //19 historia en su lugar (+2)
  "p2_susurro.wav", //20 la sombra se asoma de golpe
  "p2_latido.wav", //21 latido de los ultimos segundos
  "p3_lupa_salto.wav", //22 la lupa salta a otra foto
  "p3_escaneo.wav", //23 la lupa escanea una foto
  "p3_alerta.wav", //24 la lupa empieza a cazar tu pulsera
  "p3_encontrado.wav", //25 la lupa te encontro
  "p3_brazo.wav", //26 sube un brazo
  "p3_etiqueta.wav", //27 se arranca una etiqueta
  "p3_carta.wav", //28 la carta del mago se estampa
  "p1_obturador.wav", //29 flash de camara (prueba 1)
  "p1_zoom_entra.wav", //30 acercarse a una zona
  "p1_zoom_sale.wav", //31 alejarse de una zona
  "p1_lapiz.wav", //32 lapiz que anota una pista en el cuaderno
  "p4_paso.wav", //33 paso al correr (prueba 4)
  "p4_salto.wav", //34 salto
  "p4_aterriza.wav", //35 aterriza
  "p4_carta.wav", //36 carta que pasa silbando
  "p4_esquiva1.wav", //37 carta esquivada (racha 1)
  "p4_esquiva2.wav", //38 carta esquivada (racha 2)
  "p4_esquiva3.wav", //39 carta esquivada (racha 3 o mas)
  "p4_grito.wav", //40 grito de la sombra
  "p4_apagon.wav", //41 se apagan las luces
  "p4_paso_sombra.wav", //42 paso pesado de la sombra (suena mas fuerte cuanto mas cerca)
  "p5_pop.wav", //43 burbuja de comentario que revienta (prueba 5)
  "p5_golpe.wav", //44 golpe al jefe (la voz A en persona)
  "p5_ovacion.wav", //45 ovacion del publico (aplausometro lleno o la voz A te alcanza)
  "a3_tajo.wav", //46 tajo del mouse (acto 3)
  "a3_partir.wav", //47 burbuja que se parte
  "a3_vidrio.wav", //48 vidrio que se raja
  "a3_risa.wav", //49 risa de Aporia 2.0
  "a3_paso.wav", //50 paso del Desconocido
  "a3_eslabon.wav", //51 eslabon que se rompe
  "a3_alarma.wav", //52 alarma (entra Aporia 2.0)
  "a3_pista.wav", //53 pista (campanitas)
  "a3_descarga.wav", //54 app descargada
  "a3_combo.wav", //55 combo y rachas
  "f_susurro.wav", //56 susurro al reves (finales)
  "f_golpes.wav", //57 golpes lejanos en la madera
  "f_estatica.wav", //58 estatica de radio
  "f_parpadeo.wav", //59 el ojo parpadea
  "f_cajita.wav", //60 cajita de musica desafinada
  "f_risa_lejana.wav", //61 risa lejana
  "f_campana.wav", //62 campana grave
  "f_respiro.wav", //63 respiro muy cerca
};
int cantidadSonidosSample = 64;  // cantidad de efectos (si se agrega uno, sumar 1)

// sonidos de ambiente
String[] sonidosAmbiente = {
  "backgroundmenu.mp3", //0
  "personashablando.mp3", //1
  "narracionteatro.mp3", //2
  "p2_musica.wav", //3 musica de fondo de la prueba 2 (bucle de 48 s)
  "p4_drone.wav", //4 zumbido de tension de la prueba 4 (bucle de 8 s, sube en cada vuelta)
  "a3_pedidos.wav", //5 musica de los pedidos de la aduana (acto 3)
  "a3_jefe.wav", //6 musica de la pelea con Aporia 2.0
  "a3_serpiente.wav", //7 musica de la serpiente
  "a3_cadena.wav", //8 latido mientras el Desconocido camina por la cadena
  "f_drone.wav", //9 zumbido grave e incomodo de los finales (bucle de 12 s)
};
int cantidadSonidosAmbiente = 10;  // cantidad de ambientes (si se agrega uno, sumar 1)

// musica del tocadiscos
String[] sonidosMusica = {
  "rollin.mp3", //0
  "boysdontcry.mp3", //1
  "thereason.mp3", //2
  "nomedoyporvencido.mp3" //3
};
int cantidadCanciones = 4;  // cantidad de canciones, tambien de nombresCanciones (si se agrega una, sumar 1)

// nombres de las canciones (mismo orden que la musica)
String[] nombresCanciones = {
  "Rollin ... Limp Bizkit", // 0
  "Boys dont cry ... The Cure", // 1
  "The reason ... Hoobastank", // 2
  "No me doy por vencido ... \nLuis Fonsi" // 3
};

//VARIABLES DE IMAGENES Y AUDIOS
PImage[] imagenesCargadas = new PImage[cantidadImagenes];  // imagenes cargadas
Minim minim;  // objeto de Minim
AudioSample[] sonidosCargadosSample = new AudioSample[cantidadSonidosSample];  // efectos cargados
AudioPlayer[] sonidosCargadosAmbiente = new AudioPlayer[cantidadSonidosAmbiente];  // ambientes cargados
AudioPlayer[] sonidosCargadosMusica = new AudioPlayer[cantidadCanciones];  // canciones cargadas

PFont fuente;  // fuente del juego
