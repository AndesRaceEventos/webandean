

import 'package:flutter/material.dart';
import 'package:webandean/utils/export%20/config/config_export.dart';

import 'package:webandean/model/personal/model_personal_apu.dart';



Widget fotterButonBar({
required dynamic listaProductos,
required List<Map<String, dynamic>> selecteds,
required List<Map<String, dynamic>> sourceOriginal
}) {
  List<TPersonalApuModel> datTable = listaProductos;
    List<TPersonalApuModel> dataSelected = selecteds.map((map){
      print('IMPRIMIR MAP: $map');
      final TPersonalApuModel producto = map['data'];
      return producto;
     }).toList();  

  

// Mapa predeterminado para los campos a incluir en el PDF o Excel
final Map<String, bool> defaultMap = {
  'ID':                           false,//id
  'QR':                           true,//qr                            ==> default
  'NOMBRE':                       true,//nombre                        ==> default
  'ROL':                          true,//ubicacion                     ==> default

  'OBSERVACION':                  false,//categoria_compras   
  'ACTIVO':                       false,//active                         ==> default
};

// Función para obtener el valor de una propiedad según el nombre del campo
dynamic getValueFromModel(String key, TPersonalApuModel model) {
  switch (key) {
    case 'ID':                           return model.id;
    case 'QR':                           return model.qr;
    case 'ROL':                          return model.idRol;
    case 'NOMBRE':                       return model.nombre;
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







           