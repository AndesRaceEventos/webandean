

import 'package:webandean/utils/conversion/assets_format_values.dart';

class TItinerioApuModel {
    int? idsql;//Se añade con fines de uso en sqllite 
    String id;
    String? collectionId;
    String? collectionName;
    DateTime? created;
    DateTime? updated;

    String tipoDesalida;//
    String nombre;//
    String itinerario;//
    
    int dias;
    int noches;
    int chillcaNight;
    int machuNight;
    int anantaNight;
    int huampoNight;

    String observacion;//

    String pdf;
    String imagen;
    String? html;
    String qr;//
    bool? active;//

    TItinerioApuModel({
        required this.id,
         this.collectionId,
         this.collectionName,
         this.created,
         this.updated,

        required this.tipoDesalida,
        required this.nombre,
        required this.itinerario,
        required this.dias,
        required this.noches,
        required this.chillcaNight,
        required this.machuNight,
        required this.anantaNight,
        required this.huampoNight,
        required this.observacion,

        required this.pdf,
        required this.imagen,
        required this.qr,
         this.html,
         this.active,
    });

    factory TItinerioApuModel.fromJson(Map<String, dynamic> json) => TItinerioApuModel(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: (json["created"]),
        updated: (json["updated"]),

        tipoDesalida: json["tipoDesalida"],
        nombre: json["nombre"],
        itinerario: json["itinerario"],

        dias:  FormatValues.parseToInt(json["dias"]),
        noches: FormatValues.parseToInt(json["noches"]),
        chillcaNight: FormatValues.parseToInt(json["chillca_night"]),
        machuNight:FormatValues.parseToInt(json["machu_night"]),
        anantaNight:FormatValues.parseToInt(json["ananta_night"]),
        huampoNight: FormatValues.parseToInt(json["huampo_night"]),

        observacion: json["observacion"],
        html: json["html"],
        pdf: json["pdf"],
        imagen: json["imagen"],
        qr: json["qr"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        // "created": created.toIso8601String(),
        // "updated": updated.toIso8601String(),
        "tipoDesalida": tipoDesalida,
        "nombre": nombre,
        "itinerario": itinerario,
        "dias": dias,
        "noches": noches,
        "chillca_night": chillcaNight,
        "machu_night": machuNight,
        "ananta_night": anantaNight,
        "huampo_night": huampoNight,
        "observacion": observacion,
        "html": html,
        "pdf": pdf,
        "imagen": imagen,
        "qr": qr,
        "active": active,
    };

  static TItinerioApuModel defaultValueModel(){
     final nombre = "Error Json";//Todas Impotante para validar los Json SubListList
    return TItinerioApuModel(
      id: '',
      collectionId: null,
      collectionName: null,
      created: null,
      updated: null,

      tipoDesalida: '',
      nombre: nombre, //Todos +++++++++++++++ 
      itinerario: '',
      dias: 0,
      noches: 0,
      chillcaNight: 0,
      machuNight: 0,
      anantaNight: 0,
      huampoNight: 0,
      observacion: '',
      pdf: '',
      imagen: '',
      html: '',
      qr: '',
      active: false,
    );
  }
}
