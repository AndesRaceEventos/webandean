
import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:webandean/utils/colors/assets_colors.dart';


import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/layuot/assets_circularprogrees.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:webandean/widget/htmldowloader/html_screenshot_dowl.dart';

class QrGeneratePage extends StatelessWidget {
  const QrGeneratePage({
    super.key,
    required this.id,
    required this.qr,
  });

  final String id;
  final String qr;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton.small(
        child: Icon(Icons.close, color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: ()=> Navigator.pop(context)),
      body: QrGenerateWidget(
        id: id,
        qr: qr,
      ),
    );
  }
}

class QrGenerateWidget extends StatefulWidget {
  const QrGenerateWidget({
    super.key,
    required this.id,
    required this.qr,
  });

  final String id;
  final String qr;


  @override
  State<QrGenerateWidget> createState() => _QrGenerateWidgetState();
}

class _QrGenerateWidgetState extends State<QrGenerateWidget> {
  ScreenshotController screenshotController = ScreenshotController();
  
  String qrDataString = '';

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    qrDataString = '${widget.id}|${widget.qr}';
  }
  
  Future<Widget> buildQrCode() async {
    // final qrDataString = '${widget.id}|${widget.numeroSerie}';

    final qrPainter = QrPainter(
      data: qrDataString, //data guardad en qr 
      version: QrVersions.auto,
      embeddedImageStyle: const QrEmbeddedImageStyle(size: Size(70, 30)),
      eyeStyle: QrEyeStyle(color: Colors.black, eyeShape: QrEyeShape.square),
    );

    final qrWidget = RepaintBoundary(
      child: CustomPaint(
        painter: qrPainter,
        size: const Size(250, 250),
        child: Container(
          height: 250,
          width: 250,
          // child: QrChildTest(widget: widget),
        ),
      ),
    );
  
    //VALOR RETORNADO
    return  Container(
      width: 350,
      margin: EdgeInsets.all(10),
      padding:  EdgeInsets.all(20),
      decoration: AssetDecorationBox().decorationBorder(),
      child: Column(
        children: [
          H2Text( text: widget.qr, selectable: true),
          P3Text(text: widget.id, selectable:  true, maxLines: 1),
          SizedBox(height: 10),
          if(qrDataString != '')
          qrWidget,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Center(
        child: FutureBuilder<Widget>(
          future: buildQrCode(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Screenshot(
                    controller: screenshotController,
                    child: snapshot.data ?? Container(),
                  ),
                  Container(
                    width: 150,
                    decoration: AssetDecorationBox().borderdecoration(color: Colors.blue),
                    child:   TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          P2Text( text:'Descargar'),
                          isLoading ? AssetsCircularProgreesIndicator(): Icon( Icons.download),
                        ],
                      ),
                      onPressed: isLoading ? null : _captureAndSaveImage,
                    ) 
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
    );
  }


  
  Future<void> _captureAndSaveImage() async {
    
    //Uint8List
    final image = await screenshotController.capture().timeout(Duration(seconds: 10));
    
    if (image == null) {
      TextToSpeechService().speak('No se pudo capturar la imagen.');
    }
    TextToSpeechService().speak('Imagen Capturada');
    setState(() {
      isLoading = true;
    });
    if (image != null) {
    
      //metodo para descargar la imagen
     screenShotCaptrueDowloader(qrDataString: qrDataString, image: image);

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.green,
          content: P3Text(
            text: 'Imagen guardada en tu dispositivo.',
            textAlign: TextAlign.center,
            color: AppColors.backgroundDark,
          ),
        ),
      );
    }
  }


}

// //WIDGET EMBEBVIDO DENTRO DEL QR
// class QrChildTest extends StatelessWidget {
//   const QrChildTest({
//     super.key,
//     required this.widget,
//   });

//   final PageQrGenerateRunner widget;

//   @override
//   Widget build(BuildContext context) {
//     //ES Neseario que este en u nstack para posicioanr dentro del QR
//     return Stack(
//       children: [
//         Align(
//           alignment: Alignment.bottomRight,
//           child: Container(
//             width: 40,
//             height: 40,
//             child: FittedBox(
//               child: Image.asset(AppImages.placeholder300),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

