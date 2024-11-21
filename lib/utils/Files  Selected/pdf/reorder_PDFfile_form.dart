import 'package:flutter/material.dart';
import 'package:webandean/api/api_poketbase.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/file%20pdf%20view/pdf_view_network.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class AppReorderPDFForm extends StatefulWidget {
  const AppReorderPDFForm({super.key, required this.pdfE, required this.pdfController, 
  // required this.onReorder,
  required this.value});

  final dynamic pdfE;//List<String> imagen;
  final TextEditingController pdfController;
  // final void Function() onReorder;
  final dynamic value;

  @override
  State<AppReorderPDFForm> createState() => _AppReorderPDFFormState();
}

class _AppReorderPDFFormState extends State<AppReorderPDFForm> {
  @override
  Widget build(BuildContext context) {
     List<String>? pdf;
    if (widget.value != null) {
      pdf = widget.value.pdf is String ? [widget.value.pdf] : widget.value.pdf;
    print('${pdf!.length.toString()}');
    }
    if (widget.value != null && pdf != null){
    return Container(
       decoration: AssetDecorationBox().borderdecoration(color: Colors.grey.shade100, colorBorder: Colors.green.shade200),
      padding: EdgeInsets.only(right: 5),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          P3Text(text: 'Guardado', height: 2, color: Colors.green.shade500,fontWeight: FontWeight.w600),
          Container(
            height: 70,
            child: ScrollWeb(
              child: ReorderableListView(
                buildDefaultDragHandles: false,// Desactiva el icono drag predeterminado
                scrollDirection: Axis.horizontal,
                header: Icon(Icons.arrow_right),
                footer: Icon(Icons.arrow_left),
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 0),
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    //  onReorder();//SetState
                    if (newIndex > oldIndex) newIndex--;
                    final img = pdf!.removeAt(oldIndex);
                    pdf.insert(newIndex, img);
                    widget.pdfController.text = pdf.join(',');
                  });
                },
                children: [
                  for (int index = 0; index < pdf.length; index++)
                    Container(
                      key: ValueKey(pdf[index]),
                      width: 70,
                      height: 70,
                      margin: EdgeInsets.symmetric(horizontal:3),
                      child: ReorderableDragStartListener(
                         index: index,
                        child: GestureDetector(
                           onTap: () async {
                          final pdfViewUrl =  '$urlserver/api/files/${widget.value.collectionId}/${widget.value.id}/${pdf![index]}';
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfViewNetwork(pdfViewUrl: pdfViewUrl),
                              ),
                            );
                        
                                            },
                          child: Stack(
                            alignment: AlignmentDirectional.topCenter,
                            children: [
                            //  SfPdfViewer.network('$urlserver/api/files/${widget.value.collectionId}/${widget.value.id}/${pdf[index]}'),
                            Column(
                              children: [
                                AppSvg(width: 40).pdfSvg,
                                P3Text(text: pdf[index], maxLines: 1, height:1, color: Colors.blue.shade500,),
                              ],
                            ),
                            P2Text(text: '${index + 1}', color: Colors.white,),
                        
                            Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  decoration: AssetDecorationBox().decorationBox(color: Colors.white70),
                                  padding: EdgeInsets.all(2),
                                  margin: EdgeInsets.all(1),
                                  child: GestureDetector(
                                      onTap: () async {
                                        bool isRemve = await showDialog(context: context, builder: (context){
                                           TextToSpeechService().speak('Desea eliminar este archivo?');
                                          return AssetAlertDialogPlatform(
                                                title: 'Eliminar',
                                                message: 'Desea eliminar este archivo?',
                                                child: AppSvg().trashRepoSvg
                                              );
                                        }) ?? true;
                        
                                       if (!isRemve) {
                                          setState(() {
                                          // onReorder();//SetState
                                          pdf!.removeAt(index);
                                           TextToSpeechService().speak('archivo eliminado.');
                                          widget.pdfController.text = pdf.join(',');
                                        });
                                       }
                                      },
                                      child: Icon(Icons.close,
                                          size: 12, color: Colors.red)),
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
          ),
        ],
      ),
    );}
    else {
     return Container();
    }
  }
}
