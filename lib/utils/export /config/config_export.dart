
import 'package:flutter/material.dart';
import 'package:webandean/utils/export%20/pdf/export_pdf.dart';
import 'package:webandean/utils/button/assets_boton_style.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/export%20/excel/export_excel.dart';
import 'package:webandean/utils/animations/assets_animationswith.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/layuot/asset_listtile.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

import 'package:provider/provider.dart';
import 'package:webandean/provider/cache/menuWeb/menu_state.dart';

class FooterExport extends StatefulWidget {
  const FooterExport({
    super.key, 
    required this.datTable, 
    required this.dataSelected, 
    required this.defaultMap,
    required this.getValueFromModel,  // Parámetro para la función
    });
  final  dynamic datTable;
  final dynamic dataSelected;
  final  Map<String, bool> defaultMap;
  final dynamic Function(String key, dynamic model) getValueFromModel;  // Recibe función global con tipo dynamic

  @override
  State<FooterExport> createState() => _FooterExportState();
}

class _FooterExportState extends State<FooterExport> {
  
 late Map<String, bool> defaultMap;
 Map<String, bool> fieldMap = {};  // Inicialización vacía de fieldMap
 
  @override
  void initState() {
    super.initState();
    defaultMap = widget.defaultMap;  // Se asigna el valor pasado desde el widget
    fieldMap = Map.from(defaultMap);  // Ahora se puede crear fieldMap con los valores iniciales
  }

  // Map<String, bool> fieldMap = Map.from(defaultMap);
  bool includeImages = true; // Valor por defecto para incluir imágenes

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    return Container(
          height: 30,
          child: Row(
            children: [
               // Botón para configurar los campos del PDF y habilitar imágenes
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _configureFields(context);
            },
          ),
              AssetsAnimationSwitcher(
                isTransition: true,
                directionLeft: true,
                duration: 1000,
                child: widget.dataSelected.isEmpty
                    ? Row(
                      children: [
                      //  exportExcelData(menuProvider, datTable),
                      ExportExelListData(
                        titulo: menuProvider.selectedTitle,
                        listData: widget.datTable, 
                        getRowValues: (e) {
                          // TProductosAppModel e = items;
                          // Filtrar los campos seleccionados
                          final Map<String, dynamic> selectedFields = {};
                          fieldMap.forEach((key, value) {
                            if (value) {
                              selectedFields[key] = widget.getValueFromModel(key, e);
                            }
                          });
                          return selectedFields;
                          },
                        ),

                      ExportPDFListData(
                        includeImages: includeImages,
                        titulo: menuProvider.selectedTitle,
                        listaTproductos: widget.datTable,
                        getRowValues: (e) {
                          // TProductosAppModel e = items;
                          // Filtrar los campos seleccionados
                          final Map<String, dynamic> selectedFields = {};
                          fieldMap.forEach((key, value) {
                            if (value) {
                              selectedFields[key] = widget.getValueFromModel(key, e);
                            }
                          });
                          return selectedFields;
                        },
                      ),
                      ],
                     )
                    : Row(
                      children: [
                        checkBox(widget.dataSelected.length),
                        // exportExcelData(menuProvider, dataSelected),
                        // PDFProductos(
                        //     listaTproductos:dataSelected),
                        ExportPDFListData(
                        includeImages: includeImages,
                        titulo: menuProvider.selectedTitle,
                        listaTproductos: widget.dataSelected,
                        getRowValues: (e) {
                          // TProductosAppModel e = items;

                          // Filtrar los campos seleccionados
                          final Map<String, dynamic> selectedFields = {};
                          fieldMap.forEach((key, value) {
                            if (value) {
                              selectedFields[key] = widget.getValueFromModel(key, e);
                            }
                          });

                          return selectedFields;
                        },
                      ),

                       ExportExelListData(
                        titulo: menuProvider.selectedTitle,
                        listData: widget.dataSelected, 
                        getRowValues: (e) {
                          // TProductosAppModel e = items;
                          // Filtrar los campos seleccionados
                          final Map<String, dynamic> selectedFields = {};
                          fieldMap.forEach((key, value) {
                            if (value) {
                              selectedFields[key] = widget.getValueFromModel(key, e);
                            }
                          });
                          return selectedFields;
                          },
                        ),
                      ],
                    ),
              ),
            ],
          ),
        );
  }

void _configureFields(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        bool localIncludeImages = includeImages;
        Map<String, bool> localFieldMap = Map.from(fieldMap);
         int selectedCount = localFieldMap.values.where((v) => v).length;

         void updateSelectedCount(StateSetter setDialogState) {
        selectedCount = localFieldMap.values.where((v) => v).length;
        if (selectedCount > 8) {
          Future.delayed(Duration(seconds: 1), () {
            TextToSpeechService().speak(
              "Has seleccionado más de 8 campos. Esto puede afectar el formato PDF.",
            );
          });
        }
        setDialogState(() {}); // Actualiza el estado para reflejar los cambios
      }
        return AssetAlertDialogPlatform(
          isCupertino: false,
          oK_textbuton: 'Cerrar',
          title: 'Seleccionar Campos para Exportar',
          message: 'Configura los campos que deseas incluir en la exportación de los reportes en formato PDF y Excel.'+
          ' Puedes activar o desactivar campos según tus necesidades.',
          child: Material(
            color: Colors.transparent,
            child: StatefulBuilder(
              builder: (context, setDialogState) {
                return ScrollWeb(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Switch para incluir o no imágenes
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 240,
                              decoration: AssetDecorationBox().borderdecoration(color:localIncludeImages ? Colors.green.shade100 : Colors.red.shade100),
                              margin:EdgeInsets.only(bottom: 15),
                              child: SwitchListTile(
                                dense: true,
                                contentPadding:EdgeInsets.only(left: 10),
                                visualDensity: VisualDensity.compact,
                                activeTrackColor: Colors.green.shade700,
                                inactiveTrackColor: Colors.red,
                                inactiveThumbColor: Colors.white,
                                trackOutlineColor: MaterialStateProperty.all<Color>(Colors.white),
                                secondary: AppSvg().imageSvg,//Image.asset(AppImages.imageplaceholder300),
                                title: P3Text(text: "Incluir Imágenes".toUpperCase(), 
                                    color: AppColors.menuTheme,
                                    fontWeight: FontWeight.bold,),
                                subtitle: P3Text(text: 'Solo para PDF.'),
                                value: localIncludeImages,
                                onChanged: (bool value) {
                                  TextToSpeechService().speak( value ? "Imágenes activadas." : "No se incluirán imágenes en el documento." );
                                  setDialogState(() {
                                    localIncludeImages = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        Wrap(
                          children: [
                            // Botón "Seleccionar Todo"
                            OutlinedButton.icon(
                              style: buttonStyle2(),
                              onPressed: () {
                                setDialogState(() {
                                  localFieldMap.updateAll((key, value) => true); // Selecciona todos los campos
                                  updateSelectedCount(setDialogState);
                                });
                              },
                              icon: Icon(Icons.check_box, color: Colors.green.shade700),
                              label: P3Text(text: "Seleccionar Todo", color: Colors.green.shade900),
                            ),
                            // Botón "Limpiar Todo"
                           OutlinedButton.icon(
                              style: buttonStyle2(),
                              onPressed: () {
                                setDialogState(() {
                                  localFieldMap.updateAll((key, value) => false); // Limpiar todos los campos
                                  updateSelectedCount(setDialogState);
                                });
                              },
                              icon: Icon(Icons.check_box_outline_blank_outlined, color: Colors.red.shade700),
                              label: P3Text(text: "Limpiar Todo", color: Colors.red.shade900), 
                            ),
                          ]
                        ),
                        if (selectedCount > 8)
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            // decoration: AssetDecorationBox().rowDecoration(),
                            child: P1Text(text:
                              "Has seleccionado más de 8 campos. Esto podría afectar la presentación o alineación en el PDF." +
                              " Se recomienda limitarte a un máximo de 8 campos para este formato.",
                              color: Colors.limeAccent, textAlign: TextAlign.center, fontSize: 13),
                            
                          ),
                         Divider(color: Colors.white),
                        // Wrap para organizar los campos
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10, // Espacio horizontal entre elementos
                          runSpacing: 10, // Espacio vertical entre líneas
                          children: localFieldMap.keys.map((key) {
                            print(localFieldMap[key]!);
                            return Container(
                              width: 200, // Ancho fijo para cada elemento
                              height:45,
                              decoration: AssetDecorationBox().decorationBox(
                                color: localFieldMap[key]! ? Colors.green.shade100 :  Colors.white),
                              child: CheckboxListTile(
                                dense: true,
                                secondary: Opacity(
                                  opacity: .3, 
                                  child: localFieldMap[key]! ? 
                                  AppSvg(width: 20).candadoOpenSvg : 
                                  AppSvg(width: 20).candadoCloseSvg,
                                ),
                                activeColor: Colors.green.shade800,
                                contentPadding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                title: P3Text(
                                  text: key.toUpperCase(),
                                  color: AppColors.menuTheme,
                                  fontWeight: FontWeight.bold,
                                  maxLines: 2,
                                  height: 1,
                                ),
                                value: localFieldMap[key],
                                onChanged: (bool? value)async{

                                  setDialogState(() => localFieldMap[key] = value ?? false);

                                 updateSelectedCount(setDialogState);
                                },
                              ),
                            );
                          }).toList(),
                        ),
                        
                        
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          actionButon:  Row(
            children: [
              IconButton.filled(
                style: buttonStyle1(),
                  onPressed: () {
                    setState(() {
                      fieldMap = localFieldMap;
                      includeImages = localIncludeImages;
                    });
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.save, color: Colors.white,),
                ),
            ],
          )
        );
      },
    );
  }

}





          // PDFProductos(
                      //   includeImages: true,
                      //   titulo: menuProvider.selectedTitle,
                      //   listaTproductos: datTable,  
                      //    getRowValues: (items) {
                      //      TProductosAppModel e = items;
                      //        return {
                      //       'QR': e.qr,
                      //       'Nombre': e.nombre,
                      //       'Ubicación': e.ubicacion,
                      //       'Categoría Compras': e.categoriaCompras,
                      //       'Categoría Inventario': e.categoriaInventario,
                      //       'Moneda': e.moneda,
                      //       'Cantidad en Stock': e.cantidadEnStock,
                      //       'Unidad de Medida': e.intUndMedida,
                      //       'Activo': e.active,
                      //       'Unidad de Medida Distribución': e.outPrecioDistribucion,
                      //       'Fecha Vencimiento': e.fechaVencimiento,
                      //       };
                      //     },
                      //   ),

                        // ...localFieldMap.keys.map((key) {
                          //   return Container(
                          //     width: 220,
                          //     decoration: AssetDecorationBox().borderdecoration(color:Colors.grey.shade300),
                          //     margin:EdgeInsets.only(bottom: 5),
                          //     child: CheckboxListTile(
                          //       dense: true,
                          //       activeColor: Colors.green,
                          //       contentPadding:EdgeInsets.only(left: 10),
                          //       visualDensity: VisualDensity.compact,
                          //       title: P3Text(text: key.toUpperCase(), color:AppColors.menuTheme, fontWeight: FontWeight.bold,),
                          //       value: localFieldMap[key],
                          //       onChanged: (bool? value) {
                          //         setDialogState(() {
                          //           localFieldMap[key] = value ?? false;
                          //         });
                          //       },
                          //     ),
                          //   );
                          // }).toList(),

//  exportExcelData( MenuProvider menuProvider, List<TProductosAppModel> datTable) {
//   return ExportExelListData(
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
// }