// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class HtmlText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int maxLines;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final FontWeight fontWeight;
  final bool selectable; // Nuevo campo para determinar si el texto es seleccionable
  final double height;

  const HtmlText({
    Key? key,
    required this.text,
    this.fontSize = 14.0,
    this.color = Colors.black,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.normal,
    this.selectable = false, 
    this.height = 1.4, // Por defecto, el texto no es seleccionable
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectable) {
      return SelectableText(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          fontFamily: 'Quicksand',
          overflow: overflow,
          height:height, 
          // decoration: TextDecoration.underline
        ),
        selectionControls: CustomTextSelectionControls(),
        onSelectionChanged: (selection, cause) {
    // Maneja el cambio de selección aquí
    print('Selección cambiada: $selection');
  },
        textAlign: textAlign,
        maxLines: maxLines,
        
      );
    } else {
      return Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          fontFamily: 'Quicksand',
          height:height
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );
    }
  }
}


//PErmite activar una funsion de al opresionar el texto se active los botones se copy y select all

class CustomTextSelectionControls extends MaterialTextSelectionControls {
  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textHeight,
    [void Function()? onTap] // Cambiar [] por []() o [void Function()? onTap = null]
  ) {
    return super.buildHandle(context, type, textHeight, onTap);
  }

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    return super.getHandleAnchor(type, textLineHeight);
  }
}
