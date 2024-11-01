
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:flutter/material.dart';

ButtonStyle buttonStyle2({Color?  backgroundColor,} ) {
    return  ButtonStyle(
        // maximumSize: WidgetStatePropertyAll(Size(150, 80)),
        // minimumSize: MaterialStatePropertyAll(Size(80, 40)),
        padding: WidgetStatePropertyAll(EdgeInsets.only(left: 20, right: 20)),
        elevation: WidgetStatePropertyAll(2),
        // visualDensity: VisualDensity.compact,
        surfaceTintColor: WidgetStatePropertyAll(Colors.white30),
         backgroundColor: WidgetStatePropertyAll(backgroundColor ?? AppColors.backgroundLight),
        overlayColor: WidgetStatePropertyAll(Colors.white30),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        )));
  }


ButtonStyle buttonStyle1({Color?  backgroundColor,} ) {
    return  ButtonStyle(
        // maximumSize: WidgetStatePropertyAll(Size(150, 80)),
        // minimumSize: MaterialStatePropertyAll(Size(80, 40)),
        padding: WidgetStatePropertyAll(EdgeInsets.only(left: 20, right: 20)),
        elevation: WidgetStatePropertyAll(5),
        // visualDensity: VisualDensity.compact,
        surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
        backgroundColor: WidgetStatePropertyAll(backgroundColor ?? AppColors.successColor),
        overlayColor: WidgetStatePropertyAll(Colors.white12),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        )));
  }