import 'package:flutter/material.dart';
import 'package:webandean/utils/animations/assets_animationswith.dart';
import 'package:webandean/utils/button/asset_buton_widget.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/textfield/decoration_form.dart';

class SearchIstransitionItem extends StatelessWidget {
  const SearchIstransitionItem({
    super.key, 
    required this.isSearch, 
    required this.controller, 
    required this.onCloseSeach,
    required this.onSearch,
    required this.children,  // Pasas los elementos del Row como parámetro
    this.toBacbutton = true,
    });

  final bool isSearch;
  final TextEditingController controller;
  final  void Function()? onCloseSeach;
  final  void Function(String value)? onSearch;
  final List<Widget> children;  // Lista de elementos para el Row (excluyendo el primero)
  final bool? toBacbutton;
  @override
  Widget build(BuildContext context) {
    return AssetsAnimationSwitcher(
       // isTransition: true,
       directionLeft: true,
       duration: 700,
       child: isSearch
           ? Container(
             constraints: BoxConstraints(maxWidth: 350, maxHeight: 45),
             child: TextField(
                 controller:controller,// _filterseachController,
                 style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, height: 1.5),
                 decoration: AssetDecorationTextField.decorationTextFieldRectangle(
                   hintText: 'Escriba aquí',
                   labelText: 'Buscar',
                   fillColor: Colors.white,
                   prefixIcon: Icon(Icons.search),
                   suffixIcon: IconButton(
                     onPressed: ()=> onCloseSeach?.call(),
                     icon: Icon(Icons.close, size: 20))
                 ),
                 //Fitrar mientras escribes 
                 onChanged: (value){
                   onSearch?.call(value);
                 }
               ),
           )
           : SingleChildScrollView(
            scrollDirection: Axis.horizontal,  // Hacer scroll horizontal
             child: Row(
               mainAxisSize: MainAxisSize.min,
               children : [
                if(toBacbutton!)
               AppIconButoonELegant(
                 colorButon: Colors.red,
                 icon: AppSvg( color: Colors.white ).backSvg, 
                 onPressed: () =>  Navigator.pop(context),
                 ), 
                //TODOS lista de WIdget 
                ...children,  // Aquí agregas el resto de los elementos del Row
             
              ]),
           )
   );
  }
}



class SearchIstransitionItem2 extends StatelessWidget {
  const SearchIstransitionItem2({
    super.key, 
    required this.isSearch, 
    required this.controller, 
    required this.onCloseSeach,
    required this.onSearch,
    required this.child,  // Pasas los elementos del Row como parámetro
    });

  final bool isSearch;
  final TextEditingController controller;
  final  void Function()? onCloseSeach;
  final  void Function(String value)? onSearch;
  final Widget child;  // Lista de elementos para el Row (excluyendo el primero)

  @override
  Widget build(BuildContext context) {
    return AssetsAnimationSwitcher(
       // isTransition: true,
       directionLeft: true,
       duration: 700,
       child: isSearch
           ? Container(
             constraints: BoxConstraints(maxWidth: 350, maxHeight: 45),
             child: TextField(
                 controller:controller,// _filterseachController,
                 style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, height: 1.5),
                 decoration: AssetDecorationTextField.decorationTextFieldRectangle(
                   hintText: 'Escriba aquí',
                   labelText: 'Buscar',
                   fillColor: Colors.white,
                   prefixIcon: Icon(Icons.search),
                   suffixIcon: IconButton(
                     onPressed: ()=> onCloseSeach?.call(),
                     icon: Icon(Icons.close, size: 20))
                 ),
                 //Fitrar mientras escribes 
                 onChanged: (value){
                   onSearch?.call(value);
                 }
               ),
           )
           : child,
    
   );
  }
}