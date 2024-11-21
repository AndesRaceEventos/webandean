//GENRAR DATA SUPR IMPORTANTE : ESPECIFICOS
import 'package:flutter/material.dart';
import 'package:webandean/utils/responsiveTable/speack_ramdon/speack_random.dart';

import 'package:webandean/provider/itinerarios/provider_itinerarios.dart';
import 'package:webandean/model/itinerarios/model_itinerario_programa_apu.dart';

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
        TItinerioApuModel e = data['data'];
        return TItinerariosAppProvider().filterByFields(value: searchText, data: e);
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
  List<TItinerioApuModel> dataTable = dataParticipantes;
  List<Map<String, dynamic>> temps = [];

  for (var e in dataTable) {
    temps.add({
      //Importante : check box table
      "id": e.id,
      //HEADER encabezados DE TABLA
      "qr": e.qr,
      "nombre": e.nombre,
      "itinerario": e.itinerario,
      "tipoDesalida": e.tipoDesalida,
      "observacion": e.observacion,
      "dias": e.dias,
      "noches": e.noches,
      "active": e.active,
      //BARRA PROGRESO
      "progress": {
        "Chillca": {"nights": e.chillcaNight,   "color": Color(0xFF903B4E)}, // Rosa oscuro sobrio
        "Machu":   {"nights": e.machuNight,     "color": Color(0xFF569EAB)},    // Azul petróleo oscuro
        "Ananta":  {"nights": e.anantaNight,    "color": Color(0xFF8F4E9E)},  // Morado intenso
        "Huampo":  {"nights": e.huampoNight,    "color": Color(0xFF487718)},  // Verde jade profundo
      },
      //ALL DATA
      "data": e, //TODOs la data
    });
  }
  return temps;
}

// Define la lista de encabezados
List<Map<String, dynamic>> get headerData => [
      {
        'header': 'SERIE',
        'value': 'qr',
        'icon': Icons.qr_code 
      },
       {
        'header': 'ITINERARIO',
        'value': 'itinerario',
        'icon': Icons.card_travel_rounded
      },
      {
        'header': 'Nombre', 
        'value': 'nombre', 
        'icon': Icons.wysiwyg_outlined
      },
     
      {
        'header': 'TIPO SALIDA', 
        'value': 'tipoDesalida', 
        'icon': Icons.people_outline
      },
      {
        'header': 'DIAS',
        'value': 'dias',
        'icon': Icons.sunny
      },
       {
        'header': 'NOCHES',
        'value': 'noches',
        'icon': Icons.nightlight_round_sharp
      },
      // {
      //   'header': 'observacion',
      //   'value': 'observacion',
      //   'icon': Icons.text_fields_sharp
      // },
    ];
