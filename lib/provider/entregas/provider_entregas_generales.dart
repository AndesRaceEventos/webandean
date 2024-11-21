import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webandean/model/entregas/model_entregas_general.dart';
import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/utils/exeption/exeption_try_cath.dart';
import 'package:webandean/utils/responsiveTable/speack_ramdon/speack_random.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/validation/assets_verifi_field.dart';

import 'package:pocketbase/pocketbase.dart';


import 'package:webandean/poketbase/entregas/poketbase_entregas_general.dart';

import 'package:webandean/model/equipo/model_equipo.dart';
// import 'package:webandean/model/entregas/model_lista_equipos.dart';

class TEntregasAppProvider with ChangeNotifier {

  String eventAction = '';
  String collectionName = TEntregasGApp.collectionName;
 
  List<TEntregasModel> listProductos = [];

  TEntregasAppProvider() {
    print('$collectionName Inicializado');
    getProvider();
    realtime();
  }

  void addSet(TEntregasModel e) {
    listProductos.add(e);
    notifyListeners();
  }

  void updateSet(TEntregasModel e) {
    listProductos[listProductos.indexWhere((x) => x.id == e.id)] = e;
    notifyListeners();
  }

  void removeSet(TEntregasModel e) {
    listProductos.removeWhere((x) => x.id == e.id);
    notifyListeners();
  }

 Future<void> realtime() async {
  TEntregasGApp.realTimeToPocketbase((event) {
    // Procesar la respuesta para convertirla en TProductosAppModel
    List<TEntregasModel> productos = TEntregasGApp.processResponse([event.record!]);

      if (productos.isNotEmpty) {
        final producto = productos.first; // Solo hay un registro en cada evento
        switch (event.action) {
          case 'create': addSet(producto);    break;
          case 'update': updateSet(producto); break;
          case 'delete': removeSet(producto); break;
          default: break;
        }
        print('REALTIME $collectionName -> ${event.action}');
        eventAction = event.action;
        ExceptionClass.actionRealmSpeack(eventAction,producto.nombre);
        notifyListeners();
      }
    });                 
  }

bool hasUpdates = false; // Variable para rastrear si hubo actualizaciones
 //GET.:  Método para obtener Respuesta
 Future<void> getProvider({bool isrethrow = false }) async {
  try {
    // Obtiene la respuesta desde la fuente.
    final options = TEntregasGApp.getToPoketbase(filter: filter, expand: expand, sort: sort);

     List<RecordModel> response = await options.timeout(Duration(minutes: 1), 
        onTimeout: () {
          ExceptionClass.handleTimeout();
          throw TimeoutException('La solicitud ha tardado demasiado tiempo en responder.');
        },
      );

     if (response.isEmpty) {
        ExceptionClass.handleException(Exception(), 'No se obtuvieron registros para tu solicitud. Datos actuales conservados.');
        hasUpdates = false;
        notifyListeners();
        return;// Detenemos el flujo aquí.
      }
    
    // // Si hay productos, se procesan y se actualiza la lista.
    // List<TProductosAppModel> productos = TProductosApp.processResponse(response);
    // listProductos.clear();
    // listProductos.addAll(productos);
    // notifyListeners();
    // Procesa la respuesta y verifica si los datos cambiaron
    List<TEntregasModel> productos = TEntregasGApp.processResponse(response);
    if (listProductos.length != productos.length || !listProductos.toSet().containsAll(productos.toSet())) {
      // Actualiza la lista solo si hay cambios
      listProductos.clear();
      listProductos.addAll(productos);
      hasUpdates = true;
    } else {
      // Si no hubo cambios, marca `hasUpdates` como falso
      hasUpdates = false;
    }
    notifyListeners();
  }  catch (e) {
   // Lanza de nuevo para que `refreshProductos` lo capture si es necesario.
   if(isrethrow) {
     rethrow;
   }
   else {
    print('Erro: $e');
   }
  }
}


bool isRefresh = false;

Future<void> refreshProvider() async {
  if (isRefresh) return; // Evita múltiples llamadas simultáneas.
  isRefresh = true;
  notifyListeners();
  await ExceptionClass.tryCathCustom(
    task: () async {
     await getProvider(isrethrow: true).then((_){
     // Solo lee el mensaje si hubo actualizaciones
        if (hasUpdates) {
          TextToSpeechService().speak('${listProductos.length} registros actualizados');
        } 
     });
    }, 
    onFinally: () {
       isRefresh = false;
       notifyListeners();
  });
}

  //METODOS POST
  bool isSyncing = false;
  Future<void> saveProvider(
    {
    // Context
    required BuildContext context,
    //Coleciones 
    List<TEquiposAppModel>? listaEquipos,
    List<TProductosAppModel>? listaProducto,
    //IMAGES
    Uint8List? fileImagen,
    Uint8List? filePdf,
    //DOCUMENTOS
    required String imgString,
    required String pdfString,

    //Generico
    required String? id,
    required String qr,

    required List<String> idReserva,
    required List<String> idPersonal,
    required String idListaCompra,
    required String idListaEquipos,

    required String observacion,
    required String nombre,
    required bool active,

  }) async {
    isSyncing = true;
    notifyListeners();
     await ExceptionClass.tryCathCustom(
      task: () async {
         TEntregasModel data = TEntregasModel(
        id: id ?? '',
        qr: qr,
        nombre: nombre,
        observacion: observacion,

        listaEquipos: listaEquipos,
        listaProducto: listaProducto,

        idReserva: idReserva,
        idPersonal: idPersonal,
        idListaCompra: idListaCompra,
        idListaEquipos: idListaEquipos,

        // html: html,
        active: active,
        
        imagen: imgString,
        pdf: pdfString,
      );
      // Determinar si es creación o actualización
       final isCreating = data.id == null || data.id.isEmpty;
          // Guardar con POST o PUT según corresponda
          final operation = isCreating
          ? TEntregasGApp.postToPoketbase(data: data, imagen: fileImagen, pdf: filePdf)
          : TEntregasGApp.putToPoketbase(id: data.id, data: data, imagen: fileImagen, pdf: filePdf);
          // Aplicar timeout con manejo interno de errores
          await ExceptionClass().saveExecuteTimeout(
            context: context,
            nombre: data.nombre,
            operation: operation,
            secondsDuration: 60,//const Duration(seconds: 60),
            isCreating: isCreating,
          );

      }, 
      onFinally: (){
        isSyncing = false;
        notifyListeners();
      });
  }

  //Metodo Simplificado 
  Future<void> saveProviderFull({
  // Context
    required BuildContext context,
    //Coleciones 
    // List<TEquiposAppModel>? listaEquipos,
    // List<TProductosAppModel>? listaProducto,
    //IMAGES
    Uint8List? fileImagen,
    Uint8List? filePdf,
    //DOCUMENTOS
  required TEntregasModel data,
  }) async {
      isSyncing = true;
      notifyListeners();
      print('JSON Data: ${data.toJson()}');
      await ExceptionClass.tryCathCustom(
        task: () async {
          final isCreating = data.id == null || data.id.isEmpty;
          // Guardar con POST o PUT según corresponda
          final operation = isCreating
          ? TEntregasGApp.postToPoketbase(data: data , imagen: fileImagen, pdf: filePdf)
          : TEntregasGApp.putToPoketbase(id: data.id, data: data, imagen: fileImagen, pdf: filePdf );
          // Aplicar timeout con manejo interno de errores
          await ExceptionClass().saveExecuteTimeout(
            context: context,
            nombre: data.nombre,
            operation: operation,
            secondsDuration: 60,//const Duration(seconds: 60),
            isCreating: isCreating,
          );
        },
        onFinally: () {
          isSyncing = false;
          notifyListeners();
        },
      );
    }


  bool isDeleted = false;
 Future<void> deleteTProductosApp({required String id, required BuildContext context}) async {
    isDeleted = true;
    notifyListeners();
     await ExceptionClass.tryCathCustom(
      task: () async {
        final operation = TEntregasGApp.deleteToPoketbase(id: id);

       await ExceptionClass().deleteExecuteTimeout(
        context: context, 
        id: id, 
        secondsDuration: 60,//const Duration(seconds: 60),
        operation: operation
        );
       
      }, onFinally: () {
          isDeleted = false;
          notifyListeners();
      },);
  }

  

  // //TODOS CLASIFICACION DE DATOS
  Map<String, List<TEntregasModel>> groupByDistance({required List<TEntregasModel> listData, required String fieldName}) {
    Map<String, List<TEntregasModel>> groupedData = {};
    String value;

    for (var e in listData) {
      switch (fieldName) {
        //string 
        // case 'IDRESERVA': value = ValidationField().getField(e.idReserva); break;
        // case 'IDPERSONAL': value = ValidationField().getField(e.idPersonal); break;

        case 'IDLISTACOMPRA': value = ValidationField().getField(e.idListaCompra); break;
        case 'IDLISTAEQUIPOS': value = ValidationField().getField(e.idListaEquipos); break;
        //bool 
        case 'ACTIVE': value = ValidationField().getFieldBool(estado: e.active, textTrue: 'ACTIVO', textFalse: 'INACTIVO'); break;
       //Date time 
        case 'UPDATED': value = ValidationField().getMonthGroup(e.updated!); break;
        case 'CREATED': value = ValidationField().getMonthGroup(e.created!); break;
        // case 'F.VENCIMIENTO_ANUAL': value = ValidationField().getYearGroup(e.fechaVencimiento); break;
        //number rangue
        // case 'CANTIDADPAX': value = ValidationField().getLabeledPriceRange(e.cantidadPax, ''); break;
        // case 'CANTIDADGUIA': value = ValidationField().getLabeledPriceRange(e.cantidadGuia, ''); break;
         //ListString: Agrupamos por cada proveedor en la lista
        case 'IDRESERVA':
          for (var value in e.idReserva) {
            value = ValidationField().getField(value);
            if (!groupedData.containsKey(value)) {
              groupedData[value] = [];
            }
            groupedData[value]?.add(e);
          }
          continue; // Se utiliza continue en lugar de break para continuar la iteración del for sin repetir el switch.
        
        case 'IDPERSONAL':
          for (var value in e.idPersonal) {
            value = ValidationField().getField(value);
            if (!groupedData.containsKey(value)) {
              groupedData[value] = [];
            }
            groupedData[value]?.add(e);
          }
          continue; // Se utiliza continue en lugar de break para continuar la iteración del for sin repetir el switch.

        default: value = 'Todos';
      }
      if (!groupedData.containsKey(value)) {
        groupedData[value] = [];
      }
      groupedData[value]?.add(e);
    } 
    // Ordenar las claves y sus listas
    final sortedGroupedData = Map.fromEntries(groupedData.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));

    return sortedGroupedData;
  }

  //Busqueda de datos
  List<TEntregasModel> filteredData = [];
  String searchText = '';

  void setSearchText(String text, List<TEntregasModel> listData) {
    if (text == "" || text == null) {
      SpeackRamdom().speakRandomMessage();
    } else {
      searchText = text; // Asigna el texto de búsqueda a la variable de instancia
      filteredData = listData.where((e) => filterByFields(value: searchText, data: e)).toList();
      SpeackRamdom().speakCountResults(filteredData.length, searchText);
    }
    notifyListeners();
  }

  // Método genérico para buscar por múltiples campos
  bool filterByFields({required String value, required TEntregasModel data}) {
    List<String?> fields = [
      data.qr, 
      data.nombre, 
      data.observacion, 
      // data.cantidadPax.toString(), 
      // data.proveedor.join(', '), //list<String>
      ];
    return fields.any((field) => field.toString().toLowerCase().contains(value.toString().toLowerCase()));
  }

  void clearSearch(List<TEntregasModel> listData) {
    searchText = '';
    filteredData = listData;
    notifyListeners();
  }

  ///FILTWR POKETBASE 
   String? filter = '';
   String? sort   = '';
   String? expand = '';
  
  // Métodos auxiliares para ejemp
  List<String> filterslist = []; 
 


// Función de ejemplo para obtener datos de Pocketbase
Map<String, dynamic> getPoketbase() {
   filterslist = showDropdowns.keys.toList();
  return {
    "filter": filterslist,
    "sort": ['-updated','nombre']..addAll(showDropdowns.keys.toList()),
    "expand": ['id_menu'],
  };
}

  void setExpand({String? newExpand}){
    expand = newExpand;
    notifyListeners();
  }

   void setFilter({String? newFilter}){
    filter = newFilter;
    notifyListeners();
  }
  void setSort({String? newSort}){
    sort = newSort;
    notifyListeners();
  }

   void setOptionsPoketbase() async {
    await refreshProvider();
    filter = '';
    sort = '';
    expand = '';
    notifyListeners();
   }


//PARA FORMULARIOS EDITING - y SLECCIONAR OPCIONES 
 // Mapa para manejar la visibilidad de los dropdowns
  Map<String, bool> showDropdowns = {
    'categoria_compras': false,
    'categoria_inventario': false,
    'ubicacion': false,
    'moneda': false,
    'PROVEEDOR': false,
    'tipo': false,
    'rotacion': false,
    'estado': false,
    'demanda': false,
    'condicion_almacenamiento': false,
    'formato': false,
    'tipo_precio': false,
    'durabilidad': false,
    'proveeduria': false,
    'presentacion_visual': false,
    'embase_ambiental': false,
    'responsabilidad_ambiental': false,
    'active':false
  };

   // Método para alternar un dropdown específico
  void toggleDropdown(String key) {
    closeAllDropdowns();
    // Cerrar todos los dropdowns primero
      showDropdowns.forEach((k, v) {
        showDropdowns[k] = false;
      });
      // Luego abrir el dropdown seleccionado
      showDropdowns[key] = true;
    notifyListeners();
  }
  
  // Método para cerrar todos los dropdowns
  void closeAllDropdowns() {
    showDropdowns.updateAll((key, value) => false);
    notifyListeners();
  }
}
