import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:webandean/utils/files/assets_imge.dart';
import 'package:webandean/utils/layuot/asset_boxdecoration.dart';
import 'package:webandean/utils/routes/assets_img_urlserver.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

DatatableHeader dtaHeadercarImage() {
  return DatatableHeader(
    // flex: 2,
    text: "Image",
    value: "data",
    show: true,
    sortable: false,
    headerBuilder: (value) {
      return Container(
        // constraints: BoxConstraints(maxWidth: 200),
        decoration: BoxDecoration(
          border:
              Border.all(style: BorderStyle.solid, color: Colors.grey.shade300),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          visualDensity: VisualDensity.compact,
          dense: false,
          leading: Icon(
            Icons.image,
            size: 15,
            color: Colors.black54,
          ),
          title: H3Text(text: 'Image'.toUpperCase(), fontSize: 11),
        ),
      );
    },
    sourceBuilder: (value, row) {
      final int lenthImage =  value.imagen is String
                          ? [value.imagen].length
                          : value.imagen.length;
      final List<String> imagen = value.imagen is String
                            ? [value.imagen]
                            : value.imagen;
      return Container(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
               lenthImage > 1 ? Container(
                 margin:EdgeInsets.only(top: 10, bottom: 8) ,
                  decoration: AssetDecorationBox().borderdecoration(),
                  height: 45,
                  width: 73,
                ) : SizedBox(),
                 lenthImage > 1 ? Container(
                   margin:EdgeInsets.only(top: 5, bottom: 5) ,
                  decoration: AssetDecorationBox().borderdecoration(),
                  height: 53,
                  width: 68,
                ) : SizedBox(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: value.imagen != null && value.imagen!.isNotEmpty
                      ? Container(
                         decoration: AssetDecorationBox().borderdecoration(colorBorder: Colors.grey.shade200),
                        child: GLobalImageUrlServer(
                            height: 60,
                            width: 60,
                            fadingDuration: 0,
                            duration: 0,
                            image: imagen.first,
                            collectionId: value.collectionId ?? '',
                            id: value.id,
                            borderRadius: BorderRadius.circular(0),
                            data: value.imagen is String
                                ? [value.imagen]
                                : value.imagen,
                          ),
                      )
                      : Opacity(
                          opacity: .5,
                          child: Image.asset(
                            AppImages.placeholder300,
                            fit: BoxFit.cover,
                            height: 60,
                            width: 60,
                          ),
                        ),
                ),
                Container(
                  margin: EdgeInsets.all(3),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: AssetDecorationBox().decorationBox(color: Colors.white),
                    child: H3Text(
                        text: lenthImage.toString(),
                        fontSize: 10))
              ],
            ),
          ],
        ),
      );
    },
    textAlign: TextAlign.center,
  );
}


