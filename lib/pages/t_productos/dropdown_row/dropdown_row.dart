
  import 'package:flutter/material.dart';
import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

Widget dropDowButonbar(Map<String, dynamic> data, BuildContext context) {
   // Convertir el mapa a TProductosAppModel
  // TProductosAppModel producto = TProductosAppModel.fromJson(data);
  TProductosAppModel producto =  data['data'];
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        H2Text(text: producto.proveeduria), 
        //          Wrap(
        //   spacing: 8.0, // Espacio horizontal entre elementos
        //   runSpacing: 8.0, // Espacio vertical entre filas
        //   children: [
        //     Chip(label: Text('Flutter')),
        //     Chip(label: Text('Dart')),
        //     Chip(label: Text('Mobile Development')),
        //     Chip(label: Text('UI/UX')),
        //     Chip(label: Text('OpenAI')),
        //     Chip(label: Text('AI')),
        //   ],
        // ),
        // ElevatedButton.icon(
        //   onPressed: () {
        //     setState(() {
        //       dataDrop = data['data'];
        //     });
        //   },
        //   icon: Icon(Icons.arrow_drop_down),
        //   label: Text('Editar'),
        // ),
        // ElevatedButton.icon(
        //   onPressed: () async {
        //     isDeleteForm(data, context);
        //   },
        //   icon: Icon(Icons.delete),
        //   label: Text('Eliminar'),
        // ),
        // if (widget.checkpoint != null)
        // ElevatedButton.icon(
        //   onPressed: () async {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) =>
        //                 AssetHtmlView(html: data['data'].informacionGeneral)));
        //   },
        //   icon: Icon(Icons.add),
        //   label: Text('Html'),
        // ),
      ],
    );
  }
