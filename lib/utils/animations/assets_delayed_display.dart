import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';

class AssetsDelayedDisplayX extends StatelessWidget {
  const AssetsDelayedDisplayX(
      {super.key,
      required this.child,
      required this.duration,
      this.fadingDuration = 2500,
      this.curve = Curves.ease});
  final Widget child;
  final int fadingDuration;
  final int duration;
  final Curve curve;
  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
        slidingBeginOffset: Offset(-5, 0),
        slidingCurve: curve,
        fadeIn: true,
        fadingDuration: Duration(milliseconds: fadingDuration),
        delay: Duration(
          milliseconds: duration,
        ),
        child: child);
  }
}

class AssetsDelayedDisplayYbasic extends StatelessWidget {
  const AssetsDelayedDisplayYbasic(
      {super.key,
      required this.child,
      required this.duration,
      this.fadingDuration = 1500, this.curve = Curves.decelerate});
  final Widget child;
  final int duration;
  final int fadingDuration;
   final Curve curve;
  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      slidingCurve: curve,
        delay: Duration(milliseconds: duration),
        // slidingCurve: Curves.elasticOut,
        fadeIn: true,
        fadingDuration: Duration(milliseconds: fadingDuration),
        child: child);
  }
}
