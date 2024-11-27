import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webandean/utils/text/assets_textapp.dart';

class TipoCambioProvider with ChangeNotifier {
  double _tipoCambioCompra = 0.0;
  double _tipoCambioVenta = 0.0;
  DateTime _fecha = DateTime.now();

  double get tipoCambioCompra => _tipoCambioCompra;
  double get tipoCambioVenta => _tipoCambioVenta;
  DateTime get fecha => _fecha;

  TipoCambioProvider() {
    cargarTipoCambio();
  }

  // Método para cargar el tipo de cambio desde la SUNAT
  Future<void> cargarTipoCambio() async {
    final url = 'https://www.sunat.gob.pe/a/txt/tipoCambio.txt';
    try {
      final response = await http.get(Uri.parse(url));
      print(response.statusCode);

      if (response.statusCode == 200) {
       String data = response.body.trim(); // Recibimos la línea completa

        print('Tipo de cambio: $data');

        // Separamos los valores por '|'
        List<String> partes = data.split('|');

       if (partes.length == 4) {
          // Extraemos la fecha y los valores de tipo de cambio
          _fecha = convertirFecha(partes[0]); // Convertimos a formato DateTime

          _tipoCambioCompra = double.parse(partes[1]);
          _tipoCambioVenta = double.parse(partes[2]);

          print('Fecha: $_fecha');
          print('Tipo de cambio compra: $_tipoCambioCompra');
          print('Tipo de cambio venta: $_tipoCambioVenta');
          
          notifyListeners(); // Notificamos a los listeners para que actualicen la UI
        }
      } else {
        // throw Exception('No se pudo obtener el tipo de cambio');
        print('Error: No se pudo obtener el tipo de cambio, código de estado: ${response.statusCode}');
      }
    } catch (e) {
      // Aquí manejamos la excepción generada por cualquier error en la petición HTTP (incluyendo CORS)
    print('Error al cargar el tipo de cambio: $e');
    // Podrías asignar valores predeterminados o mostrar un mensaje de error en la UI
    // Por ejemplo, establecer valores predeterminados para no romper la aplicación:
    _fecha = DateTime.now();
    _tipoCambioCompra = 3.791;
    _tipoCambioVenta = 3.798;
    notifyListeners(); // Actualizamos la UI con los valores predeterminados
    }
  }

  // Método para convertir una fecha en formato dd/MM/yyyy a un DateTime
DateTime convertirFecha(String fecha) {
  // Dividimos la fecha usando '/' como delimitador
  List<String> partesFecha = fecha.split('/');
  
  // Verificamos que haya 3 partes (día, mes, año)
  if (partesFecha.length == 3) {
    try {
      // Convertimos las partes a enteros
      int dia = int.parse(partesFecha[0]);
      int mes = int.parse(partesFecha[1]);
      int anio = int.parse(partesFecha[2]);

      // Retorna el DateTime
      return DateTime(anio, mes, dia);
    } catch (e) {
      // throw FormatException('Fecha inválida en el formato esperado: dd/MM/yyyy');
      return DateTime.now();
    }
  } else {
    // throw FormatException('Formato de fecha inválido. Debe ser dd/MM/yyyy');
    return DateTime.now();
  }
}


   Map<String, double> calcularSumaTotalPorMoneda(
    List<dynamic> listaProductos,
    double Function(dynamic item) getValueNumber) {
  
    double totalUSD = 0.0;
    double totalPEN = 0.0;

    // Sumar el total de cada moneda
    for (var producto in listaProductos) {
      double valor = getValueNumber(producto);
      if (producto.moneda == 'USD') {
        totalUSD += valor;
      } else if (producto.moneda == 'PEN') {
        totalPEN += valor;
      }
    }

  // Convertir totales a la otra moneda
    double totalUSDenSoles = totalUSD * tipoCambioVenta;  // USD a soles
    double totalPENenDolares = totalPEN / tipoCambioVenta; // PEN a USD

  // Calcular el total en soles y en dólares
    double totalEnSoles = totalPEN + totalUSDenSoles;  // Total en soles
    double totalEnDolares = totalUSD + totalPENenDolares;  // Total en dólares

 // Retornar los totales en ambas monedas
    return {
      'USD': totalUSD,
      'PEN': totalPEN,
      'TOTAL_PEN': totalEnSoles,  // Total general en soles
      'TOTAL_USD': totalEnDolares,  // Total general en dólares
    };
}

//MORE FUNCTIONAL 
Map<String, Map<String, dynamic>> obtenerTotalesDistribucionPorMoneda(
    BuildContext context,
    List<dynamic> productos,
  ) {
    

    // Calcular los totales por moneda
    final totalesDistribucionPorMoneda = calcularSumaTotalPorMoneda(
      productos,
      (item) {
        dynamic e = item;
        double stock = e.cantidadEnStock ?? 0;
        double subTotal = (e.outPrecioDistribucion ?? 0) * stock;
        return subTotal;
      },
    );

    // Extraer valores
    double valorUSD = totalesDistribucionPorMoneda['USD'] ?? 0.0;
    double valorPEN = totalesDistribucionPorMoneda['PEN'] ?? 0.0;
    double totalEnSoles = totalesDistribucionPorMoneda['TOTAL_PEN'] ?? 0.0;
    double totalEnDolares = totalesDistribucionPorMoneda['TOTAL_USD'] ?? 0.0;

      return {
      'USD': {
        'valor': valorUSD,
        'descripcion': 'Suma de Registros existentes en dólares',
        'sufijo': '\$ ',
        'color': const Color(0xFF9AD09C),
      },
      'PEN': {
        'valor':  valorPEN,
        'descripcion': 'Suma de Registros existentes en soles',
        'sufijo': 'S/. ',
        'color':const Color(0xFFDFA0AF),
      },
      'TOTAL.PEN': {
        'valor':  totalEnSoles,
        'descripcion': 'Total general acumulado en soles',
         'sufijo': 'S/. ',
        'color': const Color(0xFFA0D0DA),
      },
      'TOTAL.USD': {
        'valor':  totalEnDolares,
        'sufijo': '\$ ',
        'descripcion': 'Total general acumulado en dólares',
        'color': const Color(0xFFC1B2D6),
      },
    };
  }

  Map<String, dynamic> calcularTotalParaCompra(
     List<dynamic>  productos) {
  // Filtrar productos activos (active == true)
  final productosActivos = productos.where((producto) => producto.active == true);
  final cantidadComprar = productosActivos.length;
  // Inicializar acumuladores
  double totalEnSoles = 0.0;
  double totalEnDolares = 0.0;

  // Sumar los montos de los productos activos
  for (var producto in productosActivos) {
    double stock = producto.cantidadEnStock ?? 0;
    double precio = producto.outPrecioDistribucion ?? 0;
    double subtotal = stock * precio;

    if (producto.moneda == 'USD') {
      totalEnDolares += subtotal; // Total en dólares
      totalEnSoles += subtotal * tipoCambioVenta; // Convertir a soles
    } else if (producto.moneda == 'PEN') {
      totalEnSoles += subtotal; // Total en soles
      totalEnDolares += subtotal / tipoCambioVenta; // Convertir a dólares
    }
  }

  // Retornar totales
  return {
    'TOTAL.PEN': totalEnSoles,
    'TOTAL.USD': totalEnDolares,
    'TOTAL.COMPRAR': cantidadComprar, // Número de productos activos
  };
}


// Este método recibe el valor en dólares y el valor en soles, y genera la gráfica
Widget generarGraficoProgreso({
 required  double valorUSD, required double valorPEN,  double? totalEnSoles, double? totalEnDolares, 
  bool progreess = true,
}) {
   // Convertimos ambos valores a una misma moneda (en este caso, dólares)
  double valorPENenUSD = valorPEN / tipoCambioVenta;
  double totalEnUSD = valorUSD + valorPENenUSD;

  // Si el total es 0, no podemos calcular un progreso, así que evitamos división por 0
  if (totalEnUSD == 0) {
    return SizedBox();
  }

 
  return Column(
    children: [
      if(progreess)
      ProgressValue(valorUSD: valorUSD, valorPEN: valorPEN, totalEnUSD: totalEnUSD, valorPENenUSD: valorPENenUSD),
      if(totalEnSoles != null && totalEnDolares != null)
      SumaTotalWidget(totalEnSoles: totalEnSoles, totalEnDolares: totalEnDolares)     
    ],
  );
}

}



class ProgressValue extends StatelessWidget {
  const ProgressValue({
    super.key,
    required this.valorUSD,
    required this.valorPEN, 
    required this.totalEnUSD, 
    required this.valorPENenUSD
  });

  final double valorUSD;
  final double valorPEN;
  final double totalEnUSD;
  final double valorPENenUSD;


  @override
  Widget build(BuildContext context) {
       // Progresos en porcentaje
  double progresoUSD = valorUSD / totalEnUSD;
  double progresoPEN = valorPENenUSD / totalEnUSD;


  // Definir colores para los distintos rangos
Color colorUSD = Color(0xFF284BAE); // Azul oscuro para USD
Color colorPEN = Color(0xFFE82C81);

    return Column(
      children: [
         
    // Leyenda con el valor de cada moneda
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              // USD
              Container(
                width: 7,
                height: 7,
                color: colorUSD,
              ),
              SizedBox(width: 5),
              P2Text(text: 
                'USD:\n${(progresoUSD * 100).toStringAsFixed(1)}%',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: colorUSD,
                  height: .9,
              ),
              SizedBox(width: 20),
              // PEN
              Container(
              width: 7,
              height: 7,
              color: colorPEN,
              ),
              SizedBox(width: 5),
              P2Text(text: 
                'PEN:\n${(progresoPEN * 100).toStringAsFixed(1)}%',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: colorPEN,
                  height: .9,
              ),
            ],
          ),
    
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: P2Text(text: 
              '\$${valorUSD}',
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: colorUSD.withOpacity(.7),
                  height: .9,
                  maxLines: 1,
                  textAlign: TextAlign.center,
            ),
          ),
          // Fondo de la gráfica (circular)
          Expanded(
            flex: 2,
            child: Container(
              constraints: BoxConstraints(maxWidth: 300),
                padding: const EdgeInsets.all(8.0),
                child: LinearProgressIndicator(
                  minHeight: 5,
                  value: progresoUSD, // Este es el progreso de USD
                  backgroundColor: colorPEN,
                  valueColor: AlwaysStoppedAnimation<Color>(colorUSD),
                ),
              ),
          ),
      
          Expanded(
            child: P2Text(text: 
              'S/.${valorPEN}',
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: colorPEN.withOpacity(.7),
                height: .9,
                  maxLines: 1,
                  textAlign: TextAlign.center,
            ),
          ),
       ]
     ),
      
    ],
         );
  }
}

class SumaTotalWidget extends StatelessWidget {
  const SumaTotalWidget({
    super.key, required this.totalEnSoles, required this.totalEnDolares,
  });
  final double totalEnSoles;
  final double totalEnDolares;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
         // Definir colores para los distintos rangos
         Color spanColor =  Colors.grey;
         Color valueColor = Colors.black87;
        return RichText(
             text: TextSpan(
               style: TextStyle(
                 fontSize: 10, // Tamaño base para el texto
                 color: valueColor,
                 fontWeight: FontWeight.bold,
               ),
               children: [
                // Título con descripción más detallada sobre la conversión
                //  TextSpan(
                //    text: 'Suma Total (100%)\n\n'.toUpperCase(),
                //    style: TextStyle(
                //      fontWeight: FontWeight.bold, // Negrita para el título
                //      fontSize: 10, 
                //      color: Colors.green.shade900,
                //      height: .1
                //    ),
                //  ),
                 // Total en soles
                 TextSpan(
                   text: 'TOTAL PEN:   ',
                   style: TextStyle(
                     color: spanColor,
                     fontSize: 8, 
                   ),
                 ),
                  TextSpan(
                   text: 'S/. ${totalEnSoles.toStringAsFixed(1)}\n',
                 ),
                 // Total en dólares
                 TextSpan(
                   text: 'TOTAL USD:   ',
                   style: TextStyle(
                     color: spanColor,
                     fontSize: 8, 
                   ),
                 ),
                  TextSpan(
                   text: '\$  ${totalEnDolares.toStringAsFixed(1)}',
                 ),
               ],
             ),
           );
      }
    );
  }
}




