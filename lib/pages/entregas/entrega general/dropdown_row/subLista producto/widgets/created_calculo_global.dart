
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webandean/provider/sunat%20/provider_tipo_cambio.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/responsiveTable/title_table/title_tabbar.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
//todos REQUISITOS : tener los campos 
//----------------------------------------------------------------
//*moneda
//*outPrecioDistribucion
//*cantidadEnStock

class TotalPreciosGenerales extends StatelessWidget {
  const TotalPreciosGenerales({
    super.key, 
    required this.listDatos, 
    });


  final List<dynamic> listDatos;  //debe tener moneda cantiad stock 

  @override
  Widget build(BuildContext context) {

      final widthTable = MediaQuery.of(context).size.width*.4;
        // Obtener el provider del tipo de cambio
      final sunatTipocambio = Provider.of<TipoCambioProvider>(context, listen: false);
      // Llama al método global para obtener los totales
      final totalesDistribucion = sunatTipocambio.
      obtenerTotalesDistribucionPorMoneda(context, listDatos);

       return Column(
         children: [

           Container(
             constraints: BoxConstraints(maxWidth: widthTable),
             margin: EdgeInsets.only(left:10.0, bottom: 0, right: 10 ),
            child: Table(
                   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                   border: TableBorder.all(color: AppColors.menuIconColor),
                   columnWidths: {
                     0: FlexColumnWidth(1), 
                     1: FixedColumnWidth(70),
                   },
                    children: [
                      TableRow(
                       decoration: BoxDecoration(color: AppColors.menuTheme.withOpacity(.8)),
                       children: [
                     Container(
                          margin: EdgeInsets.only(left: 5.0),
                          padding: const EdgeInsets.symmetric(horizontal:2.0, vertical: 5),
                          child: P2Text(
                            text: 'Totales Generales: Soles y Dólaress'.toUpperCase(),
                            color: Colors.white,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            fontSize: 11, 
                            fontWeight: FontWeight.bold,
                          ),
                        ), 
                         Container(
                          margin: EdgeInsets.only(left: .0),
                          padding: const EdgeInsets.symmetric(horizontal:2.0, vertical: 5),
                          child: FittedBox(
                            child: P2Text(
                               text: 'TC s/.${sunatTipocambio.tipoCambioVenta}',
                              color: Colors.yellow,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                             fontSize: 10, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                       
                       ]), 
                       
                    ]
              ),
          ),
          Container(
             constraints: BoxConstraints(maxWidth: widthTable),
             margin: EdgeInsets.only(left:10.0, bottom: 0, right: 10 ),
            child: Table(
                   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                   border: TableBorder.all(color: AppColors.menuIconColor),
                   columnWidths: {
                     0: FixedColumnWidth(widthTable*.35),
                     1: FlexColumnWidth(1), 
                   },
                    children: [
                      TableRow(
                       decoration: BoxDecoration(color: AppColors.menuTheme.withOpacity(.4)),
                       children: [
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              padding: const EdgeInsets.symmetric(horizontal:2.0, vertical: 5),
                              child: P2Text(
                                text: 'TOTAL artículos'.toUpperCase(),
                                color: AppColors.menuTextDark,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                fontSize: 10, 
                              ),
                            ), 
                            ChipTabar(title: 'artículos', count: listDatos.length),
                       ]) 
                    ]
              ),
          ),
           Container(
             constraints: BoxConstraints(maxWidth: widthTable),
             margin: EdgeInsets.only(left:10.0, bottom: 10, right: 10 ),
             child: Table(
                 defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                 border: TableBorder.all(color: AppColors.menuIconColor),
                 columnWidths: {
                   0: FixedColumnWidth(widthTable*.35),
                   1: FlexColumnWidth(1), 
                 },
                  children: totalesDistribucion.entries.map((entry){
                     final String key = entry.key; // Identificador de moneda o total
                      final Map<String, dynamic> value = entry.value; // Detalles asociados
                     return TableRow(
                     decoration: BoxDecoration(color: AppColors.menuHeaderTheme.withOpacity(.5)),
                      children: [
                         Container(
                          margin: EdgeInsets.only(left: 5.0),
                          padding: const EdgeInsets.symmetric(horizontal:2.0, vertical: 5),
                          child: P2Text(
                            text: '${key}'.toString(),
                            color: AppColors.menuTextDark,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            fontSize: 10
                          ),
                                             ), 
                         Tooltip(
                          message: value['descripcion'],
                          child: Container(
                           margin: EdgeInsets.only(right:10.0),
                            padding: const EdgeInsets.symmetric(horizontal:2.0, vertical: 5),
                            child: P1Text(
                              text: '${value['sufijo']}${value['valor'].toStringAsFixed(2)}'.toString(),
                              color: AppColors.menuTextDark,
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              fontSize: 11
                            ),
                          ),
                        ), 
                      ]
                    );
                  }).toList(), 
           
             ),
           ),
         ],
       );
                
  }
}




class TotalPreciosEnCompras extends StatelessWidget {
  const TotalPreciosEnCompras({
    super.key, 
    required this.listDatos, 
    });


  final List<dynamic> listDatos;  //debe tener moneda cantiad stock 

  @override
  Widget build(BuildContext context) {

      final widthTable = MediaQuery.of(context).size.width*.4;
        // Obtener el provider del tipo de cambio
      final sunatTipocambio = Provider.of<TipoCambioProvider>(context, listen: false);
       // Llama al método global para obtener los totales
        final totalesDistribucion = sunatTipocambio.calcularTotalParaCompra(listDatos);
        // Extraer los valores específicos
        final totalEnSoles = totalesDistribucion['TOTAL.PEN'] ?? 0;
        final totalEnDolares = totalesDistribucion['TOTAL.USD'] ?? 0;
        final totalComoprar = totalesDistribucion['TOTAL.COMPRAR'] ?? 0;

        final dataChipset = {
          'TOTAL.PEN': {
             'valor':  totalEnSoles,
              'descripcion': 'Total Compras en soles',
              'sufijo': 'S/. ', 
              'color': const Color(0xFFA0D0DA),
          }, 
          'TOTAL.USD': {
             'valor':  totalEnDolares,
              'descripcion': 'Total Compras en Dolares',
              'sufijo': '\$ ', 
              'color': const Color(0xFFA0D0DA),
          }
        };

       return Column(
         children: [
          Container(
             constraints: BoxConstraints(maxWidth: widthTable),
             margin: EdgeInsets.only(left:10.0, bottom: 0, right: 10 ),
            child: Table(
                   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                   border: TableBorder.all(color: AppColors.menuIconColor),
                   columnWidths: {
                     0: FlexColumnWidth(1), 
                     1: FixedColumnWidth(70),
                   },
                    children: [
                      TableRow(
                       decoration: BoxDecoration(color: AppColors.menuTheme.withOpacity(.8)),
                       children: [
                     Container(
                          margin: EdgeInsets.only(left: 5.0),
                          padding: const EdgeInsets.symmetric(horizontal:2.0, vertical: 5),
                          child: P2Text(
                            text: 'Resumen General de Compras'.toUpperCase(),
                            color: Colors.white,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            fontSize: 11, 
                            fontWeight: FontWeight.bold,
                          ),
                        ), 
                         Container(
                          margin: EdgeInsets.only(left: .0),
                          padding: const EdgeInsets.symmetric(horizontal:2.0, vertical: 5),
                          child: FittedBox(
                            child: P2Text(
                              text: 'TC s/.${sunatTipocambio.tipoCambioVenta}',
                              color: Colors.yellow,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              fontSize: 10, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                       ]) 
                    ]
              ),
          ),
           Container(
             constraints: BoxConstraints(maxWidth: widthTable),
             margin: EdgeInsets.only(left:10.0, bottom: 0, right: 10 ),
            child: Table(
                   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                   border: TableBorder.all(color: AppColors.menuIconColor),
                   columnWidths: {
                     0: FixedColumnWidth(widthTable*.35),
                     1: FlexColumnWidth(1), 
                   },
                    children: [
                      TableRow(
                       decoration: BoxDecoration(color: AppColors.menuTheme.withOpacity(.4)),
                       children: [
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              padding: const EdgeInsets.symmetric(horizontal:2.0, vertical: 5),
                              child: P2Text(
                                text: 'TOTAL COMPRAR',
                                color: AppColors.menuTextDark,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                fontSize: 10, 
                              ),
                            ), 
                            ChipTabar(title: 'artículos por comprar', count: totalComoprar),
                       ]) 
                    ]
              ),
          ),
           Container(
             constraints: BoxConstraints(maxWidth: widthTable),
              margin: EdgeInsets.only(left:10.0, bottom: 10, right: 10 ),
             child: Table(
                 defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                 border: TableBorder.all(color: AppColors.menuIconColor),
                 columnWidths: {
                   0: FixedColumnWidth(widthTable*.35),
                   1: FlexColumnWidth(1), 
                 },
                  children: dataChipset.entries.map((entry){
                     final String key = entry.key; // Identificador de moneda o total
                      final Map<String, dynamic> value = entry.value; // Detalles asociados
                     return TableRow(
                     decoration: BoxDecoration(color: AppColors.menuHeaderTheme.withOpacity(.5)),
                      children: [
                         Container(
                          margin: EdgeInsets.only(left: 5.0),
                          padding: const EdgeInsets.symmetric(horizontal:2.0, vertical: 5),
                          child: P2Text(
                            text: '${key}'.toString(),
                            color: AppColors.menuTextDark,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            fontSize: 10
                          ),
                                             ), 
                         Tooltip(
                          message: value['descripcion'],
                          child: Container(
                           margin: EdgeInsets.only(right:10.0),
                            padding: const EdgeInsets.symmetric(horizontal:2.0, vertical: 5),
                            child: P1Text(
                              text: '${value['sufijo']}${value['valor'].toStringAsFixed(2)}'.toString(),
                              color: AppColors.menuTextDark,
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              fontSize: 11
                            ),
                          ),
                        ), 
                      ]
                    );
                  }).toList(), 
           
             ),
           ),
          
         ],
       );
                
  }
}

