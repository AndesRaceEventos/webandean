 import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webandean/utils/Files%20%20Selected/pdf/reorder_pdf_widget.dart';
import 'package:webandean/provider/cache/files/files_procesisng.dart';
import 'package:webandean/utils/files%20assset/assets_imge.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class FilesPDFSelectedMovil extends StatelessWidget {
  const FilesPDFSelectedMovil({super.key, required this.isListPDf});
  final bool isListPDf;

  @override
  Widget build(BuildContext context) {
    final filesdata = Provider.of<FilesProvider>(context);
    final pdfs = filesdata.pdfs;
    final pdf = filesdata.pdf;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         if(pdf!= null || pdfs !=null)
        ListTile(
          contentPadding: EdgeInsets.all(0),
          minVerticalPadding: 0, 
          dense: true, 
          visualDensity: VisualDensity.compact,
          leading: Icon(Icons.select_all_outlined, color: Colors.blueGrey),
          title:  P3Text(text: 'Selecionados', color: Colors.blueGrey),
          trailing: TextButton(onPressed: () {
            context.read<FilesProvider>().setPdf(null);
            context.read<FilesProvider>().setPdfs(null);
          },
          child: P3Text(text:'borrar todo', color: Colors.blue,fontWeight: FontWeight.w500)),
        ),

        if (isListPDf) // Lista de múltiples PDFs
          ...[
            AppReorderPDFWidget(pdfE: pdfs),
            Container(
            decoration: AssetDecorationBox().headerDecoration(color: Colors.transparent),
            child: ListTile(
              leading: Image.asset(AppImages.fileplaceholder400),
              onTap: () async => pickMultiplePdfs(context, filesdata),
              title: H2Text(text: 'Subir Archivos'),
              subtitle:P3Text(text: 'Puedes cargar multiples archivos.'),
              trailing: Icon(Icons.upload),
            ),
          ),
           
          ],
        if (!isListPDf) // Un solo PDF
          ...[
            AppReorderPDFWidget(pdfE: pdf),
            Container(
            decoration: AssetDecorationBox().headerDecoration(color: Colors.transparent),
            child: ListTile(
              leading: Image.asset(AppImages.fileplaceholder400),
              onTap:  () async => pickPdf(context, filesdata),
              title: H2Text(text: 'Subir Archivo'),
              subtitle:P3Text(text: 'Puedes selecionar solo un archivo.'),
              trailing: Icon(Icons.upload),
            ),
          ),
          ],
      ],
    );
  }

 // Método para seleccionar múltiples PDFs
  void pickMultiplePdfs(BuildContext context, FilesProvider filesdata) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: true,
      );
      // print(result);

      if (result != null && result.files.isNotEmpty) {
        List<Uint8List> newFiles = [];

        for (var file in result.files) {
          Uint8List? bytes = file.bytes;

          // Si `bytes` es nulo, intenta leer desde `path`
          if (bytes == null && file.path != null) {
            bytes = await File(file.path!).readAsBytes();
          }

          print('Archivo PDF seleccionado (tamaño en bytes): ${bytes?.length}');
          if (bytes != null) {
            newFiles.add(bytes);
          }
        }

        if (newFiles.isNotEmpty) {
          filesdata.setPdfs((filesdata.pdfs ?? []) + newFiles); // Guarda múltiples PDFs en el proveedor
          print('Múltiples PDFs almacenados en filesdata');
        }
      } else {
        print('No se seleccionaron PDFs múltiples');
      }
    } catch (e) {
      print('Error al seleccionar múltiples PDFs: $e');
    }
  }

  // Método para seleccionar un solo PDF
  void pickPdf(BuildContext context, FilesProvider filesdata) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        Uint8List? bytes = result.files.first.bytes;

        // Si `bytes` es nulo, intenta leer desde `path`
        if (bytes == null && result.files.first.path != null) {
          bytes = await File(result.files.first.path!).readAsBytes();
        }

        print('PDF seleccionado (tamaño en bytes): ${bytes?.length}');
        if (bytes != null) {
          filesdata.setPdf(bytes); // Guarda el PDF en el proveedor
          print('PDF almacenado en filesdata');
        }
      } else {
        print('No se seleccionó ningún PDF');
      }
    } catch (e) {
      print('Error al seleccionar PDF: $e');
    }
  }
}
