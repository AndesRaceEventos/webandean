
import 'package:flutter/material.dart';

class AssetsCircularProgreesIndicator extends StatelessWidget {
  const AssetsCircularProgreesIndicator({
    super.key,  this.color = Colors.white,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color,
        ),
      );
  }
}