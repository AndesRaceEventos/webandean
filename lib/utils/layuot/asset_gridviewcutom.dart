import 'package:flutter/material.dart';
import 'package:webandean/utils/animations/assets_delayed_display.dart';
import 'package:webandean/utils/files/assets_imge.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/routes/assets_img_urlserver.dart';


class AssetGRidViewCustom extends StatelessWidget {
  const AssetGRidViewCustom({super.key, required this.listdata, required this.childrenBuilder});
  final List<dynamic> listdata;
  final Widget Function(dynamic value, BoxConstraints constraints) childrenBuilder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = (constraints.maxWidth / 180).floor();

              return ScrollWeb(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 6.0,
                    childAspectRatio: .8,
                  ),
                  itemCount: listdata.length,//groupedData[distancias]?.length ?? 0,
                  itemBuilder: (context, index) {
                    // final e = groupedData[distancias]![index];
                    final value =listdata[index];

                     final List<String> imagen = value.imagen is String
                            ? [value.imagen]
                            : value.imagen;
                    return AssetsDelayedDisplayYbasic(
                      duration: 800,
                      fadingDuration: 1500,
                      curve: Curves.decelerate,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Opacity(
                            opacity: .6,
                            child: value.imagen != null && value.imagen!.isNotEmpty
                                ? GLobalImageUrlServer(
                                   width: constraints.maxWidth,
                                    height: constraints.maxHeight,
                                    fadingDuration: 0,
                                    duration: 0,
                                    image: imagen.first,
                                    collectionId: value.collectionId ?? '',
                                    id: value.id,
                                    borderRadius: BorderRadius.circular(0),
                                    data: value.imagen,
                                    boxFit: BoxFit.cover,
                                  )
                                : Image.asset(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight,
                                  AppImages.placeholder300,
                                  fit: BoxFit.cover,
                                ),
                          ),
                          Container(
                            width: constraints.maxWidth,
                            decoration: AssetDecorationBox().selectedDecoration(),
                           child: childrenBuilder(value, constraints), // Llamada al builder
                            // Column(
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: 
                            //   [
                            //      H2Text(
                            //           text: value.numeroSerie,
                            //           fontSize: 11,
                            //           selectable: true,
                            //         ),
                            //      H2Text(
                            //           text: value.nombre,
                            //           fontSize: 11,
                            //           selectable: true,
                            //         ),
                            //   ],
                            // ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
  }
}