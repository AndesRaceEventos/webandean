import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/animations/assets_delayed_display.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
import 'package:flutter/material.dart';

class TitleLogin extends StatelessWidget {
  const TitleLogin({
    super.key,
    required this.title1,
    required this.title2,
    required this.parrafo,
    required this.title3,
    required this.title4,
    required this.fontsize,
  });
  final String title1;
  final String title2;
  final String title3;
  final String title4;
  final String parrafo;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AssetsDelayedDisplayYbasic(
              duration: 3000,
              child: H1Text(
                text: '$title1\n$title2',
                fontSize: fontsize,
                fontWeight: FontWeight.w900,
                color: AppColors.backgroundLight,
                maxLines: 2,
                height: 1.3,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AssetsDelayedDisplayYbasic(
                  fadingDuration: 2000,
                  duration: 3500,
                  child: H1Text(
                    text: title3,
                    fontSize: fontsize,
                    fontWeight: FontWeight.w900,
                    maxLines: 3,
                    color: AppColors.backgroundLight,
                  ),
                ),
                Expanded(
                  child: AssetsDelayedDisplayYbasic(
                    fadingDuration: 2000,
                    duration: 3800,
                    child: H1Text(
                      text: title4,
                      fontSize: fontsize,
                      fontWeight: FontWeight.w900,
                      maxLines: 3,
                      color: AppColors.titleAccent,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            AssetsDelayedDisplayYbasic(
              duration: 5000,
              child: P2Text(
                text: parrafo,
                textAlign: TextAlign.justify,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AssetsListTitle extends StatelessWidget {
  const AssetsListTitle({
    super.key,
    required this.title1,
     this.parrafo,
    required this.fontsize,
    required this.duration,
    required this.leading,
    required this.trailing,
    this.onTap, 
    this.color = AppColors.buttonPrimary,
  });
  final String title1;
  final String? parrafo;
  final double fontsize;
  final int duration;
  final Widget leading;
  final Widget trailing;
  final VoidCallback? onTap; // Declarar onTap como opcional
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal:10),
      visualDensity: VisualDensity.compact,
      // leading:
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AssetsDelayedDisplayYbasic(duration: duration + 1000, child: leading),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AssetsDelayedDisplayYbasic(
                    duration: duration,
                    child: H1Text(
                      text: '$title1',
                      fontSize: fontsize,
                      fontWeight: FontWeight.w900,
                      color: color!,
                      maxLines: 2,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 5,),
                  AssetsDelayedDisplayYbasic(
                    duration: duration + 700,
                    child: P2Text(
                      text: parrafo ?? '',
                      textAlign: TextAlign.justify,
                      color: color!.withOpacity(.8),
                      fontSize: fontsize-2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AssetsDelayedDisplayX(
          curve: Curves.bounceOut, duration: 300, child: trailing),
        ],
      ),
     
    );
  }
}
