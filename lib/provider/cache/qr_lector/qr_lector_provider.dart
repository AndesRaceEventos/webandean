import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:webandean/pages/producto/editing_forma_p.dart';
import 'package:webandean/provider/producto/provider_producto.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/routes/assets_class_routes_pages.dart';
import 'package:webandean/utils/speack/assets_speack.dart';

class QrLectorProvider with ChangeNotifier {
  //PASO 1:  //Controlador camara  primero iniclaizmaos la camra con controller
  final MobileScannerController controller = MobileScannerController();
  void disposeController() => controller.dispose(); // Limpieza del controlador

  //PASO 2: creame un metodo de activar y desactivar camara.
  // Estado de la cámara (iniciada o detenida)
  bool isCameraActive = false;

  // Método para alternar la cámara entre iniciar y detener
  void toggleCamera() {
    isCameraActive = !isCameraActive;
    if (isCameraActive) {
      controller.stop(); // Detener la cámara
    } else {
      controller.start(); // Iniciar la cámara
    }
    notifyListeners(); // Notificar a los widgets dependientes para que se actualicen
  }

  //PAOS 3: creamos un metodo que lea el codgio qr y lo slamcene en un String.
  //Valor de qr leido
  List<String> scannedCode = [];

  void setQrCode(String? code) {
    resetScannedCode();
    scannedCode = getScannerCodeList(code ?? '');
    notifyListeners();
    print(scannedCode);
    searchSplit(codeValue: scannedCode); //Se busca cuando se scanea
  }

  //Metodo Para dividir, el codigo Scaneado en uan lista
  List<String> getScannerCodeList(String value) {
    if (value != null && value.isNotEmpty) {
      return value.split('|'); // Dividir por el separador "|"
    } else {
      return []; // Retornar lista vacía si no hay código
    }
  }

//ESE TEXTO leido del qr debe poder buscarse en algun tipo de lista.
//PASO 4: para eso creamos un lista general de tipo dynamic. esta lisat sera llamada y se le asignara un tipo de lista de lagun modelo
  List<dynamic> dataResult = []; //LIST de un modelo MODEL

  void setListData(List<dynamic> data) {
    dataResult = data;
    notifyListeners();
    print('RESULTADO DE LIST DATA: ${dataResult.length}');
  }

//PASO 5: creamos un variable que sera un obetito de tipo dynamic que pertenece a un elemnto de lista
  dynamic
      foundData; //este sera el resultado de alacenar el tipo de resultado encontrado a literar la lisat.

  void searchSplit({required List<String> codeValue}) {
    if (codeValue.isNotEmpty) {
      // Usamos un bucle para iterar sobre todos los códigos escaneados
      for (String code in codeValue) {
        print(code);
        try {
          // Buscamos el primer elemento que coincida con el código escaneado
          var isdata = dataResult.firstWhere(
            (data) => data.id == code || data.qr == code,
            orElse: () => throw Exception('id no especificado'),
          );

          if (isdata != null) {
            // Si se encuentra el elemento, lo retornamos
            foundData = isdata;
            notifyListeners();
            TextToSpeechService()
                .speak('QR detectado para ${foundData.nombre}');
          }
        } catch (e) {
          TextToSpeechService().speak('Id valido pero el numero de serie no especificado o incorrecto');
          print('ERROR: $e');
        }
      }
    } else {
      print("La lista de códigos escaneados está vacía.");
    }
  }

  void resetScannedCode() {
    scannedCode = [];
    foundData = null; // Reinicia también el resultado encontrado
    notifyListeners(); // Notifica para que se actualicen los widgets que dependan de estos valores
  }

//FINALMENTE aqu iusaremos el tipo foundData, que sera rebido por un widgte que lo reconocera y dibujara su valorss recibiendo como un dynamic pero transformandolo a nun tipo de dato po ejemplo TproductosModel
  List<RoutesLocalStorage> routes( BuildContext context) {
    //LISTA MENU OPCIONES
    return [
      RoutesLocalStorage(
          icon: AppSvg().productosSvg,
          title: "Productos",
          path: EditPageProductosApp(onSave: () {}, e: foundData),
          content: 'Buscar en Productos',
          lisdata: Provider.of<TProductosAppProvider>(context, listen: false).listProductos),
      RoutesLocalStorage(
        icon: AppSvg().equipoSvg,
        title: "Equipos",
        path: Container(color: const Color.fromARGB(255, 135, 173, 204)),
      ),
      RoutesLocalStorage(
        icon: AppSvg(color: Colors.black).fileSvg,
        title: "Reservas",
        path: Container(color: Colors.green),
      ),
      RoutesLocalStorage(
        icon: AppSvg().analiticSvg,
        title: "Presupuestos",
        path: Container(color: Colors.purple),
      ),
    ];
  }

  

}
