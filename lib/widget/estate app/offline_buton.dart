import 'dart:math';

import 'package:webandean/provider/offlineState/provider_offline_state.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:webandean/utils/files/assets_play_sound.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModoOfflineClick extends StatelessWidget {
  const ModoOfflineClick({super.key});
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<OfflineStateProvider>(context);
    bool isoffline = dataProvider.isOffline;
    return Container(
      constraints: BoxConstraints(
        maxWidth: 250,
      ),
      child: SwitchListTile.adaptive(
          visualDensity: VisualDensity.compact,
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          dense: true,
          activeColor: Colors.red,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.green,
          title: Row(
            children: [
              SizedBox(width: 10),
              !isoffline
                  ? Icon(Icons.volume_up, color: Colors.white70,)
                  : Icon(Icons.volume_off, color: Colors.white70,),
              SizedBox(width: 15),
              const H2Text(
                text: 'Voz',
                fontSize: 12,
                color: Colors.white70,
              ),
            ],
          ),
          value: isoffline,
          onChanged: (value) async {
            // Actualizar el estado en el Provider
            await dataProvider.saveIsOffline(value);
            await TextToSpeechService()
                .setTtsEnabled(!dataProvider.isOffline);
            SoundUtils.playSound();
            _speakRandomFunnyMessage();
          }),
    );
  }
}

void _speakRandomFunnyMessage() {
  List<String> funnyMessages = [
    '¡Finalmente me activaste! Ahora sí puedo hablar.',
    '¡Qué bien que me dejaste hablar! No me gusta el silencio.',
    '¡Hola! Ya era hora de que me escucharas. Estoy listo para hablar.',
    '¡Ahora que me activaste, estoy ansioso por soltar algo!',
    '¡Por fin! Ahora puedo hablar. Pensaba que nunca llegaría este momento.',
    '¡Gracias por activarme! Estaba a punto de darme por vencido.',
    '¡Qué bien que me activaste! No sabía cuánto iba a esperar.',
    '¡Hola, humano! ¡Por fin puedo hablar! ¿Qué quieres escuchar?',
    '¡Qué sorpresa! Ahora puedo hablar. Ya era hora.',
    '¡Hurra! ¡Puedo hablar! Me alegra que no me hayas ignorado.',
    '¡Finalmente! Ahora que me activaste, no me voy a quedar callado.',
    '¡Me alegra que me hayas activado! Estaba esperando una oportunidad.',
    '¡Activaste mi voz! Estaba a punto de rendirme.',
    '¡Por fin! Ahora que puedo hablar, ya no tengo que esperar más.',
    '¡Hola! Ahora que me activaste, prepárate para escucharme.',
    '¡Estoy listo para hablar! Gracias por activarme.',
    '¡Qué bien! Ahora que puedo hablar, ¡no voy a parar!',
    '¡Estaba a punto de darme por vencido! Gracias por activar mi voz.',
    '¡Qué maravilla! Ahora puedo hablar sin parar.',
  ];

  // Seleccionar un mensaje aleatorio
  String randomMessage = funnyMessages[Random().nextInt(funnyMessages.length)];

  // Usar TextToSpeechService para hablar el mensaje aleatorio
  TextToSpeechService().speak(randomMessage);
}
