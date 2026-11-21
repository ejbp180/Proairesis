// clics segun la pantalla
void mouseClicked() {
  // con el panel del modo desarrollador abierto, los clics son para sus botones
  if (consolaAbierta) {
    clicConsola();
    return;
  }
  // con el telon abriendose los clics no hacen nada; con la guia activa solo la avanzan
  int pantallaClic = pantalla;
  if (telonActivo || guiaActiva) {
    pantallaClic = -1;
    if (!telonActivo) {
      avanzarGuia();
    }
  }

  switch (pantallaClic) {
  case 2:
    clicMenu();
    break;
  case 3:
    clicVestibulo();
    break;
  case 4:
    clicIniciarPartida();
    break;
  case 7:
    clicMago();
    break;
  case 8:
    clicBotonesActo1();
    break;
  case 9:
    clicPrueba1();
    break;
  case 11:
    clicInterroganteP1();
    break;
  case 14:
    clicP2();
    break;
  case 18:
    clicP3();
    break;
  case 26:
    clicBotonesActo2();
    break;
  case 27:
    clicP5();
    break;
  case 30:
    clicP6();
    break;
  case 33:
    clicP7();
    break;
  case 36:
    clicBotonesActo3();
    break;
  case 37:
    clicP8();
    break;
  case 46:
    clicFinal();
    break;
  case 40:
    clicP9();
    break;
  }
}
