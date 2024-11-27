
import 'package:flutter/material.dart';

class FlexibleColumnWidthWithBounds extends TableColumnWidth {
  final double minWidth;
  final double maxWidth;

  FlexibleColumnWidthWithBounds({required this.minWidth, required this.maxWidth});

  @override
  double minIntrinsicWidth(Iterable<RenderBox> boxes, double containerWidth) {
    return minWidth; // El ancho mínimo para la columna
  }

  @override
  double maxIntrinsicWidth(Iterable<RenderBox> boxes, double containerWidth) {
    return maxWidth; // El ancho máximo para la columna
  }

  @override
  double getPreferredWidth(BoxConstraints constraints, Iterable<TableColumnWidth> columnWidths) {
    // Aquí ajustamos el ancho disponible para las columnas
    double availableWidth = constraints.maxWidth / columnWidths.length;
    return availableWidth.clamp(minWidth, maxWidth); // Limitar el ancho entre minWidth y maxWidth
  }
}

class AssetColumnWidths {

  // Map<int, TableColumnWidth>? columnWidths = {
  //    0: FixedColumnWidth(50),
  //    1: FixedColumnWidth(100), // Primera columna, factor de flexibilidad 1
  //    2: FlexColumnWidth(3), // Segunda columna, factor de flexibilidad 3 (más ancha que la primera)
  //    3: FlexColumnWidth(2), // Tercera columna, factor de flexibilidad 2
  //    4: FixedColumnWidth(90), // Cuarta columna, factor de flexibilidad 1
  //    5: FixedColumnWidth(90), // Quinta columna, factor de flexibilidad 1
  //    6: FixedColumnWidth(90), // Quinta columna, factor de flexibilidad 1
  //    7: FixedColumnWidth(50), // Sexta columna, factor de flexibilidad 1
  //    8: FixedColumnWidth(100), // Sexta columna, factor de flexibilidad 1
  // };

  //TABLA DE PRODUCTOS 
 static Map<int, TableColumnWidth>? columnWidths = {
     0: FlexibleColumnWidthWithBounds(minWidth: 10, maxWidth: 50), // INDEX Primera columna con límites
     1: FlexibleColumnWidthWithBounds(minWidth: 10, maxWidth: 100), // TIPO Primera columna con límites
     2: FlexColumnWidth(3), //NOMBRE  Segunda columna, factor de flexibilidad 3 (más ancha que la primera)
     3: FlexColumnWidth(2), //OBSERBACION  Tercera columna, factor de flexibilidad 2
     4: FlexibleColumnWidthWithBounds(minWidth: 40, maxWidth: 90), //PRECIO  Primera columna con límites
     5: FlexibleColumnWidthWithBounds(minWidth: 60, maxWidth: 90), //CANTD Primera columna con límites
     6: FlexibleColumnWidthWithBounds(minWidth: 40, maxWidth: 90), //SUBTOTAL Primera columna con límites
     7: FlexibleColumnWidthWithBounds(minWidth: 10, maxWidth: 50), //MONEDA Primera columna con límites
     8: FixedColumnWidth(100), //ACTIVE Sexta columna, factor de flexibilidad 1
  };


 static Map<int, TableColumnWidth>? columnWidthsDetails = {
     0: FlexibleColumnWidthWithBounds(minWidth: 50, maxWidth: 200), // Primera columna con límites
     1: FlexibleColumnWidthWithBounds(minWidth: 50, maxWidth: 100), // Primera columna con límites
    //  2: FlexColumnWidth(2), // Tercera columna, factor de flexibilidad 2
    //  3: FixedColumnWidth(90), // Cuarta columna, factor de flexibilidad 1
    //  4: FixedColumnWidth(90), // Quinta columna, factor de flexibilidad 1
    //  5: FixedColumnWidth(90), // Quinta columna, factor de flexibilidad 1
    //  6: FixedColumnWidth(50), // Sexta columna, factor de flexibilidad 1
    //  7: FixedColumnWidth(100), // Sexta columna, factor de flexibilidad 1
  };

}




// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';
// import 'package:webandean/pages/entregas/entrega%20general/dropdown_row/Lista%20producto/widgets/created_calculo.dart';
// import 'package:webandean/pages/entregas/entrega%20general/dropdown_row/Lista%20producto/widgets/header_table.dart';
// import 'package:webandean/provider/entregas/provider_entregas_generales.dart';
// import 'package:webandean/provider/sunat%20/provider_tipo_cambio.dart';
// import 'package:webandean/utils/animations/assets_animationswith.dart';
// import 'package:webandean/utils/button/asset_buton_widget.dart';
// import 'package:webandean/utils/colors/assets_colors.dart';
// import 'package:webandean/utils/files%20assset/assets-svg.dart';
// import 'package:webandean/utils/layuot/asset_column_widths.dart';
// import 'package:webandean/utils/layuot/assets_circularprogrees.dart';
// import 'package:webandean/utils/layuot/assets_scroll_web.dart';
// import 'package:webandean/utils/responsiveTable/title_table/title_tabbar.dart';
// import 'package:webandean/utils/text/assets_textapp.dart';
// import 'package:webandean/utils/textfield/decoration_form.dart';

// import 'package:webandean/pages/entregas/entrega%20general/dropdown_row/Lista%20producto/widgets/action_crud_buttons.dart';
// import 'package:webandean/pages/entregas/entrega%20general/dropdown_row/Lista%20producto/widgets/source_builder_valuerow.dart';

// import 'package:webandean/model/entregas/model_entregas_general.dart';
// import 'package:webandean/model/producto/model_producto.dart';

// import 'package:webandean/provider/producto/provider_producto.dart';


// class ListaProductos extends StatefulWidget {
//   const ListaProductos({
//     super.key,
//     required this.data, 
//     required this.categoria, 
//     required this.getProductGrup,
//     required this.header,
//     required this.toDuplicateInstans, 
//     required this.getCreatedNewitem,
//   });

//   final TEntregasModel data;
//   final String categoria;
//   final List<String> header;
//   final Map<String, Object?> Function(dynamic producto) getProductGrup;//Productos 
//   final TProductosAppModel Function(TProductosAppModel producto,  int duplicateCount) toDuplicateInstans;
//   // final dynamic providerPadre; // es el que contiene las sublistas 
//   final Widget Function(List<TProductosAppModel> listaPadre,List<TProductosAppModel> listaHijo) getCreatedNewitem;//data ppasar la sublist 

//   @override
//   State<ListaProductos> createState() => _ListaProductosState();
// }

// class _ListaProductosState extends State<ListaProductos> {

//   int selectedIndex = 0; // Para saber cuál pestaña está activa TAbbaView 

//   late TextEditingController _filterseachController;
//   bool isSearch = false;
//   bool isExpandPrecios = false;


//   @override
//   void initState() {
//     super.initState();
//    _filterseachController = TextEditingController();

//    //SOLO PARA LA SUBLISTA de prodcutos 
//     // Limpiar la búsqueda para evitar que los datos filtrados persistan innecesariamente
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//     Provider.of<TProductosAppProvider>(context, listen : false).clearSearch([]);
//     });
//   }


//   @override
//   void dispose() {
//     _filterseachController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final providerPadre = Provider.of<TEntregasAppProvider>(context);
  

//     //METODOS FILTRADO Y BUSQUEDA PRODUCTOS
//     final providerProducto = Provider.of<TProductosAppProvider>(context);
//     // Obtener los datos filtrados
//      //LA usar emtodos de rutilizables de provider es sencible a laacenar datos y mantenerlos, por esa razon
    
//     final filterData = providerProducto.filteredData; //Lista Productos filtrados
//     String searchText = providerProducto.searchText;
    
//    // Determinar los datos a mostrar
//     final searchProvider = (filterData.isEmpty && searchText.isEmpty) ? widget.data.listaProducto : filterData;
    
//     final groupedData = providerProducto.groupByDistance( listData: searchProvider!, fieldName: widget.categoria);

//     // Validar y ajustar el índice seleccionado
//     if (selectedIndex >= groupedData.keys.length) {
//       selectedIndex = 0; // Restablece al primer índice disponible
//     }
    
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),//Cerrar teclado 
//       child: groupedData.keys.isEmpty
//         ? Erro404Page(
//             onPressed: () => isSeachVisible(providerProducto, widget.data.listaProducto ?? []),
//         )
//         :  DefaultTabController(
//         // length: categorias.length,
//         length: groupedData.keys.length,
//         initialIndex: selectedIndex,
//         child: ScrollWeb(
//           child: Scaffold(
//             appBar: AppBar(
//               leadingWidth: 0,
//               leading: SizedBox(),
//               centerTitle: false,
//               title: AssetsAnimationSwitcher(
//                         // isTransition: true,
//                         directionLeft: true,
//                         duration: 700,
//                         child: isSearch
//                             ? Container(
//                               constraints: BoxConstraints(maxWidth: 350, maxHeight: 45),
//                               child: TextField(
//                                   controller: _filterseachController,
//                                   style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, height: 1.5),
//                                   decoration: AssetDecorationTextField.decorationTextFieldRectangle(
//                                     hintText: 'Escriba aquí',
//                                     labelText: 'Buscar',
//                                     fillColor: Colors.white,
//                                     prefixIcon: Icon(Icons.search),
//                                     suffixIcon: IconButton(
//                                       onPressed: () => isSeachVisible(providerProducto, widget.data.listaProducto ?? []),
//                                       icon: Icon(Icons.close, size: 20))
//                                   ),
//                                   //Fitrar mientras escribes 
//                                   onChanged: (value) => providerProducto.setSearchText(value, widget.data.listaProducto ?? []),
//                                 ),
//                             )
//                             : Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children : [
//                               AppIconButoonELegant(
//                                 colorButon: Colors.red,
//                                 icon: AppSvg( color: Colors.white ).backSvg, 
//                                 onPressed: () =>  Navigator.pop(context),
//                                 ), 
//                               AppIconButoonELegant(
//                               colorButon: Colors.blue,
//                               icon: Icon(Icons.search,color:  Colors.white), 
//                               onPressed: () =>  setState(() => isSearch = !isSearch)
//                               ),
//                               AppIconButoonELegant(
//                               colorButon: Colors.red.shade100,
//                               icon: AppSvg().pdfSvg, 
//                               onPressed: () =>  setState(() => isSearch = !isSearch)
//                               ),
//                               AppIconButoonELegant(
//                               colorButon: Colors.green.shade300,
//                               icon: AppSvg().excelSvg, 
//                               onPressed: () =>  setState(() => isSearch = !isSearch)
//                               ),
//                               AppIconButoonELegant(
//                               colorButon: AppColors.menuIconColor,
//                               icon: AppSvg().expandSvg, 
//                               onPressed: () =>  setState(() => isExpandPrecios = !isExpandPrecios)
//                               ),
//                           ])
//               ),
//               actions: [
//               AppIconButoonELegant(
//                 label: ' Guardar', 
//                 colorlabel: Colors.white,
//                 colorButon: Colors.green.shade700,
//                 icon: providerPadre.isSyncing ? AssetsCircularProgreesIndicator() : 
//                  Icon( Icons.save, size: 30, color: Colors.white),
//                 onPressed:  providerPadre.isSyncing ? null :  () {
//                     // Actualizar la lista de productos editada en widget.data
//                       // widget.data.listaProducto = productosPorCategoria.values.expand((p) => p).toList();
                      
//                       widget.data.listaProducto = groupedData.values.expand((p) => p).toList();
//                       // Guardar los datos utilizando el Provider
//                        providerPadre.saveProviderFull(
//                         context: context,
//                         data: widget.data,
//                       );
//                       providerPadre.refreshProvider();
//                   },
//               ),
//               ],
//             ),
            
//             body:  Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                  //BUSCADOR AUTOCOMPLETE CREAR NUEVO 
//                   widget.getCreatedNewitem( 
//                       providerProducto.listProductos,//listaPADRE
//                       widget.data.listaProducto ?? [], // Lista HIJO 
//                     ),
//                           // if(isSearch)
//                         // Cabecera de las columnas

                           
//             TabBarCustom(
//                   onTap: (index) => setState(() {selectedIndex = index; }),// Actualiza el índice seleccionado
//                   tabs: groupedData.keys.map((String tabTitle) {
//                     return Tab(
//                       iconMargin: EdgeInsets.all(0),
//                       height: 40,
//                       icon: ChipTabar(title: tabTitle, count: groupedData[tabTitle]?.length ?? 0));
//                   }).toList(),
//               ),
//               SizedBox(height: 10),
//               Expanded(
//                   child: TabBarView(
//                     physics: const NeverScrollableScrollPhysics(),
//                     children: groupedData.keys.map((String categoria) {
//                       int index = groupedData.keys.toList().indexOf(categoria);
                  
//                       List<TProductosAppModel> productosPorGrupo = groupedData[categoria] ?? [];
                      
//                       if(selectedIndex != index) return Container();
                      

//                       return Offstage(
//                         offstage: selectedIndex != index, // Solo muestra el contenido si está activo
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
                           
//                             listTitleCustom(
//                              leading:  SizedBox(width:25),
//                              title: HeaderPrimraTaBle(headers: ['$categoria'], isViewIndex: false),
//                              trailing:  InkWell(
//                              onTap: ()=> providerProducto.clearSearch(widget.data.listaProducto ?? []),
//                              child: Icon(Icons.refresh)),
//                             ),
//                             listTitleCustom(
//                              leading:  SizedBox(width:25),
//                              title: HeaderPrimraTaBle(headers: widget.header),
//                              trailing:  InkWell(
//                              onTap: ()=> providerProducto.clearSearch(widget.data.listaProducto ?? []),
//                              child: Icon(Icons.refresh)),
//                             ),

//                             // Lista de productos en la categoría
//                             Expanded(
//                               child: ReorderableListView.builder(
//                                 buildDefaultDragHandles: false,// Desactiva el icono drag predeterminado
//                                 physics: const ClampingScrollPhysics(),
//                                 padding: EdgeInsets.only(bottom: 80),
//                                 shrinkWrap: true,
//                                 itemCount: productosPorGrupo.length,
//                                 onReorder: (oldIndex, newIndex)  {
//                                  // Solo realizar el reordenamiento si no hay formulario abierto
//                                  if (newIndex > oldIndex) newIndex--;
//                                    final valueProduct = productosPorGrupo.removeAt(oldIndex);
//                                    productosPorGrupo.insert(newIndex, valueProduct);
//                                    // Juntar todas las listas de productos en una sola lista
//                                    // List<TProductosAppModel> allProductos = groupedData.values.expand((productos) => productos).toList();
//                                    final allProductos = groupedData.values.expand((productos) => productos).toList();
//                                    widget.data.listaProducto = allProductos;
//                                    providerProducto.clearSearch(widget.data.listaProducto ?? []);
//                                 },
                                
//                                 itemBuilder: (context, productIndex) {
//                                   TProductosAppModel productGrup = productosPorGrupo[productIndex];

//                                   final listRows = widget.getProductGrup(productGrup);//Contruye los datos 

//                                   final colorIndex = AppColors.getColorByIndex(index: productIndex);
//                                    print('${categoria} : ${productIndex}');
//                                   return Container(
//                                   key: Key('${categoria} : ${productIndex}'),
//                                   child:  listTitleCustom(
//                                     leading: ReorderableDragStartListener(
//                                       child:Icon(Icons.reorder),
//                                       index: productIndex,
//                                     ),
//                                     trailing:  ActionCrudButton(
//                                       productosPorGrupo: productosPorGrupo, //son la lista Productos por los grupo o categorias
//                                       productGrup: productGrup, // es un elemento del grupo de lista Productos categorias
//                                       onDuplicate: () => isDuplicateItemRow(
//                                         groupedData : groupedData,
//                                         productGrup : productGrup,
//                                         productosPorGrupo: productosPorGrupo,
//                                         productIndex: productIndex,
//                                         providerProducto: providerProducto
//                                       ), 
//                                       onDeleted: () { 
//                                          productosPorGrupo.removeAt(productIndex);
//                                          // Juntar todas las listas de productos en una sola lista
//                                          List<TProductosAppModel> allProductos = groupedData.values.expand((productos) => productos).toList();
//                                          widget.data.listaProducto = allProductos;
//                                          providerProducto.clearSearch(widget.data.listaProducto ?? []);
//                                        }, 
                                       
//                                     ),
//                                     title: Table(
//                                       columnWidths: AssetColumnWidths.columnWidths,
//                                       border: TableBorder.all(width: .5, color:Colors.white),
//                                       children: [
//                                         TableRow(
//                                           decoration: BoxDecoration(color: productGrup.active! ? Colors.red.shade50 : colorIndex),
//                                           children: [
//                                               // Añadir el elemento adicional "index"
//                                               Padding(
//                                                 padding: const EdgeInsets.all(1.0),
//                                                 child: P3Text(
//                                                   text: '${productIndex + 1}',
//                                                   fontWeight: FontWeight.bold,
//                                                   textAlign: TextAlign.center,
//                                                    maxLines: 1,
//                                                 ),
//                                               ),
//                                             ...listRows.values.map((value) {
//                                                 return sourceBuilder(
//                                                   valueField: value,
//                                                   productoRow: productGrup, 
//                                                   subListDPadre : widget.data.listaProducto ?? [], 
//                                                   colorIndex : colorIndex
//                                                   );
//                                               }).toList(),
                                            
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   ) ;
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
               
               
            

//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }


// void isDuplicateItemRow({
//    required Map<String, List<TProductosAppModel>> groupedData, 
//    required TProductosAppModel productGrup,
//    required  List<TProductosAppModel> productosPorGrupo,
//    required int productIndex,  
//    required TProductosAppProvider providerProducto
//   }) 
//   {
//    // Encontrar cuántas veces el producto ha sido duplicado para agregar el sufijo adecuado
//     int duplicateCount = 1;
                                         

//     // Crear una copia del producto, manteniendo todos los campos, pero solo cambiando el nombre
//     TProductosAppModel duplicatedProduct = widget.toDuplicateInstans(productGrup, duplicateCount);

//      // Buscar si ya existe un duplicado con ese nombre y agregar el sufijo si es necesario
//      for (var p in productosPorGrupo) {
//        if (p.nombre.startsWith('${productGrup.nombre} copia [')) {
//          // Incrementar el contador para los duplicados
//          int currentCount = int.tryParse(p.nombre.split('[')[1]?.split(']')[0] ?? '0') ?? 0;
//          duplicateCount = currentCount + 1;
//        }
//      }

//      // Modificar el nombre del duplicado en la copia
//      duplicatedProduct.nombre = '${productGrup.nombre} copia [$duplicateCount]';

//      // Insertar la copia del producto después del original
//      productosPorGrupo.insert(productIndex + 1, duplicatedProduct);

//      // Actualizar el estado general
//      List<TProductosAppModel> allProductos = groupedData.values.expand((productos) => productos).toList();

//     // widget.data.listaProducto = allProductos;
//     widget.data.listaProducto = allProductos;

//      // providerProducto.clearSearch(widget.data.listaProducto ?? []);
//      providerProducto.clearSearch(widget.data.listaProducto ?? []);
// }

//  void isSeachVisible(TProductosAppProvider dataProvider,List<TProductosAppModel> listProductos ){
//   setState(() => isSearch = !isSearch);
//    if (!isSearch) {
//      _filterseachController.clear();
//      dataProvider.clearSearch(listProductos);
//    }
//  }


// Widget listTitleCustom( { required Widget title, required Widget leading,  Widget? trailing} ) {
//    return  ListTile(
//     contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//     visualDensity: VisualDensity.compact,
//         dense: true,
//         minVerticalPadding: 0,
//         leading: leading,
//         title: title,
//         trailing: trailing ?? null
//       );
// }

// }


