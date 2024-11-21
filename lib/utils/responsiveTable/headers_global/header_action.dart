import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/dialogs/assets_butonsheets.dart';

import 'package:webandean/utils/files%20assset/assets-svg.dart';
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
       return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth > 200 ? 150 : constraints.maxWidth;
        return Container(
          width: maxWidth,
          constraints: BoxConstraints(maxWidth: maxWidth), // Limita el ancho del header
            decoration: BoxDecoration(
             color: AppColors.menuHeaderTheme,
            border: Border.all(
              width: .4,
              style: BorderStyle.solid, color: Colors.grey.shade300),
            ),
            child: ListTile(
              onTap: (){},
                contentPadding: EdgeInsets.symmetric(horizontal: 3),
              visualDensity: VisualDensity.compact,
              dense: false,
              minLeadingWidth: 0, 
              minVerticalPadding: 0,
              leading: Icon(
                Icons.settings,
                size: 15,
                color: AppColors.menuTextDark),
              title: H3Text(text: 'Actions'.toUpperCase(), fontSize: 11, color: AppColors.menuTextDark),
            ),
          );
        }
      );
    },
    sourceBuilder: (value, row) {
       return LayoutBuilder(
      builder: (context, constraints) {
        // double maxWidth = constraints.maxWidth > 200 ? 100 : constraints.maxWidth;
        double maxWidth = 100;
        return Center(
          child: Container(
            width: maxWidth,
            constraints: BoxConstraints(maxWidth: maxWidth), // Limita el ancho del header
              child: Stack(
                children: [
                  Table(
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
                  ),
                ],
              ),
            ),
        );
        }
      );
    },
    textAlign: TextAlign.center,
  );
}

Container _actionCustom(
    {required Widget icon, required Function()? onPressed}) {
  return Container(
      height: 30,
      margin: EdgeInsets.all(1),
      
      decoration: AssetDecorationBox().borderdecoration(color: Colors.white,
      colorBorder: AppColors.menuHeaderTheme),
      child: IconButton(
          padding: EdgeInsets.all(3),
          icon: icon,
          onPressed: onPressed));
}
