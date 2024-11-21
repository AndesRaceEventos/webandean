

import 'package:webandean/model/equipo/model_equipo.dart';
import 'package:webandean/model/producto/model_producto.dart'; 
import 'package:webandean/utils/conversion/assets_format_values.dart';

class TEntregasModel {
     int? idsql;//Se añade con fines de uso en sqllite 
    String id;//
    String? collectionId;
    String? collectionName;
    DateTime? created;
    DateTime? updated;

    List<String> idReserva;//Pueden ser varios ID Reserva
    List<String> idPersonal;//Pueden ser varios ID de PEROSNAL  

    String idListaCompra;//
    String idListaEquipos;//

    List<TEquiposAppModel>? listaEquipos; // 
    List<TProductosAppModel>? listaProducto; //
    
    String observacion;//
    String qr;//
    String nombre;//
    String pdf;//
    String imagen;//
    bool active;//
    String? html;

    TEntregasModel({
        required this.id,
         this.collectionId,
         this.collectionName,
         this.created,
         this.updated,
         
        required this.idReserva,
        required this.idPersonal,
        required this.idListaCompra,
        required this.idListaEquipos,
        required this.listaEquipos,
        required this.listaProducto,
        required this.qr,
        required this.nombre,
        required this.pdf,
        required this.imagen,
        required this.active,

        required this.observacion,

         this.html,
    });

    factory TEntregasModel.fromJson(Map<String, dynamic> json) => TEntregasModel(
         id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: (json["created"]),
        updated: (json["updated"]),

        idReserva: List<String>.from(json["id_reserva"] ?? []),
        idPersonal: List<String>.from(json["id_personal"] ?? []),

        idListaCompra: json["id_lista_compra"],
        idListaEquipos: json["id_lista_equipos"],

        qr: json["qr"],
        nombre: json["nombre"],
        observacion: json["observacion"],
        pdf: json["pdf"],
        imagen: json["imagen"],
        active: json["active"],
        html: json["html"],

        // listaEquipos: json["lista_equipos"],
        listaEquipos: FormatValues.listaFromJson<TEquiposAppModel>
          (json["lista_equipos"], TEquiposAppModel.fromJson , TEquiposAppModel.defaultValueModel),
        // listaProducto: json["lista_producto"],
        listaProducto: FormatValues.listaFromJson<TProductosAppModel>
          (json["lista_producto"], TProductosAppModel.fromJson , TProductosAppModel.defaultValueModel),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        // "created": created.toIso8601String(),
        // "updated": updated.toIso8601String(),
        "id_reserva": idReserva,
        "id_personal": idPersonal,

        "id_lista_compra": idListaCompra,
        "id_lista_equipos": idListaEquipos,


        "lista_equipos": FormatValues.listaToString<TEquiposAppModel>(
                          listaEquipos, 
                          TEquiposAppModel.fromJson, 
                          (TEquiposAppModel value) => value.toJson()),

        // "lista_producto": listaProducto,
         "lista_producto": FormatValues.listaToString<TProductosAppModel>(
                          listaProducto, 
                          TProductosAppModel.fromJson, 
                          (TProductosAppModel value) => value.toJson()
                        ),
        "qr": qr,
        "nombre": nombre,
        "observacion": observacion,
        "pdf": pdf,
        "imagen": imagen,
        // "html": html,
        "active": active,
    };


    static TEntregasModel defaultValueModel() {
      final nombre = "Error Json";//Todas Impotante para validar los Json SubListList
      return TEntregasModel(
        id: "",
        collectionId: "",
        collectionName: "",
        created: DateTime.now(),
        updated: DateTime.now(),
        idReserva: [],
        idPersonal: [],
        idListaCompra: "",
        idListaEquipos: "",
        listaEquipos: [],
        listaProducto: [],
        qr: "",
        nombre: nombre, //Todos +++++++++++++++ 
        observacion: "",
        pdf: "",
        imagen: "",
        active: true,
        html: "",
      );
    }
}
