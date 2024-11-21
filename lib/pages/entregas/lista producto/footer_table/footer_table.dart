

import 'package:flutter/material.dart';

import 'package:webandean/model/entregas/model_lista_productos.dart';
import 'package:webandean/utils/export%20/config/config_export.dart';


Widget fotterButonBar({
required dynamic listaProductos,
required List<Map<String, dynamic>> selecteds,
required List<Map<String, dynamic>> sourceOriginal
}) {
  List<TListaEntregaProductosModel> datTable = listaProductos;
    List<TListaEntregaProductosModel> dataSelected = selecteds.map((map){
      print('IMPRIMIR MAP: $map');
      final TListaEntregaProductosModel producto = map['data'];
      return producto;
     }).toList();  

  

// Mapa predeterminado para los campos a incluir en el PDF o Excel
final Map<String, bool> defaultMap = {
  'ID':                           false,//id
  'QR':                           true,//qr                            ==> default
  'NOMBRE':                       true,//nombre                        ==> default
  'ID.ITINERARIO':                true,//ubicacion                     ==> default

  'OBSERVACION':                  false,//categoria_compras   
  'CAND.PAX':                     false,//rotacion
  'CAND.GUIA':                    false,//PROVEEDOR
  'NRO.ITEMS':                    false,
  'ACTIVO':                       false,//active                         ==> default
};

// Función para obtener el valor de una propiedad según el nombre del campo
dynamic getValueFromModel(String key, TListaEntregaProductosModel model) {
  switch (key) {
    case 'ID':                           return model.id;
    case 'QR':                           return model.qr;
    case 'NOMBRE':                       return model.nombre;
    case 'ID.ITINERARIO':                return model.idProgramaApu;
    case 'OBSERVACION':                  return model.observacion;
    case 'CAND.PAX':                     return model.cantidadPax;
    case 'CAND.GUIA':                    return model.cantidadGuia;
    case 'NRO.ITEMS':                    return model.listaProducto?.length ?? 0;
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







           