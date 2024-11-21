
import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webandean/provider/cache/files/files_procesisng.dart';
import 'package:webandean/utils/Files%20%20Selected/imagen/reorder_image_widget.dart';
import 'package:webandean/utils/files%20assset/assets_imge.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/text/assets_textapp.dart';


class FilesImagesSelectedMovil extends StatelessWidget {
  const FilesImagesSelectedMovil({super.key, required this.isListImage});
  final bool isListImage;
  @override
  Widget build(BuildContext context) {
    final filesdata = Provider.of<FilesProvider>(context);
    final imagenes = filesdata.imagenes;
    final imagenE = filesdata.imagen;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if(imagenes!= null || imagenE !=null)
        ListTile(
          contentPadding: EdgeInsets.all(0),
          minVerticalPadding: 0, 
          dense: true, 
          visualDensity: VisualDensity.compact,
          leading: Icon(Icons.select_all_outlined, color: Colors.blueGrey),
          title:  P3Text(text: 'Selecionados', color: Colors.blueGrey),
          trailing: TextButton(onPressed: () {
            context.read<FilesProvider>().setImagen(null);
            context.read<FilesProvider>().setImagenes(null);
          },
          child: P3Text(text:'borrar todo', color: Colors.blue,fontWeight: FontWeight.w500)),
        ),

        if(isListImage)//todos  si es lista de imagenes 
        ...[
        AppReorderImageWdiget( imagenE: imagenes ),
        Container(
          decoration: AssetDecorationBox().headerDecoration(color: Colors.transparent),
          child: ListTile(
            leading: Image.asset(AppImages.imageplaceholder300),
            onTap: () async => pickMultipleImagesFromGallery(context, filesdata),
            title: H2Text(text: 'Subir Imagenes'),
            subtitle:P3Text(text: 'Puedes cargar multiples Imagenes.'),
            trailing: Icon(Icons.upload),
          ),
        ),
       
       ],
        if(!isListImage)//todos  Solo una imagen 
        ...[
          AppReorderImageWdiget( imagenE: imagenE ),
          ListTile(
            leading: Image.asset(AppImages.imageplaceholder300),
            onTap: () async => pickImageFromGallery(context, filesdata, ImageSource.gallery),
            title: H2Text(text: 'Subir Imagen'),
            subtitle:P3Text(text: 'Puedes selecionar solo una imagen.'),
            trailing: Icon(Icons.upload),
          ),
          Container(
            decoration: AssetDecorationBox().headerDecoration(color: Colors.transparent),
            child: ListTile(
              leading: Image.asset(AppImages.cameraplaceholder300),
              onTap: () async => pickImageFromGallery(context, filesdata, ImageSource.camera),
              title: H2Text(text: 'Tomar Foto'),
              subtitle:P3Text(text: 'Puedes tomar una foto accede a la camara.'),
              trailing: Icon(Icons.upload),
            ),
          ),
         
          
        ],
      ],
    );
  }

  // Método para seleccionar una imagen del galería o cámara
  void pickImageFromGallery(BuildContext context, FilesProvider filesdata, ImageSource source) async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: source, imageQuality: 40);

      if (pickedFile != null) {
        File file = File(pickedFile.path);

        // Convertir PNG a JPEG si es necesario
        if (file.path.endsWith('.png')) {
          await convertPngToJpeg(file);
          file = File('${file.path}.jpg');  // Apunta al nuevo archivo .jpg
        }
        
        // Leer los bytes de la imagen y añadir a filesdata
        final imageBytes = await file.readAsBytes();
        filesdata.setImagen(imageBytes);  // Proveedor
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error selecting image: $e');
    }
  }

// Método para seleccionar múltiples imágenes desde la galería
  void pickMultipleImagesFromGallery(BuildContext context, FilesProvider filesdata) async {
    try {
      final picker = ImagePicker();
      final List<XFile>? pickedFiles = await picker.pickMultiImage(imageQuality: 40);

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        List<Uint8List> newImages = [];

        for (XFile pickedFile in pickedFiles) {
          File file = File(pickedFile.path);

          // Convertir PNG a JPEG si es necesario
          if (file.path.endsWith('.png')) {
            await convertPngToJpeg(file);
            file = File('${file.path}.jpg');
          }

          // Leer los bytes de la imagen
          final imageBytes = await file.readAsBytes();
          newImages.add(imageBytes);
        }

        // Agregar las nuevas imágenes a la lista existente en filesdata
        filesdata.setImagenes((filesdata.imagenes ?? []) + newImages);
      }
    } catch (e) {
      print('Error selecting multiple images from gallery: $e');
    }
  }

  // Conversión de PNG a JPEG
  Future<void> convertPngToJpeg(File file) async {
    try {
      final image = img.decodeImage(await file.readAsBytes());
      if (image != null) {
        final jpegBytes = Uint8List.fromList(img.encodeJpg(image));
        final jpegFile = File('${file.path}.jpg');
        await jpegFile.writeAsBytes(jpegBytes);
      }
    } catch (e) {
      print('Error converting PNG to JPEG: $e');
    }
  }
}