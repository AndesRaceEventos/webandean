import 'package:flutter/material.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/routes/assets_img_urlserver.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class AppReorderImageForm extends StatefulWidget {
  const AppReorderImageForm({super.key, required this.imagenE, required this.imagenController, 
  // required this.onReorder,
  required this.value});

  final dynamic imagenE;//List<String> imagen;
  final TextEditingController imagenController;
  // final void Function() onReorder;
  final dynamic value;

  @override
  State<AppReorderImageForm> createState() => _AppReorderImageFormState();
}

class _AppReorderImageFormState extends State<AppReorderImageForm> {
  @override
  Widget build(BuildContext context) {
     List<String>? imagen;
    if (widget.value != null) {
      imagen =
          widget.value.imagen is String ? [widget.value.imagen] : widget.value.imagen;
    }
    
    if (widget.value != null && imagen != null){
    return Container(
      decoration: AssetDecorationBox().borderdecoration(color: Colors.grey.shade100, colorBorder: Colors.green.shade200),
      padding: EdgeInsets.only(right: 5 ,bottom: 5),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          P3Text(text: 'Guardado', height: 2, color: Colors.green.shade500,fontWeight: FontWeight.w600),
          Container(
           height: 80,
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
                   final img = imagen!.removeAt(oldIndex);
                   imagen.insert(newIndex, img);
                   widget.imagenController.text = imagen.join(',');
                 });
               },
               children: [
                 for (int index = 0; index < imagen.length; index++)
                   Container(
                     key: ValueKey(imagen[index]),
                     width: 80,
                     height: 80,
                     margin: EdgeInsets.symmetric(horizontal:3),
                     child: ReorderableDragStartListener(
                        index: index,
                        child: Stack(
                         alignment: AlignmentDirectional.centerEnd,
                         children: [
                           GLobalImageUrlServer(
                             fadingDuration: 0,
                             duration: 0,
                             height: 80,
                             width: 80,
                             image: imagen[index],
                             collectionId: widget.value.collectionId ?? '',
                             id: widget.value.id,
                             borderRadius: BorderRadius.circular(1),
                             data: [imagen[index]],
                           ),
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
                                       setState(() {
                                       // onReorder();//SetState
                                       imagen!.removeAt(index);
                                        TextToSpeechService().speak('archivo eliminado.');
                                       widget.imagenController.text = imagen.join(',');
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