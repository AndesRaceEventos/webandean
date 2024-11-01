
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webandean/model/producto/model_producto.dart';
import 'package:webandean/pages/t_productos/editing_forma_p.dart';
import 'package:webandean/provider/producto/provider_producto.dart';
import 'package:webandean/utils/animations/assets_animationswith.dart';
import 'package:webandean/utils/button/asset_buton_widget.dart';
import 'package:webandean/utils/dialogs/assets_dialog.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/speack/assets_speack.dart';


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
    TProductosAppModel? dataDrop = dataDrops;
    return Positioned(
      right: 0,
      child: AssetsAnimationSwitcher(
        isTransition: true,
        duration: 500,
        child: (dataDrop != null || isFomView)
            ? Container(
                decoration: AssetDecorationBox().decorationBox(color: Colors.grey.shade100),
                padding: EdgeInsets.all(10),
                constraints: BoxConstraints(maxWidth: 400),
                height: height,
                child: Stack(
                  children: [
                    EditPageProductosApp(
                        e: dataDrop ?? null,
                        onSave: () async {
                          //PUEDES PASAE FDUNCUONES AQUI: EDITAR , CREAR NUEVO REGISTRO
                          initializeData();
                          dataDrop = null;
                          await context
                              .read<TProductosAppProvider>()
                              .refreshProvider();
                        }),
                    AppIconButon(
                        onPressed: () {
                          isVisibleForm();
                        },
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
    required TProductosAppModel data, 
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
          .read<TProductosAppProvider>()
          .deleteTProductosApp(id: id, context: context);
      await context.read<TProductosAppProvider>().refreshProvider();

      initializeData();
    }
  }

  

}