
import 'package:flutter/material.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class TextTabBarTable extends StatelessWidget {
  const TextTabBarTable({
    super.key,
    required this.groupedData, required this.tabTitle,
  });

  final Map<String, dynamic> groupedData;
  final String tabTitle;

  @override
  Widget build(BuildContext context) {
     
    return Chip(
         backgroundColor: AppColors.menuHeaderTheme,
         padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
         visualDensity: VisualDensity.compact,
         side: BorderSide.none,
         label: H2Text(text: '$tabTitle', fontSize: 11, color: AppColors.menuTextDark),
          avatar: CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.menuTheme,
          child: P2Text(text: '${groupedData[tabTitle]?.length}', 
          fontSize: 11, color: AppColors.menuIconColor)),
        );
    // Tooltip(
    //   message: '${groupedData[tabTitle]?.length} registro',
    //   child: Container(
    //     padding: EdgeInsets.all(5),
    //     decoration: AssetDecorationBox().selectedDecoration(color: AppColors.menuTheme.withOpacity(.9)),
    //     child: Row(
    //       mainAxisSize: MainAxisSize.min,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Container(
    //           margin: EdgeInsets.all(1),
    //           padding: EdgeInsets.symmetric(horizontal: 3),
    //           decoration:AssetDecorationBox().decorationBorder(color: AppColors.menuTheme),
    //           child: H1Text(
    //               fontSize: 12,
    //               color: Colors.white,
    //               text:
    //                   '${groupedData[tabTitle]?.length}'),
    //         ),
    //         SizedBox(width: 8),
    //         P2Text( color: Colors.white,fontSize: 12, text: '$tabTitle'.toUpperCase(),),
    //       ],
    //     ),
    //   ),
    // );
  }
}