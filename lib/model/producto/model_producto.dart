
import 'package:webandean/utils/conversion/assets_format_values.dart';

class TProductosAppModel {
    int? idsql;//Se añade con fines de uso en sqllite 
    String id;
    String? collectionId;
    String? collectionName;
    DateTime? created;
    DateTime? updated;

    String qr;
    String categoriaCompras;
    String categoriaInventario;
    String ubicacion;
    List<String> proveedor;
    String nombre;

    String moneda;
    String intUndMedida;
    String outUndMedida;
    double intPrecioCompra;
    double outPrecioDistribucion;
    DateTime fechaVencimiento;

    double? cantidadEnStock;
    double? cantidadCritica;
    double? cantidadOptima;
    double? cantidadMaxima;
    double? cantidadMalogrados;

    String tipo;
    String rotacion;
    String estado;
    String demanda;
    String condicionAlmacenamiento;
    String formato;
    String tipoPrecio;
    String durabilidad;
    String proveeduria;
    String presentacionVisual;
    String embaseAmbiental;
    String responsabilidadAmbiental;

    

    String observacion;
    String idMenu;
    String? html;
    List<String>? imagen;
    List<String>? pdf;
    List<TProductosAppModel>? listaMarcas;

    bool? active;
    //Sirve para visualizar el item, 
    //cuando se elimine un datos no se eliminara realmente sino que se ianctiva, 
    //pero no podra verse, Solo el admin puede eliminar definitvamente con su id y contrasena o directamente desde al BD

    TProductosAppModel({
        required this.id,
         this.collectionId,
         this.collectionName,
         this.created,
         this.updated,

        required this.qr,
        required this.categoriaCompras,
        required this.categoriaInventario,
        required this.ubicacion,
        required this.proveedor,
        required this.rotacion,
        required this.nombre,
         this.listaMarcas,
        required this.intUndMedida,
        required this.outUndMedida,
        required this.intPrecioCompra,
        required this.outPrecioDistribucion,
        required this.idMenu,
        required this.tipo,
        required this.fechaVencimiento,
        required this.estado,
        required this.demanda,
        required this.condicionAlmacenamiento,
        required this.formato,
        required this.tipoPrecio,
        required this.durabilidad,
        required this.proveeduria,
        required this.presentacionVisual,
        required this.embaseAmbiental,
        required this.responsabilidadAmbiental,

         this.imagen,
         this.pdf,
         this.cantidadEnStock,
         this.cantidadCritica,
         this.cantidadOptima,
         this.cantidadMaxima,
         this.cantidadMalogrados,

        required this.observacion,
         this.html,
        required this.moneda,
         this.active,
    });
    
    factory TProductosAppModel.fromJson(Map<String, dynamic> json) => TProductosAppModel(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: json["created"],//FormatValues.parseDateTime(json["created"]),
        updated: json["updated"],//FormatValues.parseDateTime(json["updated"]),
        qr: json["qr"],
        categoriaCompras: json["categoria_compras"],
        categoriaInventario: json["categoria_inventario"],
        ubicacion: json["ubicacion"],
        proveedor: List<String>.from(json["PROVEEDOR"] ?? []), // manejo de nulos json["PROVEEDOR"],
        rotacion: json["rotacion"],
        imagen: List<String>.from(json["imagen"] ?? []), // manejo de nulos
        pdf: List<String>.from(json["pdf"] ?? []), // manejo de nulos
        nombre: json["nombre"],
        intUndMedida: json["int_und_medida"],
        outUndMedida: json["out_und_medida"],
        intPrecioCompra: FormatValues.parseToDouble(json["int_precio_compra"]),
        outPrecioDistribucion: FormatValues.parseToDouble(json["out_precio_distribucion"]),
        idMenu: json["id_menu"],
        html: json["html"],
        tipo: json["tipo"],
        fechaVencimiento: FormatValues.parseDateTime(json["fecha_vencimiento"]),
        estado: json["estado"],
        demanda: json["demanda"],
        condicionAlmacenamiento: json["condicion_almacenamiento"],
        formato: json["formato"],
        tipoPrecio: json["tipo_precio"],
        durabilidad: json["durabilidad"],
        proveeduria: json["proveeduria"],
        presentacionVisual: json["presentacion_visual"],
        embaseAmbiental: json["embase_ambiental"],
        responsabilidadAmbiental: json["responsabilidad_ambiental"],
        cantidadEnStock: FormatValues.parseToDouble(json["cantidad_en_stock"]),
        cantidadCritica: FormatValues.parseToDouble(json["cantidad_critica"]),
        cantidadOptima: FormatValues.parseToDouble(json["cantidad_optima"]),
        cantidadMaxima: FormatValues.parseToDouble(json["cantidad_maxima"]),
        cantidadMalogrados: FormatValues.parseToDouble(json["cantidad_malogrados"]),
        observacion: json["observacion"],
        moneda: json["moneda"], 
        active: json["active"],
        // listaMarcas: listaMarcasFromString(json["lista_marcas"])
        listaMarcas: FormatValues.listaFromJson<TProductosAppModel>
          (json["lista_marcas"], TProductosAppModel.fromJson , defaultValueModel),
        // listaMarcas: json["lista_marcas"] != null && json["lista_marcas"] is List
        // ? List<TProductosAppModel>.from(json["lista_marcas"].map((x) => TProductosAppModel.fromJson(x)))
        // : [],
    );
   
    Map<String, dynamic> toJson() => {
        "id": id,//
        "collectionId": collectionId,
        "collectionName": collectionName,
        // "created": created?.toIso8601String(),
        // "updated": updated?.toIso8601String(),

        "qr": qr,//
        "categoria_compras": categoriaCompras,//
        "categoria_inventario": categoriaInventario,//
        "ubicacion": ubicacion,//
        "PROVEEDOR": proveedor,//
        "rotacion": rotacion,//
        "imagen":imagen,
        "pdf": pdf,
        "nombre": nombre,//
        // "lista_marcas": listaMarcas,
        "int_und_medida": intUndMedida,//
        "out_und_medida": outUndMedida,//
        "int_precio_compra": intPrecioCompra,//
        "out_precio_distribucion": outPrecioDistribucion,//
        "id_menu": idMenu,
        // "html": html, no enviar html porque se borra la infroacion. 
        "tipo": tipo,
        "fecha_vencimiento": fechaVencimiento.toIso8601String(),//
        "estado": estado,//
        "demanda": demanda,//
        "condicion_almacenamiento": condicionAlmacenamiento,//
        "formato": formato,//
        "tipo_precio": tipoPrecio,//
        "durabilidad": durabilidad,//
        "proveeduria": proveeduria,//
        "presentacion_visual": presentacionVisual,//
        "embase_ambiental": embaseAmbiental,//
        "responsabilidad_ambiental": responsabilidadAmbiental,

        "cantidad_en_stock": cantidadEnStock,//
        "cantidad_critica": cantidadCritica,//
        "cantidad_optima": cantidadOptima,//
        "cantidad_maxima": cantidadMaxima,//
        "cantidad_malogrados": cantidadMalogrados,//

        "observacion": observacion,
        "moneda": moneda,//
        "active": active,//

        // 'lista_marcas': listaMarcas?.map((e) => e.toJson()).toList() ?? [],
        // 'lista_marcas': listaMarcasToString(listaMarcas)
        'lista_marcas': FormatValues.listaToString<TProductosAppModel>(
                          listaMarcas, 
                          TProductosAppModel.fromJson, 
                          (TProductosAppModel marca) => marca.toJson()
                        )
    };
    
    // Convierte lista de TProductosAppModel a un String JSON
    // static  String listaMarcasToString(List<TProductosAppModel>? listaMarcas) {
    //   if (listaMarcas == null || listaMarcas.isEmpty) return '';
    //   return jsonEncode(listaMarcas.map((marca) => marca.toJson()).toList());
    // }

    // Convierte un String JSON a una lista de TProductosAppModel
    // static List<TProductosAppModel> listaMarcasFromString(String data) {
    //   if (data.isEmpty) return [];// si es vacio retorna lista vacia 
    //   List<dynamic> jsonData = jsonDecode(data);
    //   return jsonData.map((item) => TProductosAppModel.fromJson(item)).toList();
    // }

  static TProductosAppModel defaultValueModel() {
    final nombre = "Error Json";//Todas Impotante para validar los Json SubListList
    return TProductosAppModel(
      id: '',
      collectionId: null,
      collectionName: null,
      created: null,
      updated: null,
      qr: "",
      categoriaCompras: "",
      categoriaInventario: "",
      ubicacion: "",
      proveedor: [],
      rotacion: "",
      nombre: nombre, //Todos +++++++++++++++ 
      listaMarcas: [],
      intUndMedida: "",
      outUndMedida: "",
      intPrecioCompra: 0,
      outPrecioDistribucion: 0,
      idMenu: "",
      tipo: "",
      fechaVencimiento: DateTime.now(),
      estado: "",
      demanda: "",
      condicionAlmacenamiento: "",
      formato: "",
      tipoPrecio: "",
      durabilidad: "",
      proveeduria: "",
      presentacionVisual: "",
      embaseAmbiental: "",
      responsabilidadAmbiental: "",
      imagen: [],
      cantidadEnStock: 0.0,
      cantidadCritica: 0.0,
      cantidadOptima: 0.0,
      cantidadMaxima: 0.0,
      cantidadMalogrados: 0.0,
      observacion: "",
      html: "",
      moneda: "",
      active: false,
    );
  }

}
