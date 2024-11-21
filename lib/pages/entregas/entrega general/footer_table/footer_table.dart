

import 'package:flutter/material.dart';
import 'package:webandean/model/entregas/model_entregas_general.dart';
import 'package:webandean/utils/export%20/config/config_export.dart';

// import 'package:webandean/model/entregas/model_lista_equipos.dart';


Widget fotterButonBar({
required dynamic listaProductos,
required List<Map<String, dynamic>> selecteds,
required List<Map<String, dynamic>> sourceOriginal
}) {
  List<TEntregasModel> datTable = listaProductos;
    List<TEntregasModel> dataSelected = selecteds.map((map){
      print('IMPRIMIR MAP: $map');
      final TEntregasModel producto = map['data'];
      return producto;
     }).toList();  

  

// Mapa predeterminado para los campos a incluir en el PDF o Excel
final Map<String, bool> defaultMap = {
  'ID':                           false,//id
  'QR':                           true,//qr                            ==> default
  'NOMBRE':                       true,
  'ID.RESERVA':                   true,
  'ID.PERSONAL':                  true,
  'ID.LISTA PRODUCTOS':           true,
  'ID.LISTA EQUIPOS':             true,
  'NRO.ITEMS PRODUCTOS':          true,
  'NRO.ITEMS EQUIPOS':            true,


  'OBSERVACION':                  false,//categoria_compras  
  'ACTIVO':                       false,//active                         ==> default
};

// Función para obtener el valor de una propiedad según el nombre del campo
dynamic getValueFromModel(String key, TEntregasModel model) {
  switch (key) {
    case 'ID':                           return model.id;
    case 'QR':                           return model.qr;
    case 'NOMBRE':                       return model.nombre;
    case 'ID.RESERVA':                   return model.idReserva;
    case 'ID.PERSONAL':                  return model.idPersonal;
    case 'ID.LISTA PRODUCTOS':           return model.idListaCompra;
    case 'ID.LISTA EQUIPOS':             return model.idListaEquipos;

    case 'NRO.ITEMS PRODUCTOS':          return model.listaProducto?.length ?? 0;
    case 'NRO.ITEMS EQUIPOS':            return model.listaEquipos?.length ?? 0;
    case 'OBSERVACION':                  return model.observacion;
    case 'ACTIVO':                       return model.active;
    default:                             return null;
  }
}

return FooterExport(
    datTable: datTable, 
    dataSelected: dataSelected, 
    defaultMap: defaultMap, 
    getValueFromModel: (String key, model) {
      return getValueFromModel(key, model);
    },
  );
}







           