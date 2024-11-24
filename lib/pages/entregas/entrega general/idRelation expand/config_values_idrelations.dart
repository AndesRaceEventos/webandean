import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webandean/model/entregas/model_entregas_general.dart';
import 'package:webandean/model/personal/model_personal_apu.dart';
import 'package:webandean/provider/entregas/provider_entregas_generales.dart';
import 'package:webandean/provider/personal/provider_personal.dart';
import 'package:webandean/model/entregas/model_lista_equipos.dart';
import 'package:webandean/model/entregas/model_lista_productos.dart';
import 'package:webandean/provider/entregas/provider_lista_equipo.dart';
import 'package:webandean/provider/entregas/provider_lista_producto.dart';

void filterAsginalIDRelaions(BuildContext context) {
  //PADRE 
  final entregaProvider = Provider.of<TEntregasAppProvider>(context, listen: false);
  List<TEntregasModel> entregas = entregaProvider.listProductos;

  //HIJOS RELATIONS  
  final dataPersonal = Provider.of<TPersonalAppProvider>(context, listen: false);
  List<TPersonalApuModel> personalList = dataPersonal.listProductos;

  final datalistaEquipo = Provider.of<TListaEquipoAppProvider>(context, listen: false);
  List<TListaEntregaEquiposModel> listaEquipo = datalistaEquipo.listProductos;

  final datalistaProducto = Provider.of<TListaProductosAppProvider>(context, listen: false);
  List<TListaEntregaProductosModel> listaProducto = datalistaProducto.listProductos;

  // Crear mapas para búsquedas rápidas por id
  final Map<String, TPersonalApuModel> personalMap = {
    for (var personal in personalList) personal.id: personal
  };

  final Map<String, TListaEntregaEquiposModel> equipoMap = {
    for (var equipo in listaEquipo) equipo.id: equipo
  };

  final Map<String, TListaEntregaProductosModel> productoMap = {
    for (var producto in listaProducto) producto.id: producto
  };

  // Iterar sobre la lista de entregas y asignar los valores
  for (var entrega in entregas) {
    // Asignar los valores correspondientes a idPersonalValue
    entrega.idPersonalValue = entrega.idPersonal.map((id) => personalMap[id] ?? TPersonalApuModel.defaultValueModel()).toList();

    // Asignar el valor correspondiente a idListaEquiposValue
    entrega.idListaEquiposValue = equipoMap[entrega.idListaEquipos] ?? TListaEntregaEquiposModel.defaultValueModel();

    // Asignar el valor correspondiente a idListaProductosValue
    entrega.idListaProductosValue = productoMap[entrega.idListaCompra] ?? TListaEntregaProductosModel.defaultValueModel();
  }
}
