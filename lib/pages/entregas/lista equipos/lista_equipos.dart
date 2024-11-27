import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:webandean/utils/poketbase/get_filterpoketbase.dart';
import 'package:webandean/utils/button/asset_buton_widget.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/responsiveTable/search_transition/search_view_global.dart';
import 'package:webandean/utils/responsiveTable/title_table/title_tabbar.dart';
import 'package:webandean/utils/responsiveTable/title_table/title_table.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/animations/assets_animationswith.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/layuot/assets_circularprogrees.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:webandean/utils/textfield/decoration_form.dart';

import 'package:webandean/utils/gridV%20chart/p_gridview_chert.dart';
import 'package:webandean/utils/responsiveTable/responsive_table.dart';
import 'package:webandean/utils/responsiveTable/clasificar_datos/clasificacion_datos.dart';


import 'package:webandean/pages/entregas/lista%20equipos/dropdown_row/dropdown_row.dart';
import 'package:webandean/pages/entregas/lista%20equipos/footer_table/footer_table.dart';
import 'package:webandean/pages/entregas/lista%20equipos/generate_data/generate_data.dart';
import 'package:webandean/pages/entregas/lista%20equipos/table_actions/actions_button_table.dart';
import 'package:webandean/pages/entregas/lista%20equipos/table_header/header_progress.dart';


import 'package:webandean/model/entregas/model_lista_equipos.dart';
import 'package:webandean/provider/entregas/provider_lista_equipo.dart';

class PageListaEquipos extends StatelessWidget {
  const PageListaEquipos({super.key});

  @override
  Widget build(BuildContext context) {
    final dataParticipantes = Provider.of<TListaEquipoAppProvider>(context);

    return dataParticipantes
            .isRefresh //Propedad de un metodo de recarga de datos: TProductosAppProvider
        ? Center(child: CircularProgressIndicator(color: Colors.black45))
        : _PageResponsiveProductos();
  }
}

class _PageResponsiveProductos extends StatefulWidget {
  const _PageResponsiveProductos();
  @override
  State<_PageResponsiveProductos> createState() =>
      _PageResponsiveProductosState();
}

class _PageResponsiveProductosState extends State<_PageResponsiveProductos> {
  
   int selectedIndex = 0; // Para saber cuál pestaña está activa TAbbaView 

  String? _selectedProduct;

  late TextEditingController _filterseachController;

  bool isSearch = false;
  bool istransition = false;

  @override
  void initState() {
    super.initState();
    _filterseachController = TextEditingController();
     // Limpiar la búsqueda para evitar que los datos filtrados persistan innecesariamente
      WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<TListaEquipoAppProvider>(context, listen : false).clearSearch([]);
    });
  }

  @override
  void dispose() {
    _filterseachController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<TListaEquipoAppProvider>(context);
    String searchText = dataProvider.searchText;

    final listProductos = dataProvider.listProductos; //Lista Productos Geenral

    final filterData = dataProvider.filteredData; //Lista Productos filtrados
    //LISTA GRUPOS ALMACÉ
    final searchProvider = (filterData.isEmpty && searchText.isEmpty) ? listProductos : filterData;

    final groupedData = dataProvider.groupByDistance( listData: searchProvider, fieldName: _selectedProduct ?? 'Todos');

     // Validar y ajustar el índice seleccionado
    if (selectedIndex >= groupedData.keys.length) {
      selectedIndex = 0; // Restablece al primer índice disponible
    }
     
    return  groupedData.keys.isEmpty
        ? Erro404Page(
            onPressed: () => isSeachVisible(dataProvider, listProductos),
        )

        :  DefaultTabController(
      length: groupedData.keys.length,
       initialIndex: selectedIndex,
      child: Scaffold(
         //Trasnparente para la imgen de fondo
          backgroundColor:Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(85),
            child: AppBar(
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              // centerTitle: true,
              title: SearchIstransitionItem2(
                controller: _filterseachController,
                isSearch: isSearch ,
                onCloseSeach: () => isSeachVisible(dataProvider, listProductos),
                onSearch:  (value) => dataProvider.setSearchText(value, dataProvider.listProductos),
                child: TitleTableSlected(
                  selectedProduct: _selectedProduct,
                  listProductos: listProductos, 
                  istransition: istransition,//is tabla o image 
                   onTap: () => isSeachVisible(dataProvider, listProductos),),
                ),
              actions: [
                ClasificarButton(
                  keyJson: '${dataProvider.collectionName}', //ESPECIFICAR
                  subkeyJson: 'groupby', //ESPECIFICAR
                  onSelected: (selectedOption) {
                    setState(() {
                      _selectedProduct = selectedOption;
                      dataProvider.groupByDistance(listData: listProductos,fieldName: _selectedProduct!);
                      isRefreshDataSearh(dataProvider, listProductos);
                    });
                  },
                ),
                
                AppIconButon(
                  tooltip:'${!istransition ? "imágenes" : "tabla"}.',
                  child: istransition ? AppSvg().gallerySvg : AppSvg().tableSvg,
                  onPressed: () {
                    TextToSpeechService().speak('Modo ${!istransition ? "imágenes" : "tabla"}.');
                    setState(() => istransition = !istransition);
                   isRefreshDataSearh(dataProvider, listProductos);
                  },
                ),
                AppIconButon(
                    onLongPress: () {
                      AssetAlertDialogPlatform.show(context: context,
                      child: Material(
                        color: Colors.transparent,
                        child: AssetGetFilterPoketbase(),
                      ),
                      isCupertino: false,
                      title: 'Configuración Avanzada',
                      message: 'Aplica los filtros nesesarios para cargar los datos que necesitas.',
                      );
                    },
                    tooltip: 'Actualizar contenido',
                    onPressed: dataProvider.isRefresh
                        ? null
                        : () async => await dataProvider.refreshProvider(),
                    child: dataProvider.isRefresh
                        ? AssetsCircularProgreesIndicator()
                        : AppSvg().refreshSvg),
              ],
              bottom: TabBarCustom(
                onTap: (index) {
                  setState(() {
                    selectedIndex = index; // Actualiza el índice seleccionado
                  });
                },
                  tabs: groupedData.keys.map((String tabTitle) {
                    print(tabTitle);
                    return Tab(
                      iconMargin: EdgeInsets.all(0),
                      height: 32,
                      icon: ChipTabar(title: tabTitle, count: groupedData[tabTitle]?.length ?? 0));
                  }).toList()),
            ),
          ),
          body: Column(
            children: [
              
              
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: groupedData.keys.map((String distancias) {
                     int index = groupedData.keys.toList().indexOf(distancias);
                     
                    if(selectedIndex != index) return Container();

                    return Offstage(
                       offstage: selectedIndex != index, // Solo muestra 
                      child: AssetsAnimationSwitcher(
                        duration: 600,
                        child: istransition
                            ? MyGridView(
                                groupedData: groupedData, 
                                distancias: distancias,
                                childrenBuilder: (value, constraints) {
                                 // Casteamos el dynamic a TProductosAppModel
                                 final TListaEntregaEquiposModel e = value as TListaEntregaEquiposModel;
                                  return  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        H2Text(
                                          text: e.qr,
                                          fontSize: 11,
                                          selectable: true,
                                        ),
                                        H2Text(
                                          text: e.nombre,
                                          fontSize: 11,
                                          selectable: true,
                                        ),
                                      ],
                                    );
                                },
                              )
                            : Builder(
                              builder: (context) {
                                return  ScrollWeb(
                                    child:  ResponsiveTableCustom(
                                      listProductos: groupedData[distancias]!,//Lista Datos
                                      generateData: (widgetListProductos ) => generateData(widgetListProductos),
                                      headerData: headerData, 
                                      dtaHeaderListProgress: () => headerProgress(), //TODOS progreso, ESPECIFICO.
                                      dtaHeaderListProgress2: () => headerProgress2(),
                                      dropContainer: (data) => dropDowButonbar(data, context), // La función que genera el dropdown
                                      fotterButonBar: (widgetListProductos, _selecteds, _sourceOriginal) {
                                        return fotterButonBar(
                                          listaProductos: widgetListProductos,
                                          selecteds: _selecteds,
                                          sourceOriginal: _sourceOriginal,
                                        );
                                      }, 
                                      applyFilter: (_sourceOriginal , value ) => DataUtils(_sourceOriginal).applyFilter(value), 
                                      fomrView: (context , height , isFomView ,dataDrop , dynamic _initializeData() , dynamic isVisibleForm() ) {
                                       return ActionButtonTable().fomrView(
                                              context: context,
                                              height: height,
                                              isFomView: isFomView,
                                              dataDrops: dataDrop,
                                              initializeData: () => _initializeData(),
                                              isVisibleForm: () => isVisibleForm(),
                                            );
                                        }, 
                                      isDeleteForm: (context ,data , dynamic _initializeData() ) { 
                                        return  ActionButtonTable().isDeleteForm(
                                                context: context,
                                                data: data,
                                                initializeData: () => _initializeData());
                                       }, 
                                    ),
                                  );
                              }
                            ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          )),
    );
  }

  void isSeachVisible(TListaEquipoAppProvider dataProvider,List<TListaEntregaEquiposModel> listProductos ){
      setState(() => isSearch = !isSearch);
      if (!isSearch) {
          _filterseachController.clear();
          dataProvider.clearSearch(listProductos);
        }
     }
  
  void isRefreshDataSearh(TListaEquipoAppProvider dataProvider,List<TListaEntregaEquiposModel> listProductos) {
    isSearch = false;//cambiar ya que sino se cambia afectara y se muestra el buscador en modod tabla
    _filterseachController.clear();
     dataProvider.clearSearch(listProductos);
  }
}


class AssetGetFilterPoketbase extends StatelessWidget {
  const AssetGetFilterPoketbase({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<TListaEquipoAppProvider>(context);
    final filter = dataProvider.filter;
    final expand = dataProvider.expand;
    final sort = dataProvider.sort;
    final bool aplyFiter = (filter != null || expand != null || sort != null);
    return Column(
      children: [
        // H2Text(text: 'Avanzado'),
        Wrap(
          children: [
            if (aplyFiter)
              AppIconButon(
              onPressed: () async {
                dataProvider.setOptionsPoketbase();
              },
              child: Icon(Icons.refresh, size: 20)),
            chipCustom(filter),
            chipCustom(sort),
            chipCustom(expand),
          ],
        ),
        
        
        GetFiterWidget(
          dataProvider: dataProvider,
        ),
        GetExpandSortWidget(dataProvider: dataProvider),
      ],
    );
  }
}