import 'package:flutter/material.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/layuot/assets_circularprogrees.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class AppIconButon extends StatelessWidget {
  const AppIconButon({super.key, this.onPressed, required this.child, this.tooltip = '', this.onLongPress, this.color = Colors.white});
  final Function()? onPressed;
  final Widget child;
  final String? tooltip;
  final Function()? onLongPress;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.5),
      decoration: AssetDecorationBox().selectedDecoration(color: color),
      child: GestureDetector(
        onDoubleTap: onLongPress,
        // child: IconButton(
        //     visualDensity: VisualDensity.compact,
        //     padding: EdgeInsets.all(0),
        //     tooltip: tooltip,
        //     onPressed: onPressed,
        //     icon: child,),
        onTap: onPressed,
        child: Container(padding: EdgeInsets.all(5),child: child)
      )
    );
  }
}

class AppIconButoonELegant extends StatelessWidget {
  const AppIconButoonELegant(
    {super.key, 
    this.onPressed, 
    this.label,
    required this.icon, 
    this.tooltip, 
    this.colorlabel = Colors.black,
    this.colorButon = Colors.white, 
    this.height = 40.0,
    });

  final Function()? onPressed;
  final String? label;
  final Widget icon;
  final String? tooltip;
  final Color? colorlabel;
  final Color? colorButon;
  final double height;
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: tooltip,
         padding: EdgeInsets.symmetric(vertical: 0),
         visualDensity: VisualDensity.compact,
         onPressed: onPressed,
         icon:  Container(
            height: height,
            margin: EdgeInsets.symmetric(horizontal: 8),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
           decoration: AssetDecorationBox().decorationBox(color: colorButon),
           child: Row(
             mainAxisSize: MainAxisSize.min,
             children: [
              icon,
              if(label != null)
              H3Text(text: label!, color: colorlabel!), 
             ],
           ),
         ),
    );
  }
}


//Reciben u nbool para activar el loading 
class AppSaveButonForm extends StatelessWidget {
  const AppSaveButonForm({super.key,required this.onPressed, required this.isLoading});
  final Function() onPressed;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: AssetDecorationBox().decorationBox(color: AppColors.menuTheme),
        height: 40,
        child: Center(
         child: isLoading
          ? AssetsCircularProgreesIndicator()
           : const H3Text(text: 'Guardar', color: Colors.white,
        ))
      )
    );
  }
}

