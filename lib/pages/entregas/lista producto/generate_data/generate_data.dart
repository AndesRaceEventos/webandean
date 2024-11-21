//GENRAR DATA SUPR IMPORTANTE : ESPECIFICOS
import 'package:flutter/material.dart';
import 'package:webandean/utils/responsiveTable/speack_ramdon/speack_random.dart';

import 'package:webandean/model/entregas/model_lista_productos.dart';
import 'package:webandean/provider/entregas/provider_lista_producto.dart';


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
        TListaEntregaProductosModel e = data['data'];
        return TListaProductosAppProvider().filterByFields(value: searchText, data: e);
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
  List<TListaEntregaProductosModel> dataTable = dataParticipantes;
  List<Map<String, dynamic>> temps = [];

  for (var e in dataTable) {
    temps.add({
      //Importante : check box table
      "id": e.id,
      //HEADER encabezados DE TABLA
      "qr": e.qr,
      "nombre": e.nombre,
      "idProgramaApu": e.idProgramaApu,
      "observacion": e.observacion,
      "cantidadPax": e.cantidadPax,
      "cantidadGuia": e.cantidadGuia,
      "active": e.active,
      "listaProducto": e.listaProducto?.length ?? 0,
      //BARRA PROGRESO
      // "progress": [ e.fechaVencimiento,e.cantidadEnStock, e.cantidadCritica, e.cantidadOptima,e.cantidadMaxima,e.cantidadMalogrados ],
      "progress": e.listaProducto,
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
        'header': 'Nombre', 
        'value': 'nombre', 
        'icon': Icons.wysiwyg_outlined
      },
      // {
      //   'header': 'ID.ITINERARIO',
      //   'value': 'idProgramaApu',
      //   'icon': Icons.location_on_outlined
      // },
      {
        'header': 'CAND.PAX', 
        'value': 'cantidadPax', 
        'icon': Icons.people_outline
      },
      {
        'header': 'CAND.GUIA',
        'value': 'cantidadGuia',
        'icon': Icons.people
      },
      // {
      //   'header': 'NRO.ITEMS',
      //   'value': 'listaProducto',
      //   'icon': Icons.storage_outlined
      // },
      {
        'header': 'observacion',
        'value': 'observacion',
        'icon': Icons.text_fields_sharp
      },
    ];
