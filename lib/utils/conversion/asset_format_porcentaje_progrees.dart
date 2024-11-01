// Función para formatear el porcentaje
String formatPercentage(double value) {
  // Si el valor es NaN, devolver "0"
  if (value.isNaN) {
    return '0';
  }
  if (value == 1.0) {
    // Cuando el progreso es completo, mostrar 100%
    return '100';
  } else {
    // Convertir a porcentaje como cadena, mostrando decimales solo si son necesarios
    String formattedPercentage = (value * 100)
        .toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    return formattedPercentage.replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
  }
}