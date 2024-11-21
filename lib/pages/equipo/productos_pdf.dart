import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/layuot/assets_circularprogrees.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/responsiveTable/headers_global/header_generic.dart';
import 'package:webandean/utils/routes/assets_img_urlserver.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/widget/movildowloader/movil_globaldowloader.dart';
// import 'package:webandean/widget/responsiveTable/global_paginated_table.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img; // Importa la biblioteca para manipular imágenes


List headertable = [
  '',
  'Vence',
  'Categoría',
  'Nombre',
  'Ubicación',
  'Marca',
  'Precio',
  'Stock',
  'Imagen',
];

class PDFProductos extends StatefulWidget {
  const PDFProductos(
      {super.key, 
      required this.listaTproductos, 
      // required this.titulo, 
      this.icon
      });
  final List<TProductosAppModel> listaTproductos;
  // final String titulo;
  final Widget? icon;

  @override
  State<PDFProductos> createState() => _PDFProductosState();
}

class _PDFProductosState extends State<PDFProductos> {
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return isSaving
        ? AssetsCircularProgreesIndicator(color: Colors.red)
        : GestureDetector(
          // padding: EdgeInsets.all(0),
            // tooltip: 'Exportar a PDF por categoría',
            child: widget.icon ?? AppSvg().pdfSvg,
            onTap: () async {
              // TextToSpeechService().speak('iniciando');
              setState(() {
                isSaving = true;
              });
              try {
                // Precargar todas las imágenes
               TextToSpeechService().speak(
    'Iniciando. Preparando imágenes para el PDF. Este proceso puede tardar varios minutos dependiendo de la cantidad y tamaño de las imágenes. Por favor, tenga paciencia.');

                Map<String, Uint8List?> imageBytesMap =
                    await _loadAllImages(widget.listaTproductos)
                        .timeout(Duration(minutes: 10));
  
                pw.Document pdf = pw.Document();
                int rowsPerPage =
                    12; // Define cuántas filas caben en una página
                int totalPages =
                    (widget.listaTproductos.length / rowsPerPage).ceil();

                for (int page = 0; page < totalPages; page++) {
                  int startRow = page * rowsPerPage;
                  int endRow = startRow + rowsPerPage;

                  List<TProductosAppModel> currentPageData =
                      widget.listaTproductos.sublist(
                    startRow,
                    endRow > widget.listaTproductos.length
                        ? widget.listaTproductos.length
                        : endRow,
                  );

                  pdf.addPage(pw.MultiPage(
                    margin:
                        pw.EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    maxPages: 500,
                    header: (context) {
                      return pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          // pw.Text(widget.titulo,
                          //     style: pw.TextStyle(
                          //         fontSize: 12,
                          //         fontWeight: pw.FontWeight.bold)),
                          pw.Text('${widget.listaTproductos.length} registros',
                              style: pw.TextStyle(
                                  fontSize: 8, color: PdfColors.grey600)),
                        ],
                      );
                    },
                    build: (pw.Context context) {
                      return [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(height: 5),
                            generateTable(currentPageData, imageBytesMap),
                          ],
                        ),
                      ];
                    },
                  ));
                }

                Uint8List bytes =
                    await pdf.save().timeout(Duration(minutes: 10));
                //MODDESCARGA ARCHIVO
                // todos: Si estás en Movíl, manejar la descarga
                metodoDescargaMovilPDF(
                    bytes: bytes, titulo: "widget.titulo", context: context);
                //todos:  Si estás en Web, manejar la descarga
                // metodoDescagaWebPDF(
                //     bytes: bytes, titulo: "widget.titulo", context: context);
                
              } on TimeoutException catch (e) {
                // Manejo de TimeoutException
                TextToSpeechService().speak(
                    'Se agotó el tiempo de espera. Inténtelo de nuevo.${e.message}');
                AssetAlertDialogPlatform.show(
                    context: context,
                    message:
                        'Se agotó el tiempo de espera. Inténtelo de nuevo.${e.message}',
                    title: 'Tiempo de espera agotador');
                //AQUi se puede poner un emtodo para pedirle al usario reintentar
              } on IOException catch (e) {
                // Manejo de IOException
                TextToSpeechService().speak('Error de entrada/salida: ${e}');
                AssetAlertDialogPlatform.show(
                    context: context,
                    message:
                        'Error al guardar el archivo. Verifique su conexión y espacio en disco.${e}',
                    title: 'Error de entrada/salida:');
              } catch (e) {
                TextToSpeechService().speak('Se produjo un error.');
                AssetAlertDialogPlatform.show(
                    context: context,
                    message: 'Error al cargar PDF $e',
                    title: 'Se produjo un error');
              } finally {
                setState(() {
                  isSaving = false;
                });
              }
            },
          );
  }

  //CARGAR IMAGENS ANTES DE ENVIARLAS AL PDF

Future<Map<String, Uint8List?>> _loadAllImages(
    List<TProductosAppModel> listData) async {
  Map<String, Uint8List?> imageBytesMap = {};
  for (TProductosAppModel e in listData) {
    try {
      Uint8List? logoBytes = await loadImageFromUrl(
        collectionId: e.collectionId,
        id: e.id,
        file: e.imagen?[0],
      );
      
      if (logoBytes != null) {
        // Decodificar la imagen desde los bytes
        img.Image? image = img.decodeImage(logoBytes);

        if (image != null) {
          // Reducir la calidad de la imagen
          img.Image resizedImage = img.copyResize(image, width: 200); // Ajusta el ancho según sea necesario

          // Codificar la imagen redimensionada de nuevo a bytes
          Uint8List resizedBytes = Uint8List.fromList(img.encodeJpg(resizedImage, quality: 40)); // Ajusta la calidad aquí

          imageBytesMap[e.id] = resizedBytes;
        } else {
          imageBytesMap[e.id] = null;
        }
      } else {
        imageBytesMap[e.id] = null;
      }
    } catch (er) {
      imageBytesMap[e.id] = null;
    }
  }
  return imageBytesMap;
}


  //GENRAR DATOS EN EL PDF
  pw.Table generateTable(List<TProductosAppModel> listData,
      Map<String, Uint8List?> imageBytesMap) {
    return listData.isEmpty
        ? pw.Table(
            children: [
              pw.TableRow(children: [
                pw.Center(
                  child: pw.Text('No hay datos disponibles',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.black)),
                ),
              ]),
            ],
          )
        : pw.Table(
            border: pw.TableBorder.all(
              color: PdfColors.grey200,
              width: 0.5,
            ),
            columnWidths: {
              0: pw.FixedColumnWidth(15),
              1: pw.FixedColumnWidth(50),
              2: pw.FixedColumnWidth(70),
              3: pw.FixedColumnWidth(150),
              // 4: pw.FixedColumnWidth(100),
              // 5: pw.FixedColumnWidth(60),
              // 6: pw.FixedColumnWidth(50),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                children: headertable.map((header) {
                  return pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Center(
                      child: pw.Text(
                        header,
                        style: pw.TextStyle(
                            fontSize: 8, fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
              ),
              ...listData.map((e) {
                Uint8List? logoBytes = imageBytesMap[
                    e.id]; // Obtiene la imagen usando el ID del producto
                return pw.TableRow(
                  decoration: const pw.BoxDecoration(
                    border: pw.Border.symmetric(
                      horizontal:
                          pw.BorderSide(color: PdfColors.grey200, width: 0.5),
                    ),
                  ),
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('${listData.indexOf(e) + 1}',
                          style: pw.TextStyle(
                              fontSize: 5, color: PdfColors.grey600)),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                          e.fechaVencimiento.year == 1998
                              ? ' \n '
                              : formatFechaReponsiveDataTable(
                                  e.fechaVencimiento),
                          style: pw.TextStyle(
                              fontSize: 6, color: PdfColors.grey800)),
                    ),
                    // pw.Container(
                    //   padding: const pw.EdgeInsets.all(4),
                    //   child: pw.Text(e.idCategoria,
                    //       style: const pw.TextStyle(fontSize: 8)),
                    // ),
                    // pw.Container(
                    //   padding: const pw.EdgeInsets.all(4),
                    //   child: pw.Text(e.nombreProducto,
                    //       style: const pw.TextStyle(fontSize: 8)),
                    // ),
                    // pw.Container(
                    //   padding: const pw.EdgeInsets.all(4),
                    //   child: pw.Text(e.idUbicacion,
                    //       style: const pw.TextStyle(fontSize: 8)),
                    // ),
                    // pw.Container(
                    //   padding: const pw.EdgeInsets.all(4),
                    //   child: pw.Text(e.marcaProducto,
                    //       style: const pw.TextStyle(fontSize: 8)),
                    // ),
                    // pw.Container(
                    //   padding: const pw.EdgeInsets.all(4),
                    //   child: pw.Text(
                    //       '${e.moneda}  ${e.precioUnd?.toStringAsFixed(1) ?? ''}',
                    //       style: const pw.TextStyle(fontSize: 8),
                    //       textAlign: pw.TextAlign.center),
                    // ),
                    // pw.Container(
                    //   padding: pw.EdgeInsets.all(4),
                    //   child: pw.Text(e.stock?.toStringAsFixed(1) ?? '',
                    //       style: const pw.TextStyle(fontSize: 8),
                    //       textAlign: pw.TextAlign.center),
                    // ),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(4),
                      child: (logoBytes != null && logoBytes.isNotEmpty)
                          ? pw.Image(pw.MemoryImage(logoBytes),
                              fit: pw.BoxFit.contain, width: 50, height: 50)
                          : pw.Container(width: 50, height: 50),
                    ),
                  ],
                );
              }).toList(),
            ],
          );
  }
}



