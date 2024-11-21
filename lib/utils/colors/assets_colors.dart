import 'package:flutter/material.dart';

class AppColors {
  //menu barra lateral 
   static const Color menuTheme =  Color(0xFF653B5B) ;//Color(0xff2C3E50); // Gris oscuro minimalista
   static const Color menuIconColor = Colors.white70; // Blanco suave, casi crema
  //Table header Theme 
  static const Color menuHeaderTheme =  Color(0xFFAA9A9E);
  static const Color menuTextDark = Color(0xFF17010E);


  // Colores principales (minimalistas)
  static const Color primaryRed = Color(0xFF4A4A4A); // Gris oscuro minimalista
  static const Color primaryWhite = Color(0xFFF7F8FA); // Blanco suave, casi crema
  static const Color primaryBlack = Color(0xFF202124); // Gris oscuro para textos y detalles

  // Colores de fondo
  static const Color backgroundLight = Color(0xFFF2F2F2); // Gris muy claro para fondos
  static const Color backgroundDark = Color(0xFF1C1C1E); // Gris oscuro, casi negro

  // Colores de texto
  static const Color textPrimary = Color(0xFF1A1A1A); // Negro ligeramente grisáceo para texto
  static const Color textSecondary = Color(0xFF737373); // Gris suave para textos secundarios

  // Colores de título
  static const Color title = Color(0xFF333333); // Gris oscuro para títulos
  static const Color titleAccent = Color(0xFF9E9E9E); // Gris acento suave para títulos destacados

  // Colores de botones
  static const Color buttonPrimary = Color(0xFF4A4A4A); // Gris oscuro para botones principales
  static const Color buttonSecondary = Color(0xFFE0E0E0); // Gris claro para botones secundarios

  // Colores adicionales (paleta complementaria)
  static const Color accentColor = Color(0xFF6C6C6C); // Gris oscuro suave para acentos
  static const Color successColor = Color(0xFF8BC34A); // Verde suave para éxito
  static const Color warningColor = Color(0xFFFFC107); // Amarillo suave para advertencias
  static const Color errorColor = Color(0xFFD32F2F); // Rojo suave para errores


  //FUNSION QUE DEVULVE UN COLOR
 static Color getColorFromHex(String hexColor) {
    try {
      hexColor = hexColor.replaceAll('#', '');
      if (hexColor.length == 6) {
        return Color(int.parse('FF$hexColor', radix: 16));
      } else {
        throw FormatException('Invalid hex color format');
      }
    } catch (e) {
      return Color(0xFF808080); 
    }
  }


 static Color getColorByIndex({ 
      required int index, 
      Color colorPar = AppColors.primaryRed, 
      Color colorImpar = AppColors.primaryWhite
      }) {
   
    return index % 2 == 0 ?  
          colorPar : colorImpar;
  }

}

