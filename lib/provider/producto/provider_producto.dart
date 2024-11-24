import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/poketbase/producto/poketbase_producto.dart';
import 'package:webandean/utils/exeption/exeption_try_cath.dart';
import 'package:webandean/utils/responsiveTable/speack_ramdon/speack_random.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/validation/assets_verifi_field.dart';

class TProductosAppProvider with ChangeNotifier {

  String eventAction = '';
  String collectionName = TProductosApp.collectionName;

  List<TProductosAppModel> listProductos = [];

  TProductosAppProvider() {
    print('$collectionName Inicializado');
    getProvider();
    realtime();
  }

  void addSet(TProductosAppModel e) {
    listProductos.add(e);
    notifyListeners();
  }

  void updateSet(TProductosAppModel e) {
    listProductos[listProductos.indexWhere((x) => x.id == e.id)] = e;
    notifyListeners();
  }

  void removeSet(TProductosAppModel e) {
    listProductos.removeWhere((x) => x.id == e.id);
    notifyListeners();
  }

 Future<void> realtime() async {
  TProductosApp.realTimeToPocketbase((event) {
    // Procesar la respuesta para convertirla en TProductosAppModel
    List<TProductosAppModel> productos = TProductosApp.processResponse([event.record!]);

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
    final options = TProductosApp.getToPoketbase(filter: filter, expand: expand, sort: sort);

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
    List<TProductosAppModel> productos = TProductosApp.processResponse(response);
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
    List<TProductosAppModel>? listaMarcas,
    //IMAGES
    List<Uint8List>? fileImagen,
    List<Uint8List>? filePdf,
    //DOCUMENTOS
    required List<String> imgString,
    required List<String> pdfString,

    //Generico
    required String? id,
    required String qr,
    required String categoriaCompras,
    required String categoriaInventario,
    required String ubicacion,
    required List<String> proveedor,
    required String rotacion,
    required String nombre,
    required String intUndMedida,
    required String outUndMedida,
    required double intPrecioCompra,
    required double outPrecioDistribucion,
    required String? idMenu,
    required String tipo,
    required DateTime fechaVencimiento,
    required String estado,
    required String demanda,
    required String condicionAlmacenamiento,
    required String formato,
    required String tipoPrecio,
    required String durabilidad,
    required String proveeduria,
    required String presentacionVisual,
    required String embaseAmbiental,
    required String responsabilidadAmbiental,
    required double cantidadEnStock,
    required double cantidadCritica,
    required double cantidadOptima,
    required double cantidadMaxima,
    required double cantidadMalogrados,
    required String observacion,
    required String moneda,
    required bool active,

  }) async {
    isSyncing = true;
    notifyListeners();
     await ExceptionClass.tryCathCustom(
      task: () async {
         TProductosAppModel data = TProductosAppModel(
        id: id ?? '',
        qr: qr,
        categoriaCompras: categoriaCompras,
        categoriaInventario: categoriaInventario,
        ubicacion: ubicacion,
        proveedor: proveedor,
        rotacion: rotacion,
        nombre: nombre,
        listaMarcas: listaMarcas,
        intUndMedida: intUndMedida,
        outUndMedida: outUndMedida,
        intPrecioCompra: intPrecioCompra,
        outPrecioDistribucion: outPrecioDistribucion,
        idMenu: idMenu ?? "",
        tipo: tipo,
        fechaVencimiento: fechaVencimiento,
        estado: estado,
        demanda: demanda,
        condicionAlmacenamiento: condicionAlmacenamiento,
        formato: formato,
        tipoPrecio: tipoPrecio,
        durabilidad: durabilidad,
        proveeduria: proveeduria,
        presentacionVisual: presentacionVisual,
        embaseAmbiental: embaseAmbiental,
        responsabilidadAmbiental: responsabilidadAmbiental,
        cantidadEnStock: cantidadEnStock,
        cantidadCritica: cantidadCritica,
        cantidadOptima: cantidadOptima,
        cantidadMaxima: cantidadMaxima,
        cantidadMalogrados: cantidadMalogrados,
        
        observacion: observacion,
        // html: html,
        moneda: moneda,
        active: active,
        
        imagen: imgString,
        pdf: pdfString,
      );
      // Determinar si es creación o actualización
       final isCreating = data.id == null || data.id.isEmpty;
          // Guardar con POST o PUT según corresponda
          final operation = isCreating
          ? TProductosApp.postToPoketbase(data: data, imagenes: fileImagen, pdfs: filePdf)
          : TProductosApp.putToPoketbase(id: data.id, data: data, imagenes: fileImagen, pdfs: filePdf);
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
    List<TProductosAppModel>? listaMarcas,
    //IMAGES
    List<Uint8List>? fileImagen,
     List<Uint8List>? filePdf,
    //DOCUMENTOS
  required TProductosAppModel data,
  }) async {
      isSyncing = true;
      notifyListeners();
      print('JSON Data: ${data.toJson()}');
      await ExceptionClass.tryCathCustom(
        task: () async {
          final isCreating = data.id == null || data.id.isEmpty;
          // Guardar con POST o PUT según corresponda
          final operation = isCreating
          ? TProductosApp.postToPoketbase(data: data , imagenes: fileImagen, pdfs: filePdf)
          : TProductosApp.putToPoketbase(id: data.id, data: data, imagenes: fileImagen, pdfs: filePdf );
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
        final operation = TProductosApp.deleteToPoketbase(id: id);

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
  Map<String, List<TProductosAppModel>> groupByDistance({
    required List<TProductosAppModel> listData, required String fieldName}) {
    Map<String, List<TProductosAppModel>> groupedData = {};

    String value;

    for (var e in listData) {
      switch (fieldName) {
        //string 
        case 'CATEGORIA_COMPRAS': value = ValidationField().getField(e.categoriaCompras); break;
        case 'CATEGORIA_INVENTARIO': value = ValidationField().getField(e.categoriaInventario); break;
        case 'UBICACION': value = ValidationField().getField(e.ubicacion); break;
        case 'ROTACION': value = ValidationField().getField(e.rotacion); break;
        case 'TIPO': value = ValidationField().getField(e.tipo);  break;
        case 'ESTADO': value = ValidationField().getField(e.estado);  break;
        case 'DEMANDA': value = ValidationField().getField(e.demanda); break;
        case 'CONDICION_ALMACENAMIENTO': value = ValidationField().getField(e.condicionAlmacenamiento); break;
        case 'FORMATO': value = ValidationField().getField(e.formato); break;
        case 'TIPO_PRECIO': value = ValidationField().getField(e.tipoPrecio); break;
        case 'DURABILIDAD': value = ValidationField().getField(e.durabilidad); break;
        case 'PROVEEDURIA': value = ValidationField().getField(e.proveeduria); break;
        case 'PRESENTACION_VISUAL': value = ValidationField().getField(e.presentacionVisual); break;
        case 'EMBASE_AMBIENTAL': value = ValidationField().getField(e.embaseAmbiental); break;
        case 'RESPONSABILIDAD_AMBIENTAL': value = ValidationField().getField(e.responsabilidadAmbiental); break;
        case 'MONEDA': value = ValidationField().getField(e.moneda); break;
        //bool 
        case 'ACTIVE': value = ValidationField().getFieldBool(estado: e.active!, textTrue: 'ACTIVO', textFalse: 'INACTIVO'); break;
       //Date time 
        case 'F.VENCIMIENTO_MENSUAL': value = ValidationField().getMonthGroup(e.fechaVencimiento); break;
        case 'F.VENCIMIENTO_ANUAL': value = ValidationField().getYearGroup(e.fechaVencimiento); break;
        //number rangue
        case 'RANGO_PRECIO_COMPRA': value = ValidationField().getLabeledPriceRange( e.intPrecioCompra, e.moneda); break;
        case 'RANGO_PRECIO_DISTRIBUCION': value = ValidationField().getLabeledPriceRange( e.outPrecioDistribucion, e.moneda); break;
        case 'RANGO_STOCK': value = ValidationField().getLabeledPriceRange(e.cantidadEnStock, ''); break;
        //ListString: Agrupamos por cada proveedor en la lista
        case 'PROVEEDOR':
          for (var proveedor in e.proveedor) {
            value = ValidationField().getField(proveedor);
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
  List<TProductosAppModel> filteredData = [];
  String searchText = '';

  void setSearchText(String text, List<TProductosAppModel> listData) {
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
  bool filterByFields({required String value, required TProductosAppModel data}) {
    List<String?> fields = [
      data.qr, 
      data.categoriaCompras, 
      data.categoriaInventario, 
      data.ubicacion, 
      data.proveedor.join(', '), //list<String>
      data.rotacion, 
      data.nombre, 
      data.observacion, 
      data.moneda
      ];
    return fields.any((field) => field.toString().toLowerCase().contains(value.toString().toLowerCase()));
  }

  void clearSearch(List<TProductosAppModel> listData) {
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
