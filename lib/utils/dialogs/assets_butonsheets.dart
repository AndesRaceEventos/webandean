import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:flutter/material.dart';

void showCustomBottonSheet({
  required BuildContext context,
  required WidgetBuilder builder,
  double maxHeightFactor = 0.9,
  bool enableDrag = true,
  bool showDragHandle = true,
  AnimationStyle? sheetAnimationStyle,
  Color?  backgroundColor = AppColors.primaryWhite,
}) {
  final size = MediaQuery.of(context).size;
  showModalBottomSheet( 
    // barrierColor:AppColors.backgroundDark.withOpacity(.5),
    backgroundColor: backgroundColor,
    context: context,
    constraints: BoxConstraints(
      maxHeight: size.height * maxHeightFactor,
      maxWidth: size.width
    ),
    enableDrag: enableDrag,
    showDragHandle: showDragHandle,
    isScrollControlled: true,
    sheetAnimationStyle: sheetAnimationStyle ??
        AnimationStyle(
          reverseCurve: Curves.easeInExpo,
          curve: Curves.elasticInOut,
          duration: const Duration(milliseconds: 1500),
        ),
    builder: builder,
  );
}
