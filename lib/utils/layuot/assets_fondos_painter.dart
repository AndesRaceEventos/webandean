//BACKGRPOUND DIAGONAL
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:flutter/cupertino.dart';

class DiagonalPainter extends CustomPainter {
  final Color colorTop;
  final Color colorBottom;

   DiagonalPainter({Color? colorTop, Color? colorBottom})
      : colorTop = colorTop ?? AppColors.primaryBlack.withOpacity(.65),
        colorBottom = colorBottom ?? const Color.fromRGBO(0, 0, 0, 1).withOpacity(.8);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = colorTop
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.4)
      ..lineTo(0, size.height * .75)
      ..close();
    canvas.drawPath(path, paint);
    // Pintar la parte inferior con color negro transparente
    final blackPaint = Paint()
      ..color = colorBottom
      ..style = PaintingStyle.fill;

    final blackPath = Path()
      ..moveTo(0, size.height * 0.75)
      ..lineTo(size.width, size.height * 0.4)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(blackPath, blackPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
