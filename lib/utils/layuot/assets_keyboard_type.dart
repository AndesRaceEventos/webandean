
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard/flutter_keyboard.dart';

  //La función shuffle() sirve para aleatorizar los elementos de una lista reordena los elementos de forma aleatoria.
  List<String> numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  
class CustomFlutterKeyboard extends StatelessWidget {
  final Function(String) onKeyboardTap;
  final String footerMiddleCharacter;
  final bool isLogin;
  final TextEditingController textController;
  final VoidCallback? footerLeftAction;
  final VoidCallback footerRightAction;
  final List<String> characters;

  CustomFlutterKeyboard({
    required this.onKeyboardTap,
     this.footerMiddleCharacter = '0',
    required this.isLogin,
    required this.textController,
    required this.footerLeftAction,
    required this.footerRightAction,
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterKeyboard(
      physics: NeverScrollableScrollPhysics(),
      itemsPerRow: 3,
      getAllSpace: true,
      externalPaddingButtons: const EdgeInsets.all(5),
      internalPaddingButtons: EdgeInsets.symmetric(vertical: 10),
      buttonsDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xFFF1F1F1)),
      footerRightChild: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Color(0xFFF3F3F3)),
        child: const Icon(
          Icons.backspace,
          size: 32,
          color: AppColors.accentColor,
        ),
      ),
       footerLeftChild: isLogin
          ? Center(
              child: const CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
              padding: EdgeInsets.symmetric(vertical: 18.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: (textController.text.length < 8)
                    ? Colors.transparent
                    : Colors.green,
              ),
              child: H2Text(
                text: 'Continuar',
                fontSize: 14,
                color: (textController.text.length < 8)
                    ? Colors.transparent
                    : Colors.white,
              ),
            ),
      characters: characters,
      footerMiddleCharacter: footerMiddleCharacter,
      onKeyboardTap: onKeyboardTap,
      footerLeftAction: footerLeftAction,
      footerRightAction: footerRightAction,
      
    );
  }
}

 String generateMaskedText(String text) {
    final int maxLength = 8;
    String maskedText = '';

    for (int i = 0; i < maxLength; i++) {
      if (i < text.length) {
        maskedText += text[i];
      } else {
        maskedText += '•';
      }
    }

    return maskedText;
  }