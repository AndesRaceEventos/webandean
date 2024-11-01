double convertirTextoADouble(String texto) {
  try {
    // Intenta parsear la cadena a double
    return double.parse(texto);
  } catch (e) {
    // Si hay un error, intenta convertirlo a double como entero
    return double.tryParse(texto) ?? 0.0;
  }
}

double parseToDouble(dynamic value) {
  if (value is int) {
    return value.toDouble();
  } else if (value is double) {
    return value;
  } else {
    return double.parse(value.toString());
  }
}
//
String parseToformatearNumero(double numero) {
  if (numero % 1 == 0) {
    // Si el número no tiene decimales, mostrarlo como entero
    return numero.toInt().toString();
  } else {
    // Si el número tiene decimales, mostrarlo con un solo decimal
    return numero.toStringAsFixed(1);
  }
}

// Ejemplo de uso
double numero1 = 10.0;
double numero2 = 15.5;

// print(formatearNumero(numero1));  // Salida: "10"
// print(formatearNumero(numero2));  // Salida: "15.5"