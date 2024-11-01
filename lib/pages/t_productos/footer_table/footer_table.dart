
  import 'package:flutter/material.dart';
import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/pages/t_productos/product_excel.dart';
import 'package:webandean/pages/t_productos/productos_pdf.dart';
import 'package:webandean/pages/t_productos/qr_lector/qr-lector.dart';
import 'package:webandean/utils/animations/assets_animationswith.dart';
import 'package:webandean/utils/files/assets-svg.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

Widget fotterButonBar({
required dynamic listaProductos,
required List<Map<String, dynamic>> selecteds,
required List<Map<String, dynamic>> sourceOriginal
}) {
  List<TProductosAppModel> datTable = listaProductos;
  
 List<TProductosAppModel> dataSelected = selecteds.map((map){
  print('IMPRIMIR MAP: $map');
  final TProductosAppModel producto = map['data'];
  return producto;
}).toList();  
  
    return Container(
      height: 30,
      margin: EdgeInsets.only(top: 5,bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          
          //EXPORTAR ELEMENTOS SELECCIONADOS
          AssetsAnimationSwitcher(
            isTransition: true,
            directionLeft: true,
            duration: 1000,
            child: selecteds.isEmpty
                ? Row(
                  children: [
                    ExcelExportProductos(listaTproductos: datTable),
                     PDFProductos( listaTproductos: datTable),
                  ],
                )
                : Container(
                  constraints: BoxConstraints(),
                    child: Row(
                      children: [
                        Checkbox(
                            value: true,
                            onChanged: (value) {},
                        ),
                         P3Text(text: '${dataSelected.length} Seleccionados'),
                        ExcelExportProductos(
                            listaTproductos:dataSelected),
                        PDFProductos(
                            listaTproductos:dataSelected),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );

    
  }


class QrlectorButton extends StatelessWidget {
  const QrlectorButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(0),
      onPressed: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=> QrLectorPage()));
      }, 
      icon: AppSvg().qrScannerSvg);
  }
}

