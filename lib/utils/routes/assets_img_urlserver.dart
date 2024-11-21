import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';
import 'package:http/http.dart' as http;
import 'package:webandean/api/api_poketbase.dart';
import 'package:webandean/utils/animations/assets_delayed_display.dart';
import 'package:webandean/utils/files%20assset/assets_imge.dart';
import 'package:webandean/utils/layuot/assets_circularprogrees.dart';

class GLobalImageUrlServer extends StatelessWidget {
  const GLobalImageUrlServer(
      {super.key,
      required this.image,
      required this.collectionId,
      required this.id,
      required this.borderRadius,
      this.height,
      this.width,
      this.boxFit = BoxFit.cover,
      this.color,
      this.fadingDuration = 1200,
      this.duration = 1000,
      this.curve = Curves.ease,
      this.data});
  final String image;
  final String collectionId;
  final String id;
  final BorderRadiusGeometry borderRadius;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;
  final int fadingDuration;
  final int duration;
  final Curve curve;
  final List<String>? data;

  @override
  Widget build(BuildContext context) {

    final imageUrl = (image != null && image is String && image.isNotEmpty && (collectionId.isNotEmpty || id.isNotEmpty))
        ? '$urlserver/api/files/${collectionId}/${id}/${image}'
        : 'https://via.placeholder.com/300';
    return GestureDetector(
      onTap: () {
        if (data != null) {
          String pathImg(String url) {
            return '$urlserver/api/files/${collectionId}/${id}/${url}';
          }

          final List<ImageProvider> imageProviders = data
                  ?.map((url) => CachedNetworkImageProvider(pathImg(url)))
                  .toList() ??
              [];

          showImageViewerPager(
            context,
            useSafeArea: true, 
            swipeDismissible: true,
            MultiImageProvider(imageProviders),
            backgroundColor: Colors.black12,
            onViewerDismissed: (index) {
              print("Visor de imagen cerrado");
            },
          );
        }
      },
      child: AssetsDelayedDisplayX(
        fadingDuration: fadingDuration,
        duration: duration,
        curve: curve,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: CachedNetworkImage(
            // ignore: unnecessary_null_comparison, unnecessary_type_check
            imageUrl: imageUrl,
            placeholder: (context, url) => const Center(
                child: AssetsCircularProgreesIndicator(
              color: Colors.red,
            )),
            errorWidget: (context, url, error) => imagenLogo(),
            fit: boxFit,
            width: width,
            height: height,
            color: color,
          ),
        ),
      ),
    );
  }
}

Container imagenLogo() {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage(AppImages.imageplaceholder300),
        ),
        color: Colors.red.withOpacity(.3)),
  );
}



Future<Uint8List> loadImageFromUrl(
    {String? collectionId, String? id, String? file}) async {
  // Verificar si los parámetros son válidos
  if (collectionId == null || id == null || file == null) {
    throw Exception(
        'Invalid parameters: collectionId, id, and file must not be null.');
  }

  // Construir la URL
  String imageUrl =
      '$urlserver/api/files/$collectionId/$id/$file';
  print('Loading image from URL: $imageUrl');

  try {
    // Realizar la solicitud HTTP
    final response = await http.get(Uri.parse(imageUrl));

    // Verificar el código de estado de la respuesta
    if (response.statusCode != 200) {
      throw Exception(
          'Failed to load image from $imageUrl. Status code: ${response.statusCode}');
    }

    // Devolver los bytes de la imagen
    return response.bodyBytes;
  } catch (e) {
    // Manejar cualquier excepción que ocurra
    print('Error loading image: $e');
    throw Exception('Error loading image: $e');
  }
}

Future<Uint8List> loadAssetImage(String assetPath) async {
  ByteData byteData = await rootBundle.load(assetPath);
  return byteData.buffer.asUint8List();
}

Future<Uint8List> loadSvgFromAsset(String assetPath) async {
  ByteData byteData = await rootBundle.load(assetPath);
  return byteData.buffer.asUint8List();
}
