//GENRAR DATA SUPR IMPORTANTE : ESPECIFICOS
import 'package:flutter/material.dart';
import 'package:webandean/utils/responsiveTable/speack_ramdon/speack_random.dart';

import 'package:webandean/model/entregas/model_entregas_general.dart';
import 'package:webandean/provider/entregas/provider_entregas_generales.dart';

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
        TEntregasModel e = data['data'];
        return TEntregasAppProvider().filterByFields(value: searchText, data: e);
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
  List<TEntregasModel> dataTable = dataParticipantes;
  List<Map<String, dynamic>> temps = [];

  for (var e in dataTable) {
    temps.add({
      //Importante : check box table
      "id": e.id,
      //HEADER encabezados DE TABLA
      "qr": e.qr,
      "nombre": e.nombre,
      "observacion": e.observacion,
      "idReserva": e.idReserva,
      "idPersonal": e.idPersonal,
      "idListaCompra": [e.idListaCompra],
      "idListaEquipos":[ e.idListaEquipos],

      "active": e.active,
      "listaProducto": e.listaProducto?.length ?? 0,
      "listaEquipos": e.listaEquipos?.length ?? 0,
      //BARRA PROGRESO
      // "progress": [ e.fechaVencimiento,e.cantidadEnStock, e.cantidadCritica, e.cantidadOptima,e.cantidadMaxima,e.cantidadMalogrados ],
      "progress": e.listaEquipos,
      "progress2": e.listaProducto,
      //ALL DATA
      "data": e, //TODOs la data
    });
  }
  return temps;
}

// Define la lista de encabezados
List<Map<String, dynamic>> get headerData => [
      // {
      //   'header': 'SERIE',
      //   'value': 'qr',
      //   'icon': Icons.qr_code 
      // },
      {
        'header': 'Nombre', 
        'value': 'nombre', 
        'icon': Icons.wysiwyg_outlined
      },
      // {
      //   'header': 'ID.RESERVA', 
      //   'value': 'idReserva', 
      //   'icon': Icons.people_outline
      // },
      // {
      //   'header': 'ID.PERSONAL',
      //   'value': 'idPersonal',
      //   'icon': Icons.people
      // },
      // {
      //   'header': 'ID.LISTA PRODUCTO',
      //   'value': 'idListaCompra',
      //   'icon': Icons.storage_outlined
      // },
      //  {
      //   'header': 'ID.LISTA EQUIPO',
      //   'value': 'idListaEquipos',
      //   'icon': Icons.storage_outlined
      // },
      // {
      //   'header': 'observacion',
      //   'value': 'observacion',
      //   'icon': Icons.text_fields_sharp
      // },
    ];
