
import 'dart:typed_data';

import 'package:screenshot/screenshot.dart';

Future<Uint8List?> captureWidget({required ScreenshotController screenshotController}) async {
        // Captura el widget usando la instancia de screenshotController
        final image = await screenshotController.capture();

        if (image != null) {
          return image;
        } else {
          print('No se pudo capturar la imagen del widget.');
          return null;
        }
      }