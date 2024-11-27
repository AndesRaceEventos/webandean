
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/files%20assset/asset_gif.dart';
import 'package:webandean/utils/speack/assets_speack.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class TabBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const TabBarCustom({
    super.key, 
    required this.tabs,
    required this.onTap,
    });
  final List<Widget> tabs;
  final Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    return TabBar(
        dividerColor: Colors.transparent,
        indicatorColor: AppColors.warningColor,
        isScrollable: true,
        labelPadding: EdgeInsets.only(right: 5, bottom: 3),
        indicatorPadding: EdgeInsets.all(0),
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        indicatorWeight: 1,
        // dividerHeight: 0,
       onTap: onTap,
        tabs:tabs
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class ChipTabar extends StatelessWidget {
  const ChipTabar({super.key, required this.title, required this.count});
  final String title;
  final int count;
  @override
  Widget build(BuildContext context) {
    return  Chip(
        backgroundColor: AppColors.menuHeaderTheme,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        visualDensity: VisualDensity.compact,
        side: BorderSide.none,
        label: H2Text(text: '${title}', fontSize: 11, color: AppColors.menuTextDark),
        avatar: CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.menuTheme,
          child: P2Text(text: '${count}', 
          fontSize: 11, color: AppColors.menuIconColor)),
      );
  }
}



class Erro404Page extends StatefulWidget {
  const Erro404Page({
    super.key, 
    required this.onPressed, 
    this.textSpeack = 'No se encontraron resultados. Por favor, intenta buscar un nuevo registro o verifica si hay errores en tu búsqueda.'
  });
  final void Function()? onPressed;
  final String? textSpeack;
  @override
  State<Erro404Page> createState() => _Erro404PageState();
}

class _Erro404PageState extends State<Erro404Page> with TickerProviderStateMixin {
  late GifController _controller;

  @override
  void initState() {
    super.initState();

    // Inicializa el controlador sin duración explícita
    _controller = GifController(vsync: this);

    _startGifAndTextToSpeech();
  }

  Future<void> _startGifAndTextToSpeech() async {
    // Usa Text-to-Speech para leer el texto
    await TextToSpeechService().speak('${widget.textSpeack}');

    // Ejecuta la función pasada como parámetro al finalizar la lectura
    TextToSpeechService().flutterTts.setCompletionHandler(() {
      if (widget.onPressed != null) {
        widget.onPressed!();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Limpia recursos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.menuTheme,
      body: Container(
        
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   width: 300, // Ajusta el tamaño según sea necesario
              //   height: 300,
              //   decoration: BoxDecoration(
              //     //  color: Colors.white30.withOpacity(0.6),
              //     shape: BoxShape.circle, // Forma circular
              //     boxShadow: [
              //        BoxShadow(
              //         color: Colors.white12, // Color brillante del borde
              //         spreadRadius: 5, // Extensión del brillo
              //         blurRadius: 10, // Difuminado del brillo
              //         offset: Offset(0, 0), // Centrado
              //       ),
              //       BoxShadow(
              //         color: const Color(0xFF1AD1ED).withOpacity(0.9), // Color brillante del borde
              //         spreadRadius: 1, // Extensión del brillo
              //         blurRadius: 2,// Difuminado del brillo
              //         offset: Offset(0, 0), // Centrado
              //       ),
                    
              //     ],
              //   ),
              //   child: ClipOval( // Asegura que el contenido también sea circular
              //     child: Opacity(//https://i.gifer.com/LCPT.gif
              //       opacity: .8,
              //       child: Gif(
              //         image: AssetImage(AppGif.jarvisApp),//https://i.gifer.com/Mr3W.gif
              //         controller: _controller,
              //         autostart: Autostart.loop,
              //         repeat: ImageRepeat.repeat,
              //         duration: const Duration(milliseconds: 1500),
              //       ),
              //     ),
              //   ),
              // ),

            ],
          ),
        ),
      ),
    );
  }
}
