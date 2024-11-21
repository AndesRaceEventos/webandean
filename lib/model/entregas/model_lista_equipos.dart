


import 'package:webandean/model/equipo/model_equipo.dart';
import 'package:webandean/utils/conversion/assets_format_values.dart';

class TListaEntregaEquiposModel {
     int? idsql;//Se añade con fines de uso en sqllite 
    String id;
    String? collectionId;
    String? collectionName;
    DateTime? created;
    DateTime? updated;

    String idProgramaApu;
    String nombre;
    String observacion;
    int cantidadPax;
    int cantidadGuia;
    String qr;
    String? html;

    
    bool? active;

    String imagen;
    String pdf;
    List<TEquiposAppModel>? listaEquipos;

    TListaEntregaEquiposModel({
        required this.id,
         this.collectionId,
         this.collectionName,
         this.created,
         this.updated,

        required this.idProgramaApu,
        required this.nombre,
        required this.observacion,
        required this.cantidadPax,
        required this.cantidadGuia,
        required this.qr,
        required this.imagen,
        required this.pdf,
         this.html,
         this.active,
         
        required this.listaEquipos,
    });

    factory TListaEntregaEquiposModel.fromJson(Map<String, dynamic> json) => TListaEntregaEquiposModel(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: (json["created"]),
        updated: (json["updated"]),
        
        idProgramaApu: json["id_programa_apu"],
        nombre: json["nombre"],
        observacion: json["observacion"],
        cantidadPax: FormatValues.parseToInt(json["cantidad_pax"]),
        cantidadGuia:  FormatValues.parseToInt(json["cantidad_guia"]),
        qr: json["qr"],
        imagen: json["imagen"],
        pdf: json["pdf"],
        html: json["html"],
        active: json["active"],

        // listaEquipos: json["lista_equipos"],

        listaEquipos: FormatValues.listaFromJson<TEquiposAppModel>
          (json["lista_equipos"], TEquiposAppModel.fromJson , TEquiposAppModel.defaultValueModel),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        // "created": created.toIso8601String(),
        // "updated": updated.toIso8601String(),

        "qr": qr,
        "nombre": nombre,
        "id_programa_apu": idProgramaApu,
        "observacion": observacion,
        "cantidad_pax": cantidadPax,
        "cantidad_guia": cantidadGuia,
        // "lista_equipos": listaEquipos,
        "lista_equipos": FormatValues.listaToString<TEquiposAppModel>(
                          listaEquipos, 
                          TEquiposAppModel.fromJson, 
                          (TEquiposAppModel value) => value.toJson()
                        ),
        "imagen": imagen,
        "pdf": pdf,
        // "html": html,
        "active": active,
    };

     static TListaEntregaEquiposModel defaultValueModel() {
       final nombre = "Error Json";//Todas Impotante para validar los Json SubListList
       return TListaEntregaEquiposModel(
           id: '',
           collectionId: null,
           collectionName: null,
           created: null,
           updated: null,
           idProgramaApu: '',
           nombre: nombre, //Todos +++++++++++++++ 
           observacion: '',
           cantidadPax: 0,
           cantidadGuia: 0,
           qr: '',
           imagen: '',
           pdf: '',
           html: '',
           active: false,
           listaEquipos: [],
       );
     }
}
