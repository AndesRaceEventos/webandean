import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // for MediaType

class FilesProcessing {
  
static Future<List<http.MultipartFile>> processingFilesPoketbase({
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
  required String id,
  required String qr,
  required String nombre,
}) async {
  String fileName = '${nombre}_${qr}_${id}';
  
  List<http.MultipartFile> files = [
    // Image Files
    if (imagenes != null)
      for (var i = 0; i < imagenes.length; i++)
        await http.MultipartFile.fromBytes(
          'imagen',
          imagenes[i],
          filename: '${i}_${fileName}.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
    if (imagen != null)
      await http.MultipartFile.fromBytes(
        'imagen',
        imagen,
        filename: '$fileName.jpg',
        contentType: MediaType('image', 'jpeg'),
      ),
    
    // PDF Documents
    if (pdfs != null)
      for (var i = 0; i < pdfs.length; i++)
        await http.MultipartFile.fromBytes(
          'pdf',
          pdfs[i],
          filename: '${i}_${fileName}.pdf',
          contentType: MediaType('application', 'pdf'),
        ),
    if (pdf != null)
      await http.MultipartFile.fromBytes(
        'pdf',
        pdf,
        filename: '$fileName.pdf',
        contentType: MediaType('application', 'pdf'),
      ),

    // Audio Files (MP3)
    if (audios != null)
      for (var i = 0; i < audios.length; i++)
        await http.MultipartFile.fromBytes(
          'audio',
          audios[i],
          filename: '${i}_${fileName}.mp3',
          contentType: MediaType('audio', 'mpeg'),
        ),
    if (audio != null)
      await http.MultipartFile.fromBytes(
        'audio',
        audio,
        filename: '$fileName.mp3',
        contentType: MediaType('audio', 'mpeg'),
      ),

    // Word Documents (DOCX)
    if (words != null)
      for (var i = 0; i < words.length; i++)
        await http.MultipartFile.fromBytes(
          'word',
          words[i],
          filename: '${i}_${fileName}.docx',
          contentType: MediaType('application', 'vnd.openxmlformats-officedocument.wordprocessingml.document'),
        ),
    if (word != null)
      await http.MultipartFile.fromBytes(
        'word',
        word,
        filename: '$fileName.docx',
        contentType: MediaType('application', 'vnd.openxmlformats-officedocument.wordprocessingml.document'),
      ),

    // Video Files (MP4)
    if (videos != null)
      for (var i = 0; i < videos.length; i++)
        await http.MultipartFile.fromBytes(
          'video',
          videos[i],
          filename: '${i}_${fileName}.mp4',
          contentType: MediaType('video', 'mp4'),
        ),
    if (video != null)
      await http.MultipartFile.fromBytes(
        'video',
        video,
        filename: '$fileName.mp4',
        contentType: MediaType('video', 'mp4'),
      ),
  ];

  return files;
}

}

  // static Future<List<http.MultipartFile>> processingFilesPoketbase({
  //   Uint8List? imagen,
  //     List<Uint8List>? imagenes,
  //     Uint8List? documento,
  //     List<Uint8List>? documentos,
  //     required id,
  //     required String qr, 
  //     required String nombre,
  // }) async {
  //   String fileName = '${id}_${qr}_${nombre}';
  //   List<http.MultipartFile> files = [
  //        if (imagenes != null) 
  //            for(var i = 0; i < imagenes.length; i++ )
  //             http.MultipartFile.fromBytes('imagen', 
  //             await imagenes[i],
  //             filename: '${i}_$fileName.jpg'
  //        ),
  //        if (imagen != null)
  //             http.MultipartFile.fromBytes('imagen', 
  //             await imagen,//readbites ne caso de qu se reciba Imagen tipo FILE
  //             filename: '$fileName.jpg'),
  //        if (documentos != null)
  //            for(var i = 0; i < documentos.length; i++ )
  //              http.MultipartFile.fromBytes('file',
  //              await documentos[i],
  //              filename: '${i}_$fileName.pdf',
  //              contentType: MediaType('application', 'pdf'), // Content type for PDF
  //             ),
  //         if (documento != null)
  //              http.MultipartFile.fromBytes('file',
  //              await documento,
  //              filename: '$fileName.pdf',
  //              contentType: MediaType('application', 'pdf'), // Content type for PDF
  //             ),
  //   ];
  //   return files;
  // }