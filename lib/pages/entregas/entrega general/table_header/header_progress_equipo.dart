import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

import 'package:webandean/provider/sunat%20/provider_tipo_cambio.dart';

import 'package:webandean/model/equipo/model_equipo.dart';

DatatableHeader headerProgress() {
  return DatatableHeader(
    flex: 2,
    text: "Progress",
    value: "progress",
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
            // leading:
                // Icon(Icons.monetization_on, size: 15, color: getRandomColor()),
            // title: H3Text(text: 'Inversión (100%)'.toUpperCase(), fontSize: 11, maxLines: 2,),
            // subtitle: P3Text(text: 'Suma Total (100%)'.toUpperCase(), fontSize: 9),
            title: Row(
              children: [
                Icon(Icons.monetization_on, size: 15, color: AppColors.menuTextDark),
                SizedBox(width: 5), // Espacio entre icono y texto
                Expanded(child: H3Text(text: 'Inversión (100%) EQUIPOS'.toUpperCase(), fontSize: 11, 
                color: AppColors.menuTextDark, textAlign: TextAlign.center,  maxLines: 2)),
              ],
            ),
          ),
        );
      });
    },
    sourceBuilder: (value, row) {
      List<TEquiposAppModel>? listaProducto = value;

      return LayoutBuilder(builder: (context, constraints) {
      // double maxWidth = constraints.maxWidth > 200 ? 150 : constraints.maxWidth;
        final sunatTipocambio = Provider.of<TipoCambioProvider>(context);

        Map<String, double> totalesDistribucionPorMoneda =
          sunatTipocambio.calcularSumaTotalPorMoneda( listaProducto ?? [],
              (item) {
                TEquiposAppModel e = item;
                double subTotal = e.outPrecioDistribucion * e.cantidadEnStock;
                return subTotal;
              });

        double valorUSD         =   totalesDistribucionPorMoneda['USD']             ??     0.0;
        double valorPEN         =   totalesDistribucionPorMoneda['PEN']             ??     0.0;
        double totalEnSoles     =   totalesDistribucionPorMoneda['TOTAL_PEN']    ??     0.0;
        double totalEnDolares   =   totalesDistribucionPorMoneda['TOTAL_USD']  ??     0.0;

        double maxWidth =   150;//150

        return Container(
          // width: maxWidth,
          constraints: BoxConstraints( maxWidth: maxWidth), // Limita el ancho del header
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              sunatTipocambio.generarGraficoProgreso(
                progreess: true,
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



