import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class AppReorderImageWdiget extends StatefulWidget {
  const AppReorderImageWdiget({
    super.key, required this.imagenE, 
    // required this.onReorder
    });

  final dynamic imagenE;
  @override
  State<AppReorderImageWdiget> createState() => _AppReorderImageWdigetState();
}

class _AppReorderImageWdigetState extends State<AppReorderImageWdiget> {
//List<String> imagen; o  List<Uint8List>? imagen;
  @override
  Widget build(BuildContext context) {
     // Configura `imagenBytes` o `imagenStrings` según el tipo de `imagenE`
    final imagenBytes = widget.imagenE is Uint8List
        ? [widget.imagenE]
        : widget.imagenE is List<Uint8List>
            ? widget.imagenE
            : null;

    final imagenStrings = widget.imagenE is String
        ? [widget.imagenE]
        : widget.imagenE is List<String>
            ? widget.imagenE
            : null;
    
    // Genera el widget de la lista de imágenes usando `imagenBytes` o `imagenStrings`
    if ((imagenBytes != null && imagenBytes.isNotEmpty) ||
        (imagenStrings != null && imagenStrings.isNotEmpty)) {
    return Container(
            height: 70,
            child: ScrollWeb(
              child: ReorderableListView(
                scrollDirection: Axis.horizontal,
                header: Icon(Icons.arrow_right),
                footer: Icon(Icons.arrow_left),
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 0),
                onReorder: (int oldIndex, int newIndex) {
                  // setState(() {
                    //  onReorder();//SetState
                    setState(() {
                      if (newIndex > oldIndex) newIndex--;
                      if (imagenBytes != null) {
                        final img = imagenBytes.removeAt(oldIndex);
                        imagenBytes.insert(newIndex, img);
                      } else if (imagenStrings != null) {
                        final img = imagenStrings.removeAt(oldIndex);
                        imagenStrings.insert(newIndex, img);
                      }
                    });
                    // imagenController.text = imagen.join(',');
                  // });
                },
                children: [
                  for (int index = 0; index < (imagenBytes?.length ?? imagenStrings?.length ?? 0); index++)
                    Container(
                       key: ValueKey(imagenBytes != null
                      ? imagenBytes[index]
                      : imagenStrings![index]),
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.symmetric(horizontal:3),
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                         if (imagenBytes != null)
                            Image.memory(imagenBytes[index],
                                width: 80, height: 80, fit: BoxFit.cover)
                          else if (imagenStrings != null)
                            Image.network(imagenStrings[index],
                                width: 80, height: 80, fit: BoxFit.cover),
                          Align(
                            alignment: Alignment.center,
                           child: Container(
                            decoration: AssetDecorationBox().decorationBox(color: Colors.grey.shade300),
                            padding: EdgeInsets.symmetric(horizontal:10),
                            child: P2Text(text: '${index + 1}', color: Colors.black,),
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
                                    bool isRemve = await showDialog(context: context, builder: (context){
                                       TextToSpeechService().speak('Desea eliminar este archivo?');
                                      return AssetAlertDialogPlatform(
                                            title: 'Eliminar',
                                            message: 'Desea eliminar este archivo?',
                                            child: AppSvg().trashRepoSvg
                                          );
                                    }) ?? true;
                                    
                                   if (!isRemve) {
                                      // setState(() {
                                      // onReorder();//SetState
                                    setState(() {
                                        
                                     if (imagenBytes != null) {
                                        imagenBytes.removeAt(index);
                                      } else if (imagenStrings != null) {
                                        imagenStrings.removeAt(index);
                                      }
                                      TextToSpeechService().speak('archivo eliminado.');
                                     });
                                      // imagenController.text = imagen.join(',');
                                    // });
                                   }
                                  },
                                  child: Icon(Icons.close,
                                      size: 12, color: Colors.red)),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );}
          else {
            return Container();
          }
  }
}