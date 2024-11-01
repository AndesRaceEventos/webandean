import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webandean/pages/t_productos/productos_text.dart';

import 'package:webandean/utils/button/asset_buton_widget.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/formulario/formfield_customs.dart';
import 'package:webandean/utils/responsiveTable/title_table/title_tabbar.dart';
import 'package:webandean/utils/responsiveTable/title_table/title_table.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/animations/assets_animationswith.dart';
import 'package:webandean/utils/files/assets-svg.dart';
import 'package:webandean/utils/layuot/assets_circularprogrees.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:webandean/utils/textfield/decoration_form.dart';

import 'package:webandean/utils/responsiveTable/responsive_table.dart';
import 'package:webandean/utils/responsiveTable/clasificar_datos/clasificacion_datos.dart';

import 'package:webandean/pages/t_productos/footer_table/footer_table.dart';
import 'package:webandean/pages/t_productos/dropdown_row/dropdown_row.dart';
import 'package:webandean/pages/t_productos/generate_data/generate_data.dart';
import 'package:webandean/pages/t_productos/table_actions/actions_button_table.dart';
import 'package:webandean/pages/t_productos/table_header/header_progress.dart';
import 'package:webandean/pages/t_productos/p_gridview_product.dart';

import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/provider/producto/provider_producto.dart';

class PageProductos extends StatelessWidget {
  const PageProductos({super.key});

  @override
  Widget build(BuildContext context) {
    final dataParticipantes = Provider.of<TProductosAppProvider>(context);

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
  


  String? _selectedProduct;

  late TextEditingController _filterseachController;

  bool isSearch = false;
  bool istransition = false;

  @override
  void initState() {
    super.initState();
    _filterseachController = TextEditingController();
  }

  @override
  void dispose() {
    _filterseachController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<TProductosAppProvider>(context);
    String searchText = dataProvider.searchText;

    final listProductos = dataProvider.listProductos; //Lista Productos Geenral

    final filterData = dataProvider.filteredData; //Lista Productos filtrados
    //LISTA GRUPOS ALMACÉ
    final searchProvider = (filterData.isEmpty && searchText.isEmpty) ? listProductos : filterData;

    final groupedData = dataProvider.groupByDistance( listData: searchProvider, fieldName: _selectedProduct ?? 'Todos');

     
    return DefaultTabController(
      length: groupedData.keys.length,
      child: Scaffold(
         //Trasnparente para la imgen de fondo
          backgroundColor:Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(85),
            child: AppBar(
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              // centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                  AssetsAnimationSwitcher(
                    isTransition: true,
                    duration: 700,
                    child: isSearch
                        ? Container(
                          constraints: BoxConstraints(maxWidth: 350, maxHeight: 45),
                          child: TextField(
                              controller: _filterseachController,
                              decoration: decorationTextField(
                                hintText: 'Escriba aquí',
                                labelText: 'Buscar',
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.search),
                                suffixIcon: IconButton(
                                  onPressed: () => isSeachVisible(dataProvider, listProductos),
                                  icon: Icon(Icons.close, size: 20))
                              ),
                              //Fitrar mientras escribes 
                              onChanged: (value) => dataProvider.setSearchText(value, dataProvider.listProductos),
                              //TODOS presionar enter para buscar
                              // onSubmitted: (value) {
                              //   dataParticipantes.setSearchText(
                              //       value, dataParticipantes.listProductos);
                              // },
                            ),
                        )
                        : TitleTableSlected(
                            selectedProduct: _selectedProduct,
                            listProductos: listProductos, 
                            istransition: istransition,//is tabla o image 
                             onTap: () => isSeachVisible(dataProvider, listProductos),),
                  ),
                ],
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
                    tooltip: 'Actualizar contenido',
                    onPressed: dataProvider.isRefresh
                        ? null
                        : () async => await dataProvider.refreshProvider(),
                    child: dataProvider.isRefresh
                        ? AssetsCircularProgreesIndicator()
                        : AppSvg().refreshSvg),
              ],
              bottom: TabBar(
                  dividerColor: Colors.transparent,
                  indicatorColor: AppColors.warningColor,
                  isScrollable: true,
                  labelPadding: EdgeInsets.only(right: 5, bottom: 3),
                  indicatorPadding: EdgeInsets.all(0),
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),
                  indicatorWeight: 1,
                  // dividerHeight: 0,
                  tabs: groupedData.keys.map((String tabTitle) {
                    print(tabTitle);
                    return Tab(
                      iconMargin: EdgeInsets.all(0),
                      height: 32,
                      icon: TextTabBarTable(
                        groupedData: groupedData,
                        tabTitle: tabTitle,
                      ),
                    );
                  }).toList()),
            ),
          ),
          body: Column(
            children: [
              BuildGEtPoketbase(),
              
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: groupedData.keys.map((String distancias) {
                    return AssetsAnimationSwitcher(
                      duration: 600,
                      child: istransition
                          ? MyGridView(
                              groupedData: groupedData, 
                              distancias: distancias,
                              childrenBuilder: (value, constraints) {
                               // Casteamos el dynamic a TProductosAppModel
                               final TProductosAppModel e = value as TProductosAppModel;
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
                    );
                  }).toList(),
                ),
              ),
            ],
          )),
    );
  }

  void isSeachVisible(TProductosAppProvider dataProvider,List<TProductosAppModel> listProductos ){
      setState(() => isSearch = !isSearch);
      if (!isSearch) {
          _filterseachController.clear();
          dataProvider.clearSearch(listProductos);
        }
     }
  
  void isRefreshDataSearh(TProductosAppProvider dataProvider,List<TProductosAppModel> listProductos) {
    isSearch = false;//cambiar ya que sino se cambia afectara y se muestra el buscador en modod tabla
    _filterseachController.clear();
     dataProvider.clearSearch(listProductos);
  }
}