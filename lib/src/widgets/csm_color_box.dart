import 'package:flutter/material.dart';

/// Widget class for [CSMColorBox].
///
/// Defines UI for a [CSMColorBox] implementation.
///
/// [CSMColorBox] concept: draws a standard base UI for a colored box.
final class CSMColorBox extends StatelessWidget {
  /// [Widget] background color.
  final Color background;

  /// [Widget] specified size.
  final Size size;

  /// [Widget] content.
  final Widget? child;

  /// Generates a new [CSMColorBox] widget.
  const CSMColorBox({
    super.key,
    this.child,
    required this.size,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: background,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: child,
      ),
    );
  }
}
