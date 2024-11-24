import 'package:flutter/material.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
class AssetDecorationTextField {
  
static  InputDecoration decorationFormPDfView({Color fillColor = Colors.white, int padding = 0}) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(0),
      isDense: true,
      fillColor: fillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(0.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(0.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(0.0),
      ),
    );
  }


 static InputDecoration decorationTextFieldRectangle(
    {required String hintText,
     String labelText = '',
    Widget? prefixIcon, 
    Widget? suffixIcon, 
    Color fillColor = Colors.white,}) {
  return InputDecoration(
    contentPadding: EdgeInsets.only(left: 15),
    isDense: true,
    labelText: labelText,
    prefixIcon: prefixIcon,
    hintText: hintText,
    filled: true,
    fillColor:fillColor,
    suffixIcon: suffixIcon,
    labelStyle:  TextStyle(color: AppColors.menuTheme, fontSize: 13),
    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
    border: OutlineInputBorder(
      borderSide:  BorderSide(color: AppColors.menuTheme),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:  BorderSide(color: AppColors.menuTheme),
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: OutlineInputBorder(
     borderSide:  BorderSide(color: AppColors.menuTheme),
      borderRadius: BorderRadius.circular(10.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide:  BorderSide(color: AppColors.menuTheme),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

 static InputDecoration decorationTextField(
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

static InputDecoration decorationTextFieldUnderLine({
  required String hintText, 
  Color fillColor = Colors.white
  }) {

  return InputDecoration(
    filled: true,
    fillColor:fillColor,
    labelText: hintText,
    focusColor: Colors.red,
    // contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
    labelStyle:  TextStyle(color: AppColors.menuTheme, fontSize: 13),
    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    enabledBorder: UnderlineInputBorder(
     borderSide:  BorderSide(color: AppColors.menuTheme),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide:  BorderSide(color: AppColors.menuTheme),
    ),
    border: UnderlineInputBorder(
      borderSide:  BorderSide(color: AppColors.menuTheme),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide:  BorderSide(color: AppColors.menuTheme),
    ),
  );
}

}