import 'package:webandean/utils/text/custom_text.dart';
import 'package:flutter/material.dart';

class H1Text extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int maxLines;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final FontWeight fontWeight;
  final bool selectable;
  final double height;

  const H1Text({
    super.key,
    required this.text,
    this.fontSize = 20.0,
    this.color = Colors.black,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.bold,
    this.selectable = false,
    this.height = 1.4
  });

  @override
  Widget build(BuildContext context) {
    return HtmlText(
      text: text,
      fontSize: fontSize,
      color: color,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      fontWeight: fontWeight,
      selectable: selectable,
      height: height,
    );
  }
}

class H2Text extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int maxLines;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final FontWeight fontWeight;
  final bool selectable;
  final double height;

  const H2Text({
    super.key,
    required this.text,
    this.fontSize = 17.0,
    this.color = Colors.black,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.w700,
    this.selectable = false,
    this.height = 1.4
  });

  @override
  Widget build(BuildContext context) {
    return HtmlText(
      text: text,
      fontSize: fontSize,
      color: color,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      fontWeight: fontWeight,
      selectable: selectable,
      height: height,
    );
  }
}

class H3Text extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int maxLines;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final FontWeight fontWeight;
  final bool selectable;
  final double height;

  const H3Text({
    super.key,
    required this.text,
    this.fontSize = 15.0,
    this.color = Colors.black,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.w700,
    this.selectable = false,
    this.height = 1.4
  });

  @override
  Widget build(BuildContext context) {
    return HtmlText(
      text: text,
      fontSize: fontSize,
      color: color,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      fontWeight: fontWeight,
      selectable: selectable,
      height: height,
    );
  }
}

class P1Text extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int maxLines;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final FontWeight fontWeight;
  final bool selectable;
  final double height;

  const P1Text({
    super.key,
    required this.text,
    this.fontSize = 17.0,
    this.color = Colors.black,
    this.maxLines = 4000,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.w500,
    this.selectable = false,
    this.height = 1.4
  });

  @override
  Widget build(BuildContext context) {
    return HtmlText(
      text: text,
      fontSize: fontSize,
      color: color,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      fontWeight: fontWeight,
      selectable: selectable,
      height: height,
    );
  }
}

class P2Text extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int maxLines;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final FontWeight fontWeight;
  final bool selectable;
  final double height;

  const P2Text({
    super.key,
    required this.text,
    this.fontSize = 15.0,
    this.color = Colors.black,
    this.maxLines = 4000,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.w500,
    this.selectable = false,
    this.height = 1.4
  });

  @override
  Widget build(BuildContext context) {
    return HtmlText(
      text: text,
      fontSize: fontSize,
      color: color,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      fontWeight: fontWeight,
      selectable: selectable,
      height: height,
    );
  }
}

class P3Text extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int maxLines;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final FontWeight fontWeight;
  final bool selectable;
  final double height;

  const P3Text({
    super.key,
    required this.text,
    this.fontSize = 11.0,
    this.color = Colors.black,
    this.maxLines = 4000,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.normal,
    this.selectable = false,
    this.height = 1.4
  });

  @override
  Widget build(BuildContext context) {
    return HtmlText(
      text: text,
      fontSize: fontSize,
      color: color,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      fontWeight: fontWeight,
      selectable: selectable,
      height: height,
    );
  }
}
