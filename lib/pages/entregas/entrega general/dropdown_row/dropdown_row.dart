import 'package:flutter/material.dart';

import 'package:webandean/model/entregas/model_entregas_general.dart';
import 'package:webandean/model/entregas/model_lista_equipos.dart';
import 'package:webandean/model/entregas/model_lista_productos.dart';
import 'package:webandean/model/equipo/model_equipo.dart';
import 'package:webandean/model/personal/model_personal_apu.dart';
import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/pages/entregas/entrega%20general/dropdown_row/subLista%20producto/sublista_producto.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/formulario/formfield_customs.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/text/assets_textapp.dart';


/// Widget principal que recibe los datos y muestra la lista de productos
Widget dropDowButonbar(Map<String, dynamic> data) {
  // Convertir el mapa a TEntregasModel
  TEntregasModel dataRow = data['data'];

  // Manejo seguro de listas, evitando el operador `!` y gestionando posibles nulos
  final List<TPersonalApuModel> idPersonal = dataRow.idPersonalValue ?? [];
  final List<TListaEntregaEquiposModel> idListaEquipos = dataRow.idListaEquiposValue != null
      ? [dataRow.idListaEquiposValue!]
      : [];
  final List<TListaEntregaProductosModel> idListaProductos = dataRow.idListaProductosValue != null
      ? [dataRow.idListaProductosValue!]
      : [];

  final mapValue = {
    'Personal': idPersonal,
    'Equipos': idListaEquipos,
    'Producto': idListaProductos,
  };

  final List<TProductosAppModel> listaProducto = dataRow.listaProducto ?? [];
  final List<TEquiposAppModel> listaEquipos = dataRow.listaEquipos ?? [];

  return Builder(
    builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: AssetDecorationBox().headerDecoration(color: AppColors.menuHeaderTheme.withOpacity(.3)),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...mapValue.entries.map((item){
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  visualDensity: VisualDensity.compact,
                  dense: true,
                  minVerticalPadding: 0,
                  title: H3Text(text: '${item.key}'.toUpperCase()),
                  
                  subtitle: Wrap(
                    spacing: 2.0,
                    children: item.value.map((p) {
                      // Asegúrate de que `p` tenga la propiedad `nombre`
                        final String name = (p as dynamic).nombre ?? 'Sin Nombre';
                      return Chip(
                          backgroundColor: AppColors.menuHeaderTheme,
                          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          visualDensity: VisualDensity.compact,
                          side: BorderSide.none,
                          label: P2Text(
                            text: '${name}',
                            color: AppColors.primaryWhite,
                          ),);
                    }).toList(),
                  ),
                );
              }).toList(),
            
          
             ButtonSubListProductos(data: dataRow),
          
              
            ],
          ),
        ),
      );
    }
  );
}



class ButtonSubListProductos extends StatelessWidget {
  const ButtonSubListProductos({super.key, required this.data});
  final TEntregasModel data;
  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Muestra un diálogo de carga antes de continuar
        // showDialog(
        //   context: context,
        //   barrierDismissible: false, // Evita que se cierre el diálogo tocando fuera
        //   builder: (context) => Center(child: CircularProgressIndicator()),
        // );

        // // Lee las instrucciones con TextToSpeech
        // await TextToSpeechService().speak('Instrucciones para usar este widget: Toque el botón para ver la lista de productos.');

        // // Espera a que el TTS termine antes de cerrar el diálogo y navegar
        // TextToSpeechService().flutterTts.setCompletionHandler(() async {
        //   // Cierra el diálogo de carga
        //   Navigator.of(context).pop();

        //   // Navega a la siguiente pantalla
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => ListaProductos(data: data)),
        //   );
        // });
         Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => 
            ListaProductos(
              data: data, 
              categoria:'CATEGORIA_COMPRAS', //todos Asginasmos la categoria a filtrar   SEGU NTU PROVIDER OJO!!! 
              header: [
                'Tipo', 'Nombre', 'Observacion', 'Precio', 'Cantidad','SubTotal' ,'_','Estado'
              ],
              getProductGrup: (producto) { 

                 TProductosAppModel productGrup = producto;
                  productGrup.cantidadEnStock ?? 0;
                  productGrup.outPrecioDistribucion ?? 0;
                  
                  final listRows = {
                       'Tipo': productGrup.tipo,
                       'Nombre':"${productGrup.nombre} * ${productGrup.outUndMedida.toUpperCase()}",
                       'observacion': productGrup.observacion,
                       'Precio': productGrup.outPrecioDistribucion.toString(),
                       'Cantidad': productGrup.cantidadEnStock,
                       'SubTotal': (productGrup.cantidadEnStock! * productGrup.outPrecioDistribucion).toStringAsFixed(2).toString(),//lop onemso como strign para no se active el editar 
                       '_': productGrup.moneda,
                       'Estado': productGrup.active,
                     };
                 return listRows;
               },
              toDuplicateInstans: (productGrup, duplicateCount) => copyToDuplicate(productGrup, duplicateCount), 
              getCreatedNewitem: (listaPadre, listaHijo){
                return  Container(
                    padding: EdgeInsets.only(left: 15),
                    constraints: BoxConstraints(maxWidth: 365,),
                    child: FormWidgets(context).autocomleteSearchListEntregas(
                    title: 'Productos',
                    listaPadre: listaPadre,//lista de Objeto para este ejmplo se utilizo productos 
                    listaHijo: listaHijo ?? [],
                    getName: (producto) => producto.nombre,
                    getQr: (producto) => producto.qr,
                    getId: (producto) => producto.id,
                    //Valores protegidos que no deben ser reemplazados 
                    getActive: (producto) => producto.active,
                    getCantidadEnStock: (producto) => producto.cantidadEnStock,
                    getObservacion :  (producto) => producto.observacion,
                    //Metodos de Filtrados se debe buscar por .. poner aqui los valores deseados 
                    getField: (producto, query) {
                      return producto.nombre.toLowerCase().contains(query) ||
                            producto.qr.toLowerCase().contains(query) ||
                            producto.id.toLowerCase().contains(query);
                    }, 
                    toJson: (producto) => producto.toJson(), // Convierte el producto a JSON
                    fromJson: (json) => TProductosAppModel.fromJson(json), // Convierte JSON a OBJETO  ProductoModel
                    ),
                  );
              },
            )),
          );
      },
      child: Text('Productos'),
    );
  }
}

//SI es que le duplicado falla intenta asignar Valores diferntes 
TProductosAppModel copyToDuplicate(TProductosAppModel productGrup, int duplicateCount){
    String newName = '${productGrup.nombre} copia [$duplicateCount]';
   return TProductosAppModel(
        id: productGrup.id, 
         qr: productGrup.qr,
         collectionId: productGrup.collectionId ,
         collectionName: productGrup.collectionName ,
         nombre: newName,  // Modificar solo el nombre
         observacion: 'copia ${DateTime.now()}',
         cantidadEnStock: 0,
         active: true,// duplicado como comprar 
         outPrecioDistribucion: productGrup.outPrecioDistribucion,
         tipo: productGrup.tipo,
          moneda: productGrup.moneda,
         categoriaCompras: productGrup.categoriaCompras,
         categoriaInventario: productGrup.categoriaInventario,
         ubicacion: productGrup.ubicacion,
         proveedor: productGrup.proveedor,
         rotacion: productGrup.rotacion,
         intUndMedida: productGrup.intUndMedida,
         outUndMedida: productGrup.outUndMedida,
         intPrecioCompra: productGrup.intPrecioCompra,
         idMenu: productGrup.idMenu,
         fechaVencimiento: productGrup.fechaVencimiento,
         estado: productGrup.estado,
         demanda: productGrup.demanda,
         condicionAlmacenamiento: productGrup.condicionAlmacenamiento,
         tipoPrecio: productGrup.tipoPrecio,
         formato: productGrup.formato,
         durabilidad: productGrup.durabilidad,
         proveeduria: productGrup.proveeduria,
         presentacionVisual: productGrup.presentacionVisual,
         embaseAmbiental: productGrup.embaseAmbiental,
         responsabilidadAmbiental: productGrup.responsabilidadAmbiental,
         cantidadCritica: productGrup.cantidadCritica,
         cantidadOptima: productGrup.cantidadOptima,
         cantidadMaxima: productGrup.cantidadMaxima,
         cantidadMalogrados: productGrup.cantidadMalogrados,
   );
}
