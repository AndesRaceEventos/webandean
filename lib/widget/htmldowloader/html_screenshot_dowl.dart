// import 'dart:html' as html;
import 'dart:convert';
import 'dart:typed_data';

import 'package:image_gallery_saver/image_gallery_saver.dart';

Future<void> screenShotCaptrueDowloader(
    {required String qrDataString, required Uint8List image}) async {

  
  // final base64Image = base64Encode(image);// Convertir Uint8List a base64

  // final dataUrl = 'data:image/png;base64,$base64Image';// Crear una URL de datos para el archivo de imagen

  
  // bool isMobile =
  //     html.window.navigator.userAgent.toLowerCase().contains("mobile");// Detectar si es un dispositivo móvil
  
  // if (!isMobile) { //SI no es MOVIL  descarga la imagen en web
  //   // SI es web escritorio si lo descagra sin problemas.
  //   // Crear un enlace para descargar la imagen en dispositivos de escritorio
  //   final anchor = html.AnchorElement(href: dataUrl)
  //     ..setAttribute('download', '${qrDataString}qr_image.png')
  //     ..click();
    
  //   anchor.remove();// Elimina el enlace después de hacer clic
  // } 
    // else
    //debe desacargar captura de pantalla tambien
    await ImageGallerySaver.saveImage(image);
  
}
