import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:webandean/local_storage/shared_preferences/shaerd_preferences.dart';
import 'package:webandean/pages/home/orientation_phone_page.dart';
import 'package:webandean/pages/home/orientation_web_page.dart';
import 'package:webandean/provider/cache/files/files_procesisng.dart';
import 'package:webandean/provider/cache/json_loading/provider_json.dart';
import 'package:webandean/provider/cache/menuWeb/menu_state.dart';
import 'package:webandean/provider/cache/offlineState/provider_offline_state.dart';
import 'package:webandean/provider/cache/qr_lector/qr_lector_provider.dart';
import 'package:webandean/provider/cache/start%20page/current_page.dart';
import 'package:webandean/provider/cache/mouse%20region/provider_hover_web.dart';
import 'package:webandean/provider/entregas/provider_entregas_generales.dart';
import 'package:webandean/provider/entregas/provider_lista_equipo.dart';
import 'package:webandean/provider/entregas/provider_lista_producto.dart';
import 'package:webandean/provider/equipo/provider_equipo.dart';
import 'package:webandean/provider/itinerarios/provider_itinerarios.dart';
import 'package:webandean/provider/personal/provider_personal.dart';
import 'package:webandean/provider/producto/provider_producto.dart';
import 'package:webandean/provider/sunat%20/provider_tipo_cambio.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/speack/assets_speack.dart';

void main() async {
  //INICALIZAR FECHA Y HORA:
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('America/Lima'));

  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar SharedPreferencesGlobal
  SharedPrefencesGlobal prefs = SharedPrefencesGlobal();
  await prefs.initSharedPreferecnes();

  // Inicializar TextToSpeechService
  TextToSpeechService textToSpeechService = TextToSpeechService();
  await textToSpeechService.initializeTts(); // Usar el singleton

  // Bloquear la rotación de la pantalla en toda la aplicación
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //FIREBASE
  // WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp().then((value) {
  // await Firebase.initializeApp();
  runApp(const AppState());
  // });
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //TipoCambioProvider
        ChangeNotifierProvider(create: (context) => TipoCambioProvider(), lazy: false,),
        ChangeNotifierProvider(
          create: (context)=> FilesProvider()
        ),
        ChangeNotifierProvider(
          create: (context) => HoverProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LayoutModel(),
        ),
         ChangeNotifierProvider(
          create: (context) => JsonLoadProvider(),
        ),

        ChangeNotifierProvider(
          create: (context) => MenuProvider(),
        ),
        
         ChangeNotifierProvider(
          create: (context) => QrLectorProvider(),
        ),
        //OfflineStateProvider
        ChangeNotifierProvider(
          create: (context) => OfflineStateProvider(),
          lazy: false,
        ),
        //PRODUCTO CACHE
        ChangeNotifierProvider(
          create: (context) => TProductosAppProvider(),
          lazy: false,
        ),
        //EQUIPO 
        ChangeNotifierProvider(
          create: (context) => TEquipoAppProvider(),
          lazy: false,
        ),
         //ENTREGAS EQUIPO PRODUCTO  
        ChangeNotifierProvider(
          create: (context) => TListaProductosAppProvider(),
          lazy: false,
        ),
         ChangeNotifierProvider(
          create: (context) => TListaEquipoAppProvider(),
          lazy: false,
        ),
        //TItinerariosAppProvider 
         ChangeNotifierProvider(
          create: (context) => TItinerariosAppProvider(),
          lazy: false,
        ), 
        //TPersonalAppProvider
        ChangeNotifierProvider(
          create: (context) => TPersonalAppProvider(),
          lazy: false,
        ), 
        //TEntregasAppProvider
         ChangeNotifierProvider(
          create: (context) => TEntregasAppProvider(),
          lazy: false,
        ), 
      ],
      builder: (context, _) {
        return const MyApp();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Andean Lodges',
      theme: ThemeData(
        colorScheme: ColorScheme(
          primary: AppColors.primaryRed,
          primaryContainer: AppColors.primaryRed.withOpacity(0.8),
          secondary: AppColors.accentColor,
          secondaryContainer: AppColors.accentColor.withOpacity(0.8),
          surface: AppColors.backgroundLight,
          error: Colors.red,
          onPrimary: AppColors.primaryWhite,
          onSecondary: AppColors.primaryWhite,
          onSurface: AppColors.textPrimary,
          onError: AppColors.primaryWhite,
          brightness: Brightness.light,
        ),
        fontFamily: 'Quicksand',
        // Definiendo el tema de los botones
        buttonTheme: const ButtonThemeData(
          buttonColor: AppColors.buttonPrimary,
          textTheme: ButtonTextTheme.primary,
        ),
        // Definiendo el tema de AppBar
        appBarTheme: const AppBarTheme(
          color: AppColors.backgroundLight,
          titleTextStyle: TextStyle(
            color: AppColors.backgroundDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: AppColors.primaryRed),
        ),
        // Definiendo el tema de los iconos
        iconTheme: const IconThemeData(color: AppColors.primaryRed),
        // Definiendo el tema de los inputs (TextField)
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: AppColors.backgroundLight,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryRed),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textSecondary),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Builder(builder: (context) {
        final screensize = MediaQuery.of(context).size;
        if (screensize.width > 900) {
          return const WebPage();
        } else {
          return const PhonePage();
        }
        // return const ProductosResponciveTable();
      }),
    );
  }
}
