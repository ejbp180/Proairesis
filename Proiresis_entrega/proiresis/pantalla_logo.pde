// PANTALLA 1 - LOGO

float opacidadLogo = 0;  // transparencia del logo
int tiempo = 0;  // cuadros que lleva quieto
int faseLogo = 0; //0 = fade in, 1 = espera, 2 = fade out


// 1 - LOGO
void dibujarLogo() {
  background(0);

  // logo con su transparencia
  tint(255, opacidadLogo);

  image(imagenesCargadas[3],
    0,
    120,
    width,
    height - 280);

  noTint();



  // fases: 0 aparece, 1 espera, 2 desaparece
  if (faseLogo == 0) {

    opacidadLogo += 1;

    if (opacidadLogo >= 255) {
      opacidadLogo = 255;
      faseLogo = 1;
    }
  } else {
    if (faseLogo == 1) {

      tiempo++;


      if (tiempo >= 180) {
        faseLogo = 2;
      }
    } else {
      if (faseLogo == 2) {

        opacidadLogo -= 1.5;

        if (opacidadLogo <= 0) {
          opacidadLogo = 0;
          pantalla = 2;
        }
      }
    }
  }
}
