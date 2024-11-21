

import 'package:flutter/material.dart';

import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/utils/export%20/config/config_export.dart';


Widget fotterButonBar({
required dynamic listaProductos,
required List<Map<String, dynamic>> selecteds,
required List<Map<String, dynamic>> sourceOriginal
}) {
  List<TProductosAppModel> datTable = listaProductos;
    List<TProductosAppModel> dataSelected = selecteds.map((map){
      print('IMPRIMIR MAP: $map');
      final TProductosAppModel producto = map['data'];
      return producto;
     }).toList();  

  

// Mapa predeterminado para los campos a incluir en el PDF o Excel
final Map<String, bool> defaultMap = {
  'ID':                              false,//id
  'QR':                              true,//qr                            ==> default
  'NOMBRE':                          true,//nombre                        ==> default
  'UBICACIÓN':                       true,//ubicacion                     ==> default

  'Categoría Compras':               false,//categoria_compras   
  'Categoría Inventario':            false,//categoria_inventario  
  'rotacion':                        false,//rotacion
  'PROVEEDOR':                       false,//PROVEEDOR

  'UND M.COMPRA':                    true,//int_und_medida                 ==> default
  'UND M.DISTRBUCIÓN':               false,//out_und_medida                ==> default
  'MONEDA':                          true,//moneda                         ==> default
  'PRECIO M.COMPRA':                 true,//int_precio_compra              ==> default
  'PRECIO M.DISTRBUCIÓN':            false,//out_precio_distribucion       ==> default

  'FECHA VENC.':                     true,//fecha_vencimiento              ==> default

  'CAND.STOCK':                      true,//cantidad_en_stock              ==> default
  'CAND.CRITICA':                    false,//cantidad_critica
  'CAND.OPTIMA':                     false,//cantidad_optima
  'CAND.MAXIMA':                     false,//cantidad_maxima
  'CAND.MALOGRADOS':                 false,//cantidad_malogrados

  'TIPO':                            false,//tipo                          ==> default
  'ESTADO':                          false,//estado 
  'DEMANDA':                         false,//demanda
  'CONDICION ALMACENAMIENTO':        false,//condicion_almacenamiento
  'FORMATO':                         false,//formato
  'TIPO PRECIO':                     false,//tipo_precio
  'DURABILIDAD':                     false,//durabilidad
  'PROVEEDURIA':                     false,//proveeduria
  'PRESENTACIÓN VISUAL':             false,//presentacion_visual
  'EMBASE AMBIENTAL':                false,//embase_ambiental
  'RESPONSABILIDAD AMBIENTAL':       false,//responsabilidad_ambiental
  'OBSERVACION':                     false, // observacion
  'ACTIVO':                          false,//active                         ==> default
};

// Función para obtener el valor de una propiedad según el nombre del campo
dynamic getValueFromModel(String key, TProductosAppModel model) {
  switch (key) {
    case 'ID':                            return model.id;
    case 'QR':                            return model.qr;
    case 'NOMBRE':                        return model.nombre;
    case 'UBICACIÓN':                     return model.ubicacion;
    case 'Categoría Compras':             return model.categoriaCompras;
    case 'Categoría Inventario':          return model.categoriaInventario;
    case 'rotacion':                      return model.rotacion;
    case 'PROVEEDOR':                     return model.proveedor;
    case 'UND M.COMPRA':                  return model.intUndMedida;
    case 'UND M.DISTRBUCIÓN':             return model.outUndMedida;
    case 'PRECIO M.COMPRA':               return model.intPrecioCompra;
    case 'PRECIO M.DISTRBUCIÓN':          return model.outPrecioDistribucion;
    case 'TIPO':                          return model.tipo;
    case 'FECHA VENC.':                   return model.fechaVencimiento;
    case 'ESTADO':                        return model.estado;
    case 'DEMANDA':                       return model.demanda;
    case 'CONDICION ALMACENAMIENTO':      return model.condicionAlmacenamiento;
    case 'FORMATO':                       return model.formato;
    case 'TIPO PRECIO':                   return model.tipoPrecio;
    case 'DURABILIDAD':                   return model.durabilidad;
    case 'PROVEEDURIA':                   return model.proveeduria;
    case 'PRESENTACIÓN VISUAL':           return model.presentacionVisual;
    case 'EMBASE AMBIENTAL':              return model.embaseAmbiental;
    case 'RESPONSABILIDAD AMBIENTAL':     return model.responsabilidadAmbiental;
    case 'CAND.STOCK':                    return model.cantidadEnStock;
    case 'CAND.CRITICA':                  return model.cantidadCritica;
    case 'CAND.OPTIMA':                   return model.cantidadOptima;
    case 'CAND.MAXIMA':                   return model.cantidadMaxima;
    case 'CAND.MALOGRADOS':               return model.cantidadMalogrados;
    case 'MONEDA':                        return model.moneda;
    case 'OBSERVACION':                   return model.observacion;
    case 'ACTIVO':                        return model.active;
    default:                              return null;
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







           