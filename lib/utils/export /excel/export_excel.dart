

import 'package:flutter/cupertino.dart';
import 'package:webandean/utils/conversion/assets_format_fecha.dart';
import 'package:webandean/utils/conversion/assets_format_values.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/exeption/exeption_try_cath.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/layuot/assets_circularprogrees.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/widget/htmldowloader/html_globaldowloader.dart';
import 'package:webandean/widget/movildowloader/movil_globaldowloader.dart';

class ExportExelListData<T> extends StatefulWidget {
  const ExportExelListData( {
    super.key, 
    this.icon, 
    this.titulo = 'ExportExel',
    required this.listData,
    required this.getRowValues
    });
  final List<T> listData;
  final Map<String, dynamic> Function(dynamic item) getRowValues;  // Cambio a Map
  final Widget? icon;
  final String? titulo;
  
  @override
  _ExportExelListDataState createState() => _ExportExelListDataState();
}

class _ExportExelListDataState extends State<ExportExelListData> {
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    final fecha = '${formatFecha(DateTime.now())} ${formatFechaPDfhora(DateTime.now())}';

    return isSaving
        ? AssetsCircularProgreesIndicator(color: Colors.green)
        : GestureDetector(
            child: widget.icon ?? AppSvg().excelSvg,
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
                    final message = '¿Deseas exportar en formato Excel? ';
                    TextToSpeechService().speak(message);
                    return AssetAlertDialogPlatform(
                      oK_textbuton: 'Exportar',
                      message: message, 
                      title: 'Confirmar Exportación', 
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
                  // Crea un nuevo archivo Excel
                  final excel = Excel.createExcel();
                 // Si deseas renombrar una hoja llamada "Sheet1" a "SheetRenamed"
                  excel.rename('Sheet1', '${widget.titulo}');
               
                  final sheet = excel['${widget.titulo}']; 
                  // Configura el ancho predeterminado de las columnas y ajusta automáticamente la columna 2
                  sheet.setDefaultColumnWidth(30);
                  // Configura la altura de las filas 0 y 1 a 40
                  sheet.setRowHeight(0, 40);
                  sheet.setRowHeight(1, 40);

                  
                  SheetCargarDatos(sheet: sheet);
                  // Codifica el archivo Excel a bytes y lo guarda en el directorio de documentos de la aplicación
                  final List<int>? excelBytes = await excel.encode();
                    if (excelBytes != null) {
                    //todos:  Si estás en Web, manejar la descarga
                    // metodoDescargaWebEXCEL(
                    //     excelBytes: excelBytes,
                    //    titulo: '${widget.titulo} ${fecha}',
                    //     context: context);

                    // metodoDescargaMovilEXcel(
                    //     excelBytes: excelBytes,
                    //     titulo: '${widget.titulo} ${fecha}',
                    //     context: context);
                  }
                 }
                },
                onFinally: () {
                   // Actualiza el estado para detener el indicador de guardado
                    setState(() {
                      isSaving = false;
                    });
                },
              );

            });
  }


  void SheetCargarDatos({required Sheet sheet}) {
    // Obtén las claves del Map, que serán los encabezados
    List<String> headers = widget.getRowValues(widget.listData.first).keys.toList();
  // Combina las celdas para el título
    int numColumns = headers.length;
  // Combina las celdas para el título
    // sheet.merge(CellIndex.indexByString('A1'), CellIndex.indexByString('${String.fromCharCode(65 + numColumns - 1)}1')); //todos 
    sheet.merge(CellIndex.indexByString('A1'), CellIndex.indexByString('${getColumnLetter(numColumns - 1)}1'));

    // Establece el valor del título en la celda combinada
    sheet.cell(CellIndex.indexByString('A1')).value =  TextCellValue(widget.titulo!.toUpperCase());
     // Establece el estilo de la celda (centrado y texto grande)
    sheet.cell(CellIndex.indexByString('A1')).cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Center,   
      fontSize: 14,                  
      bold: true,                
      verticalAlign: VerticalAlign.Center, 
      fontColorHex: ExcelColor.white,           
      backgroundColorHex: ExcelColor.teal600,      
    );
    
   // Agregar encabezados con estilo en la fila 2
  for (int i = 0; i < headers.length ; i++) {
    // String column = String.fromCharCode(65 + i); // A, B, C, etc.  //todos 
    String column = getColumnLetter(i); // Utiliza la función para obtener la letra de la columna
    String cellIndex = column + '2'; // Fila 2 para los encabezados

    // Establece el valor de la celda
    sheet.cell(CellIndex.indexByString(cellIndex)).value = TextCellValue(headers[i].toUpperCase());

    // Establece el estilo de la celda
    sheet.cell(CellIndex.indexByString(cellIndex)).cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Center,   
      verticalAlign: VerticalAlign.Center,       
      fontSize: 12,                            
      bold: true,                              
      fontColorHex: ExcelColor.white,           
      backgroundColorHex: ExcelColor.teal600,      
    );
  }

    // Iterar sobre la lista genérica y agregar una fila por cada elemento
    int rowIndex = 3; // Empezamos desde la fila 3 (ya que la fila 2 son los encabezados)
    for (var item in widget.listData) {
      // Obtener los valores de la fila
      var rowValues = widget.getRowValues(item).values.map((value) => parseToExcelCellValue(value)).toList();

      // Agregar la fila de datos
      sheet.appendRow(rowValues);

    // Aplicar estilo alternado a las filas
    for (int colIndex = 0; colIndex < rowValues.length; colIndex++) {

      // Establecer el estilo de la celda para cada valor en la fila
      // sheet.cell(CellIndex.indexByString("${String.fromCharCode(65 + colIndex)}$rowIndex")).cellStyle = CellStyle(  //todos 
      sheet.cell(CellIndex.indexByString("${getColumnLetter(colIndex)}$rowIndex")).cellStyle = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
        fontSize: 10,   // Ajusta el tamaño de fuente si es necesario
        fontColorHex: ExcelColor.black,  // Color del texto
        backgroundColorHex: (rowIndex % 2 != 0) ? ExcelColor.white : ExcelColor.brown50,  // Color de fondo alternado
      );
    }

    // Incrementar el índice de la fila
    rowIndex++;
  }
    
  }


   CellValue parseToExcelCellValue(dynamic e,) {
      if (e == null) return TextCellValue(''); // Retorna vacío si el valor es nulo

      if (e is DateTime) {
        DateTime fecha =  FormatValues.parseDateTime(e);
        if(fecha.year == 1998){
          return TextCellValue('');
        } else {
          return TextCellValue("${fecha.year}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')} ${fecha.hour.toString().padLeft(2, '0')}:${fecha.minute.toString().padLeft(2, '0')}");
        }
        
      } else if (e is double) {
        return  DoubleCellValue(FormatValues.parseToDouble(e.toStringAsFixed(2)));
      } else if (e is int) {
        return DoubleCellValue(FormatValues.parseToDouble(e.toStringAsFixed(0)));
      } else if (e is bool) {
        if (e) {
           return  TextCellValue("☑"); // Representing a checked checkbox
          } else {
           return TextCellValue("☐"); // Representing an unchecked checkbox
          }
      } else {
        return TextCellValue(e.toString()); // Usa TextCellValue para strings y otros tipos
      }
    }

    // Función para generar el nombre de la columna en formato A, B, C, AA, AB, etc.
  String getColumnLetter(int index) {
    String result = '';
    while (index >= 0) {
      result = String.fromCharCode(65 + (index % 26)) + result;
      index = (index / 26).floor() - 1;
    }
    return result;
  }
}

//todos Uso; 
// ExportExelListData(
//     titulo: menuProvider.selectedTitle,
//     listData: datTable, 
//     getRowValues: (items) {
//       TProductosAppModel e = items;
//         return {
//          'QR': e.qr,
//          'Nombre': e.nombre,
//          'Ubicación': e.ubicacion,
//          'Categoría Compras': e.categoriaCompras,
//          'Categoría Inventario': e.categoriaInventario,
//          'Moneda': e.moneda,
//          'Cantidad en Stock': e.cantidadEnStock,
//          'Unidad de Medida': e.intUndMedida,
//          'Activo': e.active,
//          'Unidad de Medida Distribución': e.outPrecioDistribucion,
//          'Fecha Vencimiento': e.fechaVencimiento,
//         };
//       },
//     );



// import 'dart:async';
// import 'dart:io';
// import 'package:webandean/utils/conversion/assets_format_fecha.dart';
// import 'package:webandean/utils/conversion/assets_format_values.dart';
// import 'package:webandean/utils/dialogs/assets_dialog.dart';
// import 'package:webandean/utils/files%20assset/assets-svg.dart';
// import 'package:webandean/utils/layuot/assets_circularprogrees.dart';
// import 'package:webandean/utils/speack/assets_speack.dart';
// import 'package:flutter/material.dart';
// import 'package:excel/excel.dart';
// import 'package:webandean/widget/movildowloader/movil_globaldowloader.dart';
// import 'package:excel/excel.dart' as excel;  // Asignamos un alias
// USO 

//  ExportExelListData(
                          //         titulo: menuProvider.selectedTitle,
                          //         listData: dataSelected, 
                          //           headers: ['SERIE','NOMBRE','UBICACIÓN','CATEGORIA COMPRA',
                          //           'CATEGORIA INVENTARIO','MONEDA','STOCK', 'UND MEDIDA COMPRA', 'ACTIVO', 'UND MEDIDA DISTRIBUCION', 'FECHA VENCIMIENTO'],
                          //           getRowValues: (items) {
                          //           TProductosAppModel e = items;
                          //             return [
                          //             e.qr, 
                          //             e.nombre, 
                          //             e.ubicacion,
                          //             e.categoriaCompras, 
                          //             e.categoriaInventario,
                          //             e.moneda,
                          //             e.cantidadEnStock,
                          //             e.intUndMedida, 
                          //             e.active,
                          //             e.outPrecioDistribucion,
                          //             e.fechaVencimiento,
                          //           ];
                          //           },
                          //         ),

// class ExportExelListData<T> extends StatefulWidget {
//   const ExportExelListData( {
//     super.key, 
//     this.icon, 
//     this.titulo = 'ExportExel',
//     required this.listData,
//     required this.headers, 
//     required this.getRowValues});
//   final List<T> listData;
//   final List<String> headers; 
//   final List<dynamic> Function(dynamic item) getRowValues;
//   final Widget? icon;
//   final String? titulo;
  
//   @override
//   _ExportExelListDataState createState() => _ExportExelListDataState();
// }

// class _ExportExelListDataState extends State<ExportExelListData> {
//   bool isSaving = false;

//   @override
//   Widget build(BuildContext context) {
//     final fecha = '${formatFecha(DateTime.now())} ${formatFechaPDfhora(DateTime.now())}';

//     return isSaving
//         ? AssetsCircularProgreesIndicator(color: Colors.green)
//         : GestureDetector(
//           // padding: EdgeInsets.all(0),
//             child: widget.icon ?? AppSvg().excelSvg,
//             onTap: () async {
//               setState(() {
//                 isSaving = true;
//               });
//               try {
//                 // Crea un nuevo archivo Excel
//                 final excel = Excel.createExcel();
//                 final sheet = excel['Sheet1']; // Obtiene la hoja "Sheet1" por defecto
//                 // Configura el ancho predeterminado de las columnas y ajusta automáticamente la columna 2
//                 sheet.setDefaultColumnWidth(30);
//                 sheet.setRowHeight(0, 40);
//                  sheet.setRowHeight(1, 40);
//                 // sheet.setColumnAutoFit(2);
//                 // Cargar Datos en Excel
//                 SheetCargarDatos(sheet: sheet);
//                 // Codifica el archivo Excel a bytes y lo guarda en el directorio de documentos de la aplicación
//                 final List<int>? excelBytes = await excel.encode();
                
//                 if (excelBytes != null) {
//                    //todos:  Si estás en Web, manejar la descarga
//                   // metodoDescargaWebEXCEL(
//                   //     excelBytes: excelBytes,
//                   //    titulo: '${widget.titulo} ${fecha}',
//                   //     context: context);

//                   metodoDescargaMovilEXcel(
//                       excelBytes: excelBytes,
//                       titulo: '${widget.titulo} ${fecha}',
//                       context: context);
//                 }
               
//               } on TimeoutException catch (e) {
//                 // Manejo de TimeoutException
//                 TextToSpeechService().speak(
//                     'Se agotó el tiempo de espera. Inténtelo de nuevo.${e.message}');
//                 AssetAlertDialogPlatform.show(
//                     context: context,
//                     message:
//                         'Se agotó el tiempo de espera. Inténtelo de nuevo.${e.message}',
//                     title: 'Tiempo de espera agotador');
//                 //AQUi se puede poner un emtodo para pedirle al usario reintentar
//               } on IOException catch (e) {
//                 // Manejo de IOException
//                 TextToSpeechService().speak('Error de entrada/salida: ${e}');
//                 AssetAlertDialogPlatform.show(
//                     context: context,
//                     message:
//                         'Error al guardar el archivo. Verifique su conexión y espacio en disco.${e}',
//                     title: 'Error de entrada/salida:');
//               } catch (e) {
//                 TextToSpeechService().speak('Se produjo un error.');
//                 AssetAlertDialogPlatform.show(
//                     context: context,
//                     message: 'Error al cargar PDF $e',
//                     title: 'Se produjo un error');
//                 print(e);
//               } finally {
//                 // Actualiza el estado para detener el indicador de guardado
//                 setState(() {
//                   isSaving = false;
//                 });
//               }
//             });
//   }

//    CellValue parseToExcelCellValue(dynamic e,) {
//       if (e == null) return TextCellValue(''); // Retorna vacío si el valor es nulo

//       if (e is DateTime) {
//         DateTime fecha =  FormatValues.parseDateTime(e);
//         if(fecha.year == 1998){
//           return TextCellValue('');
//         } else {
//           // return  DateTimeCellValue(
//           //   year:  e.year, 
//           //   month: e.month, 
//           //   day:   e.day, 
//           //   hour:  e.hour,
//           //   minute:  e.minute
//           //   ); // Usa el formato de celda DateTime para fechas
//           return TextCellValue("${fecha.year}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')} ${fecha.hour.toString().padLeft(2, '0')}:${fecha.minute.toString().padLeft(2, '0')}");
//         }
        
//       } else if (e is double) {
//         return  DoubleCellValue(FormatValues.parseToDouble(e.toStringAsFixed(2)));
//       } else if (e is int) {
//         return DoubleCellValue(FormatValues.parseToDouble(e.toStringAsFixed(0)));
//       } else if (e is bool) {
//         // print(e);
//         // return  BoolCellValue(FormatValues.parseBool(e.toString()));
//         if (e) {
//            return  TextCellValue("☑"); // Representing a checked checkbox
//           } else {
//            return TextCellValue("☐"); // Representing an unchecked checkbox
//           }
//       } else {
//         return TextCellValue(e.toString()); // Usa TextCellValue para strings y otros tipos
//       }
//     }

//   void SheetCargarDatos({required Sheet sheet}) {
//    // Obtén la cantidad de columnas
//     int numColumns = widget.headers.length;
//     // Combina las celdas para el título
//     sheet.merge(CellIndex.indexByString('A1'), CellIndex.indexByString('${String.fromCharCode(65 + numColumns - 1)}1'));

//     // Establece el valor del título en la celda combinada
//     sheet.cell(CellIndex.indexByString('A1')).value =  TextCellValue(widget.titulo!.toUpperCase());
//      // Establece el estilo de la celda (centrado y texto grande)
//     sheet.cell(CellIndex.indexByString('A1')).cellStyle = CellStyle(
//       horizontalAlign: HorizontalAlign.Center,   // Centra el texto
//       fontSize: 14,                   // Establece el tamaño de la fuente (puedes ajustarlo)
//       bold: true,                 // Pone el texto en negrita
//       verticalAlign: VerticalAlign.Center, 
//       fontColorHex: ExcelColor.white,            // Color de texto blanco (puedes cambiarlo)
//       backgroundColorHex: ExcelColor.teal600,      // Color de fondo azul (puedes cambiarlo)
//     );
    
//     // // Agregar encabezados con estilo
//     //   sheet.appendRow(
//     //     widget.headers.map((header) {
//     //       final index = String.fromCharCode(65 + widget.headers.indexOf(header)) + '2'; // 2: fila 2 Ajuste dinámico para cada columna
          
//     //       // Establece el valor de la celda
//     //       var cell = sheet.cell(CellIndex.indexByString(index)).value = TextCellValue(header.toUpperCase());  // Usamos TextCellValue para asignar el texto

//     //       sheet.cell(CellIndex.indexByString(index)).cellStyle = CellStyle(
//     //         horizontalAlign: HorizontalAlign.Center, // Centra el texto
//     //         verticalAlign: VerticalAlign.Center,     // Centra el texto verticalmente
//     //         fontSize: 12,                            // Establece un tamaño de fuente más pequeño
//     //         bold: true,                              // Pone el texto en negrita
//     //         backgroundColorHex: ExcelColor.grey300,  // Color de fondo gris claro
//     //         fontColorHex: ExcelColor.black,          // Color del texto negro
//     //       );
          
//     //       return cell;  // Retorna la celda creada
//     //     }).toList(),
//     //   );

//    // Agregar encabezados con estilo en la fila 2
//   for (int i = 0; i < widget.headers.length; i++) {
//     String column = String.fromCharCode(65 + i); // A, B, C, etc.
//     String cellIndex = column + '2'; // Fila 2 para los encabezados

//     // Establece el valor de la celda
//     sheet.cell(CellIndex.indexByString(cellIndex)).value = TextCellValue(widget.headers[i].toUpperCase());

//     // Establece el estilo de la celda
//     sheet.cell(CellIndex.indexByString(cellIndex)).cellStyle = CellStyle(
//       horizontalAlign: HorizontalAlign.Center,   // Centra el texto
//       verticalAlign: VerticalAlign.Center,       // Centra el texto verticalmente
//       fontSize: 12,                              // Tamaño de fuente más pequeño
//       bold: true,                                // Pone el texto en negrita
//       fontColorHex: ExcelColor.white,            // Color de texto blanco (puedes cambiarlo)
//       backgroundColorHex: ExcelColor.teal600,      // Color de fondo azul (puedes cambiarlo)       // Color de texto negro
//     );
//   }
//   //  // Agregar encabezados
//   //   sheet.appendRow(widget.headers.map((header) => TextCellValue(header)).toList());//HEADERS 

//      // Iterar sobre la lista genérica y agregar una fila por cada elemento
//     // for (var item in widget.listData) {
//     //   sheet.appendRow(
//     //     widget.getRowValues(item).map((value) => parseToExcelCellValue(value)).toList(),
//     //   );
//     // }
//     // Iterar sobre la lista genérica y agregar una fila por cada elemento
//   int rowIndex = 3; // Empezamos desde la fila 3 (ya que la fila 2 son los encabezados)
//   for (var item in widget.listData) {
//     // Obtener los valores de la fila
//     var rowValues = widget.getRowValues(item).map((value) => parseToExcelCellValue(value)).toList();

//     // Agregar la fila de datos
//     sheet.appendRow(rowValues);

//     // Aplicar estilo alternado a las filas
//     for (int colIndex = 0; colIndex < rowValues.length; colIndex++) {

//       // Establecer el estilo de la celda para cada valor en la fila
//       sheet.cell(CellIndex.indexByString("${String.fromCharCode(65 + colIndex)}$rowIndex")).cellStyle = CellStyle(
//         horizontalAlign: HorizontalAlign.Center,
//         verticalAlign: VerticalAlign.Center,
//         fontSize: 10,   // Ajusta el tamaño de fuente si es necesario
//         fontColorHex: ExcelColor.black,  // Color del texto
//         backgroundColorHex: (rowIndex % 2 != 0) ? ExcelColor.white : ExcelColor.brown50,  // Color de fondo alternado
//         leftBorder: excel.Border(borderStyle: excel.BorderStyle.None),
//         rightBorder:excel.Border(borderStyle: excel.BorderStyle.None),
//         topBorder: excel.Border(borderStyle: excel.BorderStyle.None),
//         bottomBorder: excel.Border(borderStyle: excel.BorderStyle.None),
//         diagonalBorder:excel.Border(borderStyle: excel.BorderStyle.None),
//       );
//     }

//     // Incrementar el índice de la fila
//     rowIndex++;
//   }
    
//   }
// }
