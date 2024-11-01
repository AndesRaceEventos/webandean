
// import 'package:flutter_tts/flutter_tts.dart';


// class TextToSpeechService {
//   static final TextToSpeechService _instance = TextToSpeechService._internal();
//   late FlutterTts flutterTts;
//   bool _isTtsEnabled = true; // Variable para controlar el estado del TTS

//   factory TextToSpeechService() {
//     return _instance;
//   }

//   TextToSpeechService._internal() {
//     flutterTts = FlutterTts();
//     initializeTts();
//   }

//   Future<void> initializeTts() async {
//     try {
//       await flutterTts.setSharedInstance(true);
//       await flutterTts.setVolume(1);
//       await flutterTts.setSpeechRate(0.4);
//       await flutterTts.setPitch(1.0);
//       await flutterTts.setLanguage('es-ES');
//       await flutterTts.setIosAudioCategory(
//         IosTextToSpeechAudioCategory.playback,
//         [],
//         IosTextToSpeechAudioMode.defaultMode,
//       );
//       _setHandlers();
//     } catch (e) {
//       print("Error al inicializar TTS: $e");
//     }
//   }

//   void _setHandlers() {
//     flutterTts.setStartHandler(() {
//       print("Playing");
//     });

//     flutterTts.setCompletionHandler(() {
//       print("Complete");
//     });

//     flutterTts.setCancelHandler(() {
//       print("Cancel");
//     });

//     flutterTts.setPauseHandler(() {
//       print("Paused");
//     });

//     flutterTts.setContinueHandler(() {
//       print("Continued");
//     });

//     flutterTts.setErrorHandler((msg) {
//       print("error: $msg");
//     });
//   }

//   Future<void> speak(String text) async {
//     if (!_isTtsEnabled) {
//       print('TTS está desactivado.');
//       return;
//     }

//     try {
//       await flutterTts.stop();
//       await flutterTts.speak(text).then((result) {
//         if (result == 1) {
//           print('Successfully spoke the text.');
//         } else {
//           print('Failed to speak the text.');
//         }
//       });
//     } catch (e) {
//       print('Error during speak: $e');
//     }
//   }
//   //todos:activar o desactivar el TTS globalmente en tu aplicación
//   Future<void> setTtsEnabled(bool isEnabled) async {
//     _isTtsEnabled = isEnabled;
//   }

//   Future<void> stop() async {
//     try {
//       await flutterTts.stop();
//     } catch (e) {
//       print('Error during stop: $e');
//     }
//   }

//   Future<void> pause() async {
//     try {
//       await flutterTts.pause();
//     } catch (e) {
//       print('Error during pause: $e');
//     }
//   }
// }

import 'dart:async'; // Asegúrate de importar dart:async para usar Timer
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechService {
  static final TextToSpeechService _instance = TextToSpeechService._internal();
  late FlutterTts flutterTts;
  bool _isTtsEnabled = true; // Variable para controlar el estado del TTS
  Timer? _speakTimer; // Temporizador para manejar el retraso en la reproducción

  factory TextToSpeechService() {
    return _instance;
  }

  TextToSpeechService._internal() {
    flutterTts = FlutterTts();
    initializeTts();
  }

  Future<void> initializeTts() async {
    try {
      await flutterTts.setSharedInstance(true);
      await flutterTts.setVolume(1);
      await flutterTts.setSpeechRate(0.4);
      await flutterTts.setPitch(1.0);
      await flutterTts.setLanguage('es-ES');
      await flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [],
        IosTextToSpeechAudioMode.defaultMode,
      );
      _setHandlers();
    } catch (e) {
      print("Error al inicializar TTS: $e");
    }
  }

  void _setHandlers() {
    flutterTts.setStartHandler(() {
      print("Playing");
    });

    flutterTts.setCompletionHandler(() {
      print("Complete");
    });

    flutterTts.setCancelHandler(() {
      print("Cancel");
    });

    flutterTts.setPauseHandler(() {
      print("Paused");
    });

    flutterTts.setContinueHandler(() {
      print("Continued");
    });

    flutterTts.setErrorHandler((msg) {
      print("error: $msg");
    });
  }

  Future<void> speak(String text) async {
    if (!_isTtsEnabled) {
      print('TTS está desactivado.');
      return;
    }

    try {
      await flutterTts.stop(); // Detener cualquier reproducción anterior
      _speakTimer?.cancel(); // Cancelar el temporizador anterior

      // Usar un temporizador para retrasar la reproducción del mensaje
      _speakTimer = Timer(Duration(seconds: 1), () async {
        await flutterTts.speak(text).then((result) {
          if (result == 1) {
            print('Successfully spoke the text.');
          } else {
            print('Failed to speak the text.');
          }
        });
      });
    } catch (e) {
      print('Error during speak: $e');
    }
  }

  // Activar o desactivar el TTS globalmente en tu aplicación
  Future<void> setTtsEnabled(bool isEnabled) async {
    _isTtsEnabled = isEnabled;
  }

  Future<void> stop() async {
    try {
      await flutterTts.stop();
    } catch (e) {
      print('Error during stop: $e');
    }
  }

  Future<void> pause() async {
    try {
      await flutterTts.pause();
    } catch (e) {
      print('Error during pause: $e');
    }
  }
}
