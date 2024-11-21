

import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/utils/conversion/assets_format_values.dart';

class TEquiposAppModel {
    int? idsql;//Se añade con fines de uso en sqllite 
    String id;//
    String? collectionId;
    String? collectionName;
    DateTime? created;
    DateTime? updated;

    String qr;//
    String categoria;//
    String propietario;//
    String ubicacion;//
    String nombre;//

    String intUndMedida;//
    String outUndMedida;//
    String moneda;//
    double intPrecioCompra;//
    double outPrecioDistribucion;//
    double cantidadEnStock;//
    double cantidadMalogrados;//
    double cantidadCritica;//
    double cantidadOptima;//
    double cantidadMaxima;//
    DateTime fechaAdquisicion;
    DateTime fechaUltimoMantenimiento;
    DateTime fechaProximoMantenimiento;
    DateTime fechaRetiro;
    String observacion;

    String estadoOperacional;
    List<String> color;
    double costoMantenimiento;
    double vidaUtilEstimadoAnos;
    String demanda;
    String tipoPrecio;
    String proveeduria;
    String nivelUso;
    String mantenimiento;
    String tipoProveedor;
    String material;
    String riesgo;
    String durabilidad;
    String origenEquipo;
    String capacidadDeCarga;
    String dimensionesEquipo;
    String precioRelativo;

    bool active;
    String? html;
    List<String> pdf;
    List<String> imagen;

    List<TProductosAppModel>? historialMantenimiento;
   
    String idResponsableMantenimiento;

    TEquiposAppModel({
       required this.id,
         this.collectionId,
         this.collectionName,
         this.created,
         this.updated,
        required this.qr,
        required this.categoria,
        required this.propietario,
        required this.ubicacion,
        required this.nombre,
        required this.intUndMedida,
        required this.outUndMedida,
        required this.intPrecioCompra,
        required this.outPrecioDistribucion,
        required this.fechaAdquisicion,
        required this.estadoOperacional,
        required this.color,
        required this.costoMantenimiento,
        required this.fechaUltimoMantenimiento,
        required this.fechaProximoMantenimiento,
        required this.fechaRetiro,
        required this.vidaUtilEstimadoAnos,
        required this.demanda,
        required this.tipoPrecio,
        required this.proveeduria,
        required this.nivelUso,
        required this.mantenimiento,
        required this.tipoProveedor,
        required this.material,
        required this.riesgo,
        required this.durabilidad,
        required this.origenEquipo,
        required this.capacidadDeCarga,
        required this.dimensionesEquipo,
        required this.precioRelativo,
        required this.observacion,
        required this.moneda,
        required this.active,
         this.html,
        required this.pdf,
        required this.imagen,
         this.historialMantenimiento,
        required this.cantidadEnStock,
        required this.cantidadCritica,
        required this.cantidadOptima,
        required this.cantidadMaxima,
        required this.cantidadMalogrados,
        required this.idResponsableMantenimiento,
    });

    factory TEquiposAppModel.fromJson(Map<String, dynamic> json) => TEquiposAppModel(
         id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: json["created"],
        updated: json["updated"],
        qr: json["qr"],
        categoria: json["categoria"],
        propietario: json["propietario"],
        ubicacion: json["ubicacion"],
        nombre: json["nombre"],
        intUndMedida: json["int_und_medida"],
        outUndMedida: json["out_und_medida"],

        intPrecioCompra: FormatValues.parseToDouble(json["int_precio_compra"]),
        outPrecioDistribucion: FormatValues.parseToDouble(json["out_precio_distribucion"]),

        fechaAdquisicion: DateTime.parse(json["fecha_adquisicion"]),
        estadoOperacional: json["estado_operacional"],
        color:  List<String>.from(json["color"]),
        costoMantenimiento: FormatValues.parseToDouble(json["costo_mantenimiento"]),
        fechaUltimoMantenimiento: FormatValues.parseDateTime(json["fecha_ultimo_mantenimiento"]),
        fechaProximoMantenimiento: FormatValues.parseDateTime(json["fecha_proximo_mantenimiento"]),
        fechaRetiro: FormatValues.parseDateTime(json["fecha_retiro"]),
        vidaUtilEstimadoAnos: FormatValues.parseToDouble(json["vida_util_estimado_anos"]),
        demanda: json["demanda"],
        tipoPrecio: json["tipo_precio"],
        proveeduria: json["proveeduria"],
        nivelUso: json["nivel_uso"],
        mantenimiento: json["mantenimiento"],
        tipoProveedor: json["tipo_proveedor"],
        material: json["material"],
        riesgo: json["riesgo"],
        durabilidad: json["durabilidad"],
        origenEquipo: json["origen_equipo"],
        capacidadDeCarga: json["capacidad_de_carga"],
        dimensionesEquipo: json["dimensiones_equipo"],
        precioRelativo: json["precio_relativo"],
        observacion: json["observacion"],
        moneda: json["moneda"],
        active: json["active"],
        html: json["html"],
        imagen: List<String>.from(json["imagen"] ?? []), // manejo de nulos
        pdf: List<String>.from(json["pdf"] ?? []), // manejo de nulos

        cantidadEnStock: FormatValues.parseToDouble(json["cantidad_en_stock"]),
        cantidadCritica: FormatValues.parseToDouble(json["cantidad_critica"]),
        cantidadOptima: FormatValues.parseToDouble(json["cantidad_optima"]),
        cantidadMaxima: FormatValues.parseToDouble(json["cantidad_maxima"]),
        cantidadMalogrados: FormatValues.parseToDouble(json["cantidad_malogrados"]),

        idResponsableMantenimiento: json["id_responsable_mantenimiento"],
        // historialMantenimiento: json["historial_mantenimiento"],
        historialMantenimiento: FormatValues.listaFromJson<TProductosAppModel>
          (json["historial_mantenimiento"], TProductosAppModel.fromJson , TProductosAppModel.defaultValueModel),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        // "created": created.toIso8601String(),
        // "updated": updated.toIso8601String(),
        "qr": qr,
        "categoria": categoria,
        "propietario": propietario,
        "ubicacion": ubicacion,
        "nombre": nombre,
        "int_und_medida": intUndMedida,
        "out_und_medida": outUndMedida,
        "int_precio_compra": intPrecioCompra,
        "out_precio_distribucion": outPrecioDistribucion,
        "estado_operacional": estadoOperacional,
        "color": color,
        "costo_mantenimiento": costoMantenimiento,
        "fecha_adquisicion": fechaAdquisicion.toIso8601String(),
        "fecha_ultimo_mantenimiento": fechaUltimoMantenimiento.toIso8601String(),
        "fecha_proximo_mantenimiento": fechaProximoMantenimiento.toIso8601String(),
        "fecha_retiro": fechaRetiro.toIso8601String(),
        "vida_util_estimado_anos": vidaUtilEstimadoAnos,
        "demanda": demanda,
        "tipo_precio": tipoPrecio,
        "proveeduria": proveeduria,
        "nivel_uso": nivelUso,
        "mantenimiento": mantenimiento,
        "tipo_proveedor": tipoProveedor,
        "material": material,
        "riesgo": riesgo,
        "durabilidad": durabilidad,
        "origen_equipo": origenEquipo,
        "capacidad_de_carga": capacidadDeCarga,
        "dimensiones_equipo": dimensionesEquipo,
        "precio_relativo": precioRelativo,
        "observacion": observacion,
        "moneda": moneda,
        "active": active,
        "html": html,
        "imagen":imagen,
        "pdf": pdf,
        "cantidad_en_stock": cantidadEnStock,
        "cantidad_critica": cantidadCritica,
        "cantidad_optima": cantidadOptima,
        "cantidad_maxima": cantidadMaxima,
        "cantidad_malogrados": cantidadMalogrados,
        "id_responsable_mantenimiento": idResponsableMantenimiento,
        // "historial_mantenimiento": historialMantenimiento,
         'historial_mantenimiento': FormatValues.listaToString<TProductosAppModel>(
                          historialMantenimiento, 
                          TProductosAppModel.fromJson, 
                          (TProductosAppModel marca) => marca.toJson()
                        )
    };

   static TEquiposAppModel defaultValueModel() {
    final nombre = "Error Json";//Todas Impotante para validar los Json SubListList
      return TEquiposAppModel(
        id: '',
        collectionId: null,
        collectionName: null,
        created: null,
        updated: null,
        qr: "",
        categoria: "",
        propietario: "",
        ubicacion: "",
        nombre: nombre,
        intUndMedida: "",
        outUndMedida: "",
        intPrecioCompra: 0,
        outPrecioDistribucion: 0,
        fechaAdquisicion: DateTime.now(),
        estadoOperacional: "",
        color: [],
        costoMantenimiento: 0,
        fechaUltimoMantenimiento: DateTime.now(),
        fechaProximoMantenimiento: DateTime.now(),
        fechaRetiro: DateTime.now(),
        vidaUtilEstimadoAnos: 0,
        demanda: "",
        tipoPrecio: "",
        proveeduria: "",
        nivelUso: "",
        mantenimiento: "",
        tipoProveedor: "",
        material: "",
        riesgo: "",
        durabilidad: "",
        origenEquipo: "",
        capacidadDeCarga: "",
        dimensionesEquipo: "",
        precioRelativo: "",
        observacion: "",
        moneda: "",
        active: false,
        html: "",
        pdf: [],
        imagen: [],
        // historialMantenimiento: ,
        cantidadEnStock: 0,
        cantidadCritica: 0,
        cantidadOptima: 0,
        cantidadMaxima: 0,
        cantidadMalogrados: 0,
        idResponsableMantenimiento: "",
      );
    }

}
