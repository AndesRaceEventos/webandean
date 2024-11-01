import 'dart:async';
import 'dart:io';
import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/utils/conversion/assets_format_parse_string_a_double.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/files/assets-svg.dart';
import 'package:webandean/utils/layuot/assets_circularprogrees.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
// import 'package:webandean/widget/htmldowloader/html_globaldowloader.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:webandean/widget/movildowloader/movil_globaldowloader.dart';
// import 'package:webandean/widget/htmldowloader/html_globaldowloader.dart'; // Importa la biblioteca para trabajar con archivos Excel.

class ExcelExportProductos extends StatefulWidget {
  const ExcelExportProductos(
      {super.key, required this.listaTproductos, 
      // required this.titulo, 
      this.icon});
  final List<TProductosAppModel> listaTproductos;
  // final String titulo;
  final Widget? icon;

  @override
  _ExcelExportProductosState createState() => _ExcelExportProductosState();
}

class _ExcelExportProductosState extends State<ExcelExportProductos> {
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return isSaving
        ? AssetsCircularProgreesIndicator(color: Colors.green)
        : IconButton(
          padding: EdgeInsets.all(0),
            icon: widget.icon ?? AppSvg().excelSvg,
            onPressed: () async {
              setState(() {
                isSaving = true;
              });
              try {
                // Crea un nuevo archivo Excel
                final excel = Excel.createExcel();
                final sheet =
                    excel['Sheet1']; // Obtiene la hoja "Sheet1" por defecto
                // Configura el ancho predeterminado de las columnas y ajusta automáticamente la columna 2
                sheet.setDefaultColumnWidth(16);
                sheet.setColumnAutoFit(2);
                // Cargar Datos en Excel
                SheetCargarDatos(sheet: sheet);
                // Codifica el archivo Excel a bytes y lo guarda en el directorio de documentos de la aplicación
                final List<int>? excelBytes = await excel.encode();
                
                if (excelBytes != null) {
                   //todos:  Si estás en Web, manejar la descarga
                  // metodoDescargaWebEXCEL(
                  //     excelBytes: excelBytes,
                  //     titulo: "widget.titulo",
                  //     context: context);

                  metodoDescargaMovilEXcel(
                      excelBytes: excelBytes,
                      titulo: 'widget.titulo',
                      context: context);
                }
               
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
                // Actualiza el estado para detener el indicador de guardado
                setState(() {
                  isSaving = false;
                });
              }
            });
  }

  void SheetCargarDatos({required Sheet sheet}) {
    // Título y encabezados
    sheet.appendRow([
      TextCellValue("widget.titulo".toUpperCase()),
    ]);
    sheet.appendRow([
       TextCellValue('Vence'),
       TextCellValue('Articulo'),
       TextCellValue('Ubicación'),
       TextCellValue('Categoría'),
       TextCellValue('Proveedor'),
       TextCellValue('Marca'),
       TextCellValue('Medida'),
       TextCellValue('Entradas'),
       TextCellValue('Salidas'),
       TextCellValue('Existencias'),
       TextCellValue('Precio'),
       TextCellValue('Estado')
    ]);

    // Itera sobre la lista de productos y agrega una fila por cada producto
    for (var e in widget.listaTproductos) {
      final index = widget.listaTproductos.indexOf(e);
      sheet.setRowHeight(index + 2, 20); // Ajusta la altura de la fila

      // Usa el método para convertir el DateTime a DateTimeCellValue
      sheet.appendRow([
        TextCellValue(
            '${e.fechaVencimiento.year == 1998 ? '' : e.fechaVencimiento}'),
        TextCellValue('${e.nombre}'),
        TextCellValue(e.ubicacion),
        TextCellValue(e.categoriaCompras),
        TextCellValue(e.proveeduria),
        TextCellValue(e.moneda),
        TextCellValue(e.intUndMedida),
        DoubleCellValue(parseToDouble(e.cantidadEnStock!.toStringAsFixed(2))),
        DoubleCellValue(parseToDouble(e.cantidadEnStock!.toStringAsFixed(2))),
        DoubleCellValue(parseToDouble(e.cantidadEnStock!.toStringAsFixed(2))),
        DoubleCellValue(parseToDouble(e.intPrecioCompra!.toStringAsFixed(2))),
        TextCellValue(
            e.active! ? '✔️' : '✘') // Representa true como "✔️" y false como "✘"
      ]);
    }
  }
}
