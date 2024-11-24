
import 'package:provider/provider.dart';

import 'package:webandean/provider/sunat%20/provider_tipo_cambio.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/conversion/assets_format_fecha.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:flutter/material.dart';

class Dashboardpage extends StatelessWidget {
  const Dashboardpage({super.key});

  @override
  Widget build(BuildContext context) {
    final sunatTipocambio = Provider.of<TipoCambioProvider>(context);

    double tipoCambioCompra = sunatTipocambio.tipoCambioCompra;
    double tipoCambioVenta = sunatTipocambio.tipoCambioVenta;
    DateTime fechatipoCambio = sunatTipocambio.fecha;

    Map<String, Object> values = {
      'fecha': formatFecha(fechatipoCambio),
      'compra': tipoCambioCompra,
     'venta': tipoCambioVenta,
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Wrap(
              spacing: 5.0,
              children: values.entries.map((item){
                String tabTitle = item.key;
                final value = item.value;
                return Chip(
                 backgroundColor: AppColors.menuHeaderTheme,
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  visualDensity: VisualDensity.compact,
                  side: BorderSide.none,
                  label: H2Text(text: '$value', fontSize: 11, color: AppColors.menuTextDark
                  ),
                  avatar: CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.menuTheme,
                  child: FittedBox(
                    child: H2Text(text: '${tabTitle}', 
                    fontSize: 10, color: AppColors.menuIconColor),
                  )),
                );
              }).toList(),
            ), 

            
          ],
        ),
      ),

     
    );
  }
}

