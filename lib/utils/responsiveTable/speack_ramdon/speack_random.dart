
//EL TEXTO HABLA DE MANERA ALEATORIa

import 'dart:math';

import 'package:webandean/utils/speack/assets_speack.dart';

class SpeackRamdom {
  
void speakRandomMessage() {
  // List of possible messages
  List<String> messages = [
    'No has escrito nada',
    'Parece que olvidaste ingresar algo',
    '¿Te faltó escribir algo?',
    'No veo ningún texto aquí',
    '¿Nada que buscar?',
    'El campo de búsqueda está vacío',
    'Escribe algo para comenzar la búsqueda',
    '¿No hay texto?',
    'El texto está en blanco',
    'Introduce algún valor para continuar'
  ];

  // Select a random message from the list
  final random = Random();
  String selectedMessage = messages[random.nextInt(messages.length)];

  // Speak the selected message
  TextToSpeechService().speak(selectedMessage);
}


void speakCountResults(int resultCount, String searchTerm) {
  // List of random phrases
  List<String> phrases = [
    '$resultCount registros encontrados para "$searchTerm".',
    'Hay $resultCount resultados para tu búsqueda de "$searchTerm".',
    '$searchTerm arrojó $resultCount resultados.',
    'Tu búsqueda de "$searchTerm" tiene $resultCount coincidencias.',
    '$resultCount resultados disponibles para "$searchTerm".',
    'Se han encontrado $resultCount registros con "$searchTerm".',
    'Hemos hallado $resultCount resultados para "$searchTerm".',
    '$searchTerm resultó en $resultCount registros.',
    '$resultCount coincidencias encontradas para "$searchTerm".',
    'Encontramos $resultCount resultados para "$searchTerm".',
  ];

  // Select a random phrase
  String randomMessage = phrases[Random().nextInt(phrases.length)];
    TextToSpeechService().speak(randomMessage);
}

// Function to announce the number of records loaded
void speakTotalRecords(int total, String titlepage) {
  if (total > 0) {
    List<String> positivePhrases = [
      'Se han cargado $total registros en $titlepage.',
      '$total registros han sido cargados en $titlepage.',
      'Se han cargado $total resultados en $titlepage.',
      '$total registros disponibles en la tabla de $titlepage.',
      'Hay $total resultados cargados en $titlepage.',
    ];
    String message = positivePhrases[Random().nextInt(positivePhrases.length)];
    TextToSpeechService().speak(message);
  } else {
    List<String> negativePhrases = [
      'No se han cargado registros en $titlepage.',
      'No hay registros disponibles en $titlepage.',
      'No se han cargado resultados en $titlepage.',
      'No hemos encontrado ningún registro en $titlepage.',
      'No hay datos disponibles en $titlepage.',
    ];
    String message = negativePhrases[Random().nextInt(negativePhrases.length)];
    TextToSpeechService().speak(message);
  }
}


}