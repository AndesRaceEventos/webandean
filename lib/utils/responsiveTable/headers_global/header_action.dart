import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:webandean/utils/dialogs/assets_butonsheets.dart';

import 'package:webandean/utils/files/assets-svg.dart';
import 'package:webandean/utils/html_render/html_view_render.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/qr_generate/qr_generate.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

DatatableHeader dtaHeadercarActions(
    {required Function(dynamic value) onPressedEdit,
    required Function(dynamic value) onPressedDelete,
    required BuildContext context}) {
  return DatatableHeader(
    // flex: 2,
    text: "Actions",
    value: "data",
    show: true,
    sortable: false,
    headerBuilder: (value) {
      return Container(
        //  constraints: BoxConstraints(maxWidth: 200),
        decoration: BoxDecoration(
          border:
              Border.all(style: BorderStyle.solid, color: Colors.grey.shade300),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          visualDensity: VisualDensity.compact,
          dense: false,
          leading: Icon(
            Icons.settings,
            size: 15,
            color: Colors.black54,
          ),
          title: H3Text(text: 'Actions'.toUpperCase(), fontSize: 11),
        ),
      );
    },
    sourceBuilder: (value, row) {
      return Table(
        children: [
          TableRow(children: [
            //  EDITING
            _actionCustom( icon: AppSvg().editSvg, onPressed: () => onPressedEdit(value)), // Pasamos el value al callback
            //  Delete
            _actionCustom( icon: AppSvg().deleteSvg, onPressed: () => onPressedDelete(value))// Pasamos el value al callback
          ]),
          TableRow(children: [
            //  HTML
           _actionCustom( icon: AppSvg().htmlSvg, onPressed: () => Navigator.push(context,
                    MaterialPageRoute( builder: (context) => AssetHtmlView(html: value.html)))),
            //QR Generate
            _actionCustom(icon: AppSvg().qrcodeSvg,  onPressed: () {
              showCustomBottonSheet(
                context: context, 
                backgroundColor: Colors.transparent,
                 sheetAnimationStyle: AnimationStyle(),
                 maxHeightFactor: 1,
                //  enableDrag: false,
                //  showDragHandle:false,
                builder: (context) {
                return  QrGeneratePage(id: value.id, qr: value.qr);
              },);
            }
            )
          ]),
        ],
      );
    },
    textAlign: TextAlign.center,
  );
}

Container _actionCustom(
    {required Widget icon, required Function()? onPressed}) {
  return Container(
      height: 35,
      margin: EdgeInsets.all(1),
      decoration: AssetDecorationBox().borderdecoration(color: Colors.white, colorBorder: Colors.grey),
      child: IconButton(
          padding: EdgeInsets.all(0),
          icon: icon,
          onPressed: onPressed));
}
