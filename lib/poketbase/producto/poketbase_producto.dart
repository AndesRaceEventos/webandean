import 'dart:typed_data';

import 'package:pocketbase/pocketbase.dart';
import 'package:webandean/api/api_poketbase.dart';
import 'package:webandean/model/producto/model_producto.dart';
import 'package:http/http.dart' as http;

// FORMA API PUBLUC  https://andean-lodge.pockethost.io/api/collections/almacen_productos/records?page=1&perPage=500&sort=-created&skipTotal=true

class TProductosApp {
  static const String collectionName = 'almacen_productos';

   // Método reutilizable para procesar la respuesta
  static List<TProductosAppModel> processResponse(List<RecordModel> response) {
    return response.map((e) {
      e.data['id'] = e.id;
      e.data['created'] = DateTime.parse(e.created);
      e.data['updated'] = DateTime.parse(e.updated);
      e.data['collectionId'] = e.collectionId;
      e.data['collectionName'] = e.collectionName;
      return TProductosAppModel.fromJson(e.data);
    }).toList();
  }

  static Future<List<RecordModel>> getToPoketbase( {
      String? filter,
      String? sort = '-created',
      String? expand,//solo si existen relaciones, traera todos los datos del dato en emncion relacioando. 
  }
      ) async {
        print('${filter} / ${sort} / ${expand}');
    try {
      //get full list siempre devolvera rodos los datos ap esar de limitar el bath 
      final records = await pb.collection('$collectionName').getFullList(
        filter: filter,
        expand: expand,
        sort: sort,
        );
      print(records);
      return records;
    } catch (e) {
      print('Error en almacen_productos: $e');
     rethrow; // Permitir que la excepción continúe propagándose.
     // return [];
    }
  }

  static Future<RecordModel?> postToPoketbase(
      {required TProductosAppModel data,
       List<Uint8List>? imagen
      }) async {
    try {
      final record =await pb.collection('$collectionName').create(
        body: data.toJson(),
        files: [
             if (imagen != null)
             for(var i = 0; i < imagen.length; i++ )
              http.MultipartFile.fromBytes('imagen', 
              await imagen[i],
            filename: 'imagen${data.qr}${data.nombre}.jpg'), 
          ],

          );
      return record;
    } catch (e) {
      print('Error en almacen_productos: $e');
      rethrow; // Permitir que la excepción continúe propagándose.
      // return null;
    }
  }

  static Future<RecordModel?> putToPoketbase({required String id,required TProductosAppModel data, List<Uint8List>? imagen}) async {
    try {
      final record = await pb
          .collection('$collectionName')
          .update(id, body: data.toJson(), 
          files: [
             if (imagen != null)
             for(var i = 0; i < imagen.length; i++ )
              http.MultipartFile.fromBytes('imagen', 
              await imagen[i],
            filename: 'imagen${data.qr}${data.nombre}.jpg'), 
          ]);
      return record;
    } catch (e) {
      print('Error en almacen_productos: $e');
      rethrow; // Permitir que la excepción continúe propagándose.
      // return null;
    }
  }

  static Future<bool> deleteToPoketbase(
      {required String id, }) async {
        print('$id ID PROUCTO ');
    try {
      await pb.collection('$collectionName').delete(id);
      return true;
    } catch (e) {
      print('Error en almacen_productos: $e');
      rethrow; // Permitir que la excepción continúe propagándose.
      // return false:
    }
  }

  // static Future<RealtimeService> realTimeToPoletbase() async {
  //   return pb.realtime;
  // }
  
  // Método para manejar la suscripción en tiempo real
  static void realTimeToPocketbase(void Function(RecordSubscriptionEvent) onEvent) {
    pb.collection('$collectionName').subscribe('*', (e) {
      onEvent(e); // Llama al callback con el evento recibido
    });
  }
}

