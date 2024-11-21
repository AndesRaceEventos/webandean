
class TPersonalApuModel {
    int? idsql;//Se añade con fines de uso en sqllite 
    String id;
    String? collectionId;
    String? collectionName;
    DateTime? created;
    DateTime? updated;

    String nombre;
    String observacion;
    String idRol;
    String imagen;
    String pdf;
    String qr;

    String? html;
    bool? active;

    TPersonalApuModel({
        required this.id,
         this.collectionId,
         this.collectionName,
         this.created,
         this.updated,

        required this.nombre,
        required this.observacion,
        required this.idRol,

        required this.pdf,
        required this.imagen,
        required this.qr,
         this.html,
         this.active,
    });

    factory TPersonalApuModel.fromJson(Map<String, dynamic> json) => TPersonalApuModel(
        id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: (json["created"]),
        updated: (json["updated"]),

        nombre: json["nombre"],
        imagen: json["imagen"],
        observacion: json["observacion"],
        idRol: json["idRol"],
        pdf: json["pdf"],
        html: json["html"],
        qr: json["qr"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "collectionId": collectionId,
        "collectionName": collectionName,
        // "created": created.toIso8601String(),
        // "updated": updated.toIso8601String(),
        "nombre": nombre,
        "imagen": imagen,
        "observacion": observacion,
        "idRol": idRol,
        "pdf": pdf,
        "html": html,
        "qr": qr,
        "active": active,
    };

   static TPersonalApuModel defaultValueModel()  {
     final nombre = "Error Json";//Todas Impotante para validar los Json SubListList
     return TPersonalApuModel(
       id: '',
       collectionId: '',
       collectionName: '',
       created: DateTime.now(),
       updated: DateTime.now(),

       nombre: nombre, //Todos +++++++++++++++ 
       observacion: '',
       idRol: '',

       pdf: '',
       imagen: '',
       qr: '',
       html: '',
       active: false,
     );
   }
}
