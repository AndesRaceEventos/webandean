
import 'package:flutter/material.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/layuot/asset_column_widths.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class HeaderPrimraTaBle extends StatelessWidget {
  const HeaderPrimraTaBle({
    super.key, 
    required this.headers, 
    this.isViewIndex = true,
    this.isColumnWith = true,
    });
  final List<String> headers;
  final bool?  isViewIndex;
  final bool?  isColumnWith;

  @override
  Widget build(BuildContext context) {
    return Table(
          border: TableBorder.all(color: AppColors.menuHeaderTheme),
         columnWidths: isColumnWith! ? AssetColumnWidths.columnWidths : {},
         defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
             decoration: BoxDecoration(color: AppColors.menuTheme),
              children: [
                 // Añadir el elemento adicional "index"
                if(isViewIndex!)
                Padding(
                   padding: const EdgeInsets.symmetric(horizontal:2.0, vertical: 10),
                  child: P2Text(
                    text: 'Nro.',
                    color: AppColors.menuHeaderTheme,
                    textAlign: TextAlign.center,
                     maxLines: 1,
                  ),
                ),
                ...headers.map((header) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal:2.0, vertical: 10),
                    child: P2Text(
                      text: header.toString(),
                      color: AppColors.menuHeaderTheme,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  );
                }).toList(),
               
              ],
            ), 
           
      ],
    );
  }
}

// Clase para encapsular la configuración del widget dinámico
class HeaderBuildWidgetConfig {
  final String leftTitle;
  final String rightTitle;
  final List<Widget> leftChildren;
  final List<Widget> rightChildren;

  const HeaderBuildWidgetConfig({
   required this.leftTitle,
   required this.rightTitle,
   required this.leftChildren,
   required this.rightChildren,
  });
}

class HeaderSecondaryTaBle extends StatelessWidget {
  const HeaderSecondaryTaBle({
    super.key,
    this.buildWidgetConfig,
  });

  final HeaderBuildWidgetConfig? buildWidgetConfig;

  @override
  Widget build(BuildContext context) {
    // Validar si hay configuración antes de construir la tabla
    if (buildWidgetConfig == null) {
      return const  Padding(
              padding: const EdgeInsets.all(8.0),
              child: P2Text(
                text: 'Table contains irregular row lengths',
                color: AppColors.menuHeaderTheme,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ); // Devolver un widget vacío si no hay configuración
    }

    return Container(
      decoration: BoxDecoration(
                    border: Border.all(color: AppColors.menuHeaderTheme),
                  ),
      child: Column(
        children: [
          Table(
            border: TableBorder.all(color: AppColors.menuHeaderTheme),
            // columnWidths: AssetColumnWidths.columnWidths,
            children: [
              // Fila para los títulos
              TableRow(
                decoration: BoxDecoration(color: AppColors.menuTheme),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: P2Text(
                      text: buildWidgetConfig!.leftTitle,
                      color: AppColors.menuHeaderTheme,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: P2Text(
                      text: buildWidgetConfig!.rightTitle,
                      color: AppColors.menuHeaderTheme,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              ]
            ),
          // Expanded(
          //   child: SingleChildScrollView(
          //     child: Table(
          //       border: TableBorder.all(color: AppColors.menuHeaderTheme),
          //       // columnWidths: AssetColumnWidths.columnWidths,
          //       children: [
          //         // Fila para los hijos
          //         TableRow(
          //           children: [
          //             // Hijos izquierdos
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: buildWidgetConfig!.leftChildren.isNotEmpty
          //                   ? buildWidgetConfig!.leftChildren
          //                   : [const SizedBox()], // Relleno si no hay hijos
          //             ),
          //             // Hijos derechos
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: buildWidgetConfig!.rightChildren.isNotEmpty
          //                   ? buildWidgetConfig!.rightChildren
          //                   : [const SizedBox()], // Relleno si no hay hijos
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
         Expanded(
            child: Row(
               mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Columna izquierda con Container y scroll
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: buildWidgetConfig!.leftChildren.isNotEmpty
                          ? buildWidgetConfig!.leftChildren
                          : [const SizedBox()], // Relleno si no hay hijos
                    ),
                  ),
                ),
                VerticalDivider(color: AppColors.menuHeaderTheme),
                // Columna derecha con Container y scroll
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: buildWidgetConfig!.rightChildren.isNotEmpty
                          ? buildWidgetConfig!.rightChildren
                          : [const SizedBox()], // Relleno si no hay hijos
                    ),
                  ),
                ),
              ],
            ),
          ),
      

        ],
      ),
    );
  }
}



//  Expanded(
//                               // height: MediaQuery.of(context).size.height - tolba,  // Altura fija para este widget
//                               child: listTitleCustom(
//                                leading:  SizedBox(width:25),
//                                trailing:  SizedBox(width:25),
//                                title: HeaderSecondaryTaBle(
//                                buildWidgetConfig: HeaderBuildWidgetConfig(
//                                 leftTitle: 'Valor General', 
//                                 rightTitle: 'Detalles por Categoria', 
//                                 leftChildren: [
//                                    TotalPreciosGenerales(listDatos: widget.data.listaProducto ?? []),
//                                    TotalPreciosEnCompras(listDatos: widget.data.listaProducto ?? []),
//                                 ], 
//                                 rightChildren: groupedData.entries.map((entry) {
//                                     // Extraer la categoría (clave) y su lista de productos (valor)
//                                     final String categoria = entry.key;
//                                     final List<TProductosAppModel> productosPorGrupo = entry.value;
                              
//                                     return Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           categoria, // Mostrar el nombre de la categoría como encabezado
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: AppColors.menuTextDark,
//                                           ),
//                                         ),
//                                         TotalPreciosGenerales(listDatos: productosPorGrupo),
//                                         TotalPreciosEnCompras(listDatos: productosPorGrupo),
//                                       ],
//                                     );
//                                   }).toList(),
                              
                                
//                                 ),
//                                ),
//                               ),
//                             ),