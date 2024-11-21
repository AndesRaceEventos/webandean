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

