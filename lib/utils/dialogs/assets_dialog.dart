import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssetAlertDialogPlatform extends StatelessWidget {
  final String title;
  final String message;
  final Widget? child;
  final bool isCupertino;
  final String? oK_textbuton;

  const AssetAlertDialogPlatform({
    Key? key,
    required this.message,
    required this.title,
    this.child,
    this.isCupertino = true,
    this.oK_textbuton = 'OK', // Default to 'OK' for iOS
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
      ],
    )
    : AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            if (child != null) child!,
          ],
        ),
        actions: [
          TextButton(
            child: Text('$oK_textbuton'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
  }
}
