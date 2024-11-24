import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webandean/model/entregas/model_entregas_general.dart';
import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/provider/entregas/provider_entregas_generales.dart';
import 'package:webandean/provider/producto/provider_producto.dart';
import 'package:webandean/provider/sunat%20/provider_tipo_cambio.dart';
import 'package:webandean/utils/animations/assets_animationswith.dart';
import 'package:webandean/utils/button/asset_buton_widget.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/formulario/formfield_customs.dart';
import 'package:webandean/utils/layuot/assets_circularprogrees.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/responsiveTable/headers_global/header_generic.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:webandean/utils/textfield/decoration_form.dart';

/// Widget que muestra la lista de productos organizados por categorías

class ButtonSubListProductos extends StatelessWidget {
  const ButtonSubListProductos({super.key, required this.data});
  final TEntregasModel data;

  @override
  Widget build(BuildContext context) {
    //PARA la suBlista de Prodductos 
  // final providerProducto = Provider.of<TProductosAppProvider>(context);
    return ElevatedButton(
            onPressed: (){
              // providerProducto.clearSearch([]);
              Navigator.push(context, MaterialPageRoute(builder: (_)=> ListaProductos(data: data)));
          }, child: Text('Productos'));
  }
}

class ListaProductos extends StatefulWidget {
  const ListaProductos({
    super.key,
    required this.data,
  });

  final TEntregasModel data;

  @override
  State<ListaProductos> createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {

  int selectedIndex = 0; // Para saber cuál pestaña está activa TAbbaView 

  late TextEditingController _filterseachController;
  late String categoria;
  
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    categoria = 'CATEGORIA_COMPRAS';//Asginasmos la categoria a filtrar
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
    final provider = Provider.of<TEntregasAppProvider>(context);

    final listColumns = [
     'Nro' 'Tipo', 'Nombre', 'Medida', 'Precio', 'Cantidad','SubTotal' ,'','Estado'
    ];

    //METODOS FILTRADO Y BUSQUEDA PRODUCTOS
    final providerProducto = Provider.of<TProductosAppProvider>(context);
    // Obtener los datos filtrados
     //LA usar emtodos de rutilizables de provider es sencible a laacenar datos y mantenerlos, por esa razon
    
    final filterData = providerProducto.filteredData; //Lista Productos filtrados
    String searchText = providerProducto.searchText;
    
   // Determinar los datos a mostrar
    final searchProvider = (filterData.isEmpty && searchText.isEmpty) ? widget.data.listaProducto : filterData;
    
    final groupedData = providerProducto.groupByDistance( listData: searchProvider!, fieldName: categoria);

    // Validar y ajustar el índice seleccionado
    if (selectedIndex >= groupedData.keys.length) {
      selectedIndex = 0; // Restablece al primer índice disponible
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),//Cerrar teclado 
      child: groupedData.keys.isEmpty
        ? Center(
          child: AppIconButoonELegant(
          colorButon: Colors.white,
          colorlabel: AppColors.menuTextDark,
          onPressed: () => isSeachVisible(providerProducto, widget.data.listaProducto ?? []),
          label: 'No hay resultados, ¿otra búsqueda? 🔍👀',
          icon: Icon(Icons.close, size: 30, color: AppColors.menuTextDark)))

        :  DefaultTabController(
        // length: categorias.length,
        length: groupedData.keys.length,
        initialIndex: selectedIndex,
        child: ScrollWeb(
          child: Scaffold(
            appBar: AppBar(
              leadingWidth: 0,
              leading: SizedBox(),
              centerTitle: true,
              title: AssetsAnimationSwitcher(
                        isTransition: true,
                        directionLeft: true,
                        duration: 700,
                        child: isSearch
                            ? Container(
                              constraints: BoxConstraints(maxWidth: 350, maxHeight: 45),
                              child: TextField(
                                  controller: _filterseachController,
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, height: 1.5),
                                  decoration: AssetDecorationTextField.decorationTextFieldRectangle(
                                    hintText: 'Escriba aquí',
                                    labelText: 'Buscar',
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.search),
                                    suffixIcon: IconButton(
                                      onPressed: () => isSeachVisible(providerProducto, widget.data.listaProducto ?? []),
                                      icon: Icon(Icons.close, size: 20))
                                  ),
                                  //Fitrar mientras escribes 
                                  onChanged: (value) => providerProducto.setSearchText(value, widget.data.listaProducto ?? []),
                                ),
                            )
                            : Row( 
                              children : [
                              AppIconButoonELegant(
                                colorButon: Colors.red,
                                icon: AppSvg( color: Colors.white ).backSvg, 
                                onPressed: () =>  Navigator.pop(context),
                                ),
                                
                              AppIconButoonELegant(
                              colorButon: Colors.blue,
                              icon: Icon(Icons.search,color:  Colors.white), 
                              onPressed: () =>  setState(() => isSearch = !isSearch)
                              ),
                          ])
              ),
              actions: [
              AppIconButoonELegant(
                label: ' Guardar', 
                colorlabel: Colors.white,
                colorButon: Colors.green.shade700,
                icon: provider.isSyncing ? AssetsCircularProgreesIndicator() : 
                 Icon( Icons.save, size: 30, color: Colors.white),
                onPressed: provider.isSyncing ? null :  () {
                    // Actualizar la lista de productos editada en widget.data
                      // widget.data.listaProducto = productosPorCategoria.values.expand((p) => p).toList();
                      
                      widget.data.listaProducto = groupedData.values.expand((p) => p).toList();
                      // Guardar los datos utilizando el Provider
                      provider.saveProviderFull(
                        context: context,
                        data: widget.data,
                      );
                     provider.refreshProvider();
                  },
              ),
              ],
            ),
            
            body: 
            Column(
              children: [
                if(isSearch)
              Row(
                children: [
                 Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    constraints: BoxConstraints(maxWidth: 300),
                    child: FormWidgets(context).autocomleteSearchListEntregas(
                    title: 'Productos',
                    listaPadre: providerProducto.listProductos,//lista de Objeto para este ejmplo se utilizo productos 
                    listaHijo: widget.data.listaProducto ?? [],
                    getName: (producto) => producto.nombre,
                    getQr: (producto) => producto.qr,
                    getId: (producto) => producto.id,
                    //Valores protegidos que no deben ser reemplazados 
                    getActive: (producto) => producto.active,
                    getCantidadEnStock: (producto) => producto.cantidadEnStock,
                    getObservacion :  (producto) => producto.observacion,
                    //Metodos de Filtrados se debe buscar por .. poner aqui los valores deseados 
                    getField: (producto, query) {
                      return producto.nombre.toLowerCase().contains(query) ||
                            producto.qr.toLowerCase().contains(query) ||
                            producto.id.toLowerCase().contains(query);
                    }, 
                    toJson: (producto) => producto.toJson(), // Convierte el producto a JSON
                    fromJson: (json) => TProductosAppModel.fromJson(json), // Convierte JSON a OBJETO  ProductoModel
                                    ),
                  ),
                  Expanded(child: Center(child: CaruselPrecioCalculados(listaProducto:  widget.data.listaProducto ?? []))),
                ],
              ),
 
              TabBar(
                  dividerColor: Colors.transparent,
                  indicatorColor: AppColors.warningColor,
                  isScrollable: true,
                  labelPadding: EdgeInsets.only(right: 5, bottom: 3),
                  indicatorPadding: EdgeInsets.all(0),
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),
                  indicatorWeight: 1,
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index; // Actualiza el índice seleccionado
                    });
                  },
                  // tabs: categorias.map((categoria) {
                  tabs: groupedData.keys.map((String tabTitle) {
                    return Tab(
                      iconMargin: EdgeInsets.all(0),
                      height: 40,
                      icon: Chip(
                        backgroundColor: AppColors.menuHeaderTheme,
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                        visualDensity: VisualDensity.compact,
                        side: BorderSide.none,
                        label: H2Text(text: tabTitle, fontSize: 11, color: AppColors.menuTextDark),
                        avatar: CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.menuTheme,
                          child: P2Text(text: '${groupedData[tabTitle]?.length ?? 0}', 
                          fontSize: 11, color: AppColors.menuIconColor)),
                      ));
                  }).toList(),
              ),
              Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: groupedData.keys.map((String categoria) {
                      int index = groupedData.keys.toList().indexOf(categoria);
                  
                      List<TProductosAppModel> productos = groupedData[categoria] ?? [];
                      
                      if(selectedIndex != index) return Container();
                      

                      return Offstage(
                        offstage: selectedIndex != index, // Solo muestra el contenido si está activo
                        // offstage: DefaultTabController.of(context)?.index != index, // Solo muestra el contenido si está activo
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                           
                           
                           listTitleCustom(
                              leading: Icon(Icons.reorder),
                              trailing: SizedBox(width:45),
                              title: Table(
                                border: TableBorder.all(color: AppColors.menuHeaderTheme),
                               columnWidths: {
                                  1: FixedColumnWidth(270), // Segunda columna, factor de flexibilidad 3 (más ancha que la primera)
                                  2: FixedColumnWidth(150), // Tercera columna, factor de flexibilidad 2
                               },
                                children: [
                                  TableRow(
                                   decoration: BoxDecoration(color: AppColors.menuTheme),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: P2Text(
                                          text: categoria.toString(),
                                          color: Colors.white,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), 
                                      CarruselPreciosCalculadosCategoria(listaProducto: productos),
                                      CarruselProductosActivosComprar(listaProducto: productos),
                                    ],
                                  )
                                ]
                              ),
                            ),
                            // Cabecera de las columnas
                            listTitleCustom(
                              leading: Icon(Icons.reorder),
                              trailing: AppSvg(width:45).trashRepoSvg,
                              title: Table(
                                border: TableBorder.all(color: AppColors.menuHeaderTheme),
                               columnWidths: columnWidths,
                                children: [
                                  TableRow(
                                   decoration: BoxDecoration(color: AppColors.menuTheme),
                                    children: listColumns.map((header) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: P2Text(
                                          text: header.toString(),
                                          color: AppColors.menuHeaderTheme,
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    }).toList(),
                                  )
                                ]
                              ),
                            ),
                            // Lista de productos en la categoría
                            Expanded(
                              child: ReorderableListView.builder(
                                // header: 
                                buildDefaultDragHandles: false,// Desactiva el icono drag predeterminado
                                physics: const ClampingScrollPhysics(),
                                padding: EdgeInsets.only(bottom: 80),
                                shrinkWrap: true,
                                itemCount: productos.length,
                                onReorder: (oldIndex, newIndex) {
                                  // setState(() {
                                    // Reordenar los productos dentro de la categoría
                                    if (newIndex > oldIndex) newIndex--;
                                    final valueProduct = productos.removeAt(oldIndex);
                                    productos.insert(newIndex, valueProduct);
                                    // Juntar todas las listas de productos en una sola lista
                                    List<TProductosAppModel> allProductos = groupedData.values.expand((productos) => productos).toList();
                                    widget.data.listaProducto = allProductos;
                                    providerProducto.clearSearch(widget.data.listaProducto ?? []);
                                  // });
                                },
                                itemBuilder: (context, productIndex) {
                                  TProductosAppModel producto = productos[productIndex];
                              
                                  final listRows = {
                                    'Tipo': producto.tipo,
                                    'Nombre': producto.nombre,
                                    'Medida': producto.outUndMedida,
                                    'Precio': producto.outPrecioDistribucion,
                                    'Cantidad': producto.cantidadEnStock,
                                    'SubTotal': (producto.cantidadEnStock! * producto.outPrecioDistribucion),
                                    '': producto.active,
                                    'Estado': producto.active! ? 'COMPRAR' : 'NO COMPRAR',
                                  };
                                  final color = AppColors.getColorByIndex( 
                                    index: productIndex, 
                                    colorPar:  AppColors.menuHeaderTheme.withOpacity(.2), 
                                    colorImpar:  AppColors.menuIconColor
                                  );

                                  final  key = '${categoria} : ${productIndex}';
                                 
                                  print(key);
                        
                                  return Container(
                                  key: Key('$key'),
                                  child:  listTitleCustom(
                                    leading:ReorderableDragStartListener(
                                    index: productIndex,
                                    child: Icon(Icons.reorder)),
                                    // trailing: IconButton(
                                    //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                    //   visualDensity: VisualDensity.compact,
                                    //   icon: Icon(Icons.remove_circle, color: Colors.red.shade200),
                                    //   onPressed: ()  async {
                                    //       bool isDeleted = await showDialog(
                                    //                 context: context,
                                    //                 builder: (BuildContext context) {
                                    //                   TextToSpeechService().speak('¡Advertencia! Estás a punto de eliminar un registro. Esta acción no se puede deshacer.');
                                    //                   return AssetAlertDialogPlatform(
                                    //                     actionButon: CupertinoDialogAction(
                                    //                       child: Text('Cancelar'),
                                    //                       onPressed: () {
                                    //                         Navigator.of(context).pop(true);
                                    //                       },
                                    //                     ),
                                    //                     message: '⚠️ ¿Seguro de eliminar este registro? ¡No podrás recuperarlo! 💥',
                                    //                     title: 'Eliminar ${producto.nombre}',
                                    //                     oK_textbuton: 'Continuar',
                                    //                     child: AppSvg().trashRepoSvg,
                                    //                   );
                                    //                 }) ?? true;
                                    //         if (!isDeleted) {
                                    //             bool isTrashAll = await showDialog(
                                    //                 context: context,
                                    //                 builder: (BuildContext context) {
                                    //                  TextToSpeechService().speak('¿Estás seguro? Esta acción no se puede deshacer. Recuerda guardar los cambios.');
                                    //                   return AssetAlertDialogPlatform(
                                    //                     actionButon: CupertinoDialogAction(
                                    //                       child: Text('Cancelar'),
                                    //                       onPressed: () {
                                    //                         Navigator.of(context).pop(true);
                                    //                       },
                                    //                     ),
                                    //                     message: '🛑 El registro será eliminado. ¡Esta acción no tiene vuelta atrás! 🗑️',
                                    //                     title: 'Eliminar registro de ${producto.nombre}',
                                    //                     oK_textbuton: 'Eliminar',
                                    //                     child: AppSvg().trashRepoSvg,
                                    //                   );
                                    //                 }) ?? true;

                                    //               if (!isTrashAll) {
                                    //                productos.removeAt(productIndex);
                                    //                // Juntar todas las listas de productos en una sola lista
                                    //                 List<TProductosAppModel> allProductos = groupedData.values.expand((productos) => productos).toList();
                                    //                 widget.data.listaProducto = allProductos;
                                    //                 providerProducto.clearSearch(widget.data.listaProducto ?? []);
                                                    
                                    //               }
                                    //         }
                                    //     },
                                    // ),
                                    trailing: IconButton(
                                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                      visualDensity: VisualDensity.compact,
                                      icon: Icon(Icons.copy, color: Colors.red.shade200),
                                      onPressed: ()  async {
                                              
                                         bool shouldDuplicate = await showDialog(
                                             context: context,
                                             builder: (BuildContext context) {
                                              TextToSpeechService().speak('¿Quieres duplicar este registro?. Recuerda guardar los cambios.');
                                               return AssetAlertDialogPlatform(
                                                 actionButon: CupertinoDialogAction(
                                                   child: Text('Cancelar'),
                                                   onPressed: () {
                                                     Navigator.of(context).pop(true);
                                                   },
                                                 ),
                                                 message: '🛑 El registro será duplicado. ¡Esta acción..s! 🗑️',
                                                 title: 'Duplicar registro de ${producto.nombre}',
                                                 oK_textbuton: 'Duplicar',
                                                 child: AppSvg().trashRepoSvg,
                                               );
                                             }) ?? true; 
                                          if(!shouldDuplicate)  {
                                             // Crear un duplicado del producto
                                              final duplicatedProduct = producto;
                                              // Insertar el producto duplicado después del original
                                              productos.insert(productIndex + 1, duplicatedProduct);
                                              // Actualizar el estado general
                                            List<TProductosAppModel> allProductos =
                                                groupedData.values.expand((productos) => productos).toList();
                                            widget.data.listaProducto = allProductos;
                                            providerProducto.clearSearch(widget.data.listaProducto ?? []);
                                             
                                          }      
                                       }
                                      ),
                                    title: Table(
                                      columnWidths: columnWidths,
                                      border: TableBorder.all(width: .5, color:Colors.white),
                                      children: [
                                        TableRow(
                                          decoration: BoxDecoration(color: producto.active! ? Colors.red.shade50 : color),
                                          children: listRows.values.map((value) {
                                            return sourceBuilder(value, producto, widget.data);
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                                                    )
                                  ;
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

 void isSeachVisible(TProductosAppProvider dataProvider,List<TProductosAppModel> listProductos ){
      setState(() => isSearch = !isSearch);
      if (!isSearch) {
          _filterseachController.clear();
          dataProvider.clearSearch(listProductos);
        }
     }




  Map<int, TableColumnWidth>? columnWidths = {
     0: FixedColumnWidth(100), // Primera columna, factor de flexibilidad 1
     1: FlexColumnWidth(3), // Segunda columna, factor de flexibilidad 3 (más ancha que la primera)
     2: FlexColumnWidth(2), // Tercera columna, factor de flexibilidad 2
     3: FixedColumnWidth(90), // Cuarta columna, factor de flexibilidad 1
     4: FixedColumnWidth(90), // Quinta columna, factor de flexibilidad 1
     5: FixedColumnWidth(90), // Quinta columna, factor de flexibilidad 1
     6: FixedColumnWidth(50), // Sexta columna, factor de flexibilidad 1
     7: FixedColumnWidth(100), // Sexta columna, factor de flexibilidad 1
  };


Widget listTitleCustom( { required Widget title, required Widget leading,  Widget? trailing} ) {
   return  ListTile(
    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    visualDensity: VisualDensity.compact,
        dense: true,
        minVerticalPadding: 0,
        leading: leading,
        title: title,
        trailing: trailing ?? null
      );
}

 Widget sourceBuilder( Object? value,  TProductosAppModel producto, TEntregasModel data) {
  Widget renderedWidget;

    if (value is String) {
      // Si es un String, mostramos el texto con un Padding
      renderedWidget = Padding(
        padding: const EdgeInsets.all(8.0),
        child: P2Text(
          text: value,
          fontSize: 11,
          textAlign: TextAlign.center,
          // selectable: true,
          maxLines: 2,
        ),
      );
    } else if (value is bool) {
      // Si es un booleano, mostramos un Checkbox
      renderedWidget = Center(
        child: Container()
        // Checkbox(
        //   value: value,
        //   onChanged: (newValue) {
        //     // Actualiza el valor del checkbox si es necesario
        //     value = newValue!;
        //   },
        // ),
      );
    } else if (value is DateTime) {
      // Si es una fecha, la formateamos
      renderedWidget = Padding(
        padding: const EdgeInsets.all(8.0),
        child: P2Text(
          text: value.year == 1998 ? '-' : formatFechaReponsiveDataTable(value),
          fontSize: 11,
          maxLines: 2,
          selectable: true,
          textAlign: TextAlign.center,
        ),
      );
    } else if (value is double || value is int) {
      // Si es un número (int o double), mostramos el valor numérico
      renderedWidget = ValueNumberEdit(value: value, producto: producto, data: data);
      // renderedWidget = Container();
    } else if (value is List) {
      // Si es una lista, mostramos los elementos como Chips
      renderedWidget = Padding(
        padding: const EdgeInsets.all(1.0),
        child: Wrap(
          spacing: 2.0,
          runSpacing: .0,
          children: value.map<Widget>((item) {
            return Chip(
              backgroundColor: AppColors.menuHeaderTheme.withOpacity(.5),
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              visualDensity: VisualDensity.compact,
              side: BorderSide.none,
              label: Text(
                '$item',
                style: const TextStyle(fontSize: 11),
              ),
            );
          }).toList(),
        ),
      );
    } else {
      // Si el tipo no es ninguno de los anteriores, mostramos "N/A"
      renderedWidget = Padding(
        padding: const EdgeInsets.all(8.0),
        child: const P2Text(
          text: 'N/A',
          fontSize: 11,
          textAlign: TextAlign.center,
        ),
      );
    }

    return renderedWidget;
  }

}

class ValueNumberEdit extends StatefulWidget {
  const ValueNumberEdit({
    super.key,
    required this.value,
    required this.producto,
    required this.data,
  });
  final Object? value;
  final TProductosAppModel producto;
  final TEntregasModel data;

  @override
  State<ValueNumberEdit> createState() => _ValueNumberEditState();
}

class _ValueNumberEditState extends State<ValueNumberEdit> {
  
  final TextEditingController _pageController = TextEditingController();
   bool isEditable = false; // Nuevo valor para controlar si el campo es editable

  @override
  void initState() {
    super.initState();
    _pageController.text = widget.value.toString();
  }

  @override
  Widget build(BuildContext context) {
   return   GestureDetector(
      onTap: () {
        setState(() {
          isEditable = true;  // Cambia a true cuando el usuario haga tap para editar
        });
      },
     child: Container(
          // width: 30,
          // height:45,
            padding: EdgeInsets.only(top:10),
            child: isEditable
            ? TextField(
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, height: 1.5,),
              decoration: AssetDecorationTextField.decorationFormPDfView(fillColor: Colors.yellow.withOpacity(.5),),
              controller: _pageController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+(\.\d{0,2})?$'), // Solo permite números con hasta dos decimales.
                  ),
                ],
              onChanged: (value) {
                  // Verificar si el campo está vacío y asignar 0
                 double newValue = value.isEmpty ? 0.0 : double.tryParse(value) ?? 0.0;
                widget.producto.cantidadEnStock = newValue;

                // setState(() {

                //   // Actualizar la cantidad del producto
                //   // widget.producto.cantidadEnStock = double.tryParse(value) ?? widget.producto.cantidadEnStock;

                //   // Actualizar la lista temporalmente
                //   final index = widget.data.listaProducto?.indexWhere((p) => p.id == widget.producto.id);
                //   if (index != null && index != -1) {
                //     widget.data.listaProducto?[index] = widget.producto;
                //   }
                // });
                 setState(() {
              // Buscar el índice del producto que está siendo editado en la lista
              final index = widget.data.listaProducto?.indexWhere(
                (p) => p == widget.producto, // Comparar por referencia (mismo objeto)
              );

              // Si el producto encontrado es el mismo
              if (index != null && index != -1) {
                // Actualizar solo el producto en ese índice
                widget.data.listaProducto?[index] = widget.producto;
              }
              print(index);
            });

              },
            )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: P2Text(
                  text: widget.value.toString(),
                  fontSize: 11,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
         ),
   );
  }
}

// IntrinsicColumnWidth : Este tipo ajusta el ancho de la columna en función del contenido más grande de la misma
//   columnWidths: {
//   0: IntrinsicColumnWidth(),  // El ancho depende del contenido
// },

// MaxColumnWidth : se usa para asegurarse de que una columna no se expanda más allá de un ancho máximo especificado,
// columnWidths: {
//   0: MaxColumnWidth(200), // El ancho máximo de la columna es 200 píxeles
// },
// FixedColumnWidth : Define un ancho fijo para la columna en píxeles
// columnWidths: {
//   0: FixedColumnWidth(100), // 100 píxeles para la primera columna
//   1: FixedColumnWidth(150), // 150 píxeles para la segunda columna
// },
