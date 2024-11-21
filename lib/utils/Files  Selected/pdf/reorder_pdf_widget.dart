import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; // Importar Syncfusion PDF Viewer
import 'package:webandean/provider/cache/files/files_procesisng.dart';
import 'dart:io';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/file%20pdf%20view/pdf_view_memory.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/text/assets_textapp.dart';


class AppReorderPDFWidget extends StatefulWidget {
  const AppReorderPDFWidget({super.key, required this.pdfE});

  final dynamic pdfE;

  @override
  State<AppReorderPDFWidget> createState() => _AppReorderPDFWidgetState();
}

class _AppReorderPDFWidgetState extends State<AppReorderPDFWidget> {
  @override
  Widget build(BuildContext context) {
    if ((widget.pdfE != null && widget.pdfE.isNotEmpty)) {

       final List<Uint8List> pdfBytes = widget.pdfE is Uint8List ? [widget.pdfE] :  widget.pdfE;

      return Container(
          height: 45,
          padding: EdgeInsets.symmetric(vertical: 0),
          child: ScrollWeb(
          child: ReorderableListView(
            buildDefaultDragHandles: false,// Desactiva el icono drag predeterminado
            scrollDirection: Axis.horizontal,
            header: Icon(Icons.arrow_right),
            footer: Icon(Icons.arrow_left),
            padding: EdgeInsets.symmetric(vertical: 1, horizontal: 0),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final pdf = pdfBytes.removeAt(oldIndex);
                pdfBytes.insert(newIndex, pdf);
              });
            },
            children: [
              for (int index = 0; index < pdfBytes.length; index++)
                Container(
                  key: ValueKey(pdfBytes[index]),
                  width: 70,
                  height: 45,
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  child: ReorderableDragStartListener(
                  index: index,
                    child: GestureDetector(
                      onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfViewMemory(pdfBytes:pdfBytes[index]),  // Muestra el PDF directamente desde los bytes
                                ),
                              );
                      
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          // SfPdfViewer.memory(pdfBytes[index]),
                          Opacity(opacity: .7, child: AppSvg(width: 50).pdfSvg),
                          // H2Text(text: 'PDF', fontSize: 16),
                           Align(
                                alignment: Alignment.topCenter,
                               child: Container(
                                // decoration: AssetDecorationBox().decorationBox(color: Colors.white),
                                padding: EdgeInsets.symmetric(horizontal:5),
                                child: P2Text(text: '${index + 1}', color: Colors.white,),
                                ),
                             ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              decoration: AssetDecorationBox().decorationBox(color: Colors.white70),
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.all(1),
                              child: GestureDetector(
                                onTap: () async {
                                  bool isRemove = await showDialog(context: context, builder: (context) {
                                    TextToSpeechService().speak('Desea eliminar este archivo?');
                                    return AssetAlertDialogPlatform(
                                      title: 'Eliminar',
                                      message: 'Desea eliminar este archivo?',
                                      child: AppSvg().trashRepoSvg,
                                    );
                                  }) ?? true;
                    
                                  if (!isRemove) {
                                    setState(() {
                                      pdfBytes.removeAt(index);
                                       if (widget.pdfE is Uint8List) {
                                            context.read<FilesProvider>().setPdf(null);
                                          }
                                      TextToSpeechService().speak('archivo eliminado.');
                                    });
                                  }
                                },
                                child: Icon(Icons.close, size: 12, color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class PDFPreviewScreen extends StatelessWidget {
  final String filePath;

  const PDFPreviewScreen({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vista Previa PDF'),
      ),
      body: FutureBuilder(
        future: File(filePath).exists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data == true) {
            return SfPdfViewer.file(File(filePath));  // Usa SfPdfViewer para mostrar el PDF desde el archivo
          } else {
            return Center(child: Text('Error al cargar el archivo PDF'));
          }
        },
      ),
    );
  }
}
