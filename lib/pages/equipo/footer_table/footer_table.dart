
  import 'package:flutter/material.dart';
import 'package:webandean/model/equipo/model_equipo.dart';
import 'package:webandean/utils/export%20/config/config_export.dart';


Widget fotterButonBar({
  required dynamic listaProductos,
  required List<Map<String, dynamic>> selecteds,
  required List<Map<String, dynamic>> sourceOriginal
  }) 
  {
    List<TEquiposAppModel> datTable = listaProductos;
      
    List<TEquiposAppModel> dataSelected = selecteds.map((map){
      print('IMPRIMIR MAP: $map');
      final TEquiposAppModel producto = map['data'];
      return producto;
    }).toList();  

// Mapa predeterminado para los campos a incluir en el PDF o Excel
final Map<String, bool> defaultMap = {
  'ID':                         false, // id
  
  'QR':                         true,  // qr ==> default
  'NOMBRE':                     true,  // nombre ==> default
  'CATEGORIA':                  true, // categoria
  'PROPIETARIO':                false,  // propietario
  'UBICACION':                  true,  // ubicacion ==> default
  
  'UND M.COMPRA':               true,  // intUndMedida ==> default
  'UND M.DISTRBUCIÓN':          false, // outUndMedida
  'MONEDA':                     true,  // moneda ==> default
  
  'PRECIO M.COMPRA':            true,  // intPrecioCompra ==> default
  'PRECIO M.DISTRBUCIÓN':       false, // outPrecioDistribucion ==> default
  'CAND.STOCK':                 true,  // cantidadEnStock ==> default
  'CAND.MALOGRADOS':            false, // cantidadMalogrados
  'CAND.CRITICA':               false, // cantidadCritica
  'CAND.OPTIMA':                false, // cantidadOptima
  'CAND.MAXIMA':                false, // cantidadMaxima
  
  'F.ADQUISICION':              false,  // fechaAdquisicion ==> default
  'F.ULTIMOMANTENIMIENTO':      false,  // fechaUltimoMantenimiento ==> default
  'F.PROX.MANTENIMIENTO':       false,  // fechaProximoMantenimiento ==> default
  'F.RETIRO':                   false,  // fechaRetiro ==> default
  
  'OBSERVACION':                false, // observacion
  'VIDA UTIL_AÑOS':             false, // vidaUtilEstimadoAnos
  
  'ESTADO OPERACIONAL':         false, // estadoOperacional
  'COSTO MANTENIMIENTO':        false, // costoMantenimiento
  'DEMANDA':                    false, // demanda
  'TIPO PRECIO':                false, // tipoPrecio
  'PROVEEDURIA':                false, // proveeduria
  'NIVEL USO':                  false, // nivelUso
  'MANTENIMIENTO':              false, // mantenimiento
  'TIPO PROVEEDOR':             false, // tipoProveedor
  'MATERIAL':                   false, // material
  'RIESGO':                     false, // riesgo
  'DURABILIDAD':                false, // durabilidad
  'ORIGEN EQUIPO':              false, // origenEquipo
  'CAPACIDADD CARGA':           false, // capacidadDeCarga
  'DIMENSIONES EQUIPO':         false, // dimensionesEquipo
  'PRECIO RELATIVO':            false, // precioRelativo
  
  'ACTIVO':                     false,  // active ==> default
};



// Función para obtener el valor de una propiedad según el nombre del campo
dynamic getValueFromModel(String key, TEquiposAppModel model) {
  switch (key) {
    case 'ID':                         return model.id;
    
    case 'QR':                         return model.qr;
    case 'CATEGORIA':                  return model.categoria;
    case 'PROPIETARIO':                return model.propietario;
    case 'UBICACION':                  return model.ubicacion;
    case 'NOMBRE':                     return model.nombre;
    
    case 'UND M.COMPRA':               return model.intUndMedida;
    case 'UND M.DISTRBUCIÓN':          return model.outUndMedida;
    case 'MONEDA':                     return model.moneda;
    
    case 'PRECIO M.COMPRA':            return model.intPrecioCompra;
    case 'PRECIO M.DISTRBUCIÓN':       return model.outPrecioDistribucion;
    case 'CAND.STOCK':                 return model.cantidadEnStock;
    case 'CAND.MALOGRADOS':            return model.cantidadMalogrados;
    case 'CAND.CRITICA':               return model.cantidadCritica;
    case 'CAND.OPTIMA':                return model.cantidadOptima;
    case 'CAND.MAXIMA':                return model.cantidadMaxima;
    
    case 'F.ADQUISICION':              return model.fechaAdquisicion;
    case 'F.ULTIMOMANTENIMIENTO':      return model.fechaUltimoMantenimiento;
    case 'F.PROX.MANTENIMIENTO':       return model.fechaProximoMantenimiento;
    case 'F.RETIRO':                   return model.fechaRetiro;
    
    case 'OBSERVACION':                return model.observacion;
    
    case 'ESTADO OPERACIONAL':         return model.estadoOperacional;
    case 'COSTO MANTENIMIENTO':        return model.costoMantenimiento;
    case 'VIDA UTIL_AÑOS':             return model.vidaUtilEstimadoAnos;
    case 'DEMANDA':                    return model.demanda;
    case 'TIPO PRECIO':                return model.tipoPrecio;
    case 'PROVEEDURIA':                return model.proveeduria;
    case 'NIVEL USO':                  return model.nivelUso;
    case 'MANTENIMIENTO':              return model.mantenimiento;
    case 'TIPO PROVEEDOR':             return model.tipoProveedor;
    case 'MATERIAL':                   return model.material;
    case 'RIESGO':                     return model.riesgo;
    case 'DURABILIDAD':                return model.durabilidad;
    case 'ORIGEN EQUIPO':              return model.origenEquipo;
    case 'CAPACIDADD CARGA':           return model.capacidadDeCarga;
    case 'DIMENSIONES EQUIPO':         return model.dimensionesEquipo;
    case 'PRECIO RELATIVO':            return model.precioRelativo;
    
    case 'ACTIVO':                     return model.active;
    
    default:                           return null;
  }
}




    return FooterExport(
    datTable: datTable, 
    dataSelected: dataSelected, 
    defaultMap: defaultMap, 
    getValueFromModel: (String key, model) {
      return getValueFromModel(key, model);
    },);
   
}



