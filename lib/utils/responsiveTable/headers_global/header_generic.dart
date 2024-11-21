
//GENERICO   //todos ********************** ESPECIFICOS   *****************  */

import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

DatatableHeader dataHeaderCustom({String? header, String? value, IconData? icon}) {
  return DatatableHeader(
    text: header!.toUpperCase(),
    value: value!, //Muestra el valor de la tabal
    show: true,
    sortable: true,
    editable: true,
    textAlign: TextAlign.center,
    headerBuilder: (value) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth > 200 ? 150 : constraints.maxWidth;
        return Container(
          width: maxWidth,
          constraints: BoxConstraints(maxWidth: maxWidth), // Limita el ancho del header
          decoration: BoxDecoration(
            color: AppColors.menuHeaderTheme,
            border: Border.all(
              width: .4,
              style: BorderStyle.solid,
              color: Colors.grey.shade200),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 2),
            visualDensity: VisualDensity.compact,
            // dense: true,
            minLeadingWidth: 0, 
            minVerticalPadding: 0,
            // leading: Icon(icon, size: 12, color: AppColors.menuTheme),
            title: Row(
              children: [
                Icon(icon, size: 16, color: AppColors.menuTextDark),
                SizedBox(width: 5), // Espacio entre icono y texto
                Expanded(child: H3Text(text: header.toUpperCase(), fontSize: 11, 
                color: AppColors.menuTextDark, textAlign: TextAlign.center,)),
                SizedBox(width: 5), // Espacio entre icono y texto
                AppSvg(width: 15, color:  Colors.white60).sortSvg, // Icono de ordenamiento
              ],
            ),
            // trailing: AppSvg(width: 12, color: AppColors.menuTheme).sortSvg, // Icono de ordenamiento
          ),
        );
      },
    );
  },
    sourceBuilder: (value, row) {
      Widget renderedWidget;

      if (value is String) {
        renderedWidget = Padding(
          padding: const EdgeInsets.all(10.0),
          child: P2Text(
            text: value,
            fontSize: 11,
            textAlign: TextAlign.center,
            selectable: true,
            maxLines: 1,
          ),
        );
      } else if (value is bool) {
        renderedWidget = Center(
          child: Checkbox(
            value: value,
            onChanged: (newValue) {
              value = newValue;
            },
          ),
        );
      } else if (value is DateTime) {
        renderedWidget = Padding(
          padding: const EdgeInsets.all(10.0),
          child: P2Text(
            text: value.year == 1998 ? '-' : formatFechaReponsiveDataTable(value),
            fontSize: 11,
            maxLines: 2,
            selectable: true,
            textAlign: TextAlign.center,
          ),
        );
      } else if (value is double || value is int){
        renderedWidget = Padding(
          padding: const EdgeInsets.all(10.0),
          child:  P2Text(
            text: '$value',
            fontSize: 11,
            textAlign: TextAlign.center,
          ),
        );
      } else if (value is List) {
        // Renderiza la lista como Chips
        renderedWidget = Padding(
          padding: const EdgeInsets.all(1.0),
          child: Wrap(
            spacing: 2.0,
            runSpacing: .0,
            children: value.map<Widget>((item) {
              return Chip(
                 backgroundColor: AppColors.menuHeaderTheme.withOpacity(.5),
                 padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                 visualDensity: VisualDensity.compact,
                 side: BorderSide.none,
                 label: Text(
                  '$item',
                  style: const TextStyle(fontSize: 11),
                ),
              );
            }).toList(),
          ),
        );}
      else {
        renderedWidget = Padding(
          padding: const EdgeInsets.all(10.0),
          child: const P2Text(
            text: 'N/A',
            fontSize: 11,
            textAlign: TextAlign.center,
          ),
        );
      }

      return  renderedWidget;
    },
  );
}





//Format FECHA ROW TABLE 

String formatFechaReponsiveDataTable(DateTime fecha) {
  // Meses del año en español
  List<String> mesesAnio = [
    "Ene",
    "Feb",
    "Mar",
    "Abr",
    "May",
    "Jun",
    "Jul",
    "Ago",
    "Sep",
    "Oct",
    "Nov",
    "Dic"
  ];

  // Obtener el día de la semana, el día del mes y el mes en texto
  String diaMes = fecha.day.toString().padLeft(2, '0');
  String mesAno = mesesAnio[fecha.month - 1];
  String ano = fecha.year.toString();

  // Obtener la hora, el minuto y el segundo
  // String hora = fecha.hour.toString().padLeft(2, '0');
  String minuto = fecha.minute.toString().padLeft(2, '0');
  String segundo = fecha.second.toString().padLeft(2, '0');

  // Determinar si es AM o PM
  String periodo = (fecha.hour < 12) ? 'AM' : 'PM';

  // Convertir la hora al formato de 12 horas
  int hora12 = (fecha.hour > 12) ? fecha.hour - 12 : fecha.hour;
  String hora = hora12.toString().padLeft(2, '0');

  String fechaFormateada =
      "$diaMes $mesAno $ano\n$hora:$minuto:$segundo $periodo";

  return fechaFormateada;
}
