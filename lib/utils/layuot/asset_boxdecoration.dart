import 'package:flutter/material.dart';

class AssetDecorationBox {
  
  BoxDecoration decorationBox({Color? color}) {
  return BoxDecoration(
      color: color ?? Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5.0,
          spreadRadius: 1.0,
          offset: Offset(0.0, 3.0),
        )
      ]);
}

BoxDecoration headerDecoration({Color? color}) {
  return BoxDecoration(
      color:color ?? Colors.white,
      border:
          Border(bottom: BorderSide(width: 5, color: Colors.grey.shade600)));
}

BoxDecoration rowDecoration({Color? color}) {

  return BoxDecoration(
      color:  color ?? Colors.white,
      border: Border(bottom: BorderSide(color: Colors.grey.shade400)));
}


BoxDecoration borderdecoration({Color? colorBorder, Color? color}) {
  return BoxDecoration(
      color:color ?? Colors.black12,
       borderRadius: BorderRadius.circular(7),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 1.0,
          spreadRadius: .0,
          offset: Offset(0.0, 0.0),
        )
      ],
       border: Border.all(
      color: colorBorder ??  Colors.white, // Borde de color para diferenciar
      width:1, // Grosor del borde
    ),);
}


BoxDecoration selectedDecoration({Color? color}) {
  return BoxDecoration(
    color: color ?? Colors.white38, // Fondo blanco para el row seleccionado
    borderRadius: BorderRadius.circular(4), // Bordes suavemente redondeados
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.4), // Sombra gris clara
        offset: Offset(0, 4), // Sombra ligeramente desplazada hacia abajo
        blurRadius: 0, // Suavidad de la sombra
        spreadRadius: 1, // Extensión de la sombra
      ),
    ],
    // border: Border.all(
    //   color: Colors.white, // Borde de color para diferenciar
    //   width: 5, // Grosor del borde
    // ),
  );
}


BoxDecoration decorationBorder({Color? color}) {
  return BoxDecoration(
    color: color ?? Colors.white, // Fondo blanco para el row seleccionado
    borderRadius: BorderRadius.circular(4), // Bordes suavemente redondeados
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.4), // Sombra gris clara
        offset: Offset.zero, // Sombra ligeramente desplazada hacia abajo
        blurRadius: 0, // Suavidad de la sombra
        spreadRadius: 2, // Extensión de la sombra
      ),
    ],
    border: Border.all(
      color: Colors.black12, // Borde de color para diferenciar
      width: 3, // Grosor del borde
    ),
  );
}



BoxDecoration decorationGradientColor({List<Color>? colors}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(4), // Bordes suavemente redondeados
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.4), // Sombra gris clara
        offset: Offset(0, 4), // Sombra ligeramente desplazada hacia abajo
        blurRadius: 0, // Suavidad de la sombra
        spreadRadius: 1, // Extensión de la sombra
      ),
    ],
     gradient: LinearGradient(
      colors: colors ?? [], // Usar colores proporcionados o los por defecto
      begin: Alignment.topRight, // Comienzo del degradado
      end: Alignment.topLeft, // Fin del degradado
    ),
  );
}
}