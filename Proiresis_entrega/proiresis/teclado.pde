void keyReleased() {
  // al soltar la tecla se deja de repetir
  // solo se apaga si se solto la misma tecla que se repetia (soltar la "a" no corta la "b")
  if (keyCode == teclaRepetida) {
    teclaMantenida = false;
  }
  // prueba 4: deja de correr al soltar la flecha
  if (pantalla == 21) {
    soltarTeclaP4();
  }
  // prueba 7: el corazon deja de moverse al soltar la tecla
  if (pantalla == 33) {
    soltarTeclaP7();
  }
}

// teclas segun la pantalla
void keyPressed() {

  // modo desarrollador: si la tecla es para la consola, el juego no la recibe
  if (teclaConsola()) {
    return;
  }

  // solo la primera vez (mientras no estaba apretada) se anota cuando empezo; las repeticiones de draw() no la reinician
  if (teclaMantenida == false || keyCode != teclaRepetida) {
    teclaMantenida = true;
    teclaRepetida = keyCode;
    letraRepetida = key;
    inicioTecla = millis();
    ultimaRepeticion = millis();
  }

  // con el telon abriendose las teclas no hacen nada; con la guia activa solo sirven para avanzarla
  int pantallaTeclas = pantalla;
  if (telonActivo || guiaActiva) {
    pantallaTeclas = -1;
    if (!telonActivo && (keyCode == ENTER || key == ENTER || key == RETURN)) {
      avanzarGuia();
    }
  }

  switch (pantallaTeclas) {
  case 2:
    teclaMenu();
    break;
  case 5:
    teclaIntroduccion();
    break;
  case 6:
    teclaTeatro();
    break;
  case 10:
    teclaContexto();
    break;
  case 11:
    teclaInterroganteP1();
    break;
  case 14:
    teclaP2();
    break;
  case 21:
    teclaP4();
    break;
  case 12:
  case 16:
  case 19:
  case 22:
    // se acabo el tiempo (o se perdio una prueba): ENTER vuelve a los botones del Acto 1
    if ((keyCode == ENTER || key == ENTER || key == RETURN) && resultadoTerminado()) {
      sonidosCargadosAmbiente[3].pause();   // musica de la prueba 2
      sonidosCargadosAmbiente[4].pause();   // zumbido de la prueba 4
      pantalla = 8;
      if (pruebasCompletadasActo1 >= 4) {
        empezarCierreActo(1);
      }
    }
    break;
  case 13:
  case 17:
  case 20:
  case 23:
    // prueba superada: ENTER vuelve a los botones del Acto 1
    if ((keyCode == ENTER || key == ENTER || key == RETURN) && resultadoTerminado()) {
      sonidosCargadosAmbiente[3].pause();   // musica de la prueba 2
      sonidosCargadosAmbiente[4].pause();   // zumbido de la prueba 4
      pantalla = 8;
      if (pruebasCompletadasActo1 >= 4) {
        empezarCierreActo(1);
      }
    }
    break;
  case 24:
    teclaCierreActo();
    break;
  case 30:
    teclaP6();
    break;
  case 33:
    teclaP7();
    break;
  case 28:
  case 29:
  case 31:
  case 32:
  case 34:
  case 35:
    // prueba del Acto II terminada: ENTER vuelve a los botones del Acto II (o, si ya se jugaron las 3, al cierre del acto)
    if ((keyCode == ENTER || key == ENTER || key == RETURN) && resultadoTerminado()) {
      sonidosCargadosAmbiente[3].pause();
      pantalla = 26;
      inicioPantallaActo2 = millis();
      if (pruebasCompletadasActo2 >= 3) {
        empezarCierreActo(2);
      }
    }
    break;
  case 37:
    teclaP8();
    break;
  case 46:
    teclaFinal();
    break;
  case 47:
    teclaResena();
    break;
  case 40:
    teclaP9();
    break;
  case 38:
  case 39:
  case 41:
  case 42:
    // prueba del Acto III terminada: ENTER vuelve a los botones del Acto III (o, si ya se jugaron las 2, al cierre del acto)
    if ((keyCode == ENTER || key == ENTER || key == RETURN) && resultadoTerminado()) {
      sonidosCargadosAmbiente[3].pause();
      apagarMusicaA3();
      pantalla = 36;
      inicioPantallaActo3 = millis();
      if (pruebasCompletadasActo3 >= 2) {
        empezarCierreActo(3);
      }
    }
    break;
  }
}
