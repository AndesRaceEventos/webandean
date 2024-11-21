// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:html' as html; // Importa html para Flutter Web
// import 'package:image/image.dart' as img;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:webandean/utils/button/asset_buton_widget.dart';
// import 'package:webandean/provider/cache/files/files_procesisng.dart';
// import 'package:webandean/utils/Files%20%20Selected/imagen/reorder_image_widget.dart';
// import 'package:webandean/utils/files%20assset/assets_imge.dart';
// import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
// import 'package:webandean/utils/text/assets_textapp.dart';

// class FilesImagesSelectedWeb extends StatelessWidget {
//   const FilesImagesSelectedWeb({super.key, required this.isListImage});
//   final bool isListImage;
//   @override
//   Widget build(BuildContext context) {
//     final filesdata = Provider.of<FilesProvider>(context);
//     final imagenes = filesdata.imagenes;
//      final imagenE = filesdata.imagen;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//          if(imagenes!= null || imagenE !=null)
//         ListTile(
//           contentPadding: EdgeInsets.all(0),
//           minVerticalPadding: 0, 
//           dense: true, 
//           visualDensity: VisualDensity.compact,
//           leading: Icon(Icons.select_all_outlined, color: Colors.blueGrey),
//           title:  P3Text(text: 'Selecionados', color: Colors.blueGrey),
//           trailing: TextButton(onPressed: () {
//             context.read<FilesProvider>().setImagen(null);
//             context.read<FilesProvider>().setImagenes(null);
//           },
//           child: P3Text(text:'borrar todo', color: Colors.blue,fontWeight: FontWeight.w500)),
//         ),

//          if(isListImage)// si es lista de imagenes 
//          ...[
//           AppReorderImageWdiget( imagenE: imagenes ),
//           Container(
//             decoration: AssetDecorationBox().headerDecoration(color: Colors.transparent),
//             child: ListTile(
//               leading: Image.asset(AppImages.imageplaceholder300),
//               onTap:  () async => pickMultipleImageFromWeb(context, filesdata),
//               title: H2Text(text: 'Subir Imagenes'),
//               subtitle:P3Text(text: 'Puedes cargar multiples Imagenes.'),
//               trailing: Icon(Icons.upload),
//             ),
//           ),
//          ],
//          if(!isListImage)// Solo una imagen 
//          ...[
//           AppReorderImageWdiget( imagenE: imagenE ),
//            Container(
//             decoration: AssetDecorationBox().headerDecoration(color: Colors.transparent),
//              child: ListTile(
//               leading: Image.asset(AppImages.imageplaceholder300),
//               onTap: () async => pickImageFromWeb(context, filesdata),
//               title: H2Text(text: 'Subir Imagen'),
//               subtitle:P3Text(text: 'Puedes seleciona solo una imagen.'),
//               trailing: Icon(Icons.upload),
//                        ),
//            ),
//          ]
          
//       ],
//     );
//   }

//   void pickImageFromWeb(BuildContext context, FilesProvider filesdata) async {
//     final uploadInput = html.FileUploadInputElement();
//     uploadInput.accept = 'image/*';
//     uploadInput.click();

//     uploadInput.onChange.listen((event) {
//       final file = uploadInput.files!.first;
//       final reader = html.FileReader();

//       reader.readAsDataUrl(file);
//       reader.onLoadEnd.listen((event) async {
//         final dataUrl = reader.result as String;
//         final bytes = const Base64Decoder().convert(dataUrl.split(',').last);

//         // Si el archivo es PNG, conviértelo a JPEG
//         Uint8List finalBytes;
//         if (file.name.endsWith('.png')) {
//           finalBytes = await convertPngToJpeg(bytes);
//         } else {
//           finalBytes = bytes;
//         }
//         // Actualiza la lista de imágenes en el proveedor
//         filesdata.setImagen(finalBytes); // Proveedor

//       });
//     });
//   }

//   // Método para seleccionar múltiples imágenes en la web
//   void pickMultipleImageFromWeb(BuildContext context, FilesProvider filesdata) async {
//     final uploadInput = html.FileUploadInputElement();
//     uploadInput.accept = 'image/*';
//     uploadInput.multiple = true; // Permite selección de múltiples archivos
//     uploadInput.click();

//     uploadInput.onChange.listen((event) async {
//       List<Uint8List> newImages = [];

//       for (final file in uploadInput.files!) {
//         final reader = html.FileReader();
//         reader.readAsDataUrl(file);

//         await reader.onLoadEnd.first;
//         final dataUrl = reader.result as String;
//         final bytes = const Base64Decoder().convert(dataUrl.split(',').last);

//         // Si el archivo es PNG, conviértelo a JPEG
//         if (file.name.endsWith('.png')) {
//           final Uint8List convertedBytes = await convertPngToJpeg(bytes);
//           newImages.add(convertedBytes);
//         } else {
//           newImages.add(bytes);
//         }
//       }

//       // Actualiza la lista de imágenes en el proveedor
//       filesdata.setImagenes((filesdata.imagenes ?? []) + newImages);
//     });
//   }

//   // Conversión de PNG a JPEG
//   Future<Uint8List> convertPngToJpeg(Uint8List pngBytes) async {
//     try {
//       final image = img.decodeImage(pngBytes);
//       if (image != null) {
//         return Uint8List.fromList(img.encodeJpg(image));
//       }
//     } catch (e) {
//       print('Error converting PNG to JPEG: $e');
//     }
//     return pngBytes; // Devuelve los bytes originales si hay un error
//   }
// }
