
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:webandean/utils/layuot/assets_scroll_web.dart';
import 'package:webandean/utils/mouse%20region/selectd_region.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class AssetHtmlView extends StatelessWidget {
  const AssetHtmlView({
    super.key, required this.html,
  });
 final String html;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton.small(
        child: Icon(Icons.close),
        backgroundColor: Colors.blue,
        onPressed: ()=> Navigator.pop(context)),
      body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (html != null && html!.isNotEmpty)
                Expanded(
                flex: 1,
                child: ScrollWeb(
                  child: SingleChildScrollView(
                   padding: EdgeInsets.symmetric(horizontal:16.0, vertical: 100),
                  child: AssetTextSelectionRegion(
                    child: HtmlWidget(
                      html,
                      customStylesBuilder: (element) {
                        // Personaliza estilos aquí
                        return null;
                      },
                     
                    ),
                  ),
                  ),
                ),
              )
              else
                Center(child: H3Text(text:'No images available')),
            ],
          ));
  }
}