//GENRAR DATA SUPR IMPORTANTE : ESPECIFICOS
import 'package:flutter/material.dart';
import 'package:webandean/utils/responsiveTable/speack_ramdon/speack_random.dart';

import 'package:webandean/provider/personal/provider_personal.dart';
import 'package:webandean/model/personal/model_personal_apu.dart';

class DataUtils {
  final List<Map<String, dynamic>> sourceOriginal;

  DataUtils(this.sourceOriginal);

  // Aplica el filtro a los datos originales basado en el valor proporcionado
  List<Map<String, dynamic>> applyFilter(String? searchText) {
    // Si el valor de búsqueda está vacío o es nulo, retorna todos los datos originales
    //  TProductosAppModel producto =  sourceOriginal['data'];
    print(sourceOriginal);
    if (searchText == "" || searchText == null) {
      SpeackRamdom().speakRandomMessage();
      return sourceOriginal;
    } else {
      final filteredData = sourceOriginal.where((data) {
        TPersonalApuModel e = data['data'];
        return TPersonalAppProvider().filterByFields(value: searchText, data: e);
        //todos Es lo que equivale
        //  return fields.any((field) => field
        // .toString()
        // .toLowerCase()
        // .contains(value.toString().toLowerCase()));

      }).toList();

      SpeackRamdom().speakCountResults(filteredData.length, searchText);

      return filteredData;
    }
  }
  

}

List<Map<String, dynamic>> generateData(dynamic dataParticipantes) {
  List<TPersonalApuModel> dataTable = dataParticipantes;
  List<Map<String, dynamic>> temps = [];

  for (var e in dataTable) {
    temps.add({
      //Importante : check box table
      "id": e.id,
      //HEADER encabezados DE TABLA
      "qr": e.qr,
      "nombre": e.nombre,
      "idRol": e.idRol,
      "observacion": e.observacion,
      "active": e.active,
      //BARRA PROGRESO
      "progress": [],
      //ALL DATA
      "data": e, //TODOs la data
    });
  }
  return temps;
}

// Define la lista de encabezados
List<Map<String, dynamic>> get headerData => [
      {
        'header': 'Nombre', 
        'value': 'nombre', 
        'icon': Icons.wysiwyg_outlined
      },
     {
        'header': 'observacion',
        'value': 'observacion',
        'icon': Icons.text_fields_sharp
      },
      {
        'header': 'SERIE',
        'value': 'qr',
        'icon': Icons.qr_code 
      },
       {
        'header': 'ROL',
        'value': 'idRol',
        'icon': Icons.card_travel_rounded
      },
      
      {
        'header': 'ESTADO',
        'value': 'active',
        'icon': Icons.check_circle_outline_rounded
      },
      
    ];
