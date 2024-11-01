import 'dart:io';
import 'dart:typed_data';

import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

void metodoDescargaMovilPDF(
    {required Uint8List bytes,
    required String titulo,
    required BuildContext context}) async {
  Directory directory = await getApplicationDocumentsDirectory();
  // Genera un nombre único para el archivo
  try {
    final timestamp = (DateTime.now());
    final fileName = '${titulo}_$timestamp.pdf';
    final filePath = '${directory.path}/$fileName';
    final filePdf = File(filePath);

    // Escribe el archivo PDF
    await filePdf.writeAsBytes(bytes);
    // Abre el archivo PDF
    await OpenFilex.open(filePdf.path);

    // Anuncia la descarga completada
   await  TextToSpeechService().speak('Descarga completada.');

    // Muestra un diálogo de éxito
    AssetAlertDialogPlatform.show(
      context: context,
      message: 'Archivo PDF descargado con éxito',
      title: 'Descarga completada.',
    );
  } catch (e) {
    // Manejo de excepciones
   await  TextToSpeechService()
        .speak('Error al descargar el archivo: ${e.toString()}');
    AssetAlertDialogPlatform.show(
      context: context,
      message: 'Error al descargar el archivo. ${e.toString()}',
      title: 'Error',
    );
  }
}

void metodoDescargaMovilEXcel(
    {required List<int> excelBytes,
    required String titulo,
    required BuildContext context}) async {
  final directory =
      await getApplicationDocumentsDirectory().timeout(Duration(seconds: 60));
  final excelFile = File('${directory.path}/${titulo}.xlsx');
  await excelFile.writeAsBytes(excelBytes);
  await OpenFilex.open(excelFile.path);
  // Mensaje de éxito
  TextToSpeechService().speak('Archivo Excel cargado con éxito.');
  AssetAlertDialogPlatform.show(
      context: context,
      message: 'Archivo PDF descargado con éxito',
      title: 'Descarga completada.');
}
