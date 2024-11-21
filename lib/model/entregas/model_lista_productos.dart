
import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/utils/conversion/assets_format_values.dart';

class TListaEntregaProductosModel {
    int? idsql;//Se añade con fines de uso en sqllite 
    String id;
    String? collectionId;
    String? collectionName;
    DateTime? created;
    DateTime? updated;

    String qr;
    String nombre;
    String idProgramaApu;
    String observacion;
    int cantidadPax;
    int cantidadGuia;
    String? html;

    
    bool? active;

    String imagen;
    String pdf;

    List<TProductosAppModel>? listaProducto;

    TListaEntregaProductosModel({
        required this.id,
         this.collectionId,
         this.collectionName,
         this.created,
         this.updated,

        required this.idProgramaApu,
        required this.nombre,
        required this.cantidadPax,
        required this.cantidadGuia,
        required this.observacion,
        required this.qr,
        required this.pdf,
        required this.imagen,
        
        this.html,
        this.active,

        required this.listaProducto,
    });

    factory TListaEntregaProductosModel.fromJson(Map<String, dynamic> json) => TListaEntregaProductosModel(
         id: json["id"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: (json["created"]),
        updated: (json["updated"]),

        idProgramaApu: json["id_programa_apu"],
        nombre: json["nombre"],
       cantidadPax: FormatValues.parseToInt(json["cantidad_pax"]),
        cantidadGuia:  FormatValues.parseToInt(json["cantidad_guia"]),
        observacion: json["observacion"],
        qr: json["qr"],
        html: json["html"],
        pdf: json["pdf"],
        imagen: json["imagen"],
        active: json["active"],

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
        "id_programa_apu": idProgramaApu,
        "nombre": nombre,
        "cantidad_pax": cantidadPax,
        "cantidad_guia": cantidadGuia,
        "observacion": observacion,
        "qr": qr,
        "html": html,
        "pdf": pdf,
        "imagen": imagen,
        "active": active,

        // "lista_producto": listaProducto,
        "lista_producto": FormatValues.listaToString<TProductosAppModel>(
                          listaProducto, 
                          TProductosAppModel.fromJson, 
                          (TProductosAppModel value) => value.toJson()
                        ),
    };

    static TListaEntregaProductosModel defaultValueModel() {
      final nombre = "Error Json";//Todas Impotante para validar los Json SubListList
      return TListaEntregaProductosModel(
          id: "",
          collectionId: "",
          collectionName: "",
          created: null, 
          updated: null,
          idProgramaApu: "",
          nombre: nombre, //Todos +++++++++++++++ 
          cantidadPax: 0,
          cantidadGuia: 0,
          observacion: "",
          qr: "",
          html: "",
          pdf: "",
          imagen: "",
          active: false,
          listaProducto: [],
      );
    }
}
