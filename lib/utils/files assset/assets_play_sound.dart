import 'package:audioplayers/audioplayers.dart';
// import 'package:vibration/vibration.dart';

class SoundUtils {
  // Instancia persistente de AudioPlayer
  static final AudioPlayer _audioPlayer = AudioPlayer();

  // Reproduce un sonido
  static Future<void> playSound() async {
    // Verifica si el player está en uso y detén cualquier reproducción anterior
    if (_audioPlayer.state == PlayerState.playing) {
      await _audioPlayer.stop();
    }
    await _audioPlayer.play(AssetSource('song/tono.mp3')); // Ruta a tu archivo de sonido
  }

  // Realiza una vibración
  static Future<void> vibrate() async {
    // Verifica si el dispositivo tiene un vibrador antes de intentar vibrar
    // if (await hasVibrator()) {
    //   Vibration.vibrate(duration: 500);
    // }
    await playSound();
  }

  // Verifica si el dispositivo tiene un vibrador
  // static Future<bool> hasVibrator() async {
  //   return (await Vibration.hasVibrator()) ?? false;
  // }
}
