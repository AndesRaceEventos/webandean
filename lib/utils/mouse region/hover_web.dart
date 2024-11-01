import 'package:webandean/provider/mouse%20region/provider_hover_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HoverableWidget extends StatelessWidget {
  final Widget child;
 
  HoverableWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    final hoverProvider = Provider.of<HoverProvider>(context, listen: false);
    bool isHovered = hoverProvider.isHovered;
    return MouseRegion(
      onEnter: (event) => hoverProvider.setHovered(true),
      onExit: (event) => hoverProvider.setHovered(false),
      child: Consumer<HoverProvider>(
        builder: (context, hoverProvider, _) {
          return AnimatedOpacity(
            opacity: hoverProvider.isHovered ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            child:!isHovered ? child : SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
