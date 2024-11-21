import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:webandean/model/equipo/model_equipo.dart';
import 'package:webandean/poketbase/equipo/poketbase_equipo.dart';
import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/utils/exeption/exeption_try_cath.dart';
import 'package:webandean/utils/responsiveTable/speack_ramdon/speack_random.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/validation/assets_verifi_field.dart';

class TEquipoAppProvider with ChangeNotifier {

  String eventAction = '';
  String collectionName = TEquipoApp.collectionName;

  List<TEquiposAppModel> listProductos = [];

  TEquipoAppProvider() {
    print('$collectionName Inicializado');
    getProvider();
    realtime();
  }

  void addSet(TEquiposAppModel e) {
    listProductos.add(e);
    notifyListeners();
  }

  void updateSet(TEquiposAppModel e) {
    listProductos[listProductos.indexWhere((x) => x.id == e.id)] = e;
    notifyListeners();
  }

  void removeSet(TEquiposAppModel e) {
    listProductos.removeWhere((x) => x.id == e.id);
    notifyListeners();
  }

 Future<void> realtime() async {
  TEquipoApp.realTimeToPocketbase((event) {
    // Procesar la respuesta para convertirla en TProductosAppModel
    List<TEquiposAppModel> productos = TEquipoApp.processResponse([event.record!]);

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
    final options = TEquipoApp.getToPoketbase(filter: filter, expand: expand, sort: sort);

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
    List<TEquiposAppModel> productos = TEquipoApp.processResponse(response);
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
    List<TProductosAppModel>? historialMantenimiento,
    //IMAGES
    List<Uint8List>? fileImagen,
    List<Uint8List>? filePdf,
    //DOCUMENTOS
    required List<String> imgString,
    required List<String> pdfString,
    //ID RELTIONS 
    required String idResponsableMantenimiento,

    //Generico
    required String? id,
    required String qr,
    required String categoria,
    required String propietario,
    required String ubicacion,
    required List<String> color,
    // required String rotacion,
    required String nombre,
    required String moneda,
    required String intUndMedida,
    required String outUndMedida,
    required double intPrecioCompra,
    required double outPrecioDistribucion,
    required double cantidadEnStock,
    required double cantidadCritica,
    required double cantidadOptima,
    required double cantidadMaxima,
    required double cantidadMalogrados,
    required DateTime fechaAdquisicion,
    required DateTime fechaUltimoMantenimiento,
    required  DateTime fechaProximoMantenimiento,
    required DateTime fechaRetiro,
    required String observacion,
    required String estadoOperacional,

    required double costoMantenimiento,
    required double vidaUtilEstimadoAnos,
    required String demanda,
    required String tipoPrecio,
    required String proveeduria,
    required String nivelUso,
    required String mantenimiento,
    required String tipoProveedor,
    required String material,
    required String riesgo,
    required String durabilidad,
    required String origenEquipo,
    required String capacidadDeCarga,
    required String dimensionesEquipo,
    required String precioRelativo,

    required bool active,

  }) async {
    isSyncing = true;
    notifyListeners();
     await ExceptionClass.tryCathCustom(
      task: () async {
         TEquiposAppModel data = TEquiposAppModel(
        id: id ?? '',
        qr: qr,
        //Files Lista string 
        imagen: imgString,
        pdf: pdfString,
        //LITAS Object 
        historialMantenimiento: historialMantenimiento,
        //id relations 
        idResponsableMantenimiento: idResponsableMantenimiento,
        //generic 
        categoria: categoria,
        propietario:propietario,
        ubicacion: ubicacion,
        color: color,
        nombre: nombre,
        intUndMedida: intUndMedida,
        outUndMedida: outUndMedida,
        intPrecioCompra: intPrecioCompra,
        outPrecioDistribucion: outPrecioDistribucion,
        cantidadEnStock: cantidadEnStock,
        cantidadCritica: cantidadCritica,
        cantidadOptima: cantidadOptima,
        cantidadMaxima: cantidadMaxima,
        cantidadMalogrados: cantidadMalogrados,
        fechaAdquisicion: fechaAdquisicion,
        fechaUltimoMantenimiento: fechaUltimoMantenimiento,
        fechaProximoMantenimiento: fechaProximoMantenimiento,
        fechaRetiro: fechaRetiro,
        observacion: observacion,
        estadoOperacional: estadoOperacional,
        costoMantenimiento: costoMantenimiento,
        vidaUtilEstimadoAnos: vidaUtilEstimadoAnos,
        demanda: demanda,
        tipoPrecio: tipoPrecio,
        proveeduria: proveeduria,
        nivelUso: nivelUso,
        mantenimiento: mantenimiento,
        tipoProveedor: tipoProveedor,
        material: material,
        riesgo: riesgo,
        durabilidad: durabilidad,
        origenEquipo: origenEquipo,
        capacidadDeCarga: capacidadDeCarga,
        dimensionesEquipo: dimensionesEquipo,
        precioRelativo: precioRelativo,
  
        // html: html,
        moneda: moneda,
        active: active,

        
      );
      // Determinar si es creación o actualización
       final isCreating = data.id == null || data.id.isEmpty;
          // Guardar con POST o PUT según corresponda
          final operation = isCreating
          ? TEquipoApp.postToPoketbase(data: data, imagenes: fileImagen, pdfs: filePdf)
          : TEquipoApp.putToPoketbase(id: data.id, data: data, imagenes: fileImagen, pdfs: filePdf);
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
  required TEquiposAppModel data,
  }) async {
      isSyncing = true;
      notifyListeners();
      print('JSON Data: ${data.toJson()}');
      await ExceptionClass.tryCathCustom(
        task: () async {
          final isCreating = data.id == null || data.id.isEmpty;
          // Guardar con POST o PUT según corresponda
          final operation = isCreating
          ? TEquipoApp.postToPoketbase(data: data , imagenes: fileImagen, pdfs: filePdf)
          : TEquipoApp.putToPoketbase(id: data.id, data: data, imagenes: fileImagen, pdfs: filePdf );
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
        final operation = TEquipoApp.deleteToPoketbase(id: id);

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
  Map<String, List<TEquiposAppModel>> groupByDistance({required List<TEquiposAppModel> listData, required String fieldName}) {
    Map<String, List<TEquiposAppModel>> groupedData = {};
    String value;

    for (var e in listData) {
      switch (fieldName) {
        //string 
        case 'CATEGORIA': value = ValidationField().getField(e.categoria); break;
        case 'PROPIETARIO': value = ValidationField().getField(e.propietario); break;
        case 'UBICACION': value = ValidationField().getField(e.ubicacion); break;
        case 'ESTADO_OPERACIONAL': value = ValidationField().getField(e.estadoOperacional); break;
        // case 'COLOR': value = ValidationField().getField(e.color);  break;
        case 'DEMANDA': value = ValidationField().getField(e.demanda);  break;
        case 'TIPO_PRECIO': value = ValidationField().getField(e.tipoPrecio); break;
        case 'PROVEEDURIA': value = ValidationField().getField(e.proveeduria); break;
        case 'NIVEL_USO': value = ValidationField().getField(e.nivelUso); break;
        case 'MANTENIMIENTO': value = ValidationField().getField(e.mantenimiento); break;
        case 'TIPO_PROVEEDOR': value = ValidationField().getField(e.tipoProveedor); break;
        case 'MATERIAL': value = ValidationField().getField(e.material); break;
        case 'RIESGO': value = ValidationField().getField(e.riesgo); break;
        case 'DURABILIDAD': value = ValidationField().getField(e.durabilidad); break;
        case 'ORIGEN_EQUIPO': value = ValidationField().getField(e.origenEquipo); break;
        case 'CAPACIDAD_DE_CARGA': value = ValidationField().getField(e.capacidadDeCarga); break;
        case 'PRECIO_RELATIVO': value = ValidationField().getField(e.precioRelativo); break;
        case 'MONEDA': value = ValidationField().getField(e.moneda); break;
        case 'DIMENSIONES_EQUIPO': value = ValidationField().getField(e.dimensionesEquipo); break;
        //bool 
        case 'ACTIVE': value = ValidationField().getFieldBool(estado: e.active, textTrue: 'ACTIVO', textFalse: 'INACTIVO'); break;
       //Date time 
        case 'F_ULTIMO_MANTENIMIENTO': value = ValidationField().getYearGroup(e.fechaUltimoMantenimiento); break;
        case 'F_ULTIMO_MANTENIMIENTO_MENSUAL': value = ValidationField().getMonthGroup(e.fechaUltimoMantenimiento); break;

        case 'F_PROXIMO_MANTENIMIENTO': value = ValidationField().getYearGroup(e.fechaProximoMantenimiento); break;
        case 'F_PROXIMO_MANTENIMIENTO_MENSUAL': value = ValidationField().getMonthGroup(e.fechaProximoMantenimiento); break;

        case 'F_RETIRO': value = ValidationField().getYearGroup(e.fechaRetiro);break;
        case 'F_RETIRO_MENSUAL': value = ValidationField().getMonthGroup(e.fechaRetiro); break;

        //number rangue
        case 'RANGO_PRECIO_COMPRA': value = ValidationField().getLabeledPriceRange( e.intPrecioCompra, e.moneda); break;
        case 'RANGO_PRECIO_DISTRIBUCION': value = ValidationField().getLabeledPriceRange( e.outPrecioDistribucion, e.moneda); break;
        case 'RANGO_COSTO_MANTENIMIENTO': value = ValidationField().getLabeledPriceRange(e.costoMantenimiento, e.moneda); break;
        case 'RANGO_STOCK': value = ValidationField().getLabeledPriceRange(e.cantidadEnStock, ''); break;
        //ListString: Agrupamos por cada proveedor en la lista
        case 'COLOR':
          for (var proveedor in e.color) {
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
  List<TEquiposAppModel> filteredData = [];
  String searchText = '';

  void setSearchText(String text, List<TEquiposAppModel> listData) {
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
  bool filterByFields({required String value, required TEquiposAppModel data}) {
    List<String?> fields = [
      data.qr, 
      data.categoria, 
      data.propietario, 
      data.ubicacion, 
      // data.proveedor.join(', '), //list<String>
      data.estadoOperacional, 
      data.nombre, 
      data.observacion, 
      data.moneda
      ];
    return fields.any((field) => field.toString().toLowerCase().contains(value.toString().toLowerCase()));
  }

  void clearSearch(List<TEquiposAppModel> listData) {
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
    'categoria': false,
    'propietario': false,
    'ubicacion': false,
    'estado_operacional': false,
    'color': false,
    'demanda': false,
    'tipo_precio': false,
    'proveeduria': false,
    'nivel_uso': false,
    'mantenimeinto': false,
    'tipo_proveedor': false,
    'material': false,
    'riesgo': false,
    'durabilidad': false,
    'origen_equipo': false,
    'capacidad_de_carga': false,
    'dimensiones_equipo': false,
    'precio_relativo': false,
    'moneda': false,
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
