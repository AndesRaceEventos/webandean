
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webandean/provider/cache/menuWeb/menu_state.dart';
import 'package:webandean/utils/button/asset_buton_widget.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class TitleTableSlected extends StatelessWidget {
  const TitleTableSlected({
    required String? selectedProduct,
    required this.listProductos, 
    required this.istransition, 
    this.onTap,
  }) : _selectedProduct = selectedProduct;

  final String? _selectedProduct;
  final dynamic listProductos;
  final bool istransition;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
     final menuProvider = Provider.of<MenuProvider>(context); //Titulo de la seleccion Opcion
    return GestureDetector(
      onTap: istransition ?  onTap  : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
         istransition ?  AppIconButon(child: Icon(Icons.search_outlined, color: AppColors.menuTheme,)) : SizedBox(),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              H1Text(
                // fontSize: 25,
                color: AppColors.menuTheme,
                  height: 1,
                  text:
                      '${(_selectedProduct == null || _selectedProduct == 'Todos') ? menuProvider.selectedTitle : _selectedProduct}'
                          .toUpperCase(),
                  textAlign: TextAlign.center),
              P2Text(
                height: 1,
                fontSize: 11,
                text: '${listProductos.length} registros',
                color: AppColors.menuTheme,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
