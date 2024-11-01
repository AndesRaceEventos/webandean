import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:webandean/local_storage/shared_preferences/shaerd_preferences.dart';
import 'package:webandean/pages/home/orientation_phone_page.dart';
import 'package:webandean/pages/home/orientation_web_page.dart';
import 'package:webandean/provider/cache/json_loading/provider_json.dart';
import 'package:webandean/provider/cache/menuWeb/menu_state.dart';
import 'package:webandean/provider/cache/qr_lector/qr_lector_provider.dart';
import 'package:webandean/provider/cache/start%20page/current_page.dart';
import 'package:webandean/provider/mouse%20region/provider_hover_web.dart';
import 'package:webandean/provider/offlineState/provider_offline_state.dart';
import 'package:webandean/provider/producto/provider_producto.dart';
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
        //RUNNER OfflineStateProvider
        ChangeNotifierProvider(
          create: (context) => OfflineStateProvider(),
          lazy: false,
        ),
        //USUARIO CACHE
        ChangeNotifierProvider(
          create: (context) => TProductosAppProvider(),
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
