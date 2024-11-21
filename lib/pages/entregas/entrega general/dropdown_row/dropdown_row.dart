import 'package:flutter/material.dart';
import 'package:webandean/model/entregas/model_entregas_general.dart';
import 'package:webandean/pages/entregas/entrega%20general/dropdown_row/Lista%20producto/lista_producto.dart';


/// Widget principal que recibe los datos y muestra la lista de productos
Widget dropDowButonbar(Map<String, dynamic> data) {
  // Convertir el mapa a TEntregasModel
  TEntregasModel dataRow = data['data'];
  return Builder(
    builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Mostrar el nombre del producto (o entrega)
          // H2Text(text: '${listaProducto.length}' ),
          // ...listaProducto.map((item){
          //   return P3Text(text: '${item.nombre}');
          // })
          // Usamos un contenedor con altura fija para evitar conflictos con 'Expanded'
          // Container(
          //   height: 500, // Ajusta el tamaño según sea necesario
          //   child: ListaProductos(listaProducto: listaProducto),
          // ),
          ElevatedButton(
            onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (_)=> ListaProductos(data: dataRow)));
          }, child: Text('Productos')), 
          
        ],
      );
    }
  );
}
