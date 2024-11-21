// import 'dart:typed_data';
// import 'dart:html' as html; // Importa html para Flutter Web
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:webandean/utils/Files%20%20Selected/pdf/reorder_pdf_widget.dart';
// import 'package:webandean/provider/cache/files/files_procesisng.dart';
// import 'package:webandean/utils/files%20assset/assets_imge.dart';
// import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
// import 'package:webandean/utils/text/assets_textapp.dart';

// class FilesPDFSelectedWeb extends StatelessWidget {
//   const FilesPDFSelectedWeb({super.key, required this.isListImage});
//   final bool isListImage;
//   @override
//   Widget build(BuildContext context) {
//     final filesdata = Provider.of<FilesProvider>(context);
//     final pdfs = filesdata.pdfs;
//      final pdf = filesdata.pdf;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//          if(pdf!= null || pdfs !=null)
//         ListTile(
//           contentPadding: EdgeInsets.all(0),
//           minVerticalPadding: 0, 
//           dense: true, 
//           visualDensity: VisualDensity.compact,
//           leading: Icon(Icons.select_all_outlined, color: Colors.blueGrey),
//           title:  P3Text(text: 'Selecionados', color: Colors.blueGrey),
//           trailing: TextButton(onPressed: () {
//             context.read<FilesProvider>().setPdf(null);
//             context.read<FilesProvider>().setPdfs(null);
//           },
//           child: P3Text(text:'borrar todo', color: Colors.blue,fontWeight: FontWeight.w500)),
//         ),

//          if(isListImage)// si es lista de imagenes 
//          ...[
//            AppReorderPDFWidget(pdfE: pdfs),
//            Container(
//             decoration: AssetDecorationBox().headerDecoration(color: Colors.transparent),
//             child: ListTile(
//               leading: Image.asset(AppImages.fileplaceholder400),
//               onTap: () async => pickMultiplePdfFromWeb(context, filesdata),
//               title: H2Text(text: 'Subir Archivos'),
//               subtitle:P3Text(text: 'Puedes cargar multiples archivos.'),
//               trailing: Icon(Icons.upload),
//             ),
//           ),
//          ],
//          if(!isListImage)// Solo una imagen 
//          ...[
//            AppReorderPDFWidget(pdfE: pdf),
//             Container(
//             decoration: AssetDecorationBox().headerDecoration(color: Colors.transparent),
//             child: ListTile(
//               leading: Image.asset(AppImages.fileplaceholder400),
//               onTap:() async => pickPdfFromWeb(context, filesdata),
//               title: H2Text(text: 'Subir Archivo'),
//               subtitle:P3Text(text: 'Puedes selecionar solo un archivo.'),
//               trailing: Icon(Icons.upload),
//             ),
//           ),
//          ]
          
//       ],
//     );
//   }
// void pickPdfFromWeb(BuildContext context, FilesProvider filesdata) async {
//     final uploadInput = html.FileUploadInputElement();
//     uploadInput.accept = 'application/pdf'; // Solo permite PDFs
//     uploadInput.click();

//     uploadInput.onChange.listen((event) {
//       final file = uploadInput.files!.first;
//       final reader = html.FileReader();

//       reader.readAsArrayBuffer(file); // Lee como un array buffer para PDF
//       reader.onLoadEnd.listen((event) async {
//         final bytes = reader.result as Uint8List;

//         // Actualiza el archivo en el proveedor
//         filesdata.setPdf(bytes); // Proveedor
//       });
//     });
//   }

//   // Método para seleccionar múltiples PDFs en la web
//   void pickMultiplePdfFromWeb(BuildContext context, FilesProvider filesdata) async {
//     final uploadInput = html.FileUploadInputElement();
//     uploadInput.accept = 'application/pdf'; // Solo permite PDFs
//     uploadInput.multiple = true; // Permite selección de múltiples archivos
//     uploadInput.click();

//     uploadInput.onChange.listen((event) async {
//       List<Uint8List> newFiles = [];

//       for (final file in uploadInput.files!) {
//         final reader = html.FileReader();
//         reader.readAsArrayBuffer(file); // Lee como un array buffer para PDF

//         await reader.onLoadEnd.first;
//         final bytes = reader.result as Uint8List;

//         newFiles.add(bytes); // Agrega el archivo PDF a la lista
//       }

//       // Actualiza la lista de archivos en el proveedor
//       filesdata.setPdfs((filesdata.pdfs ?? []) + newFiles);
//     });
//   }

// }
