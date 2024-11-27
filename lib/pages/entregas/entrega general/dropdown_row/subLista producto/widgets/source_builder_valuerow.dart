

import 'package:flutter/material.dart';
import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/pages/entregas/entrega%20general/dropdown_row/subLista%20producto/widgets/edit_values_row.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/responsiveTable/headers_global/header_generic.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

Widget sourceBuilder( { 
  required Object? valueField, 
  required dynamic productoRow,
  required List<TProductosAppModel> subListDPadre, 
  required Color colorIndex}) {

  Widget renderedWidget;

    if (valueField is String) {
      // Si es un String, mostramos el texto con un Padding
       renderedWidget =  ValueObservacionEdit(
       valueTable: valueField, 
          productoRow: productoRow, 
          subListDPadre: subListDPadre, 
        );
    
    } else if (valueField is bool) {
      // Si es un booleano, mostramos un Checkbox
      renderedWidget = Center(
        child: ValueBoolCompraEdit(
          valueTable: valueField, 
          productoRow: productoRow, 
          subListDPadre: subListDPadre, 
          color : colorIndex,
        )
      );
    } else if (valueField is DateTime) {
      // Si es una fecha, la formateamos
      renderedWidget = Padding(
        padding: const EdgeInsets.all(8.0),
        child: P2Text(
          text: valueField.year == 1998 ? '-' : formatFechaReponsiveDataTable(valueField),
          fontSize: 11,
          maxLines: 2,
          selectable: true,
          textAlign: TextAlign.center,
        ),
      );
    } else if (valueField is double || valueField is int) {
     
        renderedWidget = Center(
          child: ValueNumberEdit(
            valueTable: valueField, 
            productoRow: productoRow, 
            subListDPadre: subListDPadre
            ),
        );

    } else if (valueField is List) {
      // Si es una lista, mostramos los elementos como Chips
      renderedWidget = Padding(
        padding: const EdgeInsets.all(1.0),
        child: Wrap(
          spacing: 2.0,
          runSpacing: .0,
          children: valueField.map<Widget>((item) {
            return Chip(
              backgroundColor: AppColors.menuHeaderTheme.withOpacity(.5),
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              visualDensity: VisualDensity.compact,
              side: BorderSide.none,
              label: Text(
                '$item',
                style: const TextStyle(fontSize: 11),
                 maxLines: 1,
              ),
            );
          }).toList(),
        ),
      );
    } else {
      // Si el tipo no es ninguno de los anteriores, mostramos "N/A"
      renderedWidget = Padding(
        padding: const EdgeInsets.all(8.0),
        child: const P2Text(
          text: 'N/A',
          fontSize: 11,
          textAlign: TextAlign.center,
        ),
      );
    }

    return renderedWidget;
  }
