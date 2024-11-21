import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webandean/model/entregas/model_entregas_general.dart';
import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/provider/entregas/provider_entregas_generales.dart';
import 'package:webandean/utils/animations/assets_delayed_display.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/responsiveTable/headers_global/header_generic.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:webandean/utils/textfield/decoration_form.dart';
import 'package:webandean/widget/estate%20app/state_icon_offline.dart';

/// Widget que muestra la lista de productos organizados por categorías
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
  // Mapa que almacena productos organizados por categoría
  Map<String, List<TProductosAppModel>> productosPorCategoria = {};

  int selectedIndex = 0; // Para saber cuál pestaña está activa TAbbaView 

  @override
  void initState() {
    super.initState();
    final listaProducto = widget.data.listaProducto ?? [];
    // Agrupar los productos por categoría de compras
    for (var p in listaProducto) {
      String categoria = p.categoriaCompras.isNotEmpty ? p.categoriaCompras : "_N/A".toUpperCase();
  
      if (!productosPorCategoria.containsKey(categoria)) {
        productosPorCategoria[categoria] = [];
      }
      productosPorCategoria[categoria]?.add(p);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> categorias = productosPorCategoria.keys.toList();
    categorias.sort();  // Orden  ar las categorías alfabéticamente

    final listColumns = [
     'Nro' 'Tipo', 'Nombre', 'Medida', 'Precio', 'Cantidad', '','Estado'
    ];
   
  
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DefaultTabController(
        length: categorias.length,
        initialIndex: selectedIndex,
        child: ScrollWeb(
          child: Scaffold(
            appBar: AppBar(
              actions: [
                TextButton.icon(
                  icon: Icon(Icons.save),
                  label: H3Text(text: 'Guardar'),
                  onPressed: () {
                   // Actualizar la lista de productos editada en widget.data
                    widget.data.listaProducto = productosPorCategoria.values.expand((p) => p).toList();
          
                    // Guardar los datos utilizando el Provider
                    context.read<TEntregasAppProvider>().saveProviderFull(
                      context: context,
                      data: widget.data,
                    );
                    context.read<TEntregasAppProvider>().refreshProvider();
                    
                  },
                ),
              ],
              bottom: TabBar(
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
                tabs: categorias.map((categoria) {
                  return Tab(
                    iconMargin: EdgeInsets.all(0),
                    height: 40,
                    icon: Chip(
                       backgroundColor: AppColors.menuHeaderTheme,
                       padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                       visualDensity: VisualDensity.compact,
                       side: BorderSide.none,
                      label: H2Text(text: categoria, fontSize: 11, color: AppColors.menuTextDark),
                      avatar: CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.menuTheme,
                        child: P2Text(text: '${productosPorCategoria[categoria]!.length}', 
                        fontSize: 11, color: AppColors.menuIconColor)),
                    ));
                }).toList(),
              ),
            ),
            body: 
            TabBarView(
              physics: const NeverScrollableScrollPhysics(),
  //             IndexedStack(
  // index: selectedIndex,
              children: categorias.map((categoria) {
                int index = categorias.indexOf(categoria);
                List<TProductosAppModel> productos = productosPorCategoria[categoria] ?? [];
                
                if(selectedIndex != index) return Container();

                return Offstage(
                  offstage: selectedIndex != index, // Solo muestra el contenido si está activo
                  // offstage: DefaultTabController.of(context)?.index != index, // Solo muestra el contenido si está activo
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        color:  AppColors.menuHeaderTheme.withOpacity(.2),
                        constraints: BoxConstraints(maxWidth: 200),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          minVerticalPadding: 0,
                          leading: Icon(Icons.monetization_on),
                          title: H2Text(text: '${categoria}',
                          fontSize: 13, color: AppColors.menuTextDark),
                          subtitle: FittedBox(
                            child: H1Text(text:"TOTAL : ${calcularTotalCantidad(productos)}", 
                            fontSize: 20, color: AppColors.menuTextDark),
                          ),
                        ),
                      ),
                      // Cabecera de las columnas
                      listTitleCustom(
                        leading: Icon(Icons.reorder),
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
                            setState(() {
                              // Reordenar los productos dentro de la categoría
                              if (newIndex > oldIndex) newIndex--;
                              final valueProduct = productos.removeAt(oldIndex);
                              productos.insert(newIndex, valueProduct);
                            });
                          },
                          itemBuilder: (context, productIndex) {
                            TProductosAppModel producto = productos[productIndex];
                        
                            final listRows = {
                              'Tipo': producto.tipo,
                              'Nombre': producto.nombre,
                              'Medida': producto.outUndMedida,
                              'Precio': producto.outPrecioDistribucion,
                              'Cantidad': producto.cantidadEnStock,
                              '': producto.active,
                              'Estado': producto.active! ? 'COMPRAR' : 'NO COMPRAR',
                            };
                            final color = AppColors.getColorByIndex( 
                              index: productIndex, 
                              colorPar:  AppColors.menuHeaderTheme.withOpacity(.2), 
                              colorImpar:  AppColors.menuIconColor
                            );
                  
                            print( '${categoria} : ${productIndex}');
                  
                            // return AssetsDelayedDisplayYbasic(
                            //   duration: 100,
                            //   fadingDuration: 300,
                            return Container(
                              key: Key('producto_${producto.id}_$productIndex'),
                              child:  listTitleCustom(
                                  leading:ReorderableDragStartListener(
                                index: productIndex,
                                child: Icon(Icons.reorder)),
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

double calcularTotalCantidad(List<TProductosAppModel> productos) {
  return productos.fold(0, (sum, product) {
    // Asegurarse de que los valores no sean nulos antes de multiplicar
    double cantidad = product.cantidadEnStock ?? 0;
    double precio = product.outPrecioDistribucion ?? 0;
    return sum + (cantidad * precio);
  });
}


  Map<int, TableColumnWidth>? columnWidths = {
     0: FixedColumnWidth(100), // Primera columna, factor de flexibilidad 1
     1: FlexColumnWidth(3), // Segunda columna, factor de flexibilidad 3 (más ancha que la primera)
     2: FlexColumnWidth(2), // Tercera columna, factor de flexibilidad 2
     3: FixedColumnWidth(100), // Cuarta columna, factor de flexibilidad 1
     4: FixedColumnWidth(100), // Quinta columna, factor de flexibilidad 1
     5: FixedColumnWidth(60), // Sexta columna, factor de flexibilidad 1
     6: FixedColumnWidth(100), // Sexta columna, factor de flexibilidad 1
  };


Widget listTitleCustom( { required Widget title, required Widget leading} ) {
   return  ListTile(
    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    visualDensity: VisualDensity.compact,
        dense: true,
        minVerticalPadding: 0,
        leading: leading,
        title: title,
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
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  // Actualizar la cantidad del producto
                  widget.producto.cantidadEnStock = double.tryParse(value) ?? widget.producto.cantidadEnStock;
     
                  // Actualizar la lista temporalmente
                  final index = widget.data.listaProducto?.indexWhere((p) => p.id == widget.producto.id);
                  if (index != null && index != -1) {
                    widget.data.listaProducto?[index] = widget.producto;
                  }
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
