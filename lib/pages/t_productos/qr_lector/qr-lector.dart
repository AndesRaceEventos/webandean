import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:webandean/utils/animations/assets_animationswith.dart';
import 'package:webandean/utils/button/asset_buton_widget.dart';

import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/files/assets_imge.dart';
import 'package:webandean/utils/html_render/html_view_render.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';


import 'package:webandean/provider/cache/qr_lector/qr_lector_provider.dart';
import 'package:webandean/pages/t_productos/qr_lector/camera_weblector.dart';
import 'package:webandean/utils/qr_generate/qr_generate.dart';
import 'package:webandean/utils/routes/assets_class_routes_pages.dart';
import 'package:webandean/utils/routes/assets_img_urlserver.dart';
import 'package:webandean/utils/text/assets_textapp.dart';


class QrLectorPage extends StatefulWidget {
  const QrLectorPage({Key? key}) : super(key: key);

  @override
  State<QrLectorPage> createState() => _QrLectorPageState();
}

class _QrLectorPageState extends State<QrLectorPage>  with TickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final qrData = Provider.of<QrLectorProvider>(context, listen: false);
    final routes = qrData.routes(context);
    _tabController = TabController(vsync: this, length: routes.length);

    // Agregar listener para cambiar datos cuando se selecciona una pestaña
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // Al cambiar de pestaña, establece los datos según el índice
        qrData.setListData(routes[_tabController.index].lisdata ?? []);
        qrData.resetScannedCode();
      }
    });

    // Asigna el valor inicial de la lista a la primera pestaña
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (qrData.dataResult.isEmpty) {
        qrData.setListData(routes.first.lisdata ?? []);
      }
    });
  }

  @override
  void dispose() {

   _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final qrData = Provider.of<QrLectorProvider>(context);
    final routes = qrData.routes(context);
    final foundData = qrData.foundData;
    return DefaultTabController(
      length: routes.length,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            // title: H3Text(text: "${foundData}"),
            backgroundColor: Colors.black54,
            toolbarHeight: 0,//25,
            leading: SizedBox(),
            bottom: TabBar(
                controller: _tabController,
                dividerColor: Colors.transparent,
                indicatorColor: AppColors.warningColor,
                isScrollable: true,
                labelPadding: EdgeInsets.only(right: 20, bottom: 0),
                indicatorPadding: EdgeInsets.all(0),
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
                indicatorWeight: 2,
                labelColor: Colors.yellow,
                unselectedLabelColor: Colors.white,
                tabs: List.generate(routes.length, (index) {
                  final tab = routes[index];
                  return Tab(
                    icon: tab.icon,
                    text: tab.title,
                  );
                })),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 800) {
                return ScrollWeb(
                  child: TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(routes.length, (index) {
                      final tab = routes[index];
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(height: 400, child: QrCameraLector()),
                            _tabContent(foundData, tab),
                          ],
                        ),
                      );
                    }),
                  ),
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    QrCameraLector(),
                    Expanded(
                      flex: 1,
                      child: TabBarView(
                        controller: _tabController,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(routes.length, (index) {
                          final tab = routes[index];
                          return Center(
                            child:  _tabContent(foundData, tab),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              }
            },
          ), 
          
          ),
    );
  }

  Container _tabContent(dynamic foundData, RoutesLocalStorage tab) {
    return Container(
           margin: EdgeInsets.symmetric(horizontal: 30),
          constraints: BoxConstraints(maxWidth: 400),
          child: AssetsAnimationSwitcher(
            duration: 500,
            child: (foundData == null) ?  Image.asset(AppImages.qrimge) : ScrollWeb(
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                Center(child: imageGenerate(foundData)),
                H1Text(text: foundData.nombre.toString().toUpperCase(), textAlign: TextAlign.center, selectable: true),
                 qrGenerate(foundData),
                 AppIconButon(
                  onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> htmlFOundString(foundData),),),
                  child: H3Text(text: 'Informacion')),
                AppIconButon(
                  onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> Scaffold(body: tab.path),),),
                  child: H3Text(text: 'Editar'))
              ],
            ),
          )) );
  }


  QrGenerateWidget qrGenerate(dynamic foundData) => QrGenerateWidget(id: foundData.id, qr: foundData.qr);

  AssetHtmlView htmlFOundString(dynamic foundData) => AssetHtmlView(html: foundData.html ?? "");
  
  Widget imageGenerate(dynamic value) {
     final int lenthImage =  value.imagen is String
                          ? [value.imagen].length
                          : value.imagen.length;
      final List<String> imagen = value.imagen is String
                            ? [value.imagen]
                            : value.imagen;
    final imageBuilder = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
         alignment: AlignmentDirectional.topStart,
        children: [
          lenthImage > 1 ? Container(
                   margin:EdgeInsets.only(top: 10, bottom: 8) ,
                    decoration: AssetDecorationBox().borderdecoration(),
                    height: 45 + 40,
                    width: 73 + 40,
                  ) : SizedBox(),
                   lenthImage > 1 ? Container(
                     margin:EdgeInsets.only(top: 5, bottom: 5) ,
                    decoration: AssetDecorationBox().borderdecoration(),
                    height: 53 + 40,
                    width: 68 + 40,
                  ) : SizedBox(),
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: value.imagen != null && value.imagen!.isNotEmpty
                ? Container(
                    decoration: AssetDecorationBox().borderdecoration(colorBorder: Colors.grey.shade200),
                    child: GLobalImageUrlServer(
                      height: 100,
                      width: 100,
                      fadingDuration: 0,
                      duration: 0,
                      image: imagen.first,
                      collectionId: value.collectionId ?? '',
                      id: value.id,
                      borderRadius: BorderRadius.circular(0),
                      data:imagen,
                    ),
                  )
                : Opacity(
                    opacity: .5,
                    child: Image.asset(
                      AppImages.placeholder300,
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60,
                    ),
                  ),
          ),
          Container(
                    margin: EdgeInsets.all(3),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: AssetDecorationBox().decorationBox(color: Colors.white),
                      child: H3Text(
                          text: lenthImage.toString(),
                          fontSize: 10))
        ],
      ),
    );
    return imageBuilder;
  }
}

