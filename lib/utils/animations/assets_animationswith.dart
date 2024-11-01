
// import 'package:flutter/cupertino.dart';

// class AssetsAnimationSwitcher extends StatelessWidget {
//   const AssetsAnimationSwitcher({
//     super.key,
//     required this.child,
//     this.duration = 2000,
//     this.switchOutCurve = Curves.linear,
//     this.switchInCurve = Curves.linear,
//     this.isTransition = false, // Valor predeterminado para evitar null
//   });

//   final Widget child;
//   final int duration;
//   final Curve switchOutCurve;
//   final Curve switchInCurve;
//   final bool isTransition; // Valor predeterminado para evitar null

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSwitcher(
//       switchOutCurve: switchOutCurve,
//       switchInCurve: switchInCurve,
//       duration: Duration(milliseconds: duration),
//       transitionBuilder: (Widget child, Animation<double> animation) {
//         if (isTransition) {
//           return SlideTransition(
          
//             position: Tween<Offset>(
//               begin: Offset(1, 0), // Desplazamiento desde la derecha
//               end: Offset.zero,
//             ).animate(animation),
//             child: child,
//           );
//         } else {
//           return FadeTransition(
//             opacity: animation,
//             child: ScaleTransition(
//               alignment: Alignment.topCenter,
//               scale: animation,
//               child: child,
//             ),
//           );
//         }
//       },
//       child: child,
//     );
//   }
// }

import 'package:flutter/cupertino.dart';

class AssetsAnimationSwitcher extends StatelessWidget {
  const AssetsAnimationSwitcher({
    super.key,
    required this.child,
    this.duration = 2000,
    this.switchOutCurve = Curves.linear,
    this.switchInCurve = Curves.linear,
    this.isTransition = false, // Valor predeterminado para evitar null
    this.directionLeft = false, // Valor predeterminado para evitar null
  });

  final Widget child;
  final int duration;
  final Curve switchOutCurve;
  final Curve switchInCurve;
  final bool isTransition;
  final bool directionLeft;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchOutCurve: switchOutCurve,
      switchInCurve: switchInCurve,
      duration: Duration(milliseconds: duration),
      transitionBuilder: (Widget child, Animation<double> animation) {
        // Añadiendo una transición de opacidad a las animaciones existentes
        return FadeTransition(
          opacity: animation,
          child: isTransition
              ? SlideTransition(
                  position: Tween<Offset>(
                    begin:directionLeft ? const Offset(-1, 0) : const Offset(1, 0), // Desde la derecha
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                )
              : ScaleTransition(
                  alignment: Alignment.topCenter,
                  scale: animation,
                  child: child,
                ),
        );
      },
      child: child,
    );
  }
}

