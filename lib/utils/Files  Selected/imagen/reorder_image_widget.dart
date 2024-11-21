import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webandean/provider/cache/files/files_procesisng.dart';
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
  @override
  Widget build(BuildContext context) {
    // final filesdata = Provider.of<FilesProvider>(context);
    // final imagenes = filesdata.imagenes;
    // final imagenE = filesdata.imagen;
    // Genera el widget de la lista de imágenes usando `imagenBytes` o `imagenStrings`
    if ((widget.imagenE != null && widget.imagenE.isNotEmpty) ) {
         // Configura `imagenBytes` o `imagenStrings` según el tipo de `imagenE`
    final List<Uint8List> imagenBytes = widget.imagenE is Uint8List ? [widget.imagenE] :  widget.imagenE;

    return Container(
            height: 80,
            padding: EdgeInsets.symmetric(vertical: 0),
            child: ScrollWeb(
              child: ReorderableListView(
                buildDefaultDragHandles: false,// Desactiva el icono drag predeterminado
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
                      } 
                    });
                    // imagenController.text = imagen.join(',');
                  // });
                },
                children: [
                  for (int index = 0; index < (imagenBytes.length); index++)
                    Container(
                       key: ValueKey( imagenBytes[index]),
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.symmetric(horizontal:3),
                      child: ReorderableDragStartListener(
                        index: index,
                        child: Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [
                           if (imagenBytes != null)
                              Image.memory(imagenBytes[index],  width: 80, height: 80, fit: BoxFit.cover),
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
                                       print(imagenBytes.length);
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
                                          if (widget.imagenE is Uint8List) {
                                            context.read<FilesProvider>().setImagen(null);
                                          }
                                        TextToSpeechService().speak('archivo eliminado.');
                                        }
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