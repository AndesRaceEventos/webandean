import 'dart:typed_data';
import 'package:flutter/material.dart';

class FilesProvider with ChangeNotifier {
  Uint8List? _imagen;
  List<Uint8List>? _imagenes;
  Uint8List? _pdf;
  List<Uint8List>? _pdfs;
  Uint8List? _audio;
  List<Uint8List>? _audios;
  Uint8List? _word;
  List<Uint8List>? _words;
  Uint8List? _video;
  List<Uint8List>? _videos;

  // Getters
  Uint8List? get imagen => _imagen;
  List<Uint8List>? get imagenes => _imagenes;
  Uint8List? get pdf => _pdf;
  List<Uint8List>? get pdfs => _pdfs;
  Uint8List? get audio => _audio;
  List<Uint8List>? get audios => _audios;
  Uint8List? get word => _word;
  List<Uint8List>? get words => _words;
  Uint8List? get video => _video;
  List<Uint8List>? get videos => _videos;

  // Setters
  void setImagen(Uint8List? newImage) {
    _imagen = newImage;
    notifyListeners();
  }

  void setImagenes(List<Uint8List>? newImages) {
    _imagenes = newImages;
    notifyListeners();
  }

  void setPdf(Uint8List? newPdf) {
    _pdf = newPdf;
    notifyListeners();
  }

  void setPdfs(List<Uint8List>? newPdfs) {
    _pdfs = newPdfs;
    notifyListeners();
  }

  void setAudio(Uint8List? newAudio) {
    _audio = newAudio;
    notifyListeners();
  }

  void setAudios(List<Uint8List>? newAudios) {
    _audios = newAudios;
    notifyListeners();
  }

  void setWord(Uint8List? newWord) {
    _word = newWord;
    notifyListeners();
  }

  void setWords(List<Uint8List>? newWords) {
    _words = newWords;
    notifyListeners();
  }

  void setVideo(Uint8List? newVideo) {
    _video = newVideo;
    notifyListeners();
  }

  void setVideos(List<Uint8List>? newVideos) {
    _videos = newVideos;
    notifyListeners();
  }

  // Método para limpiar todos los archivos
  void clearAllFiles() {
    _imagen = null;
    _imagenes = null;
    _pdf = null;
    _pdfs = null;
    _audio = null;
    _audios = null;
    _word = null;
    _words = null;
    _video = null;
    _videos = null;
    notifyListeners();
  }
}
