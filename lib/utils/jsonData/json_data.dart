
// // import 'dart:convert';

// // import 'package:flutter/services.dart' show rootBundle;

// // class JsonDataLoading {
  
// // // Método reutilizable para cargar datos del JSON
// //   Future<List<String>> loadJsonData({ required String key,required String subKey}) async {
// //     try {
// //       final jsonString =
// //           await rootBundle.loadString('assets/json/select-field.json');
// //       final Map<String, dynamic> jsonData = json.decode(jsonString);
// //       List<String> categoriaCompras =
// //           List<String>.from(jsonData[key][subKey]);
// //       return categoriaCompras;
// //     } catch (error) {
// //       print('Error loading JSON: $error');
// //       return [];
// //     } 
// //   }
// // }


// //       // final jsonString =
// //       //     await rootBundle.loadString('assets/json/select-field.json');
// //       // final Map<String, dynamic> jsonData = json.decode(jsonString);
// //       // List<String> categoriaCompras =
// //       //     List<String>.from(jsonData['almacen_productos']['groupby']);




// import 'package:webandean/pages/t_productos/p_gridview_product.dart';
// import 'package:webandean/pages/t_productos/p_table_product.dart';
// import 'package:webandean/provider/cache/json_loading/provider_json.dart';
// import 'package:webandean/provider/cache/menuWeb/menu_state.dart';
// import 'package:webandean/provider/producto/provider_producto.dart';
// import 'package:webandean/utils/button/asset_buton_widget.dart';
// import 'package:webandean/utils/colors/assets_colors.dart';
// import 'package:webandean/utils/jsonData/json_data.dart';
// import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
// import 'package:webandean/utils/speack/assets_speack.dart';
// import 'package:webandean/utils/text/assets_textapp.dart';
// import 'package:webandean/utils/animations/assets_animationswith.dart';
// import 'package:webandean/utils/dialogs/assets_dialog.dart';
// import 'package:webandean/utils/files/assets-svg.dart';
// import 'package:webandean/utils/layuot/assets_circularprogrees.dart';
// import 'package:webandean/utils/layuot/assets_scroll_web.dart';
// import 'package:webandean/utils/textfield/decoration_form.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class PageProductos extends StatelessWidget {
//   const PageProductos({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final dataParticipantes = Provider.of<TProductosAppProvider>(context);

//     return dataParticipantes.isRefresh
//         ? Center(child: CircularProgressIndicator(color: Colors.black45))
//         : _PageResponsiveProductos();
//   }
// }

// class _PageResponsiveProductos extends StatefulWidget {
//   const _PageResponsiveProductos();
//   @override
//   State<_PageResponsiveProductos> createState() =>
//       _PageResponsiveProductosState();
// }

// class _PageResponsiveProductosState extends State<_PageResponsiveProductos> {
//   // List<dynamic> _productos = [];
//   String? _selectedProduct;

//   bool isSearch = false;
//   late TextEditingController _filterseachController;
//   bool istransition = false;

//   @override
//   void initState() {
//     super.initState();
//     _filterseachController = TextEditingController();
//     // loadAlmacenProductos();
//   }

//   // // Método para cargar y extraer las keys.
//   // Future<void> loadAlmacenProductos() async {
//   //   List<String> categoriaCompras = await JsonDataLoading()
//   //         .loadJsonData(key: 'almacen_productos', subKey: 'groupby');

//   //     setState(() {
//   //       _productos = categoriaCompras;
//   //     });
//   // }

//   @override
//   void dispose() {
//     _filterseachController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final dataParticipantes = Provider.of<TProductosAppProvider>(context);

//     String searchText = dataParticipantes.searchText;

//     final listProductos =
//         dataParticipantes.listProductos; //Lista Productos Geenral

//     final filterData =
//         dataParticipantes.filteredData; //Lista Productos filtrados

//     //LISTA GRUPOS ALMACÉ
//     final searchProvider =
//         (filterData.isEmpty && searchText.isEmpty) ? listProductos : filterData;

//     final groupedData = dataParticipantes.groupByDistance(
//         listParticipantes: searchProvider,
//         filename: _selectedProduct ?? 'Todos');

//     final menuProvider = Provider.of<MenuProvider>(context);

//     return DefaultTabController(
//       length: groupedData.keys.length,
//       child: Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(90), // Ajusta la altura deseada aquí
//             child: AppBar(
//               elevation: 0,
//               surfaceTintColor: Colors.transparent,
//               centerTitle: true,
//               title: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           isSearch = !isSearch;
//                         });
//                         if (!isSearch) {
//                           _filterseachController.clear();
//                           dataParticipantes.clearSearch(listProductos);
//                         }
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 8.0, right: 15),
//                         child: Icon(
//                             isSearch ? Icons.close : Icons.search_outlined),
//                       )),
//                   Container(
//                     constraints: BoxConstraints(maxWidth: 250),
//                     child: AssetsAnimationSwitcher(
//                       isTransition: true,
//                       duration: 700,
//                       child: isSearch
//                           ? TextField(
//                               controller: _filterseachController,
//                               decoration: decorationTextField(
//                                 hintText: 'Escriba aquí',
//                                 labelText: 'Buscar',
//                                 fillColor: Colors.white,
//                                 prefixIcon: Icon(Icons.search),
//                               ),
//                               onChanged: (value) {
//                                 dataParticipantes.setSearchText(
//                                     value, dataParticipantes.listProductos);
//                               },
//                             )
//                           : Column(
//                               children: [
//                                 H1Text(
//                                     height: 1,
//                                     text:
//                                         '${_selectedProduct == null ? menuProvider.selectedTitle : _selectedProduct}'
//                                             .toUpperCase(),
//                                     textAlign: TextAlign.center),
//                                 P2Text(
//                                   height: 1,
//                                   fontSize: 10,
//                                   text: '${listProductos.length} registros',
//                                 ),
//                               ],
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//               actions: [
//                 AppIconButon(
//                   tooltip: "analitic.",
//                   child: AppSvg().chartSvg,
//                   onPressed: () {},
//                 ),
//                  ClasificarButton(
//                 onSelected: (selectedOption) {
//                   setState(() {
//                     _selectedProduct = selectedOption;
//                     dataParticipantes.groupByDistance(
//                         listParticipantes: listProductos, filename: _selectedProduct!);
//                   });
//                 },
//               ),
//                 // AppIconButon(
//                 //   tooltip: "Clasifica los datos presionando aquí.",
//                 //   child: AppSvg().categorySvg,
//                 //   onPressed: () {
//                 //     // optionGroupField(
//                 //     //   context: context,
//                 //     //   listaDatos: listProductos,
//                 //     //   serverProvider: dataParticipantes,
//                 //     // );
//                 //      final menuProvider = Provider.of<MenuProvider>(context, listen: false);
//                 //     TextToSpeechService().speak('Por favor, elige una opción.');
//                 //     AssetAlertDialogPlatform.show(
//                 //         context: context,
//                 //         title: 'Organización de Datos',
//                 //         message: 'Elige el tipo de clasificación que deseas utilizar.',
//                 //         child: Container(
//                 //           width: double.maxFinite,
//                 //           height: MediaQuery.of(context).size.height * .5,
//                 //           child: Column(
//                 //             children: [
//                 //               Container(
//                 //                 width: double.infinity,
//                 //                 decoration: headerDecoration(color: Colors.transparent),
//                 //               ),
//                 //               // Expanded(
//                 //               //   child: Material(
//                 //               //     color: Colors.transparent,
//                 //               //     child: ScrollWeb(
//                 //               //       child: ListView.builder(
//                 //               //         itemCount: _productos.length,
//                 //               //         itemBuilder: (BuildContext context, int index) {
//                 //               //           final option = _productos[index];
//                 //               //           return ListTile(
//                 //               //             visualDensity: VisualDensity.compact,
//                 //               //             minVerticalPadding: 0,
//                 //               //             contentPadding: EdgeInsets.all(0),
//                 //               //             leading: menuProvider.selectedSvg,
//                 //               //             trailing: AppSvg(width: 12).menusvg,
//                 //               //             title: H3Text(text:option, fontSize: 11),
//                 //               //             onTap: () {
//                 //               //               setState(() {
//                 //               //                 _selectedProduct = option!;
//                 //               //                 dataParticipantes.groupByDistance(
//                 //               //                     listParticipantes: listProductos,
//                 //               //                     filename: _selectedProduct!);
//                 //               //                 // isFirstLoad = false;
//                 //               //               });
//                 //               //             },
//                 //               //           );
//                 //               //         },
//                 //               //       ),
//                 //               //     ),
//                 //               //   ),
//                 //               // ),
//                 //             ],
//                 //           ),
//                 //         ));
//                 //   },
//                 // ),
//                 AppIconButon(
//                   tooltip:
//                       'Vista cambiada a ${!istransition ? "imágenes" : "tabla"}.',
//                   child: istransition ? AppSvg().gallerySvg : AppSvg().tableSvg,
//                   onPressed: () {
//                     TextToSpeechService()
//                         .speak('Modo ${!istransition ? "imágenes" : "tabla"}.');
//                     setState(() {
//                       istransition = !istransition;
//                     });
//                   },
//                 ),
//                 AppIconButon(
//                     onPressed: dataParticipantes.isRefresh
//                         ? null
//                         : () async {
//                             await dataParticipantes.refreshProductos();
//                           },
//                     tooltip: 'Actualizar contenido',
//                     child: dataParticipantes.isRefresh
//                         ? AssetsCircularProgreesIndicator(
//                             color: Colors.black45,
//                           )
//                         : AppSvg().refreshSvg),
//               ],
//               bottom: TabBar(
//                   dividerColor: Colors.transparent,
//                   indicatorColor: AppColors.warningColor,
//                   isScrollable: true,
//                   labelPadding: EdgeInsets.only(right: 5, bottom: 3),
//                   indicatorPadding: EdgeInsets.all(0),
//                   overlayColor: WidgetStatePropertyAll(Colors.transparent),
//                   indicatorWeight: 1,
//                   // dividerHeight: 0,
//                   tabs: groupedData.keys.map((String distancias) {
//                     return Tab(
//                       iconMargin: EdgeInsets.all(0),
//                       height: 27,
//                       icon: Tooltip(
//                         message: '${groupedData[distancias]?.length} registro',
//                         child: Container(
//                           padding: EdgeInsets.all(5),
//                           decoration: rowDecoration(),
//                           child: H1Text(
//                               fontSize: 12, text: '$distancias'.toUpperCase()),
//                         ),
//                       ),
//                     );
//                   }).toList()),
//             ),
//           ),
//           body: TabBarView(
//             physics: const NeverScrollableScrollPhysics(),
//             children: groupedData.keys.map((String distancias) {
//               return AssetsAnimationSwitcher(
//                 duration: 600,
//                 child: istransition
//                     ? MyGridView(
//                         groupedData: groupedData,
//                         distancias: distancias,
//                       )
//                     : ScrollWeb(
//                         child: DataPage(
//                           listProductos: groupedData[distancias]!,
//                           tabName: distancias,
//                           // isFirstLoad: isFirstLoad,
//                         ),
//                       ),
//               );
//             }).toList(),
//           )),
//     );
//   }

//   // void optionGroupField({
//   //   required BuildContext context,
//   //   required List<TProductosAppModel> listaDatos,
//   //   required TProductosAppProvider serverProvider,
//   // }) {
//   //   final menuProvider = Provider.of<MenuProvider>(context, listen: false);
//   //   TextToSpeechService().speak('Por favor, elige una opción.');
//   //   AssetAlertDialogPlatform.show(
//   //       context: context,
//   //       title: 'Organización de Datos',
//   //       message: 'Elige el tipo de clasificación que deseas utilizar.',
//   //       child: Container(
//   //         width: double.maxFinite,
//   //          height: MediaQuery.of(context).size.height * .5,
//   //         child: Column(
//   //           children: [
//   //             Container(
//   //               width: double.infinity,
//   //               decoration: headerDecoration(color: Colors.transparent),
//   //             ),
//   //             Expanded(
//   //               child: Material(
//   //                 color: Colors.transparent,
//   //                 child: ScrollWeb(
//   //                   child: ListView.builder(
//   //                     itemCount: _productos.length,
//   //                     itemBuilder: (BuildContext context, int index) {
//   //                       final option = _productos[index];
//   //                       return ListTile(
//   //                         visualDensity: VisualDensity.compact,
//   //                         minVerticalPadding: 0,
//   //                         contentPadding: EdgeInsets.all(0),
//   //                         leading: menuProvider.selectedSvg,
//   //                         trailing: AppSvg(width: 12).menusvg,
//   //                         title: H3Text(text:option, fontSize: 11),
//   //                         onTap: () {
//   //                           setState(() {
//   //                             _selectedProduct = option!;
//   //                             serverProvider.groupByDistance(
//   //                                 listParticipantes: listaDatos,
//   //                                 filename: _selectedProduct!);
//   //                             // isFirstLoad = false;
//   //                           });
//   //                         },
//   //                       );
//   //                     },
//   //                   ),
//   //                 ),
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //       ));
//   // }
// }




// class ClasificarButton extends StatelessWidget {
//   final Function(String) onSelected;

//   ClasificarButton({required this.onSelected});

//   @override
//   Widget build(BuildContext context) {
//     return AppIconButon(
//       tooltip: "Clasifica los datos presionando aquí.",
//       child: AppSvg().categorySvg,
//       onPressed: () {
//         TextToSpeechService().speak('Por favor, elige una opción.');
//         Provider.of<JsonLoadProvider>(context, listen: false).loadProductos();
//         _showClasificarDialog(context);
//       },
//     );
//   }

//   void _showClasificarDialog(BuildContext context) {
//     final menuProvider = Provider.of<MenuProvider>(context, listen: false);
//     final productos = Provider.of<JsonLoadProvider>(context, listen: false).productos;

//     AssetAlertDialogPlatform.show(
//       context: context,
//       title: 'Organización de Datos',
//       message: 'Elige el tipo de clasificación que deseas utilizar.',
//       child: Container(
//         width: double.maxFinite,
//         height: MediaQuery.of(context).size.height * .5,
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               decoration: headerDecoration(color: Colors.transparent),
//             ),
//             Expanded(
//               child: Material(
//                 color: Colors.transparent,
//                 child: ScrollWeb(
//                   child: ListView.builder(
//                     itemCount: productos.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final option = productos[index];
//                       return ListTile(
//                         visualDensity: VisualDensity.compact,
//                         minVerticalPadding: 0,
//                         contentPadding: EdgeInsets.all(0),
//                         leading: menuProvider.selectedSvg,
//                         trailing: AppSvg(width: 12).menusvg,
//                         title: H3Text(text: option, fontSize: 11),
//                         onTap: () {
//                           onSelected(option);
//                           Navigator.pop(context);
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



