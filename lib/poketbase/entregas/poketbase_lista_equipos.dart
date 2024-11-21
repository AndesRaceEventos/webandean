import 'dart:typed_data';

import 'package:pocketbase/pocketbase.dart';
import 'package:webandean/api/api_poketbase.dart';
import 'package:webandean/model/entregas/model_lista_equipos.dart';
// import 'package:webandean/model/equipo/model_equipo.dart';
import 'package:webandean/poketbase/procesing_files_poketbase.dart';


class TListaEquiposApp {
  static const String collectionName = 'almacen_lista_equipos';

   // Método reutilizable para procesar la respuesta
  static List<TListaEntregaEquiposModel> processResponse(List<RecordModel> response) {
    return response.map((e) {
      e.data['id'] = e.id;
      e.data['created'] = DateTime.parse(e.created);
      e.data['updated'] = DateTime.parse(e.updated);
      e.data['collectionId'] = e.collectionId;
      e.data['collectionName'] = e.collectionName;
      return TListaEntregaEquiposModel.fromJson(e.data);
    }).toList();
  }

  static Future<List<RecordModel>> getToPoketbase( {
      String? filter= '',
      String? sort = '-created',
      String? expand = '',}) async {
        print('${filter} / ${sort} / ${expand}');
      try {
        final records = await pb.collection('$collectionName').getFullList(
          filter: '${filter}' , //'categoria_compras="VIVERES"' 'categoria_compras="VERDURAS" && active=true',
          expand: expand,
          sort: sort,
          // fields: ['ubicacion','nombre'].join(',') ?? ''
          );
        print(records);
        return records;
      } catch (e) {
      print('Error en almacen_productos: $e');
     rethrow; // Permitir que la excepción continúe propagándose.
     // return [];
    }
  }

  static Future<RecordModel?> postToPoketbase({
      required TListaEntregaEquiposModel data, 
       Uint8List? imagen,
        List<Uint8List>? imagenes,
        Uint8List? pdf,
        List<Uint8List>? pdfs,
        Uint8List? audio,
        List<Uint8List>? audios,
        Uint8List? word,
        List<Uint8List>? words,
        Uint8List? video,
        List<Uint8List>? videos,
      }) async {
    try {
      final files = await FilesProcessing.processingFilesPoketbase(
        imagen: imagen, imagenes: imagenes,
        pdf: pdf, pdfs: pdfs,
        audio: audio, audios: audios,
        word: word, words: words,
        video: video, videos: videos,
        id: data.id, qr: data.qr,nombre: data.nombre,
      );
      final record =await pb.collection('$collectionName').create(body: data.toJson(),files: files);
      return record;
    } catch (e) {
      print('Error en almacen_productos: $e');
      rethrow; // Permitir que la excepción continúe propagándose.
      // return null;
    }
  }



  static Future<RecordModel?> putToPoketbase({
    required String id,
    required TListaEntregaEquiposModel data,
    Uint8List? imagen,
    List<Uint8List>? imagenes,
    Uint8List? pdf,
    List<Uint8List>? pdfs,
    Uint8List? audio,
    List<Uint8List>? audios,
    Uint8List? word,
    List<Uint8List>? words,
    Uint8List? video,
    List<Uint8List>? videos,
    // reciba un índice general y determine qué lista debe modificarse
    // int? index,
    // bool delete = false,
    }) async {
    //   List<Uint8List> updatedImages = List.from(imagenes ?? []);
    // List<Uint8List> updatedPdfs = List.from(pdfs ?? []);

    
    //   if (delete) {
    //     updatedImages.removeAt(index); // Eliminar imagen
    //   } 

      final files = await FilesProcessing.processingFilesPoketbase(
        imagen: imagen, imagenes: imagenes,
        pdf: pdf, pdfs: pdfs,
        audio: audio, audios: audios,
        word: word, words: words,
        video: video, videos: videos,
        id: data.id, qr: data.qr,nombre: data.nombre,
      );
    try {
      final record = await pb.collection('$collectionName').update(id, body: data.toJson(), files: files);
      return record;
    } catch (e) {
      print('Error en almacen_productos: $e');
      rethrow; // Permitir que la excepción continúe propagándose.
      // return null;
    }
  }

  static Future<bool> deleteToPoketbase({required String id, }) async {
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

