import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:webandean/provider/cache/qr_lector/qr_lector_provider.dart';
import 'package:webandean/utils/formulario/formfield_customs.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class QrCameraLector extends StatefulWidget {
  const QrCameraLector({super.key});

  @override
  State<QrCameraLector> createState() => _QrCameraLectorState();
}

class _QrCameraLectorState extends State<QrCameraLector> {
  late QrLectorProvider _qrData; // Variable para almacenar el Provider

  @override
  void initState() {
    super.initState();
    // Almacena la referencia al provider para no depender de context en dispose()
    _qrData = Provider.of<QrLectorProvider>(context, listen: false);
  }

  @override
  void dispose() {
    // Limpia el controlador sin usar el context directamente
    _qrData.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qrData = Provider.of<QrLectorProvider>(context);
    final listaProducto = qrData.dataResult;
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.all(10),
      constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
      decoration: AssetDecorationBox().decorationBorder(color: Colors.grey.shade200),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
            Align(
            alignment: Alignment.center,
             child: Container(
                  color: Colors.white30,
                  margin: EdgeInsets.only(top: 60),
                  child: qrData.isCameraActive
                ? Icon(Icons.videocam_off_outlined,
                    color: Colors.grey.shade400, size: 150)
                : MobileScanner(
                      fit: BoxFit.fitHeight,
                      controller: qrData.controller,
                      placeholderBuilder: (context, child) =>_widgetBuilderLoading(),
                      errorBuilder: (context, exception, child) => _widgetBuilderCamera(exception),
                      onDetect: (BarcodeCapture barcodeCapture) {
                        if (barcodeCapture.barcodes.isNotEmpty) {
                          final barcode = barcodeCapture.barcodes.first;
                          qrData.setQrCode(barcode.rawValue);
                        }
                      },
                    ),
                ),
           ),
          Align(
            alignment: Alignment.topCenter,
            child: FormWidgets(context).autocomleteSearchList(
              listaProducto: listaProducto,
              getName: (producto) => producto.nombre,
              getQr: (producto) => producto.qr,
              getId: (producto) => producto.id,
              getField: (producto, query) {
                return producto.nombre.toLowerCase().contains(query) ||
                       producto.qr.toLowerCase().contains(query) ||
                       producto.id.toLowerCase().contains(query);
              }, 
            ),
          ),
          // Añadir botones de control de la cámara
          Align(
            alignment: Alignment.bottomRight,
            child: Opacity(
              opacity: .8,
              child: Container(
                decoration: AssetDecorationBox().decorationBox(),
                padding: EdgeInsets.symmetric(vertical:5, horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    qrData.setQrCode('95thxx71batve90|27320032');
                    // qrData.toggleCamera();
                  },
                  child: P3Text(
                    text: qrData.isCameraActive
                        ? 'Iniciar cámara'
                        : 'Detener cámara',
                   fontWeight: FontWeight.bold,
                   color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
         
        ],
      ),
    );
  }

 

  Widget _widgetBuilderLoading() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.videocam, color: Colors.grey.shade400, size: 150),
        CircularProgressIndicator(),
      ],
    );
  }

  Widget _widgetBuilderCamera(MobileScannerException exception) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.videocam_off_outlined,
            color: Colors.grey.shade400, size: 150),
        P3Text(
          text:
              'Error al iniciar el escáner: \n${exception.errorDetails?.message ?? exception.toString()}',
          textAlign: TextAlign.center,
          color: Colors.red.shade400,
        ),
      ],
    );
  }
}
