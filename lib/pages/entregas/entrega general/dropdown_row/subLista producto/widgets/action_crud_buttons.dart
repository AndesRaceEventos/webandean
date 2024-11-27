
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class ActionCrudButton extends StatefulWidget {
  const ActionCrudButton({
    super.key, 
    required this.productGrup, 
    required this.productosPorGrupo, 
    // required this.productIndex, 
    // required this.groupedData, 
    // required this.data,
    // required this.providerProducto, 
    required this.onDuplicate, 
    required this.onDeleted,
    });

  final List<dynamic> productosPorGrupo;//son Lista de Productos por los grupo o categorias 
  final dynamic productGrup; // es un elemento del grupo de lista Productos categorias
  // final TProductosAppModel productGrup;
  // final List<TProductosAppModel> productosPorGrupo;
  // final int productIndex;
  // final Map<String, List<TProductosAppModel>> groupedData;// GRUPO de datos clasificdos por uns categoria 
  // final TEntregasModel data;
  // final  TProductosAppProvider providerProducto;
  final void Function()? onDuplicate;
  final void Function()? onDeleted;

  @override
  State<ActionCrudButton> createState() => _ActionCrudButtonState();
}

class _ActionCrudButtonState extends State<ActionCrudButton> {
  bool isEditable = false; 
  bool isModifiTemporal = false; 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (mounted) {
        setState(() {
            isEditable = true; 
            isModifiTemporal = true;
            TextToSpeechService().speak('Puedes duplicar o eliminar este registro.');
        });
        }else {
          isEditable = true; 
        }
      },
      
      child: isEditable ? 
      IconButton(
         padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
         visualDensity: VisualDensity.compact,
        icon:  Icon(Icons.settings, color: isModifiTemporal ? Colors.blue.shade300 : Colors.black45,),
        onPressed: isEditable ? () => _showOptions(context) : null,
      
      ) :  Icon(Icons.settings, color: Colors.black45),

    );
  }
  
   void _showOptions(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset buttonPosition = button.localToGlobal(Offset.zero);
    final Size buttonSize = button.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        buttonPosition.dx,
        buttonPosition.dy + buttonSize.height,
        buttonPosition.dx + buttonSize.width,
        0,
      ),
      items: [
        PopupMenuItem(
          value: 'duplicate',
          child:  ButtonDuplicateItem(
            productGrup: widget.productGrup, 
            productosPorGrupo: widget.productosPorGrupo, 
            // productIndex: widget.productIndex, 
            // groupedData: widget.groupedData,
            // providerProducto: widget.providerProducto, 
            // data: widget.data,
            onDuplicate: widget.onDuplicate,//funcion para duplicar elemento
            // () {
             
              // // Encontrar cuántas veces el producto ha sido duplicado para agregar el sufijo adecuado
              //   int duplicateCount = 1;
              //   String newName = '${widget.productGrup.nombre} copia [$duplicateCount]';

              //   // Crear una copia del producto, manteniendo todos los campos, pero solo cambiando el nombre
              //   final duplicatedProduct = TProductosAppModel(
              //     id: widget.productGrup.id, 
              //     qr: widget.productGrup.qr,
              //     collectionId: widget.productGrup.collectionId ,
              //     collectionName: widget.productGrup.collectionName ,
              //     nombre: newName,  // Modificar solo el nombre
              //     observacion: 'copia [$duplicateCount]',
              //     cantidadEnStock: 0,
              //     active: true,// duplicado como comprar 
              //     outPrecioDistribucion: widget.productGrup.outPrecioDistribucion,
              //     tipo: widget.productGrup.tipo,
              //     moneda: widget.productGrup.moneda,

              //     categoriaCompras: widget.productGrup.categoriaCompras,
              //     categoriaInventario: widget.productGrup.categoriaInventario,
              //     ubicacion: widget.productGrup.ubicacion,
              //     proveedor: widget.productGrup.proveedor,
              //     rotacion: widget.productGrup.rotacion,
              //     intUndMedida: widget.productGrup.intUndMedida,
              //     outUndMedida: widget.productGrup.outUndMedida,
              //     intPrecioCompra: widget.productGrup.intPrecioCompra,
              //     idMenu: widget.productGrup.idMenu,
              //     fechaVencimiento: widget.productGrup.fechaVencimiento,
              //     estado: widget.productGrup.estado,
              //     demanda: widget.productGrup.demanda,
              //     condicionAlmacenamiento: widget.productGrup.condicionAlmacenamiento,
              //     tipoPrecio: widget.productGrup.tipoPrecio,
              //     formato: widget.productGrup.formato,
              //     durabilidad: widget.productGrup.durabilidad,
              //     proveeduria: widget.productGrup.proveeduria,
              //     presentacionVisual: widget.productGrup.presentacionVisual,
              //     embaseAmbiental: widget.productGrup.embaseAmbiental,
              //     responsabilidadAmbiental: widget.productGrup.responsabilidadAmbiental,
              //     cantidadCritica: widget.productGrup.cantidadCritica,
              //     cantidadOptima: widget.productGrup.cantidadOptima,
              //     cantidadMaxima: widget.productGrup.cantidadMaxima,
              //     cantidadMalogrados: widget.productGrup.cantidadMalogrados,
              //   );

              //   // Buscar si ya existe un duplicado con ese nombre y agregar el sufijo si es necesario
              //   for (var p in widget.productosPorGrupo) {
              //     if (p.nombre.startsWith('${widget.productGrup.nombre} copia [')) {
              //       // Incrementar el contador para los duplicados
              //       int currentCount = int.tryParse(p.nombre.split('[')[1]?.split(']')[0] ?? '0') ?? 0;
              //       duplicateCount = currentCount + 1;
              //     }
              //   }

              //   // Modificar el nombre del duplicado en la copia
              //   duplicatedProduct.nombre = '${widget.productGrup.nombre} copia [$duplicateCount]';

              //   // Insertar la copia del producto después del original
              //   widget.productosPorGrupo.insert(widget.productIndex + 1, duplicatedProduct);

              //   // Actualizar el estado general
              //   List<TProductosAppModel> allProductos =
              //       widget.groupedData.values.expand((productos) => productos).toList();

              //   // widget.data.listaProducto = allProductos;
              //   widget.data.listaProducto = allProductos;

              //   // providerProducto.clearSearch(widget.data.listaProducto ?? []);
              //   widget.providerProducto.clearSearch(widget.data.listaProducto ?? []);
            // }
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child:  ButtonDeleteItem(
            productGrup: widget.productGrup, 
            productosPorGrupo: widget.productosPorGrupo, 
            // productIndex: widget.productIndex, 
            // groupedData: widget.groupedData,
            // providerProducto: widget.providerProducto, 
            // data: widget.data,
            onDeleted: widget.onDeleted,
            //  (){
            //    widget.productosPorGrupo.removeAt(widget.productIndex);
            //         // Juntar todas las listas de productos en una sola lista
            //          List<TProductosAppModel> allProductos = widget.groupedData.values.expand((productos) => productos).toList();
            //          widget.data.listaProducto = allProductos;
            //          widget.providerProducto.clearSearch(widget.data.listaProducto ?? []);
            // },
          ),
        ),
      ],
    ).then((value) {
      // setState(() {
        isEditable = false; // Finaliza la edición
      // });
        // Navigator.pop(context);
    });
  }
}

class ButtonDuplicateItem extends StatelessWidget {
  const ButtonDuplicateItem({
    super.key, 
    required this.productGrup, 
    required this.productosPorGrupo, 
    // required this.productIndex, 
    // required this.groupedData, 
    // required this.data,
    // required this.providerProducto,
    required this.onDuplicate
    });

  // final TProductosAppModel productGrup;
  // final List<TProductosAppModel> productosPorGrupo;
  // final int productIndex;
  // final Map<String, List<TProductosAppModel>> groupedData;
  // final TEntregasModel data;
  // final  TProductosAppProvider providerProducto;
  final List<dynamic> productosPorGrupo;//son Lista de Productos por los grupo o categorias 
  final dynamic productGrup; // es un elemento del grupo de lista Productos categorias

  final void Function()? onDuplicate;



  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
            label: P1Text(text: 'Duplicar', color: Colors.indigo, fontSize: 11),
            icon: Icon(Icons.copy, color: Colors.blueAccent),
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
                       message: 'Este registro se duplicará. ¡Asegúrate de revisar antes de proceder!',
                       title: 'Confirmar duplicación de ${productGrup.nombre}',
                       oK_textbuton: 'Duplicar',
                     );
                   }) ?? true; 
                if (!shouldDuplicate) {
                  onDuplicate?.call();
                }
         }
      );
  }
}






class ButtonDeleteItem extends StatelessWidget {
  const ButtonDeleteItem({
    super.key, 
    required this.productGrup, 
    required this.productosPorGrupo, 
    // required this.productIndex, 
    // required this.groupedData, 
    // required this.data,
    // required this.providerProducto, 
    required this.onDeleted,
    });

  // final TProductosAppModel productGrup;
  // final List<TProductosAppModel> productosPorGrupo;
  // final int productIndex;
  // final Map<String, List<TProductosAppModel>> groupedData;
  // final TEntregasModel data;
  // final  TProductosAppProvider providerProducto;
  final List<dynamic> productosPorGrupo;//son Lista de Productos por los grupo o categorias 
  final dynamic productGrup; // es un elemento del grupo de lista Productos categorias

  final void Function()? onDeleted;



  @override
  Widget build(BuildContext context) {
     return TextButton.icon(
            label: P1Text(text: 'Eliminar', color: Colors.indigo, fontSize: 11),      
       icon: Icon(Icons.remove_circle, color: Colors.red.shade500),
       onPressed: ()  async {
           bool isDeleted = await showDialog(
                     context: context,
                     builder: (BuildContext context) {
                       TextToSpeechService().speak('¡Atención! Estás a punto de eliminar este registro.');
                       return AssetAlertDialogPlatform(
                         actionButon: CupertinoDialogAction(
                           child: Text('Cancelar'),
                           onPressed: () {
                             Navigator.of(context).pop(true);
                           },
                         ),
                         message: '⚠️ ¿Seguro de eliminar este registro? ¡No podrás recuperarlo! 💥',
                         title: 'Eliminar ${productGrup.nombre}',
                         oK_textbuton: 'Continuar',
                       );
                     }) ?? true;
             if (!isDeleted) {
                 bool isTrashAll = await showDialog(
                     context: context,
                     builder: (BuildContext context) {

                      TextToSpeechService().speak('¿Estás seguro? Esta acción es irreversible.');
                       return AssetAlertDialogPlatform(
                         actionButon: CupertinoDialogAction(
                           child: Text('Cancelar'),
                           onPressed: () {
                             Navigator.of(context).pop(true);
                           },
                         ),
                         message: '🛑 El registro será eliminado. ¡Esta acción no tiene vuelta atrás! 🗑️\n\n ${productGrup.nombre}\n',
                         title: '',
                         oK_textbuton: 'Eliminar',
                         child: AppSvg(width: 80).trashRepoSvg,
                       );}) ?? true;
              
                   if (!isTrashAll) {
                      onDeleted?.call();//llmar al afuncion de eliminar 
                     
                   }
             }
       }
     );
  }
}




// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';
// import 'package:webandean/utils/animations/assets_animationswith.dart';
// import 'package:webandean/utils/button/asset_buton_widget.dart';
// import 'package:webandean/utils/colors/assets_colors.dart';
// import 'package:webandean/utils/files%20assset/assets-svg.dart';
// import 'package:webandean/utils/formulario/formfield_customs.dart';
// import 'package:webandean/utils/layuot/assets_circularprogrees.dart';
// import 'package:webandean/utils/layuot/assets_scroll_web.dart';
// import 'package:webandean/utils/text/assets_textapp.dart';
// import 'package:webandean/utils/textfield/decoration_form.dart';

// import 'package:webandean/pages/entregas/entrega%20general/dropdown_row/Lista%20producto/widgets/action_crud_buttons.dart';
// import 'package:webandean/pages/entregas/entrega%20general/dropdown_row/Lista%20producto/widgets/source_builder_valuerow.dart';

// import 'package:webandean/model/entregas/model_entregas_general.dart';
// import 'package:webandean/model/producto/model_producto.dart';

// import 'package:webandean/provider/entregas/provider_entregas_generales.dart';
// import 'package:webandean/provider/producto/provider_producto.dart';
// import 'package:webandean/provider/sunat%20/provider_tipo_cambio.dart';

// /// Widget que muestra la lista de productos organizados por categorías

// class ButtonSubListProductos extends StatelessWidget {
//   const ButtonSubListProductos({super.key, required this.data});
//   final TEntregasModel data;
  

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () async {
//         // Muestra un diálogo de carga antes de continuar
//         // showDialog(
//         //   context: context,
//         //   barrierDismissible: false, // Evita que se cierre el diálogo tocando fuera
//         //   builder: (context) => Center(child: CircularProgressIndicator()),
//         // );

//         // // Lee las instrucciones con TextToSpeech
//         // await TextToSpeechService().speak('Instrucciones para usar este widget: Toque el botón para ver la lista de productos.');

//         // // Espera a que el TTS termine antes de cerrar el diálogo y navegar
//         // TextToSpeechService().flutterTts.setCompletionHandler(() async {
//         //   // Cierra el diálogo de carga
//         //   Navigator.of(context).pop();

//         //   // Navega a la siguiente pantalla
//         //   Navigator.push(
//         //     context,
//         //     MaterialPageRoute(builder: (context) => ListaProductos(data: data)),
//         //   );
//         // });
//          Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => ListaProductos(
//               data: data, 
//               categoria:'CATEGORIA_COMPRAS', //todos Asginasmos la categoria a filtrar   SEGU NTU PROVIDER OJO!!! 
//               header: [
//                 'Tipo', 'Nombre', 'Observacion', 'Precio', 'Cantidad','SubTotal' ,'_','Estado'
//               ],
//               getProductGrup: (producto) { 

//                  TProductosAppModel productGrup = producto;
//                   productGrup.cantidadEnStock ?? 0;
//                   productGrup.outPrecioDistribucion ?? 0;
                  
//                   final listRows = {
//                        'Tipo': productGrup.tipo,
//                        'Nombre':productGrup.nombre,// "${producto.nombre.toUpperCase()} * ${producto.outUndMedida.toUpperCase()}",
//                        'observacion': productGrup.observacion,
//                        'Precio': productGrup.outPrecioDistribucion.toString(),
//                        'Cantidad': productGrup.cantidadEnStock,
//                        'SubTotal': (productGrup.cantidadEnStock! * productGrup.outPrecioDistribucion).toStringAsFixed(2).toString(),//lop onemso como strign para no se active el editar 
//                        '_': productGrup.moneda,
//                        'Estado': productGrup.active,
//                      };
//                  return listRows;
//                },
              
//               )),
//           );
//       },
//       child: Text('Productos'),
//     );
//   }
// }

// class ListaProductos extends StatefulWidget {
//   const ListaProductos({
//     super.key,
//     required this.data, 
//     required this.categoria, 
//     required this.getProductGrup,
//     // required this.createdNewItem,
//     required this.header,
//   });

//   final TEntregasModel data;
//   final String categoria;
  
//   final Map<String, Object?> Function(dynamic producto) getProductGrup;
//   final List<String> header;

//   // final Widget Function(dynamic dataPadre) createdNewItem;//data ppasar la sublist 
//   //  final Widget  createdNewItem;

//   @override
//   State<ListaProductos> createState() => _ListaProductosState();
// }

// class _ListaProductosState extends State<ListaProductos> {

//   int selectedIndex = 0; // Para saber cuál pestaña está activa TAbbaView 

//   late TextEditingController _filterseachController;
//   // late String categoria;
  
//   bool isSearch = false;

//   @override
//   void initState() {
//     super.initState();
//     // categoria = 'CATEGORIA_COMPRAS';
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
//     final provider = Provider.of<TEntregasAppProvider>(context);
  
//   // Suponiendo que puedes llamar a getProductGrup y devolver un mapa vacío si no tienes acceso a productGrup.
//   // final listColumns = widget.getProductGrup({}).keys.toList();
//     // final listColumns = [
//     //  'Tipo', 'Nombre', 'Observacion', 'Precio', 'Cantidad','SubTotal' ,'_','Estado'
//     // ];

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
//         ? Center(
//           child: AppIconButoonELegant(
//           colorButon: Colors.white,
//           colorlabel: AppColors.menuTextDark,
//           onPressed: () => isSeachVisible(providerProducto, widget.data.listaProducto ?? []),
//           label: 'No hay resultados, ¿otra búsqueda? 🔍👀',
//           icon: Icon(Icons.close, size: 30, color: AppColors.menuTextDark)))

//         :  DefaultTabController(
//         // length: categorias.length,
//         length: groupedData.keys.length,
//         initialIndex: selectedIndex,
//         child: ScrollWeb(
//           child: Scaffold(
//             appBar: AppBar(
//               leadingWidth: 0,
//               leading: SizedBox(),
//               centerTitle: true,
//               title: AssetsAnimationSwitcher(
//                         isTransition: true,
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
//                           ])
//               ),
//               actions: [
//               AppIconButoonELegant(
//                 label: ' Guardar', 
//                 colorlabel: Colors.white,
//                 colorButon: Colors.green.shade700,
//                 icon: provider.isSyncing ? AssetsCircularProgreesIndicator() : 
//                  Icon( Icons.save, size: 30, color: Colors.white),
//                 onPressed: provider.isSyncing ? null :  () {
//                     // Actualizar la lista de productos editada en widget.data
//                       // widget.data.listaProducto = productosPorCategoria.values.expand((p) => p).toList();
                      
//                       widget.data.listaProducto = groupedData.values.expand((p) => p).toList();
//                       // Guardar los datos utilizando el Provider
//                       provider.saveProviderFull(
//                         context: context,
//                         data: widget.data,
//                       );
//                      provider.refreshProvider();
//                   },
//               ),
//               ],
//             ),
            
//             body: 
//             Column(
//               children: [
//                 if(isSearch)
//               Row(
//                 children: [
//                   // widget.createdNewItem,
//                  Container(
//                     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                     constraints: BoxConstraints(maxWidth: 300),
//                     child: FormWidgets(context).autocomleteSearchListEntregas(
//                     title: 'Productos',
//                     listaPadre: providerProducto.listProductos,//lista de Objeto para este ejmplo se utilizo productos 
//                     listaHijo: widget.data.listaProducto ?? [],
//                     getName: (producto) => producto.nombre,
//                     getQr: (producto) => producto.qr,
//                     getId: (producto) => producto.id,
//                     //Valores protegidos que no deben ser reemplazados 
//                     getActive: (producto) => producto.active,
//                     getCantidadEnStock: (producto) => producto.cantidadEnStock,
//                     getObservacion :  (producto) => producto.observacion,
//                     //Metodos de Filtrados se debe buscar por .. poner aqui los valores deseados 
//                     getField: (producto, query) {
//                       return producto.nombre.toLowerCase().contains(query) ||
//                             producto.qr.toLowerCase().contains(query) ||
//                             producto.id.toLowerCase().contains(query);
//                     }, 
//                     toJson: (producto) => producto.toJson(), // Convierte el producto a JSON
//                     fromJson: (json) => TProductosAppModel.fromJson(json), // Convierte JSON a OBJETO  ProductoModel
//                                     ),
//                   ),
//                   Expanded(child: Center(child: CaruselPrecioCalculados(listaProducto:  widget.data.listaProducto ?? []))),
//                 ],
//               ),
 
//               TabBar(
//                   dividerColor: Colors.transparent,
//                   indicatorColor: AppColors.warningColor,
//                   isScrollable: true,
//                   labelPadding: EdgeInsets.only(right: 5, bottom: 3),
//                   indicatorPadding: EdgeInsets.all(0),
//                   overlayColor: WidgetStatePropertyAll(Colors.transparent),
//                   indicatorWeight: 1,
//                   onTap: (index) {
//                     setState(() {
//                       selectedIndex = index; // Actualiza el índice seleccionado
//                     });
//                   },
//                   // tabs: categorias.map((categoria) {
//                   tabs: groupedData.keys.map((String tabTitle) {
//                     return Tab(
//                       iconMargin: EdgeInsets.all(0),
//                       height: 40,
//                       icon: Chip(
//                         backgroundColor: AppColors.menuHeaderTheme,
//                         padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//                         visualDensity: VisualDensity.compact,
//                         side: BorderSide.none,
//                         label: H2Text(text: tabTitle, fontSize: 11, color: AppColors.menuTextDark),
//                         avatar: CircleAvatar(
//                           radius: 25,
//                           backgroundColor: AppColors.menuTheme,
//                           child: P2Text(text: '${groupedData[tabTitle]?.length ?? 0}', 
//                           fontSize: 11, color: AppColors.menuIconColor)),
//                       ));
//                   }).toList(),
//               ),
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
//                            listTitleCustom(
//                               leading: SizedBox(width:25),
//                               trailing: SizedBox(width:25),
//                               title: Table(
//                                 border: TableBorder.all(color: AppColors.menuHeaderTheme),
//                                columnWidths: {
//                                   1: FixedColumnWidth(270), // Segunda columna, factor de flexibilidad 3 (más ancha que la primera)
//                                   2: FixedColumnWidth(150), // Tercera columna, factor de flexibilidad 2
//                                },
//                                 children: [
//                                   TableRow(
//                                    decoration: BoxDecoration(color: AppColors.menuTheme),
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: P2Text(
//                                           text: categoria.toString(),
//                                           color: Colors.white,
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ), 
//                                       CarruselPreciosCalculadosCategoria(listaProducto: productosPorGrupo),
//                                       CarruselProductosActivosComprar(listaProducto: productosPorGrupo),
//                                     ],
//                                   )
//                                 ]
//                               ),
//                             ),
//                             // Cabecera de las columnas
//                             listTitleCustom(
//                               leading:  SizedBox(width:25),
//                               trailing:  SizedBox(width:25),
//                               title: Table(
//                                 border: TableBorder.all(color: AppColors.menuHeaderTheme),
//                                columnWidths: columnWidths,
//                                 children: [
//                                   TableRow(
//                                    decoration: BoxDecoration(color: AppColors.menuTheme),
//                                     children: widget.header.map((header) {
//                                     // children: widget.getProductGrup(productosPorGrupo[index]).keys.map((header) {
//                                       return Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: P2Text(
//                                           text: header.toString(),
//                                           color: AppColors.menuHeaderTheme,
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       );
//                                     }).toList(),
//                                   )
//                                 ]
//                               ),
//                             ),
//                             // Lista de productos en la categoría
//                             Expanded(
//                               child: ReorderableListView.builder(
//                                 // header: 
//                                 buildDefaultDragHandles: false,// Desactiva el icono drag predeterminado
//                                 physics: const ClampingScrollPhysics(),
//                                 padding: EdgeInsets.only(bottom: 80),
//                                 shrinkWrap: true,
//                                 itemCount: productosPorGrupo.length,
//                                 onReorder: (oldIndex, newIndex)  {
//                                  // Solo realizar el reordenamiento si no hay formulario abierto
//                                     if (newIndex > oldIndex) newIndex--;
//                                       final valueProduct = productosPorGrupo.removeAt(oldIndex);
//                                       productosPorGrupo.insert(newIndex, valueProduct);
//                                       // Juntar todas las listas de productos en una sola lista
//                                       List<TProductosAppModel> allProductos = groupedData.values.expand((productos) => productos).toList();
//                                       widget.data.listaProducto = allProductos;
//                                       providerProducto.clearSearch(widget.data.listaProducto ?? []);
//                                 },
                                
//                                 itemBuilder: (context, productIndex) {
//                                   // TProductosAppModel productGrup = productosPorGrupo[productIndex];
//                                   final productGrup = productosPorGrupo[productIndex];
                                

//                                   final listRows = widget.getProductGrup(productGrup);
                                  
//                                   // final listRows = {
//                                   //   'Tipo': productGrup.tipo,
//                                   //   'Nombre':productGrup.nombre,// "${producto.nombre.toUpperCase()} * ${producto.outUndMedida.toUpperCase()}",
//                                   //   'observacion': productGrup.observacion,
//                                   //   'Precio': productGrup.outPrecioDistribucion.toString(),
//                                   //   'Cantidad': productGrup.cantidadEnStock,
//                                   //   'SubTotal': (productGrup.cantidadEnStock! * productGrup.outPrecioDistribucion).toStringAsFixed(2).toString(),//lop onemso como strign para no se active el editar 
//                                   //   '_': productGrup.moneda,
//                                   //   'Estado': productGrup.active,
//                                   // };

//                                   final colorIndex = AppColors.getColorByIndex(index: productIndex);
                        
//                                   return Container(
//                                   key: Key('${categoria} : ${productIndex}'),
//                                   child:  listTitleCustom(
//                                     leading:ReorderableDragStartListener(
//                                     index: productIndex,
//                                     child:Icon(Icons.reorder),
//                                     ),
                                   
//                                     trailing:  ActionCrudButton(
//                                       productosPorGrupo: productosPorGrupo, //son la lista Productos por los grupo o categorias
//                                       productGrup: productGrup, // es un elemento del grupo de lista Productos categorias
//                                       // productIndex: productIndex, ///Index de Grupo 
//                                       // groupedData: groupedData,  // GRUPO de datos clasificdos por uns categoria 
//                                       // data: widget.data,
//                                       // providerProducto: providerProducto,
//                                       onDuplicate: () { 
//                                         // Encontrar cuántas veces el producto ha sido duplicado para agregar el sufijo adecuado
//                                           int duplicateCount = 1;
//                                           String newName = '${productGrup.nombre} copia [$duplicateCount]';

//                                           // Crear una copia del producto, manteniendo todos los campos, pero solo cambiando el nombre
//                                           final duplicatedProduct = TProductosAppModel(
//                                             id: productGrup.id, 
//                                             qr: productGrup.qr,
//                                             collectionId: productGrup.collectionId ,
//                                             collectionName: productGrup.collectionName ,
//                                             nombre: newName,  // Modificar solo el nombre
//                                             observacion: 'copia [$duplicateCount]',
//                                             cantidadEnStock: 0,
//                                             active: true,// duplicado como comprar 
//                                             outPrecioDistribucion: productGrup.outPrecioDistribucion,
//                                             tipo: productGrup.tipo,
//                                             moneda: productGrup.moneda,

//                                             categoriaCompras: productGrup.categoriaCompras,
//                                             categoriaInventario: productGrup.categoriaInventario,
//                                             ubicacion: productGrup.ubicacion,
//                                             proveedor: productGrup.proveedor,
//                                             rotacion: productGrup.rotacion,
//                                             intUndMedida: productGrup.intUndMedida,
//                                             outUndMedida: productGrup.outUndMedida,
//                                             intPrecioCompra: productGrup.intPrecioCompra,
//                                             idMenu: productGrup.idMenu,
//                                             fechaVencimiento: productGrup.fechaVencimiento,
//                                             estado: productGrup.estado,
//                                             demanda: productGrup.demanda,
//                                             condicionAlmacenamiento: productGrup.condicionAlmacenamiento,
//                                             tipoPrecio: productGrup.tipoPrecio,
//                                             formato: productGrup.formato,
//                                             durabilidad: productGrup.durabilidad,
//                                             proveeduria: productGrup.proveeduria,
//                                             presentacionVisual: productGrup.presentacionVisual,
//                                             embaseAmbiental: productGrup.embaseAmbiental,
//                                             responsabilidadAmbiental: productGrup.responsabilidadAmbiental,
//                                             cantidadCritica: productGrup.cantidadCritica,
//                                             cantidadOptima: productGrup.cantidadOptima,
//                                             cantidadMaxima: productGrup.cantidadMaxima,
//                                             cantidadMalogrados: productGrup.cantidadMalogrados,
//                                           );

//                                           // Buscar si ya existe un duplicado con ese nombre y agregar el sufijo si es necesario
//                                           for (var p in productosPorGrupo) {
//                                             if (p.nombre.startsWith('${productGrup.nombre} copia [')) {
//                                               // Incrementar el contador para los duplicados
//                                               int currentCount = int.tryParse(p.nombre.split('[')[1]?.split(']')[0] ?? '0') ?? 0;
//                                               duplicateCount = currentCount + 1;
//                                             }
//                                           }

//                                           // Modificar el nombre del duplicado en la copia
//                                           duplicatedProduct.nombre = '${productGrup.nombre} copia [$duplicateCount]';

//                                           // Insertar la copia del producto después del original
//                                           productosPorGrupo.insert(productIndex + 1, duplicatedProduct);

//                                           // Actualizar el estado general
//                                           List<TProductosAppModel> allProductos =
//                                               groupedData.values.expand((productos) => productos).toList();

//                                           // widget.data.listaProducto = allProductos;
//                                           widget.data.listaProducto = allProductos;

//                                           // providerProducto.clearSearch(widget.data.listaProducto ?? []);
//                                           providerProducto.clearSearch(widget.data.listaProducto ?? []);
//                                                                 }, 
//                                       onDeleted: () { 
//                                          productosPorGrupo.removeAt(productIndex);
//                                          // Juntar todas las listas de productos en una sola lista
//                                          List<TProductosAppModel> allProductos = groupedData.values.expand((productos) => productos).toList();
//                                          widget.data.listaProducto = allProductos;
//                                          providerProducto.clearSearch(widget.data.listaProducto ?? []);
//                                        }, 
                                       
//                                     ),
//                                     title: Table(
//                                       columnWidths: columnWidths,
//                                       border: TableBorder.all(width: .5, color:Colors.white),
//                                       children: [
//                                         TableRow(
//                                           decoration: BoxDecoration(color: productGrup.active! ? Colors.red.shade50 : colorIndex),
//                                           children: listRows.values.map((value) {
//                                             return sourceBuilder(
//                                               valueField: value,
//                                               productoRow: productGrup, 
//                                               subListDPadre : widget.data.listaProducto ?? [], 
//                                               colorIndex : colorIndex
//                                               );
//                                           }).toList(),
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

//  void isSeachVisible(TProductosAppProvider dataProvider,List<TProductosAppModel> listProductos ){
//   setState(() => isSearch = !isSearch);
//    if (!isSearch) {
//      _filterseachController.clear();
//      dataProvider.clearSearch(listProductos);
//    }
//  }




//   Map<int, TableColumnWidth>? columnWidths = {
//      0: FixedColumnWidth(100), // Primera columna, factor de flexibilidad 1
//      1: FlexColumnWidth(3), // Segunda columna, factor de flexibilidad 3 (más ancha que la primera)
//      2: FlexColumnWidth(2), // Tercera columna, factor de flexibilidad 2
//      3: FixedColumnWidth(90), // Cuarta columna, factor de flexibilidad 1
//      4: FixedColumnWidth(90), // Quinta columna, factor de flexibilidad 1
//      5: FixedColumnWidth(90), // Quinta columna, factor de flexibilidad 1
//      6: FixedColumnWidth(50), // Sexta columna, factor de flexibilidad 1
//      7: FixedColumnWidth(100), // Sexta columna, factor de flexibilidad 1
//   };


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

