import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

import 'package:webandean/provider/sunat%20/provider_tipo_cambio.dart';

import 'package:webandean/model/producto/model_producto.dart';


DatatableHeader headerProgress2() {
  return DatatableHeader(
    flex: 2,
    text: "Progress2",
    value: "progress2",
    show: true,
    sortable: false,
    headerBuilder: (value) {
      return LayoutBuilder(builder: (context, constraints) {
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
            contentPadding: EdgeInsets.symmetric(horizontal: 3),
            visualDensity: VisualDensity.compact,
            dense: false,
            minLeadingWidth: 0,
            minVerticalPadding: 0,
             title: Row(
              children: [
                Icon(Icons.monetization_on, size: 15, color: AppColors.menuTextDark),
                SizedBox(width: 5), // Espacio entre icono y texto
                Expanded(child: H3Text(text:'Inversión (100%) PRODUCTOS'.toUpperCase(), fontSize: 11, 
                color: AppColors.menuTextDark, textAlign: TextAlign.center,  maxLines: 2)),
              ],
            ),
          ),
        );
      });
    },
    sourceBuilder: (value, row) {
      List<TProductosAppModel>? listaProducto = value;

     

      return LayoutBuilder(builder: (context, constraints) {
      // double maxWidth = constraints.maxWidth > 200 ? 150 : constraints.maxWidth;
        final sunatTipocambio = Provider.of<TipoCambioProvider>(context);

        Map<String, double> totalesDistribucionPorMoneda =
          sunatTipocambio.calcularSumaTotalPorMoneda( listaProducto ?? [],
              (item) {
                TProductosAppModel e = item;
                double subTotal = e.outPrecioDistribucion * e.cantidadEnStock!;
                return subTotal;
              });

        double valorUSD         =   totalesDistribucionPorMoneda['USD']             ??     0.0;
        double valorPEN         =   totalesDistribucionPorMoneda['PEN']             ??     0.0;
        double totalEnSoles     =   totalesDistribucionPorMoneda['TotalEnSoles']    ??     0.0;
        double totalEnDolares   =   totalesDistribucionPorMoneda['TotalEnDolares']  ??     0.0;

        double maxWidth =   150;//150

        return Container(
          // width: maxWidth,
          constraints: BoxConstraints( maxWidth: maxWidth), // Limita el ancho del header
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              sunatTipocambio.generarGraficoProgreso(
                valorUSD: valorUSD, 
                valorPEN : valorPEN, 
                totalEnSoles : totalEnSoles, 
                totalEnDolares : totalEnDolares
              ),              
            ],
          ),
        );
      });
    },
    textAlign: TextAlign.center,
  );
}
