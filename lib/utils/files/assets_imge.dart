

import 'dart:math';

class AppImages {
  //ICON APP
  static const String iconApp = 'assets/icon/appstore.png';
  static const String andeanlodgesApp = 'assets/img/andeanlodges.png';

  //IMAGENES FONDO APP
  static const String qrimge = 'assets/img/qr_image.jpeg';
  //IMAGENES LOGO
  static const String logoAndes = 'assets/img/andean.png';
  static const String placeholder300 = 'assets/img/300.jpg';
  //IMAGENES LOGO APP 2
  static const String iaImage1 = 'assets/img/ia_image1.png';
  static const String iaImage2 = 'assets/img/ia_image2.png';
  static const String iaImage3 = 'assets/img/ia_image3.png';
  static const String iaImage4 = 'assets/img/ia_image4.png';
  static const String iaImage5 = 'assets/img/ia_image5.png';
  static const String iaImage6 = 'assets/img/ia_image6.png';

   //Función que selecciona una imagen IA de manera aleatoria
  static String getRandomIaImage() {
    List<String> iaImages = [
      iaImage1,
      iaImage2,
      iaImage3,
      iaImage4,
      iaImage5,
      iaImage6,
      iconApp
    ];

    final random = Random();
    int index = random.nextInt(iaImages.length);
    return iaImages[index];
  }
}
