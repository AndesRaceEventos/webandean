

import 'package:flutter/material.dart';
import 'package:webandean/utils/animations/assets_delayed_display.dart';
import 'package:webandean/utils/button/assets_boton_style.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
// import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/utils/conversion/assets_format_values.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class SubListWidget<T> extends StatelessWidget {
  const SubListWidget({
    super.key, 
    required this.controller, 
    required this.fromJson, 
    required this.toJson, required this.getId, 
    required this.getQr, 
    required this.getName, 
    required this.routewidget,
    });
  final TextEditingController controller;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;
  final String Function(T) getId;
  final String Function(T) getQr;
  final String Function(T) getName;
  final Widget routewidget;
  

  @override
  Widget build(BuildContext context) {
    if(controller.text.isEmpty) return Container();
    // List<TProductosAppModel> listaMarcas = FormatValues.listaFromString<TProductosAppModel>(
    //   controller.text, 
    //   TProductosAppModel.fromJson
    // );

    // print(listaMarcas);
     List<T> itemList = FormatValues.listaFromString<T>(controller.text, fromJson);
    print(itemList);

     // Lista invertida para mostrarla en la interfaz
    List<T> reversedList = itemList.reversed.toList();

    return ScrollWeb(
      child: ReorderableListView.builder(
        buildDefaultDragHandles: false,// Desactiva el icono drag predeterminado
        header: ListTile(
          contentPadding: EdgeInsets.all(0),
          minVerticalPadding: 0,
          trailing: P3Text(text: '${itemList.length} REGISTROS.', fontWeight: FontWeight.bold,),
          leading: ElevatedButton(
            style: buttonStyle1(backgroundColor: Colors.green.shade900),
            onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> routewidget));
          }, child: P3Text(text: 'Configuración Avanzado',color: Colors.white,)),
        ),
        footer: ListTile(
          onTap: () async {
             bool isDeleted = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        TextToSpeechService().speak('Advertencia!. Estas apunto de eliminar todos los registros!!.');
                        return AssetAlertDialogPlatform(
                         message: '¿Estás seguro de que deseas eliminar todos los registros? Esta acción no se puede deshacer.',
                          title: 'Eliminar ${itemList.length} registros',
                          oK_textbuton: 'Continuar',
                          child: AppSvg().trashRepoSvg,
                        );
                      }) ?? true;
              if (!isDeleted) {
                  bool isTrashAll = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        TextToSpeechService().speak('Se eliminarán todos los registros. Luego de aceptar, recuerda presionar Guardar para aplicar los cambios. Asegúrate de que estás seguro, ya que perderás todos los registros.');
                        return AssetAlertDialogPlatform(
                          message: 'Se eliminarán todos los registros. Si estás seguro, presiona "Eliminar". Recuerda que debes presionar "Guardar" para aplicar los cambios. Asegúrate de que esta acción es la que deseas realizar, ya que perderás todos los datos.',
                          title: 'Eliminar ${itemList.length} registros',
                          oK_textbuton: 'Eliminar Todo',
                          child: AppSvg().trashRepoSvg,
                        );
                      }) ?? true;

                    if (!isTrashAll) {
                      controller.clear();
                      
                    }
              }
          },
          contentPadding: EdgeInsets.all(0),
          minVerticalPadding: 0,
          trailing: P3Text(text: 'Borrar todo', fontWeight: FontWeight.bold, color: Colors.red,),
          leading: AppSvg().trashRepoSvg,
        ),
        physics: ClampingScrollPhysics(),
        itemCount: itemList.length,//listaMarcas.length,
        // onReorder: (int oldIndex, int newIndex) {
        //   if (newIndex > oldIndex) newIndex--;  // Corrige el índice si se mueve hacia abajo
        //   final marca = itemList.removeAt(oldIndex); // Remueve la marca en el índice original
        //   itemList.insert(newIndex, marca); // Inserta la marca en el nuevo índice
        //    // Actualiza el controlador con la nueva lista de objetos
        //   controller.text = FormatValues.listaToString<T>(
        //     itemList,
        //     fromJson,
        //     toJson,
        //   );
        // },
        onReorder: (int oldIndex, int newIndex) {
          // Ajustamos los índices para reflejar el orden invertido visualmente
          if (newIndex > oldIndex) newIndex--;  // Ajustar el índice al mover elementos hacia abajo
          
          final item = reversedList.removeAt(oldIndex);
          reversedList.insert(newIndex, item);
    
          // Al final, actualizamos el controlador con la lista reordenada (pero invertida visualmente)
          controller.text = FormatValues.listaToString<T>(
            reversedList.reversed.toList(), // Invertimos la lista antes de actualizar el texto
            fromJson,
            toJson,
          );
        },
        itemBuilder: (context, index) {
        //  final item = itemList.reversed.toList()[index];
          // final item = itemList[index];
          final item = reversedList[index];
          final itemName = getName(item);
          bool isJsonError = (getId(item).isNotEmpty && getQr(item).isNotEmpty && getName(item) != 'Error Json');
    
          return isJsonError ? 
          Container(
            key: ValueKey(item),  // La clave es importante para que se pueda mover
            decoration: AssetDecorationBox().selectedDecoration(color: Colors.white),
            margin: EdgeInsets.only(bottom: 5),
            child: AssetsDelayedDisplayYbasic(
              duration: 300,
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                minTileHeight: 0,
                minVerticalPadding: 0,
                visualDensity: VisualDensity.compact,
                dense: true, 
                minLeadingWidth: 0,
                selectedColor: Colors.lime,
                leading: ReorderableDragStartListener(
                  index: index,
                  child: TextButton.icon(
                  iconAlignment: IconAlignment.start,
                  onPressed: null, 
                  label: P3Text(text: '${index + 1}', 
                      color: AppColors.menuTheme,
                      fontWeight: FontWeight.bold,
                      ),
                  icon: Icon(Icons.drag_handle)
                  ),
                ),
                title: P2Text(text: '${itemName}'), // Aquí puedes mostrar la propiedad `nombre` o cualquier otra que desees
                subtitle: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black54, fontSize:11),
                  children: [
                    TextSpan(text: 'ID  : ',style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${getId(item)}',),
                     TextSpan(text: '\nQR : ',style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${ getQr(item)}'),
                  ])),
                trailing: IconButton(
                  onPressed: () async {
                    bool isDeleted = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        TextToSpeechService().speak('Deseas eliminar el registro ${itemName}?');
                        return AssetAlertDialogPlatform(
                          message: '¿Confirmar eliminación?',
                          title: 'Eliminar $itemName}',
                          oK_textbuton: 'Eliminar',
                        );
                      }) ?? true;
              
                    if (!isDeleted) {
                      // Eliminar el producto de la lista.
                      itemList.remove(item);
                      // Actualiza el controlador con la nueva lista.
                      controller.text = FormatValues.listaToString<T>(
                        itemList, 
                        fromJson, 
                        toJson
                      );
                      TextToSpeechService().speak('Registro eliminado. ${itemName}');
                    }                
                  },
                  icon: Icon(
                    Icons.remove_circle_outline_outlined,
                    size: 15,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ) : Container(
              key: ValueKey(item),  // La clave es importante para que se pueda mover
            child: _warnigJsonError(item),
          );
        },
      ),
    );
  }

  Column _warnigJsonError(T item) {
    return Column(
            children: [
            H1Text(text:getName(item), height:3, color: Colors.red.shade300),
            AppSvg(color: Colors.red.shade300, width: 100).crashSvg,
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black54, fontSize:12),
                children: [
                  TextSpan(
                    text: '¡Atención! Error al cargar datos.',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  TextSpan(text: ' Se ha detectado un error en los datos del servidor. Es posible que la información no sea compatible con el sistema.',),
                  TextSpan(text:  '\n\nTe recomendamos revisar la información en el servidor y corregir cualquier error antes de continuar.',
                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                   ),
                  TextSpan(text:  ' Si deseas reemplazar los datos existentes con los nuevos, puedes continuar y añadir registros. Sin embargo, ten en cuenta que se perderá la información actual y se reemplazara con la nueva.',),
                ],
              ),
            ),
          ],
      );
  }
}
// // import 'package:flutter/material.dart';
// // import 'package:webandean/model/producto/model_producto.dart';
// // import 'package:webandean/utils/conversion/assets_format_values.dart';
// // import 'package:webandean/utils/dialogs/assets_dialog.dart';
// // import 'package:webandean/utils/layuot/assets_scroll_web.dart';
// // import 'package:webandean/utils/speack/assets_speack.dart';

// // class SubListWidget extends StatelessWidget {
// //   const SubListWidget({super.key, required this.controller});
// //   final TextEditingController controller;

// //   @override
// //   Widget build(BuildContext context) {
// //      List<TProductosAppModel> listaMarcas = FormatValues.listaFromString<TProductosAppModel>(controller.text, TProductosAppModel.fromJson);
// //          print(listaMarcas);
// //           return Container(
// //             height: 300,
// //             child: ScrollWeb(
// //               child: ListView.builder(
// //                 itemCount: listaMarcas.length,
// //                 itemBuilder: (context, index) {
// //                   final marca = listaMarcas.reversed.toList()[index];
// //                   return ListTile(
// //                     leading: Icon(Icons.edit, color: Colors.green),
// //                     title: Text('${marca.nombre} ${index + 1}'), // Aquí puedes mostrar la propiedad `nombre` o cualquier otra que desees
// //                     trailing:IconButton(
// //                       onPressed: () async {
                      
// //                         bool isDeleted = await showDialog(
// //                           context: context,
// //                           builder: (BuildContext context) {
// //                              TextToSpeechService().speak('Deseas eliminar el registro ${marca.nombre}?');
// //                             return AssetAlertDialogPlatform(
// //                               message: '¿Confirmar eliminación?',
// //                               title: 'Eliminar ${marca.nombre}',
// //                               oK_textbuton: 'Eliminar',
// //                             );
// //                           }) ??
// //                       true;

// //                         if (!isDeleted) {
// //                           // Eliminar el producto de la lista.
// //                             listaMarcas.remove(marca);
// //                             // Actualiza el controlador con la nueva lista.
// //                             controller.text = FormatValues.listaToString<TProductosAppModel>(
// //                               listaMarcas, 
// //                               TProductosAppModel.fromJson, 
// //                               (TProductosAppModel marca) => marca.toJson()
// //                             );
// //                             TextToSpeechService().speak('Registro eliminado. ${marca.nombre}');
// //                         }                
// //                       },
// //                       icon:  Icon(
// //                       Icons.remove_circle_outline_outlined,
// //                       size: 15,
// //                       color: Colors.red,
// //                     ),
// //                     )
// //                   );
// //                 },
// //               ),
// //             ),
// //           );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:webandean/model/producto/model_producto.dart';
// import 'package:webandean/utils/conversion/assets_format_values.dart';
// import 'package:webandean/utils/dialogs/assets_dialog.dart';
// import 'package:webandean/utils/files%20assset/assets-svg.dart';
// import 'package:webandean/utils/layuot/assets_scroll_web.dart';
// import 'package:webandean/utils/speack/assets_speack.dart';
// import 'package:webandean/utils/text/assets_textapp.dart';

// class SubListWidget extends StatelessWidget {
//   const SubListWidget({super.key, required this.controller});
//   final TextEditingController controller;
  

//   @override
//   Widget build(BuildContext context) {
//     List<TProductosAppModel> listaMarcas = FormatValues.listaFromString<TProductosAppModel>(
//       controller.text, 
//       TProductosAppModel.fromJson
//     );
//     print(listaMarcas);

//     return Container(
//       height: 300,
//       child: ScrollWeb(
//         child: ReorderableListView.builder(
//           itemCount: listaMarcas.length,
//           onReorder: (int oldIndex, int newIndex) {
//             if (newIndex > oldIndex) newIndex--;  // Corrige el índice si se mueve hacia abajo
//             final marca = listaMarcas.removeAt(oldIndex); // Remueve la marca en el índice original
//             listaMarcas.insert(newIndex, marca); // Inserta la marca en el nuevo índice
//           },
//           itemBuilder: (context, index) {
//             final marca = listaMarcas.reversed.toList()[index];

//             bool isjsonError = (marca.id.isNotEmpty && marca.qr.isNotEmpty && marca.nombre != 'Error Json');

//             return isjsonError ? ListTile(
//               key: ValueKey(marca),  // La clave es importante para que se pueda mover
//               leading: Icon(Icons.edit, color: Colors.green),
//               title: Text('${marca.nombre} ${index + 1}'), // Aquí puedes mostrar la propiedad `nombre` o cualquier otra que desees
//               trailing: IconButton(
//                 onPressed: () async {
//                   bool isDeleted = await showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       TextToSpeechService().speak('Deseas eliminar el registro ${marca.nombre}?');
//                       return AssetAlertDialogPlatform(
//                         message: '¿Confirmar eliminación?',
//                         title: 'Eliminar ${marca.nombre}',
//                         oK_textbuton: 'Eliminar',
//                       );
//                     }) ?? true;

//                   if (!isDeleted) {
//                     // Eliminar el producto de la lista.
//                     listaMarcas.remove(marca);
//                     // Actualiza el controlador con la nueva lista.
//                     controller.text = FormatValues.listaToString<TProductosAppModel>(
//                       listaMarcas, 
//                       TProductosAppModel.fromJson, 
//                       (TProductosAppModel marca) => marca.toJson()
//                     );
//                     TextToSpeechService().speak('Registro eliminado. ${marca.nombre}');
//                   }                
//                 },
//                 icon: Icon(
//                   Icons.remove_circle_outline_outlined,
//                   size: 15,
//                   color: Colors.red,
//                 ),
//               ),
//             ) : Container(
//                 key: ValueKey(marca),  // La clave es importante para que se pueda mover
//               child: _warnigJsonError(marca),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Column _warnigJsonError(TProductosAppModel marca) {
//     return Column(
//             children: [
//             H1Text(text: marca.nombre, height:3, color: Colors.red.shade300),
//             AppSvg(color: Colors.red.shade300, width: 100).crashSvg,
//             RichText(
//               text: TextSpan(
//                 style: TextStyle(color: Colors.black54, fontSize:12),
//                 children: [
//                   TextSpan(
//                     text: '¡Atención! Error al cargar datos.',
//                     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
//                   ),
//                   TextSpan(text: ' Se ha detectado un error en los datos del servidor. Es posible que la información no sea compatible con el sistema.',),
//                   TextSpan(text:  '\n\nTe recomendamos revisar la información en el servidor y corregir cualquier error antes de continuar.',
//                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
//                    ),
//                   TextSpan(text:  ' Si deseas reemplazar los datos existentes con los nuevos, puedes continuar y añadir registros. Sin embargo, ten en cuenta que se perderá la información actual y se reemplazara con la nueva.',),
//                 ],
//               ),
//             ),
//           ],
//       );
//   }
// }


