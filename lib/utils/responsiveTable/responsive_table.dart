import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:webandean/provider/cache/files/files_procesisng.dart';
import 'package:webandean/utils/button/asset_buton_widget.dart';

import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/textfield/decoration_form.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/mouse%20region/selectd_region.dart';
import 'package:webandean/utils/responsiveTable/headers_global/header_image.dart';
import 'package:webandean/utils/responsiveTable/headers_global/header_action.dart';
import 'package:webandean/utils/responsiveTable/headers_global/header_generic.dart';
import 'package:webandean/utils/responsiveTable/paginated%20control/paginated_control.dart';

// import 'package:webandean/pages/t_productos/dropdown_row/dropdown_row.dart';
// import 'package:webandean/pages/t_productos/generate_data/generate_data.dart';
// import 'package:webandean/pages/t_productos/table_header/header_progress.dart';
// import 'package:webandean/pages/t_productos/footer_table/footer_table.dart';
// import 'package:webandean/pages/t_productos/table_actions/actions_button_table.dart';

class ResponsiveTableCustom extends StatefulWidget {
  const ResponsiveTableCustom({
    Key? key,
    required this.listProductos, 
    required this.dropContainer, 
    required this.fotterButonBar, 
     this.dtaHeaderListProgress, 
      this.dtaHeaderListProgress2, 
    
    required this.headerData, 
    required this.generateData, 
    required this.applyFilter, 
    
    required this.fomrView, 
    required this.isDeleteForm,
  }) : super(key: key);

  // final List<TProductosAppModel> listProductos;
  final List<dynamic> listProductos;
  final Widget Function(Map<String, dynamic>) dropContainer; // Función para el dropdown
  final Widget Function(List<dynamic>, List<Map<String, dynamic>>, List<Map<String, dynamic>>) fotterButonBar; // Función para el dropdown
  final Function()? dtaHeaderListProgress;
  final Function()? dtaHeaderListProgress2;

  final List<Map<String, dynamic>>  headerData;
  final List<Map<String, dynamic>>  Function(List<dynamic> ) generateData;
  final  Function(List<Map<String, dynamic>>, String? ) applyFilter;

  final Widget Function(BuildContext,double, bool, dynamic, Function(), Function() ) fomrView;
  final Function(BuildContext, dynamic, Function() ) isDeleteForm;//Ponerl widget si quieres aumentar mas cosas

  @override
  State<ResponsiveTableCustom> createState() => _ResponsiveTableCustomState();
}

class _ResponsiveTableCustomState extends State<ResponsiveTableCustom> {
 
  late List<DatatableHeader> _headers; // Encabezados de la tabla, se inicializan en initState

  //TODOS ** ***************** GENERICOS - NO VARÍAN A LO LARGO DEL USO DE LA TABLA *******************

  //** ***************** PAGINACIÓN *******************
  final List<int> _perPages = [
    10,
    20,
    50,
    100
  ]; // Opciones para el número de elementos por página
  int _total = 100; // Total de elementos en la tabla
  int? _currentPerPage = 10; // Número de elementos por página actual
  List<bool>?
      _expanded; // Lista de booleans que indica si una fila está expandida o no

  int _currentPage = 1; // Página actual en la paginación
  bool _isSearch = false; // Indica si la búsqueda está activa
  final List<Map<String, dynamic>> _sourceOriginal =
      []; // Datos originales sin filtrar
  List<Map<String, dynamic>> _sourceFiltered =
      []; // Datos después de aplicar filtros
  List<Map<String, dynamic>> _source = []; // Datos que se muestran en la tabla
  List<Map<String, dynamic>> _selecteds = []; // Datos seleccionados en la tabla

  String? _sortColumn; // Columna por la que se está ordenando
  bool _sortAscending = true; // Indica si el orden es ascendente
  bool _isLoading = true; // Indica si los datos están siendo cargados
  final bool _showSelect =
      true; // Indica si se debe mostrar la opción de selección

  // late DataUtils _dataUtils;
  //todos **********************GENERICO  *****************  */

  _mockPullData() async {
    // Inicializa la lista _expanded con valores false para cada elemento de la página actual.
    _expanded = List.generate(_currentPerPage!, (index) => false);

    // Cambia el estado de _isLoading a true para mostrar un indicador de carga.
    if (mounted) {
      setState(() => _isLoading = true);
    }

    // Simula un retraso de 1 segundo para la carga de datos.
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      try {
        // Limpia la lista de datos originales.
        _sourceOriginal.clear();

        // Llena la lista _sourceOriginal con datos generados por la función cargarData.
        _sourceOriginal.addAll(cargarData());

        // Establece _sourceFiltered igual a _sourceOriginal (sin filtrar).
        _sourceFiltered = _sourceOriginal;

        // Actualiza el total de elementos con el tamaño de _sourceFiltered.
        _total = _sourceFiltered.length;

        // Calcula el rango final basado en el número de elementos por página actual y el total.
        int endRange = min(_currentPerPage!, _total);

        // Establece _source con los elementos de _sourceFiltered en el rango de la página actual.
        _source = _sourceFiltered.getRange(0, endRange).toList();
      } catch (e) {
        // Maneja cualquier error que ocurra durante la carga de datos.
        print("Error al cargar los datos: $e");

        // Puedes actualizar el estado para reflejar el error.
        if (mounted) {
          setState(() => _isLoading = false);
        }
      } finally {
        // Asegúrate de que _isLoading sea false, incluso si ocurre un error.
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }).catchError((e) {
      // Captura cualquier error que ocurra específicamente en la ejecución del Future.
      print("Error en Future.delayed: $e");

      // Asegúrate de que _isLoading sea false en caso de error.
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });
  }

  /// Actualiza los datos mostrados en la tabla en función de la paginación.
  /// - [start]: El índice de inicio para la página actual.
  _resetData({int start = 0}) async {
    if (mounted) {
      setState(() => _isLoading = true);
    }

    // Calcula el número de elementos a mostrar en la página actual.
    var expandedLen =
        _total - start < _currentPerPage! ? _total - start : _currentPerPage!;

    // Simula un retraso de 1 segundo para la carga de datos.
    Future.delayed(const Duration(seconds: 1)).then((value) {
      // Actualiza la lista de expansión para las filas.
      _expanded = List.generate(expandedLen, (index) => false);

      // Limpia la lista de datos mostrados.
      _source.clear();

      // Calcula el rango final para la página actual.
      var endRange = start + expandedLen;
      endRange = endRange > _total ? _total : endRange;

      // Actualiza la lista de datos mostrados con el rango calculado.
      _source = _sourceFiltered.getRange(start, endRange).toList();
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });
  }

  //FILTRADo LOGICA GENERAL
  void _filterData(String? value) {
    // Cambia el estado a 'cargando' mientras se realiza el filtrado de datos
    setState(() => _isLoading = true);

    try {
      // Filtra los datos usando una función específica para aplicar el filtro
      // _sourceFiltered = _applyFilter(value);
      // _sourceFiltered = DataUtils(_sourceOriginal).applyFilter(value);
       _sourceFiltered = widget.applyFilter(_sourceOriginal, value);

      // Actualiza la paginación y el rango de datos visibles en la tabla
      _updatePagination();
    } catch (e) {
      // Captura y muestra cualquier error que ocurra durante el filtrado
      print(e);
    }

    // Cambia el estado a 'no cargando' después de completar el filtrado
    setState(() => _isLoading = false);
  }

  void _updatePagination() {
    // Actualiza el total de elementos filtrados
    _total = _sourceFiltered.length;

    // Calcula el rango máximo de elementos que se deben mostrar por página
    var rangeTop = _total < _currentPerPage! ? _total : _currentPerPage!;

    // Genera una lista de booleans para controlar la expansión de las filas
    _expanded = List.generate(rangeTop, (index) => false);

    // Actualiza la lista de elementos que se deben mostrar en la tabla
    _source = _sourceFiltered.getRange(0, rangeTop).toList();
  }

  void _initializeData() async {
    // Llama al método para cargar los datos de prueba o iniciales
    _mockPullData();
  }

  void onSort({required dynamic value}) {
    setState(() => _isLoading = true);

    setState(() {
      // Verifica que el valor de la columna de ordenamiento no sea nulo o inválido
      if (value == null ||
          !_sourceFiltered.every((element) => element.containsKey(value))) {
        print('Error: El valor de ordenamiento es nulo o inválido.');
        _isLoading = false; // Detén la carga si hay un error
        return; // Sal del método si hay un error
      }

      _sortColumn = value;
      _sortAscending = !_sortAscending;

      // Realiza la comparación solo si los elementos son válidos
      if (_sortAscending) {
        _sourceFiltered.sort((a, b) {
          // Verifica si el valor es válido y no es nulo
          if (a[_sortColumn] == null || b[_sortColumn] == null) {
            return 0; // Considera iguales si uno de los elementos es nulo
          }
          return a[_sortColumn].compareTo(b[_sortColumn]);
        });
      } else {
        _sourceFiltered.sort((a, b) {
          if (a[_sortColumn] == null || b[_sortColumn] == null) {
            return 0; // Considera iguales si uno de los elementos es nulo
          }
          return b[_sortColumn].compareTo(a[_sortColumn]);
        });
      }

      var rangeTop = _currentPerPage! < _sourceFiltered.length
          ? _currentPerPage!
          : _sourceFiltered.length;
      _source = _sourceFiltered.getRange(0, rangeTop).toList();

      _isLoading = false;
    });
  }

// Carga los datos específicos para la tabla usando la función 'generateData'
  List<Map<String, dynamic>> cargarData() {
    // return generateData(widget.listProductos);
    return widget.generateData(widget.listProductos);
  }

    //FORMULARIO
  // TProductosAppModel? dataDrop;
  dynamic? dataDrop;
  bool isFomView = false;


  @override
  void initState() {
    super.initState();
    // Configura los encabezados para la tabla de datos. Aquí se mapean las entradas de 'headerData'
    // a una lista de encabezados personalizados usando la función 'dataHeaderCustom'.
    // También se añade un encabezado opcional para la barra de progreso.
    _headers = [
        dtaHeadercarImage(),//GENERAL siempre y cuando imagen sea [imagen] =======> 
      // ...headerData.map(
      //       (entry) => dataHeaderCustom(
      //         header: entry['header'],
      //         value: entry['value'],
      //         icon: entry['icon'], // Pasar el icono también como parámetro
      //       ),
      //     ),
       ...widget.headerData.map( ///====>
            (entry) => dataHeaderCustom(
              header: entry['header'],
              value: entry['value'],
              icon: entry['icon'], // Pasar el icono también como parámetro
            ),
          ),
      //! Barra de progreso opcional

      // dtaHeaderListProgress(), //TODOS progreso, ESPECIFICO.  
      // widget.dtaHeaderListProgress(), //TODOS progreso, ESPECIFICO.   =======> 

      // Barra de progreso opcional: se agrega solo si 'dtaHeaderListProgress' no es null
      if (widget.dtaHeaderListProgress != null) widget.dtaHeaderListProgress!(),
      if (widget.dtaHeaderListProgress2 != null) widget.dtaHeaderListProgress2!(),
      dtaHeadercarActions( // =======> 
        context: context,
        onPressedEdit: (value) => setState(() => dataDrop = value),
        // onPressedDelete: (value) => ActionButtonTable().isDeleteForm(
        //     data: value,
        //     context: context,
        //     initializeData: () => _initializeData()),
         onPressedDelete: (value) => widget.isDeleteForm(
             context,
             value,
             _initializeData),
      ), //Actions
    ];
    // Inicializa los datos de la tabla llamando al método '_initializeData'.
    _initializeData();
  }



  @override
  Widget build(BuildContext context) {

    return Container(
      child: AssetTextSelectionRegion(
        child: GestureDetector(
          onTap: () {
            isVisibleForm();
          },
          child: LayoutBuilder(builder: (context, constraints) {
            return SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: ResponsiveDatatable(
                      //********************  GENRICOS ****************
                      headerDecoration: AssetDecorationBox().headerDecoration(),
                      rowDecoration: AssetDecorationBox().rowDecoration(),
                      selectedDecoration: AssetDecorationBox().selectedDecoration(),
                      headers: _headers,
                      source: _source,
                      selecteds: _selecteds,
                      showSelect: _showSelect,
                      autoHeight: false,
                      expanded: _expanded,
                      sortAscending: _sortAscending,
                      sortColumn: _sortColumn,
                      isLoading: _isLoading,
                      reponseScreenSizes: [],// ScreenSize.xs, ScreenSize.sm
                      onSort: (value) => onSort(value: value),
                      //NOP SE MODIFICA
                      onSelect: (value, item) {
                        print("estado: $value  data: $item ");
                        if (value!) {
                          setState(() => _selecteds.add(item));
                        } else {
                          setState(() =>
                              _selecteds.removeAt(_selecteds.indexOf(item)));
                        }
                      },
                      onSelectAll: (value) {
                        if (value!) {
                          setState(() => _selecteds =
                              _source.map((entry) => entry).toList().cast());
                        } else {
                          setState(() => _selecteds.clear());
                        }
                      },
                      //********************  ESPECIFICOS  ****************
      
                      title: TextButton(
                        onPressed: () {
                          setState(() {
                            isFomView = !isFomView;
                            print(isFomView);
                          });
                        },
                        child: Container(
                          decoration: AssetDecorationBox().selectedDecoration(color: Colors.white),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppSvg().createFilledSvg,
                              H3Text(text: 'Nuevo')
                            ],
                          ),
                        ),
                      ),
                      actions: actionsSearch(),
                      dropContainer: (data) {
                        // return dropDowButonbar(data, context);//todos 
                        return widget.dropContainer(data);
                      },
      
                      footers: [
                        // fotterButonBar(//todos 
                        //   listaProductos: widget.listProductos,
                        //   selecteds: _selecteds,
                        //   sourceOriginal: _sourceOriginal,
                        // ),
                       widget.fotterButonBar(widget.listProductos, _selecteds, _sourceOriginal),
                       Expanded(child: SizedBox()),
                       PaginationControls(
                                currentPage: _currentPage,
                                totalItems: _total,
                                itemsPerPage: _currentPerPage!,
                                itemsPerPageOptions: _perPages,
                                onPageChanged: (page) {
                                  setState(() {
                                    _currentPage = page;
                                    _resetData(start: (page - 1) * _currentPerPage!);
                                  });
                                },
                                onItemsPerPageChanged: (items) {
                                  setState(() {
                                    _currentPerPage = items;
                                    _currentPage = 1;
                                    _resetData();
                                  });
                                },
                              ),
                      ],
                    ),
                  ),
                  // ActionButtonTable().fomrView(
                  //   height: constraints.maxHeight * .9,
                  //   isFomView: isFomView,
                  //   dataDrops: dataDrop,
                  //   context: context,
                  //   initializeData: () => _initializeData(),
                  //   isVisibleForm: () => isVisibleForm(),
                  // )
                  
                   widget.fomrView( 
                     context,
                     constraints.maxHeight * .99,
                     isFomView,
                     dataDrop,
                     _initializeData,
                    isVisibleForm,
                  ), 
                 
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

//todos ********************** GENERICO *****************  */
  List<Widget> actionsSearch() {
    return [
      if (_isSearch)
     LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth > 200 ? 400 : 200;
            return Container(
                decoration: AssetDecorationBox().decorationBox(),
                constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: 45),
                child: TextField(
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, height: 1.5),
                  decoration: AssetDecorationTextField.decorationTextFieldRectangle(
                    hintText: 'Escriba aquí para buscar',
                    labelText: 'Buscar',
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          setState(() {
                            _isSearch = false;
                          });
                          _initializeData();
                        }),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    _filterData(value);
                  },
                  // onSubmitted: (value) {
                  //   _filterData(value);
                  // },
                ));
          }
        ),
      if (!_isSearch)
        AppIconButon(
            tooltip: 'Buscar',
            child: const Icon(
              Icons.search_outlined,
              color: Colors.blue,
            ),
            onPressed: () {
              setState(() {
                _isSearch = true;
              });
            }),
    ];
  }

  //ESPECIFICO : cerrar formulario
  void isVisibleForm() async {
    if (dataDrop != null || isFomView) {
      // Espera la respuesta del diálogo
      bool? isClose = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              TextToSpeechService().speak(
                          '¿Seguro que quieres cerrar el formulario?');
              return AssetAlertDialogPlatform(
                message: '¿Seguro que quieres cerrar el panel?',
                title: 'Cerrar Sin Guardar',
                oK_textbuton: 'Cerrar',
                actionButon:  CupertinoDialogAction(
                child: Text('Continuar'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              );
            },
          ) ??
          true;

      // Verifica la respuesta y actualiza el estado si es necesario
      if (!isClose) {
        setState(() {
          dataDrop = null;
          isFomView = false;
          context.read<FilesProvider>().clearAllFiles();
        });
      }
    }
  }
}
