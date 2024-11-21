
import 'package:provider/provider.dart';
import 'package:webandean/provider/sunat%20/provider_tipo_cambio.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/routes/assets_class_routes_pages.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:flutter/material.dart';

class Dashboardpage extends StatefulWidget {
  const Dashboardpage({super.key});

  @override
  State<Dashboardpage> createState() => _DashboardpageState();
}

class _DashboardpageState extends State<Dashboardpage> {
  PageController _pageController = PageController(viewportFraction: .8);
  String title = 'Sincronizacion de datos';
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int pageIndex = _pageController.page!.round();
      if (_currentPageIndex != pageIndex) {
        setState(() {
          _currentPageIndex = pageIndex;
          title = routes[pageIndex].title;
        });
      }
    });
  }

  List<RoutesLocalStorage> routes = [
    RoutesLocalStorage(
        icon: AppSvg(width: 100).candadoOpenSvg,
        title: "Usuarios",
        path: Container(),
        content:
            'Administre y descargue los datos\n de usuarios en su dispositivo.'),
    RoutesLocalStorage(
        icon: AppSvg(width: 100).candadoCloseSvg,
        title: "Puntos de Control",
        path: Container(),
        content:
            'Administre y almacene los dato\n locales para los puntos de control.'),
    RoutesLocalStorage(
        icon: AppSvg(width: 100).chartSvg,
        title: "Lista de Participantes",
        path: Container(),
        content:
            'Descargue y almacene localmente\n la lista de participantes. '),
  ];

  @override
  Widget build(BuildContext context) {
    final sunatTipocambio = Provider.of<TipoCambioProvider>(context);
    double tipoCambioCompra = sunatTipocambio.tipoCambioCompra;
    double tipoCambioVenta = sunatTipocambio.tipoCambioVenta;
    DateTime fechatipoCambio = sunatTipocambio.fecha;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              Container(
                constraints: BoxConstraints(minWidth: 200),
                decoration: AssetDecorationBox().decorationBox(color: AppColors.primaryRed),
                padding: EdgeInsets.all(20),
                child: H3Text(
                  text: title.toUpperCase(),
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
              ),
              
               H3Text(
                  text: 'tipoCambioCompra ${fechatipoCambio}',
                  textAlign: TextAlign.center,
              ),
              H3Text(
                  text: 'tipoCambioCompra ${tipoCambioCompra}',
                  textAlign: TextAlign.center,
              ),
             H3Text(
                  text: 'tipoCambioVenta ${tipoCambioVenta}',
                  textAlign: TextAlign.center,
                ),
              Expanded(
                child: ScrollWeb(
                  child: PageView(
                    controller: _pageController,
                    children: routes
                        .map(
                          (route) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              route.icon,
                              H2Text(
                                text: route.title,
                                color: Colors.white,
                                maxLines: 2,
                              ),
                             
                             
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => route.path),
                                    );
                                  },
                                  child: P1Text(text: 'Comenzar ahora'))
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ]),
            Positioned(
              bottom: 10,
              left: 20,
              child: IconButton.filled(
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.backgroundLight,
                ),
                onPressed: _currentPageIndex > 0
                    ? () {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    : null, // Deshabilita el botón si estamos en la primera página.
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: _currentPageIndex < routes.length - 1
          ? IconButton.filled(
              onPressed: () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon: Icon(
                Icons.arrow_forward,
                color: AppColors.backgroundLight,
              ),
            )
          : null, // Deshabilita el botón si estamos en la última página.
    );
  }
}


  // Expanded(
  //       child: LayoutBuilder(
  //         builder: (context, constraints) {
  //           // Calcular el número de columnas en función del ancho disponible
  //           int crossAxisCount = (constraints.maxWidth / 200).floor();
  //           // Ajusta el tamaño de los elementos
  //           double aspectRatio = constraints.maxWidth / (crossAxisCount * 150);

  //           return GridView.builder(
  //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: crossAxisCount,
  //               childAspectRatio: aspectRatio,
  //               crossAxisSpacing: 8.0,
  //               mainAxisSpacing: 8.0,
  //             ),
  //             padding: EdgeInsets.all(16.0),
  //             itemCount: routes.length,
  //             itemBuilder: (context, index) {
  //               final route = routes[index];
  //               return GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (context) => route.path),
  //                   );
  //                 },
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Expanded(
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: route.icon,
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Text(
  //                         route.title,
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 16,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             },
  //           );
  //         },
  //       ),
  //     ),