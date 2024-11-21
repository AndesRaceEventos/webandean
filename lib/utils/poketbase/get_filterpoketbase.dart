import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';

import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/formulario/formfield_customs.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

import 'package:webandean/provider/cache/json_loading/provider_json.dart';


Widget chipCustom(String? field) {
  bool isField = (field == null || field == '');
  return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Chip(
            labelPadding: EdgeInsets.all(0),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            visualDensity: VisualDensity.compact,
            // labelStyle: TextStyle(fontSize: 12),
            backgroundColor: !isField ? Colors.white : Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: Colors.grey.shade400),
            ),
            label: P3Text(text: '${field}', color: Colors.black,fontWeight: FontWeight.bold,)),
      );
}

class GetExpandSortWidget extends StatefulWidget {
  const GetExpandSortWidget({super.key, required this.dataProvider});

  final dynamic dataProvider;
  @override
  State<GetExpandSortWidget> createState() => _GetExpandSortWidgetState();
}

class _GetExpandSortWidgetState extends State<GetExpandSortWidget> {
  final TextEditingController _expandController = TextEditingController();
  final TextEditingController _sortController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //  final dataProvider = Provider.of<TProductosAppProvider>(context);
    final dataProvider = widget.dataProvider;
    final Map<String, dynamic> pocketbaseData = dataProvider.getPoketbase();
    return Column(
      children: [
        ...List.generate(pocketbaseData.keys.length, (index) {
          String key = pocketbaseData.keys
              .elementAt(index); //titulo Filter, expand, sort
          final options = pocketbaseData[key]; //Lista de opciones de cada lista

          if (key != 'filter') {
            return ExpansionTile(
              minTileHeight: 0,
              visualDensity: VisualDensity.compact,
              tilePadding: EdgeInsets.symmetric(horizontal: 10),
              dense: true,
              leading: AppSvg(color: Colors.blue, width: 20)
                  .fileSvg, // Icono para cada categoría
              title: P2Text(text: key, color: Colors.blue.shade400,),
              children: [
                if (options is List<String>)
                  MultiSelectChipDisplay<String>(
                      items: options
                          .map((option) => MultiSelectItem(option, option))
                          .toList(),
                      scroll: true,
                      height: 40,
                      textStyle: TextStyle(
                        color: Colors.white, // Color del texto
                        fontSize: 13, // Tamaño del texto
                      ),
                      colorator: (value) {
                        if (key == 'expand') {
                          return _expandController.text == value
                              ? Colors.green.shade500
                              :AppColors.menuTheme;
                        } else if (key == 'sort') {
                          return _sortController.text == value
                              ? Colors.green.shade500
                              : AppColors.menuTheme;
                        }
                        return Colors.grey; // Valor por defecto
                      },
                      onTap: (selected) async {
                        setState(() {
                          if (key == 'expand') {
                            _expandController.text = selected;
                            dataProvider.setExpand(
                                newExpand: _expandController.text);
                          } else if (key == 'sort') {
                            _sortController.text = selected;
                            dataProvider.setSort(newSort: _sortController.text);
                          }
                        });
                      }),
                H3Text(
                    text: key == 'expand'
                        ? _expandController.text
                        : _sortController.text),
                _buildSelectionRow(
                  controller:
                      key == 'expand' ? _expandController : _sortController,
                  clearAction: () {
                    if (key == 'expand') {
                      dataProvider.setExpand(newExpand: '');
                    } else {
                      dataProvider.setSort(newSort: '');
                    }
                  },
                ),
              ],
            );
          }
          return SizedBox();
        }),
      ],
    );
  }

  Widget _buildSelectionRow({
    required TextEditingController controller,
    required VoidCallback clearAction,
  }) {
    return Row(
      children: [
        if (controller.text.isNotEmpty)
          IconButton(
            onPressed: () {
              setState(() {
                controller.clear();
                clearAction();
              });
            },
            icon: Icon(
              Icons.close,
              size: 16,
              color: Colors.grey,
            ),
          ),
        Container(
          decoration: AssetDecorationBox().decorationBox(color: Colors.white),
          child: P3Text(
            text: '  ${controller.text}  ',
            height: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class GetFiterWidget extends StatefulWidget {
  const GetFiterWidget({super.key, required this.dataProvider});
  final dynamic dataProvider;

  @override
  State<GetFiterWidget> createState() => _GetFiterWidgetState();
}

class _GetFiterWidgetState extends State<GetFiterWidget> {
  final TextEditingController _filterController = TextEditingController();
  String? getFilter;
  @override
  Widget build(BuildContext context) {
    // final dataProvider = Provider.of<TProductosAppProvider>(context);
    final dataProvider = widget.dataProvider;
    final jsonData = Provider.of<JsonLoadProvider>(context, listen: false);
    final Map<String, dynamic> pocketbaseData = dataProvider.getPoketbase();

    return Column(
      children: [
        ...List.generate(pocketbaseData.keys.length, (index) {
          String key = pocketbaseData.keys
              .elementAt(index); //titulo Filter, expand, sort
          final options = pocketbaseData[key]; //Lista de opciones de cada lista

          if (key == 'filter') {
            return ExpansionTile(
              visualDensity: VisualDensity.compact,
              tilePadding: EdgeInsets.symmetric(horizontal: 10),
              dense: true,
              leading: AppSvg(color: Colors.blue, width: 20)
                  .fileSvg, // Icono para cada categoría
              title: P2Text(text: key, color: Colors.blue.shade400,),
              children: [
                if (options is List<String>)
                  ScrollWeb(
                    child: MultiSelectChipDisplay<String>(
                        items: options
                            .map((option) => MultiSelectItem(option, option))
                            .toList(),
                        scroll: true,
                        height: 40,
                        textStyle: TextStyle(
                          color: Colors.white, // Color del texto
                          fontSize: 12, // Tamaño del texto
                        ),
                        colorator: (value) {
                          return _filterController.text.split('=')[0].trim() ==
                                  value
                              ? Colors.green.shade500
                              : AppColors.menuTheme;
                        },
                        onTap: (selected) async {
                          _filterController
                              .clear(); // Limpia las selecciones anteriores
                          dataProvider.toggleDropdown(selected);
                          await jsonData.loadJsonData(
                              key: '${dataProvider.collectionName}',
                              subKey: '$selected');
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
                         if (subKey != 'active') {
                            _filterController.text =
                              '$subKey="$getFilter"'; // Ejemplo: 'categoria_compras="VIVERES"'
                         }
                          else{
                            _filterController.text =
                              '$subKey=$getFilter'; // Ejemplo: 'active=true'
                          }
                          dataProvider.setFilter(
                              newFilter: _filterController.text);
                          dataProvider.toggleDropdown(
                              subKey); // Cierra el dropdown al seleccionar
                        });
                  }
                  return Container(); // Devuelve un contenedor vacío si no se debe mostrar el dropdown
                }).toList(),
                _buildSelectionRow(
                  controller: _filterController,
                  clearAction: () {
                    dataProvider.setFilter(newFilter: '');
                  },
                )
              ],
            );
          }
          return Container();
        }),
      ],
    );
  }

  Widget _buildSelectionRow({
    required TextEditingController controller,
    required VoidCallback clearAction,
  }) {
    return Row(
      children: [
        if (controller.text.isNotEmpty)
          IconButton(
            onPressed: () {
              setState(() {
                controller.clear();
                clearAction();
              });
            },
            icon: Icon(
              Icons.close,
              size: 16,
              color: Colors.grey,
            ),
          ),
        Container(
          decoration: AssetDecorationBox().decorationBox(color: Colors.white),
          child: P3Text(
            text: '  ${controller.text}  ',
            height: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
