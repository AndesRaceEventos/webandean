import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:webandean/utils/animations/assets_animationswith.dart';
import 'package:webandean/utils/responsiveTable/search_transition/search_view_global.dart';
import 'package:webandean/utils/button/asset_buton_widget.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/layuot/asset_column_widths.dart';
import 'package:webandean/utils/layuot/assets_circularprogrees.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/responsiveTable/title_table/title_tabbar.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

import 'package:webandean/pages/entregas/entrega%20general/dropdown_row/subLista%20producto/widgets/header_table_global.dart';
import 'package:webandean/pages/entregas/entrega%20general/dropdown_row/subLista%20producto/widgets/action_crud_buttons.dart';
import 'package:webandean/pages/entregas/entrega%20general/dropdown_row/subLista%20producto/widgets/source_builder_valuerow.dart';

import 'package:webandean/model/entregas/model_entregas_general.dart';
import 'package:webandean/model/producto/model_producto.dart';

import 'package:webandean/provider/producto/provider_producto.dart';
import 'package:webandean/provider/entregas/provider_entregas_generales.dart';


class ListaProductos extends StatefulWidget {
  const ListaProductos({
    super.key,
    required this.data, 
    required this.categoria, 
    required this.getProductGrup,
    required this.header,
    required this.toDuplicateInstans, 
    required this.getCreatedNewitem,
  });

  final TEntregasModel data;
  final String categoria;
  final List<String> header;
  final Map<String, Object?> Function(dynamic producto) getProductGrup;//Productos 
  final TProductosAppModel Function(TProductosAppModel producto,  int duplicateCount) toDuplicateInstans;
  // final dynamic providerPadre; // es el que contiene las sublistas 
  final Widget Function(List<TProductosAppModel> listaPadre,List<TProductosAppModel> listaHijo) getCreatedNewitem;//data ppasar la sublist 

  @override
  State<ListaProductos> createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {

  int selectedIndex = 0; // Para saber cuál pestaña está activa TAbbaView 

  late TextEditingController _filterseachController;
  bool isSearch = false;
  

  @override
  void initState() {
    super.initState();
   _filterseachController = TextEditingController();

   //SOLO PARA LA SUBLISTA de prodcutos 
    // Limpiar la búsqueda para evitar que los datos filtrados persistan innecesariamente
    WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<TProductosAppProvider>(context, listen : false).clearSearch([]);
    });
  }


  @override
  void dispose() {
    _filterseachController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final providerPadre = Provider.of<TEntregasAppProvider>(context);
  

    //METODOS FILTRADO Y BUSQUEDA PRODUCTOS
    final providerProducto = Provider.of<TProductosAppProvider>(context);
    // Obtener los datos filtrados
     //LA usar emtodos de rutilizables de provider es sencible a laacenar datos y mantenerlos, por esa razon
    
    final filterData = providerProducto.filteredData; //Lista Productos filtrados
    String searchText = providerProducto.searchText;
    
   // Determinar los datos a mostrar
    final searchProvider = (filterData.isEmpty && searchText.isEmpty) ? widget.data.listaProducto : filterData;
    
    final groupedData = providerProducto.groupByDistance( listData: searchProvider!, fieldName: widget.categoria);

    // Validar y ajustar el índice seleccionado
    if (selectedIndex >= groupedData.keys.length) {
      selectedIndex = 0; // Restablece al primer índice disponible
    }
    
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),//Cerrar teclado 
      child: 
      // groupedData.keys.isEmpty
      //   ? Erro404Page(
      //       onPressed: () => isSeachVisible(providerProducto, widget.data.listaProducto ?? []),
      //   )
      //   :  
        DefaultTabController(
        length: groupedData.keys.length,
        initialIndex: selectedIndex,
        child: ScrollWeb(
          child: Scaffold(
            appBar: AppBar(
              leadingWidth: 0,
              leading: SizedBox(),
              centerTitle: false,
              title: SearchIstransitionItem(
                isSearch: isSearch , //todos variable para 🔍 🔍 Buscador en pagina
                controller: _filterseachController,
                onCloseSeach: () => isSeachVisible(providerProducto, widget.data.listaProducto ?? []),
                onSearch:  (value) => providerProducto.setSearchText(value, widget.data.listaProducto ?? []),
                children: [
                    AppIconButoonELegant(
                    colorButon: Colors.blue,
                    icon: Icon(Icons.search,color:  Colors.white), 
                     onPressed: () =>  setState(() => isSearch = !isSearch)
                    ),
                    AppIconButoonELegant(
                    colorButon: Colors.red.shade100,
                    icon: AppSvg().pdfSvg, 
                    //  onPressed: () =>  setState(() => isSearch = !isSearch)
                    ),
                    AppIconButoonELegant(
                    colorButon: Colors.green.shade300,
                    icon: AppSvg().excelSvg, 
                    //  onPressed: () =>  setState(() => isSearch = !isSearch)
                    ),
                    AppIconButoonELegant(
                    colorButon: AppColors.menuIconColor,
                    icon: AppSvg().expandSvg, 
                    //  onPressed: () =>  setState(() => isSearch = !isSearch)
                    ),
                    
                ],
              ),
              actions: [
              AppIconButoonELegant(
                label: ' Guardar', 
                colorlabel: Colors.white,
                colorButon: Colors.green.shade700,
                icon: providerPadre.isSyncing ? AssetsCircularProgreesIndicator() : 
                 Icon( Icons.save, size: 30, color: Colors.white),
                onPressed:  providerPadre.isSyncing ? null :  () {
                    // Actualizar la lista de productos editada en widget.data
                      widget.data.listaProducto = groupedData.values.expand((p) => p).toList();//igual a la lista reagrupada
                      // Guardar los datos utilizando el Provider
                      providerPadre.saveProviderFull(context: context,data: widget.data);
                      providerPadre.refreshProvider();
                  },
              ),
              ],
            ),
            body:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [   

              Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: TabBarCustom(//todos Tab Bar Custom
                    onTap: (index) => setState(() {selectedIndex = index; isSearch = false; }),// Actualiza el índice seleccionado
                    tabs: groupedData.keys.map((String tabTitle) {
                      return Tab(
                        iconMargin: EdgeInsets.all(0),
                        height: 40,
                        icon: ChipTabar(title: tabTitle, count: groupedData[tabTitle]?.length ?? 0));
                    }).toList(),
                ),
              ),
             
              Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: groupedData.keys.map((String categoria) {
                      int index = groupedData.keys.toList().indexOf(categoria);
                  
                      List<TProductosAppModel> productosPorGrupo = groupedData[categoria] ?? [];
                      
                      if(selectedIndex != index) return Container();
                      

                      return Offstage(
                        offstage: selectedIndex != index, // Solo muestra el contenido si está activo
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          listTitleCustom(
                            leading: InkWell(
                              onTap: (){}, 
                              child:  AppSvg(width: 25).createFilledSvg),
                            trailing:  InkWell(
                             onTap: ()=> providerProducto.clearSearch(widget.data.listaProducto ?? []),
                             child: Icon(Icons.refresh)),
                            title:  AssetsAnimationSwitcher(
                              child: isSearch ?  
                               //BUSCADOR AUTOCOMPLETE CREAR NUEVO 
                                Container(
                                  child: widget.getCreatedNewitem( 
                                   providerProducto.listProductos,//listaPADRE
                                    widget.data.listaProducto ?? [], // Lista HIJO 
                                  ),
                                ) 
                                :   HeaderPrimraTaBle(
                                  headers: ['$categoria'], 
                                  isViewIndex: false, 
                                  isColumnWith: false,
                                  ),
                            ),
                          ),
                          
                           
                            listTitleCustom(
                             leading:  SizedBox(width:25),
                             title: HeaderPrimraTaBle(headers: widget.header),
                             trailing: SizedBox(width:25),
                            ),

                            // Lista de productos en la categoría
                            Expanded(
                              child: ReorderableListView.builder(
                                buildDefaultDragHandles: false,// Desactiva el icono drag predeterminado
                                physics: const ClampingScrollPhysics(),
                                padding: EdgeInsets.only(bottom: 80),
                                shrinkWrap: true,
                                itemCount: productosPorGrupo.length,
                                onReorder: (oldIndex, newIndex)  {
                                 // Solo realizar el reordenamiento si no hay formulario abierto
                                 if (newIndex > oldIndex) newIndex--;
                                   final valueProduct = productosPorGrupo.removeAt(oldIndex);
                                   productosPorGrupo.insert(newIndex, valueProduct);
                                   // Juntar todas las listas de productos en una sola lista
                                   // List<TProductosAppModel> allProductos = groupedData.values.expand((productos) => productos).toList();
                                   final allProductos = groupedData.values.expand((productos) => productos).toList();
                                   widget.data.listaProducto = allProductos;
                                   providerProducto.clearSearch(widget.data.listaProducto ?? []);
                                },
                                
                                itemBuilder: (context, productIndex) {
                                  final colorIndex = AppColors.getColorByIndex(index: productIndex);
                                   print('${categoria} : ${productIndex}');

                                  final productGrup = productosPorGrupo[productIndex];

                                  final builderRow = widget.getProductGrup(productGrup);//todos Contruye los datos 


                                  return Container(
                                  key: Key('${categoria} : ${productIndex}'),
                                  child:  listTitleCustom(
                                    leading: ReorderableDragStartListener(
                                      child:Icon(Icons.reorder),
                                      index: productIndex,
                                    ),
                                    trailing:  ActionCrudButton(
                                      productosPorGrupo: productosPorGrupo, //son la lista Productos por los grupo o categorias
                                      productGrup: productGrup, // es un elemento del grupo de lista Productos categorias
                                      onDuplicate: () => isDuplicateItemRow(
                                        groupedData : groupedData,
                                        productGrup : productGrup,
                                        productosPorGrupo: productosPorGrupo,
                                        productIndex: productIndex,
                                        providerProducto: providerProducto
                                      ), 
                                      onDeleted: () { 
                                         productosPorGrupo.removeAt(productIndex);
                                         // Juntar todas las listas de productos en una sola lista
                                         List<TProductosAppModel> allProductos = groupedData.values.expand((productos) => productos).toList();
                                         widget.data.listaProducto = allProductos;
                                         providerProducto.clearSearch(widget.data.listaProducto ?? []);
                                       }, 
                                       
                                    ),
                                    title: Table(
                                      columnWidths: AssetColumnWidths.columnWidths,
                                      border: TableBorder.all(width: .5, color:Colors.white),
                                      children: [
                                        TableRow(
                                          decoration: BoxDecoration(color: productGrup.active! ? Colors.red.shade50 : colorIndex),
                                          children: [
                                              // Añadir el elemento adicional "index"
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: P3Text(
                                                  text: '${productIndex + 1}',
                                                  textAlign: TextAlign.center,
                                                   maxLines: 1,
                                                ),
                                              ),
                                            ...builderRow.values.map((value) {
                                                return sourceBuilder(
                                                  valueField: value,
                                                  productoRow: productGrup, 
                                                  subListDPadre : widget.data.listaProducto ?? [], 
                                                  colorIndex : colorIndex
                                                  );
                                              }).toList(),
                                            
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  ) ;
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
               
               
            

              ],
            ),
          ),
        ),
      ),
    );
  }


void isDuplicateItemRow({
   required Map<String, List<TProductosAppModel>> groupedData, 
   required TProductosAppModel productGrup,
   required  List<TProductosAppModel> productosPorGrupo,
   required int productIndex,  
   required TProductosAppProvider providerProducto }) {
   // Encontrar cuántas veces el producto ha sido duplicado para agregar el sufijo adecuado
    int duplicateCount = 1;
                                         

    // Crear una copia del producto, manteniendo todos los campos, pero solo cambiando el nombre
    TProductosAppModel duplicatedProduct = widget.toDuplicateInstans(productGrup, duplicateCount);

     // Buscar si ya existe un duplicado con ese nombre y agregar el sufijo si es necesario
     for (var p in productosPorGrupo) {
       if (p.nombre.startsWith('${productGrup.nombre} copia [')) {
         // Incrementar el contador para los duplicados
         int currentCount = int.tryParse(p.nombre.split('[')[1]?.split(']')[0] ?? '0') ?? 0;
         duplicateCount = currentCount + 1;
       }
     }

     // Modificar el nombre del duplicado en la copia
     duplicatedProduct.nombre = '${productGrup.nombre} copia [$duplicateCount]';

     // Insertar la copia del producto después del original
     productosPorGrupo.insert(productIndex + 1, duplicatedProduct);

     // Actualizar el estado general
     List<TProductosAppModel> allProductos = groupedData.values.expand((productos) => productos).toList();

    // widget.data.listaProducto = allProductos;
    widget.data.listaProducto = allProductos;

     // providerProducto.clearSearch(widget.data.listaProducto ?? []);
     providerProducto.clearSearch(widget.data.listaProducto ?? []);
}

 void isSeachVisible(TProductosAppProvider dataProvider,List<TProductosAppModel> listProductos ){
  setState(() => isSearch = !isSearch);
   if (!isSearch) {
     _filterseachController.clear();
     dataProvider.clearSearch(listProductos);
   }
 }


Widget listTitleCustom( { required Widget title, required Widget leading,  Widget? trailing} ) {
   return  ListTile(
    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    visualDensity: VisualDensity.compact,
        dense: true,
        minVerticalPadding: 0,
        leading: leading,
        title: title,
        trailing: trailing ?? null, 
      );
}

}






