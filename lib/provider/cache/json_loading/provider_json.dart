

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle; 
import 'package:flutter/material.dart';

class JsonLoadProvider with ChangeNotifier {
  List<String> _options = [];
  String? _optionSeleccionado;
  bool _isLoading = false; // Estado de carga

  List<String> get options => _options;
  String? get optionSeleccionado => _optionSeleccionado;
  bool get isLoading => _isLoading; // Getter para el estado de carga

  // Método para cargar productos desde el JSON
  Future<void> loadJsonData({required String key, required String subKey}) async {
    _isLoading = true; // Iniciar carga
    notifyListeners(); // Notificar a los oyentes

    try {
      final jsonString = await rootBundle.loadString('assets/json/select-field.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Cargar productos desde el JSON
      _options = List<String>.from(jsonData[key][subKey]);
    } catch (error) {
      print('Error loading JSON: $error');
      _options = []; // Limpiar opciones en caso de error 
    } finally {
      _isLoading = false; // Terminar carga
      notifyListeners(); // Notificar a los oyentes
    }
  }

  // Método para seleccionar un producto
  void seleccionarOption(String producto) {
    _optionSeleccionado = producto;
    notifyListeners(); // Notificar a los oyentes sobre el cambio de selección
  }





  ///SCROlLEABLE OPTIONS : IMPORTANTE PARA USAR EL SCROOL DE LAS OPCIONES 
  bool _isScroll = true;

  bool get isScroll => _isScroll;

  // void toggleScroll() {
  //   _isScroll = !_isScroll;
  //   print(_isScroll);
  //   notifyListeners();
  // }

  void setScroll(bool value) {
    _isScroll = value;
    notifyListeners();
  }
}
