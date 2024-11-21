import 'package:webandean/pages/entregas/entrega%20general/entrega_general.dart';
import 'package:webandean/pages/entregas/lista%20equipos/lista_equipos.dart';
import 'package:webandean/pages/entregas/lista%20producto/lista_productos.dart';
import 'package:webandean/pages/equipo/equipo.dart';
import 'package:webandean/pages/home/dashboard_page.dart';
import 'package:webandean/pages/itinerarios/itinerarios.dart';
import 'package:webandean/pages/personal/personal.dart';
import 'package:webandean/pages/producto/productos.dart';
import 'package:webandean/utils/qr_lector/qr-lector.dart';
import 'package:webandean/provider/cache/menuWeb/menu_state.dart';
import 'package:webandean/utils/animations/assets_delayed_display.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/files%20assset/assets_imge.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/routes/assets_class_routes_pages.dart';
import 'package:flutter/material.dart';
import 'package:webandean/provider/cache/start%20page/current_page.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:webandean/widget/estate%20app/offline_buton.dart';
import 'package:provider/provider.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        clipBehavior: Clip.none,
        elevation: 2,
        width: 150,
        child: AssetsDelayedDisplayX(
          duration: 100,
          fadingDuration: 700,
          child: Container(
            color: AppColors.menuTheme,
            padding: const EdgeInsets.only(bottom:10),
            child: SafeArea(
              bottom: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  inicioButton(context),
                  const Expanded(child: ListaOpcionesphone()),
                  ModoOfflineClick(),
          
                  //  size.width < 900 ? CloseSesion() : SizedBox(),
                  // Opción para fijar el menú
                ],
              ),
            ),
          ),
        ));
  }

  Widget inicioButton(BuildContext context) {
  final menuProvider = Provider.of<MenuProvider>(context);
  bool isSelected = menuProvider.selectedIndex == -1; // -1 para el inicioButton

  return Container(
    decoration:isSelected ? AssetDecorationBox().selectedDecoration(color: AppColors.menuTheme.withOpacity(.5)) : AssetDecorationBox().headerDecoration(color: Colors.transparent),
    child: ListTile(
      visualDensity: VisualDensity.compact,
      dense: true,
      contentPadding: const EdgeInsets.all(0),
      title: Image.asset(
        AppImages.andeanlodgesApp,
        height: 38.5,
      ),
      
      onTap: () {
        final screensize = MediaQuery.of(context).size;
        final layoutmodel = Provider.of<LayoutModel>(context, listen: false);
        layoutmodel.currentPage = const Dashboardpage();
        
        // Actualizar el índice seleccionado en el menú
        menuProvider.selectIndex(-1); // -1 indica que estamos en el botón de inicio

        if (screensize.width <= 900) {
          Navigator.pop(context);
        }
      },
    ),
  );
}

}

class ListaOpcionesphone extends StatelessWidget {
  const ListaOpcionesphone({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorSvg = AppColors.menuIconColor;
    List<RoutesLocalStorage> routes = [
      RoutesLocalStorage(
        icon: AppSvg(color:colorSvg).productosSvg,
        title: "Productos",
        path: PageProductos(),
      ),
      RoutesLocalStorage(
        icon: AppSvg(color:colorSvg).equipoSvg,
        title: "Equipos",
        path: PageEquipos(),
      ),
      RoutesLocalStorage(
        icon: AppSvg().entregasSvg,
        title: "Lista Productos",
        path: PageListaProductos(),
      ),
      RoutesLocalStorage(
        icon: AppSvg().entregasSvg,
        title: "Lista Equipos",
        path: PageListaEquipos(),
      ),
       //PageEntregaGeneral
       RoutesLocalStorage(
        icon: AppSvg().deliverySvg,
        title: "Entregas Almacén",
        path: PageEntregaGeneral(),
      ),

      RoutesLocalStorage(
        icon: AppSvg(color: colorSvg).itinerarySvg,
        title: "Itinerarios",
        path: PageItinerarios(),
      ),
     
       //PagePersonal
       RoutesLocalStorage(
        icon: AppSvg(color: colorSvg).personalSvg,
        title: "Personal OP",
        path: PagePersonal(),
      ),
      
      RoutesLocalStorage(
        icon: AppSvg(color: colorSvg).fileSvg,
        title: "Reservas",
        path: Container(),
      ),
      RoutesLocalStorage(
        icon: AppSvg(color:colorSvg ).analiticSvg,
        title: "Presupuestos",
        path: Container(),
      ),
      RoutesLocalStorage(
        icon: AppSvg(color:colorSvg ).qrScannerSvg,
        title: "Lector Qr",
        path: QrLectorPage(),
      ),
    ];
    final menuProvider = Provider.of<MenuProvider>(context);
    return ScrollWeb(
      child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: routes.length,
          itemBuilder: (context, index) {
            final listaRoutes = routes[index];

            return CardMenuPrincipal(
                listaRoutes: listaRoutes,
                isSelected: menuProvider.selectedIndex == index, index: index,);
          }),
    );
  }
}


class CardMenuPrincipal extends StatelessWidget {
  const CardMenuPrincipal({
    super.key,
    required this.listaRoutes,
    required this.isSelected, required this.index, // Añadido para controlar la selección
  });

  final RoutesLocalStorage listaRoutes;
  final int index;
  final bool isSelected; // Propiedad para controlar la selección
  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
     final colorSvg = AppColors.menuIconColor;
    return Container(
      decoration:isSelected ? AssetDecorationBox().selectedDecoration(color: AppColors.menuTheme.withOpacity(.5)) : null,
      child: ListTile(
        visualDensity: VisualDensity.compact,
        dense: true,
        contentPadding:  EdgeInsets.only(left: isSelected ? 30 : 10),
        minVerticalPadding: 0,
        leading: listaRoutes.icon,
        title: P2Text(
          text: listaRoutes.title,
          fontSize: 12,
          color: colorSvg,
          maxLines: 1,
        ),
        trailing: isSelected ? AppSvg(width: 15, color: Colors.white).menusvg : null,
      
        onTap: () {
          menuProvider.selectIndex(index);//Index 
          menuProvider.selectTitle(listaRoutes.title); //nombre option 
           menuProvider.selectSvg(listaRoutes.icon); //svg option

          final screensize = MediaQuery.of(context).size;
          if (screensize.width > 900) {
            final layoutmodel = Provider.of<LayoutModel>(context, listen: false);
            layoutmodel.currentPage = listaRoutes.path;
          } else {
            final layoutmodel = Provider.of<LayoutModel>(context, listen: false);
            layoutmodel.currentPage = listaRoutes.path;
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
