import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webandean/utils/button/asset_buton_widget.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class AssetAlertDialogPlatform extends StatelessWidget {
  final String title;
  final String message;
  final Widget? child;
  final bool isCupertino;
  final String? oK_textbuton;
  final Widget? actionButon;

  const AssetAlertDialogPlatform({
    Key? key,
    required this.message,
    required this.title,
    this.child,
    this.isCupertino = true,
    this.oK_textbuton = 'OK', // Default to 'OK' for iOS
    this.actionButon,
  }) : super(key: key);

  static void show(
      {required BuildContext context,
      required String message,
      required String title,
      Widget? child, 
      bool isCupertino = true, // Default to true for iOS
      String oK_textbuton = 'OK', // Default to 'OK' for iOS
      }) {
    showDialog(
      context: context,
      builder: (context) => AssetAlertDialogPlatform(
        message: message,
        title: title,
        child: child,
        isCupertino: isCupertino,
        oK_textbuton: oK_textbuton,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Theme.of(context).platform == TargetPlatform.iOS
    // ?
    return isCupertino
        ? CupertinoAlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              if (child != null) child!,
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('$oK_textbuton'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          if (actionButon != null) ...[
              actionButon!,
            ],
          ],
        )
    : AlertDialog(
        title: H1Text(text: title, color: Colors.lime, ),
        backgroundColor: Colors.black54,
        content: ScrollWeb(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                P3Text(text: message, color: Colors.white),
                SizedBox(height: 10),
                if (child != null) child!,
              ],
            ),
          ),
        ),
        actions: [
          if (actionButon != null) ...[
           actionButon!,
         ],
          AppIconButon(
            child: Text('$oK_textbuton'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
  }
}
