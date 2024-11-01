import 'package:flutter/material.dart';

InputDecoration decorationTextField(
    {required String hintText,
     String labelText = '',
    Widget? prefixIcon, 
    Widget? suffixIcon, 
    Color fillColor = Colors.white,}) {
  return InputDecoration(
    labelText: labelText,
    prefixIcon: prefixIcon,
    hintText: hintText,
    filled: true,
    fillColor:fillColor,
    suffixIcon: suffixIcon,
    labelStyle:  TextStyle(color: Colors.blue.shade500, fontSize: 14),
    hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
    border: OutlineInputBorder(
      borderSide:  BorderSide(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:  BorderSide(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: OutlineInputBorder(
     borderSide:  BorderSide(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(10.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide:  BorderSide(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

InputDecoration decorationTextFieldUnderLine({required String hintText}) {
  const color = Color(0xFF5F3113);
  return InputDecoration(
    // labelText: labelText,
    hintText: hintText,
    focusColor: Colors.red,
    contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
    labelStyle: const TextStyle(
        color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w300),
    hintStyle: const TextStyle(color: Colors.black45, fontSize: 15),
    // contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: color.withOpacity(.5)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: color.withOpacity(.5)),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: color.withOpacity(.5)),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: color.withOpacity(.5)),
    ),
  );
}