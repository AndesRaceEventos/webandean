import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';

class MenuProvider with ChangeNotifier {
  bool _isVisible = true; // Estado inicial

  bool get isVisible => _isVisible;

  void toggleMenuVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
  ///SELECTED INDEX MENU 
  ////*Provider que maneje la selección del elemento en el menú. 
  ///He creado el SelectedIndexProvider y he ajustado el CardMenuPrincipal para cambiar el color de fondo según el índice seleccionado.
   int _selectedIndex = -1;

  int get selectedIndex => _selectedIndex;

  void selectIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // Notifica a los listeners para actualizar la UI
  }

   ///SELECTED Title MENU PRINCIPAL
   String _selectedTitle = 'Inicio';

  String get selectedTitle => _selectedTitle;

  void selectTitle(String title) {
    _selectedTitle = title;
    notifyListeners(); // Notifica a los listeners para actualizar la UI
  }

  //SVG WIDGET 
   Widget _selectedSvg = AppSvg().home1Svg;

    Widget get selectedSvg => _selectedSvg;

    void selectSvg(Widget svg) {
      _selectedSvg = svg;
      notifyListeners(); // Notifica a los listeners para actualizar la UI
    }

  ///SELECTED Title MENU CATEGORY GRUPBY
   String _selectedTitleGroup = '';

  String get selectedTitleGroup => _selectedTitleGroup;

  void setSelectTitleGroupBy(String title) {
    _selectedTitleGroup = title;
    notifyListeners(); 
  }

  ///Expand Graficas 
   bool _expandeView = false;

  bool get expandeView => _expandeView;

  void setExpandeView(bool expand) {
    _expandeView = expand;
    notifyListeners(); 
  }

  //Option graficas page 
  int _option = 1;

  int get option => _option;

  void setOption(int number) {
    _option = number;
    notifyListeners(); 
  }

  // label grafical position. 
  int labelRotationIndex = 0;

void randomizelabelRotation(List<int> rotations) {
  int newRotation;
    do {
      // Genera un índice aleatorio de la lista de rotaciones
      newRotation = rotations[Random().nextInt(rotations.length)];
    } while (newRotation == labelRotationIndex); // Asegura que el nuevo valor sea diferente

    labelRotationIndex = newRotation; // Asigna el nuevo valor
    notifyListeners(); // Notifica a los oyentes sobre el cambio
  }

}
