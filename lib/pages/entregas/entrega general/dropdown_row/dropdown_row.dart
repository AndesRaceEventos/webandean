import 'package:flutter/material.dart';

import 'package:webandean/model/entregas/model_entregas_general.dart';
import 'package:webandean/model/entregas/model_lista_equipos.dart';
import 'package:webandean/model/entregas/model_lista_productos.dart';
import 'package:webandean/model/personal/model_personal_apu.dart';
import 'package:webandean/pages/entregas/entrega%20general/dropdown_row/Lista%20producto/lista_producto.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
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
