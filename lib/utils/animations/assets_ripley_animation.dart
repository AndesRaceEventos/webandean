import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class LottiesImage extends StatelessWidget {
  const LottiesImage({
    super.key,
    this.height,
    required this.child,
    this.ripplesCount = 5,
    this.color = const Color(0x2ABCB8B8),
  });
  final double? height;
  final Widget child;
  final int ripplesCount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateX(3.14159 / 2.2)
            ..rotateZ(3.14159 * 2),
          child:  RippleAnimation(
            repeat: true,
            ripplesCount: ripplesCount,
            duration: const Duration(milliseconds: 2800),
            color: color,
            child: Container(
              height: 40,
            ),
          ),
        ),
        child
      ],
    );
  }
}
