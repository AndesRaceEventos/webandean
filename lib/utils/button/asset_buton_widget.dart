import 'package:flutter/material.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';

class AppIconButon extends StatelessWidget {
  const AppIconButon({super.key, this.onPressed, required this.child, this.tooltip = '', this.onDoubleTap});
  final Function()? onPressed;
  final Widget child;
  final String? tooltip;
  final Function()? onDoubleTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.5),
      decoration: AssetDecorationBox().selectedDecoration(color: Colors.white),
      child: GestureDetector(
        onDoubleTap: onDoubleTap,
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
