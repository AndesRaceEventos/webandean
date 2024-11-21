// import 'package:flutter/material.dart';
// import 'package:webandean/utils/dialogs/assets_dialog.dart';
// import 'package:webandean/utils/speack/assets_speack.dart';
// // import 'dart:typed_data';

// import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
// import 'dart:html' as html; // Importa html para Flutter Web

// //PARA PDF
// void metodoDescagaWebPDF(
//     {required Uint8List bytes,
//     required String titulo,
//     required BuildContext context}) async {
//   if (kIsWeb) {
//     final blob = await html.Blob([bytes]);
//     final url = await html.Url.createObjectUrlFromBlob(blob);

//     await html.AnchorElement(href: url)
//       ..setAttribute("download", "${titulo}.pdf")
//       ..click();

//     html.Url.revokeObjectUrl(url);
//     await   TextToSpeechService().speak('Descarga completada.');
//     AssetAlertDialogPlatform.show(
//         context: context,
//         message: 'Archivo PDF descargado con éxito',
//         title: 'Descarga completada.');
//   }
// }

// //PARA EXCEL
// void metodoDescargaWebEXCEL(
//     {required List<int> excelBytes,
//     required String titulo,
//     required BuildContext context}) async {
//   if (kIsWeb) {
//     final blob = html.Blob([excelBytes]);
//     final url = html.Url.createObjectUrlFromBlob(blob);

//     await html.AnchorElement(href: url)
//       ..setAttribute('download', '${titulo}.xlsx')
//       ..click();

//     html.Url.revokeObjectUrl(url);

//       // Mensaje de éxito
//   TextToSpeechService().speak('Archivo Excel cargado con éxito.');
//   AssetAlertDialogPlatform.show(
//       context: context,
//       message: 'Archivo Excel descargado con éxito',
//       title: 'Descarga completada.');
//   }
// }
