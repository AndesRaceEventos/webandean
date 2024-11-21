import 'dart:async';

import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img;
import 'package:webandean/utils/conversion/assets_format_fecha.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';

import 'package:webandean/utils/exeption/exeption_try_cath.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/files%20assset/assets_imge.dart';
import 'package:webandean/utils/layuot/assets_circularprogrees.dart';
import 'package:webandean/utils/routes/assets_img_urlserver.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/widget/htmldowloader/html_globaldowloader.dart';

import 'package:webandean/widget/movildowloader/movil_globaldowloader.dart';




class ExportPDFListData extends StatefulWidget {
  const ExportPDFListData(
      {super.key, 
      required this.listaTproductos, 
      // required this.headertable, 
       required this.getRowValues,
       this.titulo = 'Expor PDF' , 
      this.icon, 
      required this.includeImages, 
      });
  // final List<TProductosAppModel> listaTproductos;
  final List<dynamic> listaTproductos;
  final String? titulo;
  final Widget? icon;
  // final List<String> headertable;
   final Map<String, dynamic> Function(dynamic item) getRowValues;
  final bool includeImages;  // Nuevo parámetro para saber si incluir imágenes o no

  @override
  State<ExportPDFListData> createState() => _ExportPDFListDataState();
}

class _ExportPDFListDataState extends State<ExportPDFListData> {
  bool isSaving = false;
  @override
  Widget build(BuildContext context) {
   final fecha = '${formatFecha(DateTime.now())} ${formatFechaPDfhora(DateTime.now())}';
   String message = 'Preparando imágenes para PDF. Esto puede tardar unos minutos. Gracias por su paciencia.';
    
    return isSaving
        ? AssetsCircularProgreesIndicator(color: Colors.red)
        : GestureDetector(
            child: widget.icon ?? AppSvg().pdfSvg,
            onTap: () async {

              setState(() {
                isSaving = true;
              });

              await ExceptionClass.tryCathCustom(
                task: () async {
             //COnfirmacion  
              bool isAdd = await showDialog(
                  context: context,
                  builder: (context) {
                    final message = '¿Deseas exportar el formato PDF? ${widget.includeImages ? 'El archivo incluirá imágenes.' : ''}';
                    TextToSpeechService().speak(message);
                    return AssetAlertDialogPlatform(
                      oK_textbuton: 'Exportar',
                      message: message, 
                      title: 'Confirmar Exportación', 
                      child: Column(
                        children: [
                          if(widget.includeImages )
                          Image.asset(AppImages.imageplaceholder300, height: 100)
                        ],
                      ),
                      actionButon: CupertinoDialogAction(
                          child: Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      );
                  }
                ) ?? true;
            if (!isAdd) {
              
          
               Map<String, Uint8List?> imageBytesMap = {};
              // Solo cargar imágenes si el usuario lo ha activado
              if (widget.includeImages) {
                 TextToSpeechService().speak(message);
                //todos Cargar Imagenes : este proceso se dan antes de crear el PDF
                imageBytesMap = await _loadAllImages(widget.listaTproductos)
                  .timeout(Duration(minutes: 10), 
                    onTimeout: () {
                      String onTimeout = 'La solicitud ha tardado demasiado tiempo en responder.';
                      TextToSpeechService().speak(onTimeout);
                      throw TimeoutException(onTimeout);
                    })
                  .then((value) {
                    // Si todo sale bien
                    TextToSpeechService().speak("Imágenes cargadas exitosamente.");
                    return value;
                  }).catchError((error) {
                    // Si falla la carga
                    TextToSpeechService().speak("Error al cargar imágenes.");
                    throw error; // Lanza el error nuevamente
                  });
              }
                 
              
              
               
                pw.Document pdf = pw.Document();
                int rowsPerPage = widget.includeImages ? 14 : 23; // Define cuántas filas caben en una página
                // El método ceil() en Dart redondea un número decimal al siguiente entero más alto. 
                int totalPages = (widget.listaTproductos.length / rowsPerPage).ceil();

                for (int page = 0; page < totalPages; page++) {
                  int startRow = page * rowsPerPage;
                  int endRow = startRow + rowsPerPage;

                  List<dynamic> currentPageData =
                      widget.listaTproductos.sublist( 
                        startRow,endRow > widget.listaTproductos.length ? widget.listaTproductos.length : endRow);

                  pdf.addPage(pw.MultiPage(
                    margin: pw.EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    maxPages: 500,
                    header: (pw.Context context) {
                      return pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(widget.titulo!,
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold)),
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
                    footer: (pw.Context context){
                     
                      return pw.Center(child:  pw.Text(fecha,  style: pw.TextStyle(
                                  fontSize: 8, color: PdfColors.grey600)));
                    }
                  ));
                }

                Uint8List bytes = await pdf.save().timeout(Duration(minutes: 10));
                //MODDESCARGA ARCHIVO
                // todos: Si estás en Movíl, manejar la descarga
                metodoDescargaMovilPDF(
                    bytes: bytes, titulo: '${widget.titulo} ${fecha}', context: context);
                //todos:  Si estás en Web, manejar la descarga
                // metodoDescagaWebPDF(
                //     bytes: bytes, titulo: '${widget.titulo} ${fecha}', context: context);
                
                 }
              }, 
               onFinally: () {
                setState(() {
                  isSaving = false;
                });
               
              });
            },
          );
  }

  //CARGAR IMAGENS ANTES DE ENVIARLAS AL PDF

Future<Map<String, Uint8List?>> _loadAllImages(
    List<dynamic> listData) async {
  Map<String, Uint8List?> imageBytesMap = {};
  for (dynamic e in listData) {
   final List<String> imagen = e.imagen is String
                            ? [e.imagen]
                            : e.imagen;
    try {
      Uint8List? logoBytes = await loadImageFromUrl(
        collectionId: e.collectionId,
        id: e.id,
        file: imagen[0]//e.imagen?[0],
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
  pw.Table generateTable(List<dynamic> listData,
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
              // 0: pw.FixedColumnWidth(20),
              // 1: pw.FixedColumnWidth(100),
              // 2: pw.FixedColumnWidth(70),
              // 3: pw.FixedColumnWidth(150),
              // 4: pw.FixedColumnWidth(100),
              // 5: pw.FixedColumnWidth(60),
              // 6: pw.FixedColumnWidth(50),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                children:[
                  ...widget.getRowValues(widget.listaTproductos.first).keys.map((header) {
                  return pw.Container(
                      color: PdfColors.teal600,
                      padding: const pw.EdgeInsets.symmetric(horizontal:1, vertical: 4),
                      child: pw.Center(
                        child: pw.Text(
                        header == '' ? '-' : header.toUpperCase(),
                          style: pw.TextStyle(fontSize: 6, fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                          textAlign: pw.TextAlign.center,
                          maxLines: 1,
                          overflow: pw.TextOverflow.visible
                        ),
                      ),
                    );
                }).toList(),
                
                // Solo agregar la imagen si está habilitada
                if (widget.includeImages)
                pw.Container(
                    color: PdfColors.teal600,
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Center(
                      child: pw.Text(
                        'IMAGEN',
                        style: pw.TextStyle(fontSize: 6, fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                        textAlign: pw.TextAlign.center,
                        maxLines: 1,
                        overflow: pw.TextOverflow.visible
                      ),
                    ),
                  ),
                ]
              ),
              ...listData.map((e) {
                Uint8List? logoBytes = imageBytesMap[e.id]; // Obtiene la imagen usando el ID del producto
                return pw.TableRow(
                  verticalAlignment: pw.TableCellVerticalAlignment.middle,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border.symmetric(
                      horizontal: pw.BorderSide(color: PdfColors.grey200, width: 0.5),
                    ),
                  ),
                  children: [
                    ... widget.getRowValues(e).values.map((value){
                      return  pw.Container(
                        height: 31,
                      padding:  pw.EdgeInsets.all(4), 
                      child: pw.Center(
                         child: parseToExcelCellValue(value)
                         ),
                    );
                    }).toList(),

                    // Solo agregar la imagen si está habilitada
                    if (widget.includeImages)
                      pw.Container(
                      padding: const pw.EdgeInsets.all(0),
                      child: (logoBytes != null && logoBytes.isNotEmpty)
                          ? pw.Image(pw.MemoryImage(logoBytes),
                              fit: pw.BoxFit.cover, width: 60, height: 50)
                          : pw.Container(width: 50, height: 50),
                    ),
                  ],
                );
              }).toList(),
            ],
          );
  }

  pw.Widget parseToExcelCellValue(dynamic e,) {
      if (e == null) return textPdf('-');

      if (e is DateTime) {
        final fecha = '${formatFecha(e)}\n${formatFechaPDfhora(e)}';
        if(e.year == 1998){
          return textPdf('-');
        } else {
          return pw.Text( fecha.toString(),
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
          fontSize: 6, color: determinarEstado(e)));
        }
        
      } else if (e is double) {
        return  textPdf(e.toStringAsFixed(2).toString());
      } else if (e is int) {
        return textPdf(e.toStringAsFixed(0).toString());
      } else if (e is bool) {
       
           return  pw.Checkbox(
            value: e, 
            height: 10,
            width: 10, 
            activeColor: PdfColors.teal600,
            name: ''); // Representing a checked checkbox
        
      } else {
        return textPdf(e.toString()); // Usa TextCellValue para strings y otros tipos
      }
    }

  pw.Widget textPdf(String value) {
    return pw.Text( value.toString(),// + " $value  HOLA MUNDO ",
      textAlign: pw.TextAlign.center,
      maxLines: widget.includeImages ? 3 : 2,
      // overflow: pw.TextOverflow.visible,
      style: pw.TextStyle(
      fontSize: 6, color: PdfColors.grey800));
  }


// Método para determinar el estado basado en la fecha
PdfColor determinarEstado(DateTime fecha) {
  final now = DateTime.now();
  if (fecha.isBefore(now)) {
    return PdfColors.red600;
  } else if (fecha.difference(now).inDays <= 7) {
    return PdfColors.orange800;
  }
  else if (fecha.difference(now).inDays <= 15) {
    return PdfColors.green700;
  }
  else {
    return PdfColors.black;
  }
}

}


// USO SIMPLE
//  PDFProductos(
//     includeImages: true,
//     titulo: menuProvider.selectedTitle,
//     listaTproductos: datTable,  
//      getRowValues: (items) {
//        TProductosAppModel e = items;
//          return {
//         'QR': e.qr,
//         'Nombre': e.nombre,
//         'Ubicación': e.ubicacion,
//         'Categoría Compras': e.categoriaCompras,
//         'Categoría Inventario': e.categoriaInventario,
//         'Moneda': e.moneda,
//         'Cantidad en Stock': e.cantidadEnStock,
//         'Unidad de Medida': e.intUndMedida,
//         'Activo': e.active,
//         'Unidad de Medida Distribución': e.outPrecioDistribucion,
//         'Fecha Vencimiento': e.fechaVencimiento,
//         };
//       },
//     ),




