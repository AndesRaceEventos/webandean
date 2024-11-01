import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:webandean/provider/cache/json_loading/provider_json.dart';
import 'package:webandean/provider/producto/provider_producto.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/files/assets-svg.dart';
import 'package:webandean/utils/formulario/formfield_customs.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class BuildGEtPoketbase extends StatefulWidget {
  const BuildGEtPoketbase({super.key});

  @override
  State<BuildGEtPoketbase> createState() => _BuildGEtPoketbaseState();
}

class _BuildGEtPoketbaseState extends State<BuildGEtPoketbase> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetFiterWidget(),
        GetExpandSortWidget(),
      ],
    );
  }
}


class GetExpandSortWidget extends StatefulWidget {
  const GetExpandSortWidget({super.key});

  @override
  State<GetExpandSortWidget> createState() => _GetExpandSortWidgetState();
}

class _GetExpandSortWidgetState extends State<GetExpandSortWidget> {

  final TextEditingController _expandController = TextEditingController();
  final TextEditingController _sortController = TextEditingController();
  @override
  Widget build(BuildContext context) {
     final dataProvider = Provider.of<TProductosAppProvider>(context);
     final Map<String, dynamic> pocketbaseData = dataProvider.getPoketbase();
    return Column(
      children: [
         ...List.generate(pocketbaseData.keys.length, (index) {
          String key = pocketbaseData.keys.elementAt(index);//titulo Filter, expand, sort
          final options = pocketbaseData[key];//Lista de opciones de cada lista
           
          if(key != 'filter'){
           
          return ExpansionTile(
            minTileHeight: 0, 
            visualDensity: VisualDensity.compact, 
            tilePadding: EdgeInsets.symmetric(horizontal: 10),
            dense: true,
            leading: AppSvg(color: Colors.blue, width: 20).fileSvg, // Icono para cada categoría
            title: P2Text(text:  key), 
            subtitle:  H3Text(text: key =='expand' ? _expandController.text : _sortController.text),
            children: [
              if (options is List<String>)
                MultiSelectChipDisplay<String>(
                  items: options.map((option) => MultiSelectItem(option, option)).toList(),
                  scroll: true,
                  height: 40,
                   textStyle: TextStyle(
                  color: Colors.white, // Color del texto
                  fontSize: 13, // Tamaño del texto
                ),
                colorator: (value) {
                     if (key == 'expand') {
                      return _expandController.text == value ? Colors.green.shade500 : Colors.grey;
                    } else if (key == 'sort') {
                      return _sortController.text == value ? Colors.green.shade500 : Colors.grey;
                    }
                    return Colors.grey; // Valor por defecto
                  },
                onTap: (selected) async {
                  setState(() {
                           if (key == 'expand') {
                            _expandController.text = selected;
                          } else if (key == 'sort') {
                            _sortController.text = selected;
                          }
                        
                        });
                }),
              
            ],
          );}
          return SizedBox();
                  }),
      ],
    );
  }
}


class GetFiterWidget extends StatefulWidget {
  const GetFiterWidget({super.key});

  @override
  State<GetFiterWidget> createState() => _GetFiterWidgetState();
}

class _GetFiterWidgetState extends State<GetFiterWidget> {
    final TextEditingController _filterController = TextEditingController();
  String? getFilter;

  // void _toggleDropdown(String key) {
  //   _closeAllDropdowns();
  //   setState(() {
  //     // Cerrar todos los dropdowns primero
  //     showDropdowns.forEach((k, v) {
  //       showDropdowns[k] = false;
  //     });
  //     // Luego abrir el dropdown seleccionado
  //     showDropdowns[key] = true;
  //   });
  // }

  // void _closeAllDropdowns() {
  //   setState(() {
  //     showDropdowns.updateAll((key, value) => false);
  //   });
  // }
  @override
  Widget build(BuildContext context) {
      final dataProvider = Provider.of<TProductosAppProvider>(context);
    final jsonData = Provider.of<JsonLoadProvider>(context, listen: false);
    final Map<String, dynamic> pocketbaseData = dataProvider.getPoketbase();
    
    return Column(
      children: [
        H3Text(text: _filterController.text ),
        ...List.generate(pocketbaseData.keys.length, (index) {
          String key = pocketbaseData.keys.elementAt(index);//titulo Filter, expand, sort
          final options = pocketbaseData[key];//Lista de opciones de cada lista
           
          if(key == 'filter'){
        
       return  ExpansionTile( visualDensity: VisualDensity.compact, 
                tilePadding: EdgeInsets.symmetric(horizontal: 10),
                dense: true,
                leading: AppSvg(color: Colors.blue, width: 20).fileSvg, // Icono para cada categoría
                title: P2Text(text:  key), 
                children: [
                  if (options is List<String>)
                    ScrollWeb(
                      child: MultiSelectChipDisplay<String>(
                        items: options.map((option) => MultiSelectItem(option, option)).toList(),
                        scroll: true,
                        height: 40,
                         textStyle: TextStyle(
                        color: Colors.white, // Color del texto
                        fontSize: 12, // Tamaño del texto
                      ),
                      colorator: (value) {
                          return _filterController.text.split('=')[0].trim() == value ? Colors.green.shade500 : AppColors.menuTheme;
                        },
                      onTap: (selected) async {
                         _filterController.clear(); // Limpia las selecciones anteriores
                         dataProvider.toggleDropdown(selected);
                          await jsonData.loadJsonData(
                                  key: '${dataProvider.collectionName}', subKey: '$selected');
                                   _filterController.text = selected;
                      }),
                    ),
                 
                    ...options.map((option) {
                      if (dataProvider.showDropdowns[option] == true) {
                        return FormWidgets(context).singleSelectDropdownPoketbase(
                          key: dataProvider.collectionName, 
                          subKey: option, 
                          controller: _filterController, 
                          showDropdowns: dataProvider.showDropdowns,
                          toggleDropdown: (subKey) {
                            getFilter = _filterController.text;
                            _filterController.text = '$subKey=$getFilter'; // Ejemplo: 'categoria_compras=VIVERES'
                            dataProvider.toggleDropdown(subKey); // Cierra el dropdown al seleccionar
                          }
                        );
                      }
                      return Container(); // Devuelve un contenedor vacío si no se debe mostrar el dropdown
                    }).toList(),
                ],
                );
          }
          return Container();
          }),
      ],
    );
  }
}



// // Función de ejemplo para obtener datos de Pocketbase
// Map<String, dynamic> getPoketbase() {
//   return {
//     "filter": filters,
//     "sort": ['-updated','nombre']..addAll(showDropdowns.keys.toList()),
//     "expand": ['id_menu'],
//   };
// }

// // Métodos auxiliares para ejemplo
// List<String> filters = showDropdowns.keys.toList();


//   // Mapa para manejar la visibilidad de los dropdowns
//   Map<String, bool> showDropdowns = {
//     'categoria_compras': false,
//     'categoria_inventario': false,
//     'ubicacion': false,
//     'moneda': false,
//     'PROVEEDOR': false,
//     'tipo': false,
//     'rotacion': false,
//     'estado': false,
//     'demanda': false,
//     'condicion_almacenamiento': false,
//     'formato': false,
//     'tipo_precio': false,
//     'durabilidad': false,
//     'proveeduria': false,
//     'presentacion_visual': false,
//     'embase_ambiental': false,
//     'responsabilidad_ambiental': false,
//     'active':false
//   };