import 'package:timezone/timezone.dart' as tz;

// Lista de días en español
List<String> diasSemana = ["Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"];

// Meses del año en español
List<String> mesesAnio = [
  "Ene",
  "Feb",
  "Mar",
  "Abr",
  "May",
  "Jun",
  "Jul",
  "Ago",
  "Sep",
  "Oct",
  "Nov",
  "Dic"
];

String formatFecha(DateTime fecha) {
  //Obtener el día de la semana, el día del mes y el mes en texto
  String diaSemana = diasSemana[fecha.weekday - 1];
  String diaMes = fecha.day.toString();
  String mesAno = mesesAnio[fecha.month - 1];
  String ano = fecha.year.toString();

  String fechaFormateada = "$diaSemana, $diaMes $mesAno $ano";
  return fechaFormateada;
}

//FECHA HORA EXPRESION LARGA 
String formatFechaTimeZone(DateTime fecha) {
  // Convertir la fecha a la zona horaria de América/Lima
  final tz.TZDateTime fechaLima =
      tz.TZDateTime.from(fecha, tz.getLocation('America/Lima'));
  fecha = fechaLima;
  // Obtener el día de la semana, el día del mes y el mes en texto
  String diaSemana = diasSemana[fecha.weekday - 1];
  String diaMes = fecha.day.toString();
  String mesAno = mesesAnio[fecha.month - 1];
  String ano = fecha.year.toString();

  // Obtener la hora y el minuto
  // String hora = fecha.hour.toString().padLeft(2, '0');
  String minuto = fecha.minute.toString().padLeft(2, '0');

  // Determinar si es AM o PM
  String periodo = (fecha.hour < 12) ? 'AM' : 'PM';

  // Convertir la hora al formato de 12 horas
  int hora12 = (fecha.hour > 12) ? fecha.hour - 12 : fecha.hour;
  // Crear la cadena formateada
  String fechaFormateada =
      "$diaSemana, $diaMes $mesAno $ano a las $hora12:$minuto $periodo";
  return fechaFormateada;
}




String formatFechaPDfhora(DateTime fecha) {
  // String diaSemana = diasSemana[fecha.weekday - 1];
  String minuto = fecha.minute.toString().padLeft(2, '0');
  String segundo = fecha.second.toString().padLeft(2, '0');

  // Determinar si es AM o PM
  String periodo = (fecha.hour < 12) ? 'AM' : 'PM';

  // Convertir la hora al formato de 12 horas
  int hora12 = ((fecha.hour > 12) ? fecha.hour - 12 : fecha.hour);

  // Crear la cadena formateada
  String fechaFormateada = "$hora12:$minuto:$segundo $periodo";

  return fechaFormateada;
}

String formatEventDates(DateTime startDate, DateTime endDate) {
  // List of month names in Spanish
  const List<String> months = [
    'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
    'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
  ];

  // Extract day, month, and year for both dates
  String startDay = startDate.day.toString().padLeft(2, '0');
  String startMonth = months[startDate.month - 1];
  int startYear = startDate.year;

  String endDay = endDate.day.toString().padLeft(2, '0');
  String endMonth = months[endDate.month - 1];
  int endYear = endDate.year;

  // Check if the month and year are the same for both dates
  if (startMonth == endMonth && startYear == endYear) {
    return '$startDay y $endDay de $startMonth del $startYear';
  } else if (startYear == endYear) {
    return '$startDay de $startMonth y $endDay de $endMonth del $startYear';
  } else {
    return '$startDay de $startMonth del $startYear y $endDay de $endMonth del $endYear';
  }
}
String formatControlPointTimes(DateTime apertura, DateTime cierre) {
  // Lista de nombres de meses en español
  const List<String> months = [
    'ene', 'feb', 'mar', 'abr', 'may', 'jun',
    'jul', 'ago', 'sep', 'oct', 'nov', 'dic'
  ];

  // Formatear fecha y hora
  String formatDateTime(DateTime dateTime) {
    String day = dateTime.day.toString().padLeft(2, '0');
    String month = months[dateTime.month - 1];
    String hour = (dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12).toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String period = dateTime.hour < 12 ? 'AM' : 'PM';
    return '$day $month, $hour:$minute $period';
  }

  // Verificar si el día, mes y año son los mismos para ambas fechas
  if (apertura.year == cierre.year && apertura.month == cierre.month && apertura.day == cierre.day) {
    return 'Abierto de ${formatDateTime(apertura)} a ${formatDateTime(cierre).split(', ')[1]}';
  } else {
    return 'Abierto de ${formatDateTime(apertura)} a ${formatDateTime(cierre)}';
  }
}




