
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:flutter/material.dart';

Widget customListTitle(
    {required String? leading, required String? title, Widget? trailing}) {
  return Container(
    height: 25,
    child: ListTile(
      contentPadding: EdgeInsets.all(0),
      dense: true,
      visualDensity: VisualDensity.compact,
      leading: H3Text(
        text: leading ?? '',
        maxLines: 5,
        fontSize: 13,
      ),
      title: P3Text(
        text: title ?? '',
        maxLines: 1,
        selectable: true,
      ),
      trailing: trailing,
    ),
  );
}