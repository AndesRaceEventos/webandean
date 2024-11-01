import 'dart:ui';

import 'package:flutter/material.dart';

class AppBLurFilter extends StatelessWidget {
  const AppBLurFilter({super.key,  this.borderradius = 10, required this.child});
  final double borderradius;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(borderradius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: child,
        ));
  }
}
