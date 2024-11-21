
import 'dart:convert';

class FormatValues {

 static List<String> convertirToListString(String value){
   // Si el valor es nulo o vacío, devuelve una lista vacía
    if (value.isEmpty) return [];
   // Esto divide el texto por comas y elimina espacios en blanco
  return value.split(',')
    .map((p) => p.trim()) // Eliminar espacios en blanco
    .toList();// Debería imprimir: [PLAZA VEA, SAN PEDRO SILVIA]
 }

 static  bool parseBool(String value) {
  String lowerCaseValue = value.toLowerCase();
  
  if (lowerCaseValue == 'true') {
    return true;
  } else if (lowerCaseValue == 'false') {
    return false;
  } else {
    return false;
    // throw FormatException("Valor booleano no válido: $value");
  }
}


static double convertirTextoADouble(String texto) {
  try {
    // Intenta parsear la cadena a double
    return double.parse(texto);
  } catch (e) {
    // Si hay un error, intenta convertirlo a double como entero
    return double.tryParse(texto) ?? 0.0;
  }
}

static double parseToDouble(dynamic value) {
  if (value is int) {
    return value.toDouble();
  } else if (value is double) {
    return value;
  } else {
    return double.parse(value.toString());
  }
}

static int parseToInt(dynamic value) {
  if (value is int) {
    return value;
  } else if (value is double) {
    return value.toInt();
  } else {
    return int.parse(value.toString());
  }
}

//
static String parseToformatearNumero(double numero) {
  if (numero % 1 == 0) {
    // Si el número no tiene decimales, mostrarlo como entero
    return numero.toInt().toString();
  } else {
    // Si el número tiene decimales, mostrarlo con un solo decimal
    return numero.toStringAsFixed(1);
  }
}

// Ejemplo de uso
// double numero1 = 10.0;
// double numero2 = 15.5;

// print(formatearNumero(numero1));  // Salida: "10"
// print(formatearNumero(numero2));  // Salida: "15.5"


static DateTime parseDateTime(dynamic value) {
      if (value == null || value.toString().isEmpty) {
        // Asignar una fecha predeterminada si el valor es nulo o vacío
        return DateTime(1998, 1, 1); // Puedes cambiar esta fecha según tus necesidades
      } else {
        // Intentar convertir el valor a DateTime
        try {
          return DateTime.parse(value.toString());
        } catch (e) {
          // En caso de error al parsear, asignar una fecha por defecto
          return DateTime(1998, 1, 1); // Puedes cambiar esta fecha según tus necesidades
        }
      }
    }



//todos DE OBJETO A JSON 
// Método Global para Convertir Listas a JSON
// Convierte cualquier lista de objetos a un String JSON
static String listaToString<T>(List<T>? lista, T Function(Map<String, dynamic>) fromJson, Map<String, dynamic> Function(T) toJson) {
  try {
    if (lista == null || lista.isEmpty) return '';
    return jsonEncode(lista.map((item) => toJson(item)).toList());
  } catch (e) {
    print("Error al convertir lista a JSON: $e");
    return ''; // Retorna cadena vacía en caso de error
  }
}


//todos DE JSON a OBJETO 
 // Método para obtener los nombres de los campos en comillas
// Método genérico para convertir una lista JSON a una lista de objetos
static List<T> listaFromJson<T>(dynamic jsonList, T Function(Map<String, dynamic>) fromJson, T Function() defaultValue) {
  try {
    if (jsonList == null || jsonList is! List) {
      return []; // Retorna lista vacía si no es válida o es null
    }
    
    // Mapea los elementos de la lista JSON a objetos de tipo T
    return List<T>.from(jsonList.map((item) => fromJson(item)));
  } catch (e) {
    print("Error al convertir lista desde JSON: $e");
    return [defaultValue()]; // Retorna lista vacía en caso de error
  }
}

//todos DE STRING A  JSON y luego  OBJETO : idal para formulario
// Método Global para Convertir de JSON a Lista de Objetos
// Convierte un String JSON a una lista de objetos
static List<T> listaFromString<T>(String data, T Function(Map<String, dynamic>) fromJson) {
  try {
    if (data.isEmpty) return [];
    List<dynamic> jsonData = jsonDecode(data);
    return jsonData.map((item) => fromJson(item)).toList();
  } catch (e) {
    print("Error al convertir lista desde String a JSON: $e");
    return []; // Retorna lista vacía en caso de error
    // // Lanza la excepción de nuevo para que se pueda capturar en un nivel superior
    // rethrow;
  }
}

}