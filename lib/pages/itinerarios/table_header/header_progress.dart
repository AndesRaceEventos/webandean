import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

DatatableHeader headerProgress() {
  return DatatableHeader(
    flex: 1,
    text: "Progress",
    value: "progress",
    show: true,
    sortable: false,
    headerBuilder: (value) {
      return LayoutBuilder(builder: (context, constraints) {
        double maxWidth =
            constraints.maxWidth > 200 ? 150 : constraints.maxWidth;
        return Container(
          width: maxWidth,
          constraints:
              BoxConstraints(maxWidth: maxWidth), // Limita el ancho del header
          decoration: BoxDecoration(
            color: AppColors.menuHeaderTheme,
            border: Border.all(
                width: .4,
                style: BorderStyle.solid,
                color: Colors.grey.shade200),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 3),
            visualDensity: VisualDensity.compact,
            dense: false,
            minLeadingWidth: 0,
            minVerticalPadding: 0,
            // leading:
            // Icon(Icons.monetization_on, size: 15, color: getRandomColor()),
            // title: H3Text(text: 'Inversión (100%)'.toUpperCase(), fontSize: 11, maxLines: 2,),
            // subtitle: P3Text(text: 'Suma Total (100%)'.toUpperCase(), fontSize: 9),
            title: Row(
              children: [
                AppSvg(width: 15, color: AppColors.menuTextDark).itinerarySvg,
                SizedBox(width: 5), // Espacio entre icono y texto
                Expanded(
                    child: H3Text(
                        text: 'Noches por lodge'.toUpperCase(),
                        fontSize: 11,
                        color: AppColors.menuTextDark,
                        textAlign: TextAlign.center,
                        maxLines: 2)),
              ],
            ),
          ),
        );
      });
    },
    sourceBuilder: (value, row) {
      if (value == null) return Container();

      // Usamos el mapa progress con noches y color
      Map<String, Map<String, dynamic>> nochesLodge = value;
     
      return LayoutBuilder(builder: (context, constraints) {
        // double maxWidth = constraints.maxWidth > 200 ? 150 : constraints.maxWidth;
        double maxWidth = 150; //150

        return Container(
          // width: maxWidth,
          constraints:
              BoxConstraints(maxWidth: maxWidth), // Limita el ancho del header
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ...nochesLodge.entries.map((entry) {
                // Obtener las noches y el color del mapa
                int nights = entry.value["nights"];
                Color elementColor = entry.value["color"];

                // Generar puntos según el valor (número de noches)
            List<Widget> dots = List.generate(nights, (index) {
              return Container(
                margin: EdgeInsets.only(right: 4),  // Espacio entre los puntos
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: elementColor,  // Usamos el color del elemento para todos los puntos
                  shape: BoxShape.circle,
                ),
                
              );
            });

                return Row(
                  children: [
                    // El nombre del hospedaje
                  if (nights != null && nights > 0) 
                   ...[ 
                    Expanded(
                      child: H3Text(
                        text: "${entry.key}".toUpperCase(),
                        fontSize: 9,
                        color: elementColor,
                        fontWeight: FontWeight.bold,
                        height: 1.6,
                      ),
                    ),
                    // Mostrar los puntos generados
                    ...dots,
                   ]
                  ],
                );
              }).toList()
            ],
          ),
        );
      });
    },
    textAlign: TextAlign.center,
  );
}
