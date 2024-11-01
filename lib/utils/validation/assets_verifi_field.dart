
class ValidationField {
  
String getField(dynamic field) {
  return (field == null || field.toString().isEmpty) ? 'N/A' : field.toString();
}


//Caso de bool : no puede mostrar verdadero false, debe mostrar un texto.
String getFieldBool(
    {required bool estado,
    required String textTrue,
    required String textFalse}) {
  // Agrupación por estado booleano con textos personalizados
  return estado ? textTrue : textFalse;
}



//FECHAS 

  // Método para formatear la fecha para agrupamiento mensual
  String getMonthGroup(DateTime dateTime) {
    final month = _getMonthAbbreviation(dateTime.month);
    
    return '$month ${dateTime.year}';
  }

  // Método para formatear la fecha para agrupamiento anual
  String getYearGroup(DateTime dateTime) {
    return '${dateTime.year}';
  }

  // Método auxiliar para obtener la abreviatura del mes
  String _getMonthAbbreviation(int month) {
    switch (month) {
      case 1: return 'Jan';
      case 2: return 'Feb';
      case 3: return 'Mar';
      case 4: return 'Apr';
      case 5: return 'May';
      case 6: return 'Jun';
      case 7: return 'Jul';
      case 8: return 'Aug';
      case 9: return 'Sep';
      case 10: return 'Oct';
      case 11: return 'Nov';
      case 12: return 'Dec';
      default: return '';
    }
  }

 // Función para clasificar valores numéricos en rangos, considerando la moneda.
String getLabeledPriceRange(dynamic value, String? currency) {
  // Manejar el caso en que no hay valor y no hay moneda
 if ((value == null || value == 0) && (currency == null || currency.isEmpty)) {
    return ' 0 - N/A';
  } 

  // Convertir a double si es posible
  double numericValue;
  if (value is int) {
    numericValue = value.toDouble();
  } else if (value is double) {
    numericValue = value;
  } else {
    throw ArgumentError('El valor debe ser un número (int o double).');
  }

  String range;
  String character;

  // Asignar caracteres según el rango para mantener el orden Unicode
   if (numericValue == 0) {
    range = '0';
    character = ''; // ■ (Black Square) - valor Unicode: 9642
  }
  else if (numericValue <= 10) {
    range = '1 - 10';
    character = '\u25A0'; // ■ (Black Square) - valor Unicode: 9642
  } else if (numericValue <= 20) {
    range = '11 - 20';
    character = '\u25A1'; // □ (White Square) - valor Unicode: 9643
  } else if (numericValue <= 50) {
    range = '21 - 50';
    character = '\u25B2'; // ▲ (Black Triangle) - valor Unicode: 9650
  } else if (numericValue <= 100) {
    range = '51 - 100';
    character = '\u25B3'; // △ (White Triangle) - valor Unicode: 9651
  } else if (numericValue <= 200) {
    range = '101 - 200';
    character = '\u25C6'; // ♠ (Spade) - valor Unicode: 9824
  } else if (numericValue <= 300) {
    range = '201 - 300'; //u25C7
    character = '\u25C7'; // ♡ (Heart) - valor Unicode: 9825
  } else if (numericValue <= 500) {
    range = '301 - 500';
    character = '\u25CB'; // ♢ (Diamond) - valor Unicode: 9826
  } else if (numericValue <= 800) {
    range = '501 - 800';
    character = '\u25CF'; // ♣ (Club) - valor Unicode: 9827
  } else if (numericValue <= 1000) {
    range = '801 - 1000';
    character = '\u2605'; // ◆ (Black Diamond) - valor Unicode: 9670
  } else if (numericValue <= 1500) {
    range = '1001 - 1500';
    character = '\u2606'; // ◇ (White Diamond) - valor Unicode: 9671
  } else if (numericValue <= 2000) {
    range = '1501 - 2000';
    character = '\u2660'; // ○ (White Circle) - valor Unicode: 9675
  } else if (numericValue <= 3000) {
    range = '2001 - 3000';
    character = '\u2661'; // ● (Black Circle) - valor Unicode: 9679
  } else if (numericValue <= 5000) {
    range = '3001 - 5000';
    character = '\u2662'; // ★ (Black Star) - valor Unicode: 9733
  } else if (numericValue <= 10000) {
    range = '5001 - 10000';
    character = '\u2663'; // ☆ (White Star) - valor Unicode: 9734
  } else {
    range = '10000 ... +';
    character = '\u2731'; // ✱ (Star) - valor Unicode: 10001
  }


  // Retornar el rango junto con la moneda y el carácter
  return '$character $range $currency';
}



}