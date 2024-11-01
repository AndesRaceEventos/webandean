import 'package:flutter/material.dart';

class AssetTextSelectionRegion extends StatelessWidget {
  const AssetTextSelectionRegion({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SelectableRegion(
        focusNode: FocusNode(),
        selectionControls: materialTextSelectionControls,
        child: child);
  }
}
