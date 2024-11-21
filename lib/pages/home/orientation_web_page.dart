import 'package:webandean/local_storage/shared_preferences/shaerd_preferences.dart';
import 'package:webandean/pages/home/menu_principal.dart';
import 'package:flutter/material.dart';
import 'package:webandean/provider/cache/menuWeb/menu_state.dart';
import 'package:webandean/provider/cache/start%20page/current_page.dart';
import 'package:provider/provider.dart';
import 'package:webandean/utils/animations/assets_animationswith.dart';
import 'package:webandean/utils/animations/assets_delayed_display.dart';
import 'package:webandean/utils/blur/blur_filter.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/files%20assset/assets-svg.dart';
import 'package:webandean/utils/files%20assset/assets_imge.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  SharedPrefencesGlobal sharedPrefs = SharedPrefencesGlobal();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _speakWelcomeMessage();
    });

    sharedPrefs.setLoggedIn();
  }

  void _speakWelcomeMessage() {
    // final currenUser = Provider.of<CacheUsuarioProvider>(context, listen: false)
    //     .usuarioEncontrado;
    // if (currenUser != null) {
    //   TextToSpeechService().speak('Bienvenido, ${currenUser.nombre}');
    // } else {
    // Puedes manejar el caso en el que currenUser es null, si es necesario
    TextToSpeechService().speak('Bienvenido, usuario desconocido');
    // }
  }

  @override
  Widget build(BuildContext context) {
    final layoutmodel = Provider.of<LayoutModel>(context);
    final menuProvider = Provider.of<MenuProvider>(context);
    return Scaffold(
      body: Row(
        children: [
          //MENU
          AssetsAnimationSwitcher(
            isTransition: true,
            directionLeft: true,
            duration: 10,
            switchInCurve: Curves.ease,
            switchOutCurve: Curves.ease,
            child: menuProvider.isVisible
                ? const SizedBox(width: 180, child: MenuPrincipal())
                : Container(),
          ),
          //CONTENT
          Expanded(
              child: AssetsDelayedDisplayX(
                duration: 900,
                curve: Curves.fastLinearToSlowEaseIn,
                slidingRight: true,
                child: Stack(
                 alignment: AlignmentDirectional.bottomCenter,
                 children: [
                   Align(
                    alignment: Alignment.topCenter,
                     child: H2Text(
                      text: menuProvider.selectedIndex != -1
                          ? 'PANEL ${menuProvider.selectedTitle}'.toUpperCase()
                          : 'Inicio'.toUpperCase(),
                      color: Colors.limeAccent,
                                       ),
                   ),
                    AppBLurFilter(
                      child: Opacity(
                          opacity: .3, child: Image.asset(AppImages.iaImage2)),
                    ),
                    Column(
                      children: [
                        _CustomAppBar(menuProvider: menuProvider),
                        Expanded(
                          child: layoutmodel.currentPage,
                        ),
                      ],
                    ),
                   ],
                ),
              )),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({
    required this.menuProvider,
  });

  final MenuProvider menuProvider;

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    return Container(
      decoration: AssetDecorationBox().headerDecoration(color: AppColors.menuTheme),
      padding: EdgeInsets.only(left: 5,right: 2,bottom: 1),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            GestureDetector(
              child:menuProvider.isVisible
                  ? AppSvg(
                      color: Colors.limeAccent,
                    ).slidebarCollapseSvg
                  : AppSvg(color: Colors.limeAccent).slidebarSvg,
              onTap: () {
                menuProvider.toggleMenuVisibility();
              },
            ),
            SizedBox(width: 20),
            
            H2Text(
              text: menuProvider.selectedIndex != -1
                  ? 'PANEL ${menuProvider.selectedTitle}'.toUpperCase()
                  : 'Inicio'.toUpperCase(),
              color: Colors.limeAccent,
            ),
            Expanded(child: Container()),
            AppSvg().gmailSvg,
            SizedBox(width: 10),
            AppSvg(width: 26).whatsappSvg,
            SizedBox(width: 10),
            CardUsuario()
          ],
        ),
      ),
    );
  }
}

class CardUsuario extends StatelessWidget {
  const CardUsuario({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AssetDecorationBox().decorationBorder(color: Colors.black45),
      constraints: BoxConstraints(maxWidth: 220),
      margin: EdgeInsets.only(bottom: 1),
      child: ListTile(
        onTap: () {
          //TODO : poner accion de editar perfil
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
        visualDensity: VisualDensity.compact,
        dense: true,
        minVerticalPadding: 0,
        leading: CircleAvatar(child: Icon(Icons.person),),
        title: H3Text(text: 'Alberto', color: Colors.white70, height: 1),
        minTileHeight: 47,
        subtitle: P3Text(text: 'alberto@gmail.com', maxLines: 1, height: 1, color: Colors.white),
        trailing: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.limeAccent,),
      ),
    );
  }
}
