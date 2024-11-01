
//GEENRICO

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webandean/utils/colors/assets_colors.dart';

import 'package:webandean/utils/files/assets-svg.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/button/asset_buton_widget.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';

import 'package:webandean/provider/cache/json_loading/provider_json.dart';
import 'package:webandean/provider/cache/menuWeb/menu_state.dart';

class ClasificarButton extends StatelessWidget {
  final Function(String) onSelected;

  ClasificarButton({required this.onSelected, required this.keyJson, required this.subkeyJson});

  final String keyJson;
  final String subkeyJson;

  @override
  Widget build(BuildContext context) {
    final jsonData = Provider.of<JsonLoadProvider>(context);

    return AppIconButon(
      tooltip: "Clasifica los datos presionando aquí.",
      child: AppSvg().categorySvg,
      onPressed: () async {
        TextToSpeechService().speak('Por favor, elige una opción.');
        
        // Cargar los datos desde el JSON
        // await jsonData.loadJsonData(key: 'almacen_productos', subKey: 'groupby');// NO es totalemnte Genrico por esto de aqui.
         await jsonData.loadJsonData(key: '$keyJson', subKey: '$subkeyJson');
        // Mostrar el diálogo después de cargar los datos
        _showClasificarDialog(context, jsonData);
      },
    );
  }

  void _showClasificarDialog(BuildContext context, JsonLoadProvider jsonData) {
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    final decoration = AssetDecorationBox().selectedDecoration(color: AppColors.menuTheme);
    AssetAlertDialogPlatform.show(
      context: context,
      title: 'Organización de Datos',
      message: 'Elige el tipo de clasificación que deseas utilizar.',
      child: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * .6,
        child: Column(
          children: [
           
            Material(
              color: Colors.transparent,
              child: ListTile(
                visualDensity: VisualDensity.compact,
                minVerticalPadding: 0,
                contentPadding: EdgeInsets.all(0),
                leading: Container(decoration: decoration, child: menuProvider.selectedSvg),
                trailing: AppSvg(width: 10).lengthSvg,
                title: H1Text(text: "MOSTRAR TODOS", fontSize: 11),
                onTap: () {
                  onSelected("Todos");
                  jsonData.seleccionarOption("Todos");
                  menuProvider.setSelectTitleGroupBy('Todos');
                  Navigator.pop(context);
                },
              ),
            ),
           
             Container(
              width: double.infinity,
              height: 50,
              child: AppSvg(width: 40, color: Colors.black38).categorySvg,
            ),
             Container(
              width: double.infinity,
              decoration: AssetDecorationBox().headerDecoration(color: Colors.transparent),
            ),
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: Consumer<JsonLoadProvider>(
                  builder: (context, jsonData, child) {
                    if (jsonData.isLoading) {
                      return Center(child: CircularProgressIndicator()); // Indicador de carga
                    }

                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 100),
                      itemCount: jsonData.options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final option = jsonData.options[index];

                        return ListTile(
                          visualDensity: VisualDensity.compact,
                          minVerticalPadding: 0,
                          contentPadding: EdgeInsets.all(0),
                          leading: Container(decoration: decoration, child: menuProvider.selectedSvg),
                          trailing: AppSvg(width: 10).menusvg,
                          title: H3Text(text: option, fontSize: 11),
                          onTap: () {
                            onSelected(option);
                            jsonData.seleccionarOption(option);
                            // Usa context.read() para obtener el provider sin un listener
                             context.read<MenuProvider>().setSelectTitleGroupBy(option);
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
