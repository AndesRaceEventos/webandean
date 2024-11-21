import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/conversion/assets_format_values.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

DatatableHeader headerProgress() {
  return DatatableHeader(
    text: "Progress",
    value: "progress",
    show: true,
    sortable: false,
    headerBuilder: (value) {
      return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth > 200 ? 150 : constraints.maxWidth;
        return Container(
          width: maxWidth,
          constraints: BoxConstraints(maxWidth: maxWidth), // Limita el ancho del header
            decoration: BoxDecoration(
            color: AppColors.menuHeaderTheme,
            border: Border.all(
              width: .4,
              style: BorderStyle.solid,
              color: Colors.grey.shade200),
          ),
            child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 3),
              visualDensity: VisualDensity.compact,
              dense: false,
              minLeadingWidth: 0, 
              minVerticalPadding: 0,
              leading: Icon(Icons.bar_chart_outlined, size: 15, color: AppColors.menuTextDark),
              title: H3Text(text: 'Progress'.toUpperCase(), fontSize: 11,
              color: AppColors.menuTextDark, textAlign: TextAlign.center,)
            ),
          );
        }
      );
    },
    sourceBuilder: (value, row) {
      List<dynamic> progressValues = value;

      // Extraer valores de la lista
      DateTime fechaVencimiento = FormatValues.parseDateTime(progressValues[0]);
      double cantidadEnStock = progressValues[1] ?? 0;
      double cantidadCritica = progressValues[2] ?? 0;
      double cantidadOptima = progressValues[3] ?? 0;
      double cantidadMaxima = progressValues[4] ?? 0;

      // Determinar estados
      String estadoFecha = _determinarEstado(fechaVencimiento);
      String estadoStock = _determinarEstadoStock(cantidadEnStock, cantidadCritica, cantidadOptima, cantidadMaxima);

      // Calcular progresos en porcentaje
      double progresoFecha = _calcularProgresoFecha(fechaVencimiento);
      double progresoStock = _calcularProgresoStock(cantidadEnStock, cantidadCritica, cantidadOptima, cantidadMaxima);

       return LayoutBuilder(
      builder: (context, constraints) {
        // double maxWidth = constraints.maxWidth > 200 ? 150 : constraints.maxWidth;
        double maxWidth = 150;
        return Center(
          child: Container(
            width: maxWidth,
            constraints: BoxConstraints(maxWidth: maxWidth), // Limita el ancho del header
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     ListTile(
                       contentPadding: EdgeInsets.symmetric(horizontal: 10),
                       visualDensity: VisualDensity.compact,
                       dense: false,
                       minLeadingWidth: 0,
                       minTileHeight: 0,
                       minVerticalPadding: 0,
                       title: H3Text(text: estadoFecha, fontSize: 11),
                       leading: Container(
                         height: 10,
                         width: 10,
                          child: Icon(Icons.date_range, size: 15 , 
                         color: _colorSemaforoFecha(fechaVencimiento)),
                       ),
                       subtitle: LinearProgressIndicator(
                         value: progresoFecha,
                         backgroundColor: estadoFecha == "Vencido" ? Colors.red.shade100 : (estadoFecha == 'Vigente' ? Colors.transparent : Colors.grey.shade300) ,
                         valueColor: AlwaysStoppedAnimation<Color>(_colorSemaforoFecha(fechaVencimiento)),
                       ),
                     ),
                      SizedBox(height: 10),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        visualDensity: VisualDensity.compact,
                        dense: false,
                        minLeadingWidth: 0,
                        minTileHeight: 0,
                        minVerticalPadding: 0,
                        title: H3Text(text: estadoStock, fontSize: 11),
                        leading: Container(
                          height: 10,
                          width: 10,
                          child: Icon(Icons.line_weight_sharp, size: 15, 
                          color: _colorSemaforoStock(cantidadEnStock, cantidadCritica, cantidadOptima, cantidadMaxima)),
                        ),
                        subtitle: LinearProgressIndicator(
                          value: progresoStock,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(_colorSemaforoStock(cantidadEnStock, cantidadCritica, cantidadOptima, cantidadMaxima)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        );
        }
      );
    },
    textAlign: TextAlign.center,
  );
}
// Método para determinar el estado basado en el stock
String _determinarEstadoStock(double cantidadStock, double cantidadCritica, double cantidadOptima, double cantidadMaxima) {
  if (cantidadStock <= 0) {
    return "Agotado";
  } else if (cantidadStock <= cantidadCritica) {
    return "Por Agotar";
  } else if (cantidadStock <= cantidadOptima) {
    return "En Stock";
  } else if (cantidadStock <= cantidadMaxima) {
    return "Suficiente";
  } else {
    return "Abundante";
  }
}



// Método para determinar el estado basado en la fecha
String _determinarEstado(DateTime fecha) {
  final now = DateTime.now();
  if (fecha.isBefore(now)) {
    return "Vencido";
  } else if (fecha.difference(now).inDays <= 7) {
    return "Por vencer";
  }
  else if (fecha.difference(now).inDays <= 15) {
    return "Prox. 15 dias";
  }
  else {
    return "Vigente";
  }
}


// Método para calcular el progreso en función del stock
double _calcularProgresoStock(double cantidadEnStock, double cantidadCritica, double cantidadOptima, double cantidadMaxima) {
  if (cantidadMaxima == 0) return 0.0; // Previene división por cero
  return (cantidadEnStock / cantidadMaxima).clamp(0.0, 1.0); // Progreso basado en la cantidad máxima
}



// Método para calcular el progreso en función de la fecha
double _calcularProgresoFecha(DateTime fecha) {
  final now = DateTime.now();
  
  // Si la fecha ya ha vencido, el progreso debe ser 1.0 (completo)
  if (fecha.isBefore(now)) {
    return 0.0;
  }

  // Definimos el inicio y el final del rango de un mes
  final inicioMes = DateTime(now.year, now.month, 1);
  final finMes = DateTime(now.year, now.month + 1, 0); // Último día del mes actual
  
  // Calculamos el total de días en el rango
  final totalDias = finMes.difference(inicioMes).inDays;
  
  // Calculamos los días transcurridos desde el inicio del mes hasta ahora
  final diasTranscurridos = now.difference(inicioMes).inDays.clamp(0, totalDias);
  
  // Días restantes hasta la fecha de vencimiento
  final diasHastaVencimiento = fecha.difference(now).inDays;

  // Calculamos el progreso inverso:
  // Cuanto más cerca esté la fecha de vencimiento, más lleno debe estar el progreso
  final progreso = 1 - (diasHastaVencimiento / (diasHastaVencimiento + diasTranscurridos));
  
  return progreso.clamp(0.0, 1.0); // Asegúrate de que esté entre 0 y 1
}



// Colores de semáforo para el stock
Color _colorSemaforoStock(double cantidadStock, double cantidadCritica, double cantidadOptima, double cantidadMaxima) {
  if (cantidadStock <= 0) return Colors.red;
  if (cantidadStock <= cantidadCritica) return Colors.orange;
  if (cantidadStock <= cantidadOptima) return Colors.green;
  if (cantidadStock <= cantidadMaxima) return Colors.blue.shade400;
  return Colors.white;
}
// Colores de semáforo para la fecha
Color _colorSemaforoFecha(DateTime fecha) {
  final now = DateTime.now();
  if (fecha.isBefore(now)) return Colors.red;
  if (fecha.difference(now).inDays <= 7) return Colors.orange;
  if (fecha.difference(now).inDays <= 15) return Colors.yellow.shade600;
  return Colors.white;
}