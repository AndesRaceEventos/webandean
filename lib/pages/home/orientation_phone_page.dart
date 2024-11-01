import 'package:webandean/local_storage/shared_preferences/shaerd_preferences.dart';
import 'package:webandean/pages/home/menu_principal.dart';
import 'package:webandean/utils/animations/assets_delayed_display.dart';
import 'package:webandean/utils/files/assets_imge.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/widget/estate%20app/state_icon_offline.dart';
import 'package:flutter/material.dart';
import 'package:webandean/provider/cache/start%20page/current_page.dart';

import 'package:provider/provider.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState(); 
}

class _PhonePageState extends State<PhonePage> {
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
    // final currenUser =
    //     Provider.of<CacheUsuarioProvider>(context, listen: false).usuarioEncontrado;
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

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: AssetsDelayedDisplayYbasic(
              duration: 2000,
              child: Image.asset(
                AppImages.andeanlodgesApp,height: 30,
              )),
         ),
      body: layoutmodel.currentPage, //const ListaOpciones(),
      endDrawer: const MenuPrincipal(),
    );
  }
}
