//GENRAR DATA SUPR IMPORTANTE : ESPECIFICOS
import 'package:flutter/material.dart';
import 'package:webandean/model/equipo/model_equipo.dart';
import 'package:webandean/provider/equipo/provider_equipo.dart';
import 'package:webandean/utils/responsiveTable/speack_ramdon/speack_random.dart';

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
        TEquiposAppModel e = data['data'];
        return TEquipoAppProvider().filterByFields(value: searchText, data: e);
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
  List<TEquiposAppModel> dataTable = dataParticipantes;
  List<Map<String, dynamic>> temps = [];

  for (var e in dataTable) {
    temps.add({
      //Importante : check box table
      "id": e.id,
      //HEADER encabezados DE TABLA
      "nombre": e.nombre,
      "categoria": e.categoria,
      "ubicacion": e.ubicacion,
      "qr": e.qr,
      "fechaMantenimiento": e.fechaProximoMantenimiento,
      "cantidadEnStock": e.cantidadEnStock,
      //BARRA PROGRESO
      "progress": [ e.fechaProximoMantenimiento,e.cantidadEnStock, e.cantidadCritica, e.cantidadOptima,e.cantidadMaxima,e.cantidadMalogrados ],
      "colors": e.color,
      //ALL DATA
      "data": e, //TODOs la data
    });
  }
  return temps;
}

// Define la lista de encabezados
List<Map<String, dynamic>> get headerData => [
      {
        'header': 'Categoria',
        'value': 'categoria',
        'icon': Icons.category_outlined
      },
      {
        'header': 'Nombre', 
        'value': 'nombre',
        'icon': Icons.wysiwyg_outlined
      },
      {
        'header': 'Ubicación',
        'value': 'ubicacion',
        'icon': Icons.location_on_outlined
      },
      {
        'header': 'Serie', 
        'value': 'qr', 
        'icon': Icons.qr_code
      },
      {
        'header': 'F.Mantenimiento',
        'value': 'fechaMantenimiento',
        'icon': Icons.date_range
      },
      {
        'header': 'Stock',
        'value': 'cantidadEnStock',
        'icon': Icons.storage_outlined
      },
    ];
