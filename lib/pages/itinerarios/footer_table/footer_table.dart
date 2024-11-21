

import 'package:flutter/material.dart';
import 'package:webandean/utils/export%20/config/config_export.dart';

import 'package:webandean/model/itinerarios/model_itinerario_programa_apu.dart';



Widget fotterButonBar({
required dynamic listaProductos,
required List<Map<String, dynamic>> selecteds,
required List<Map<String, dynamic>> sourceOriginal
}) {
  List<TItinerioApuModel> datTable = listaProductos;
    List<TItinerioApuModel> dataSelected = selecteds.map((map){
      print('IMPRIMIR MAP: $map');
      final TItinerioApuModel producto = map['data'];
      return producto;
     }).toList();  

  

// Mapa predeterminado para los campos a incluir en el PDF o Excel
final Map<String, bool> defaultMap = {
  'ID':                           false,//id
  'QR':                           true,//qr                            ==> default
  'NOMBRE':                       true,//nombre                        ==> default
  'ITINERARIO':                   true,//ubicacion                     ==> default
  'TIPO SALIDA':                  true,  
  'DIAS':                         true,
  'NOCHES':                       true,

  'CHILLCA NIGHT':                true,
  'MACHU  NIGHT':                 true,
  'ANANTA NIGHT':                 true,
  'HUAMPO NIGHT':                 true,
 
  'OBSERVACION':                  false,//categoria_compras   
  'ACTIVO':                       false,//active                         ==> default
};

// Función para obtener el valor de una propiedad según el nombre del campo
dynamic getValueFromModel(String key, TItinerioApuModel model) {
  switch (key) {
    case 'ID':                           return model.id;
    case 'QR':                           return model.qr;
    case 'NOMBRE':                       return model.nombre;
    case 'ITINERARIO':                   return model.itinerario;
    case 'TIPO SALIDA':                  return model.tipoDesalida;
    case 'DIAS':                         return model.dias;
    case 'NOCHES':                       return model.noches;
    case 'CHILLCA NIGHT':                return model.chillcaNight;
    case 'MACHU  NIGHT':                 return model.machuNight;
    case 'ANANTA NIGHT':                 return model.anantaNight;
    case 'HUAMPO NIGHT':                 return model.huampoNight;
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







           