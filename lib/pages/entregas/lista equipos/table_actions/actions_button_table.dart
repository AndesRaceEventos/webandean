
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webandean/provider/entregas/provider_lista_equipo.dart';
import 'package:webandean/utils/animations/assets_animationswith.dart';
import 'package:webandean/utils/button/asset_buton_widget.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/speack/assets_speack.dart';

import 'package:webandean/model/entregas/model_lista_equipos.dart';

class ActionButtonTable {

//todos ********************** ESPECIFICOS *****************  */
  
  Widget fomrView({
    required  BuildContext context,
    double? height,
    required  bool isFomView, 
    // required  TProductosAppModel? dataDrop,
    required  dynamic? dataDrops,
    required  Function() initializeData,
    required  Function() isVisibleForm,
    }) {
    TListaEntregaEquiposModel? dataDrop = dataDrops;
    return Positioned(
      right: 0,
      child: AssetsAnimationSwitcher(
        isTransition: true,
          duration: 150,
          // switchInCurve: Curves.ease,
          // switchOutCurve: Curves.ease,
        child: (dataDrop != null || isFomView)
            ? Container(
                decoration: AssetDecorationBox().selectedDecoration(color: Colors.grey.shade100),
                padding: EdgeInsets.only(),
                constraints: BoxConstraints(maxWidth: 440),
                height: height,
                child: Stack(
                  children: [
                    // EditPageProductosApp(
                    //     e: dataDrop ?? null,
                    //     onSave: () async {
                    //       //PUEDES PASAE FDUNCUONES AQUI: EDITAR , CREAR NUEVO REGISTRO
                    //       initializeData();
                    //       dataDrop = null;
                    //       await context.read<TListaProductosAppProvider>().refreshProvider();
                    //     }),
                    AppIconButon(
                        onPressed: () => isVisibleForm(),
                        child: Icon(Icons.close))
                  ],
                ))
            : SizedBox(),
      ),
    );
    
  }

 

  

  //ESPECIFICO : cerrar formulario Map<String, dynamic>
  void isDeleteForm(
    {
    required TListaEntregaEquiposModel data, 
    required BuildContext context, 
    required  Function() initializeData,
    }
    ) async {
    // Espera la respuesta del diálogo
    bool? isdelete = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            TextToSpeechService().speak(
                          '¿Seguro que quieres Eliminar este registro?');
            return AssetAlertDialogPlatform(
              message: '¿Seguro que quieres Eliminar este registro?',
              title: 'Eliminar Registro',
              oK_textbuton: 'Eliminar',
            );
          },
        ) ??
        true;

    // Verifica la respuesta y actualiza el estado si es necesario
    if (!isdelete) {
      final id = await data.id; //data["id"];
      print(id);
      await context
          .read<TListaEquipoAppProvider>()
          .deleteTProductosApp(id: id, context: context);
      await context.read<TListaEquipoAppProvider>().refreshProvider();

      initializeData();
    }
  }

  

}