import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// {widget} class.
///
/// Draws a {CSM} visual design pattern for a bordered box.
final class BorderedBox extends StatelessWidget {
  /// Wrapped widget bordered box.
  final Widget child;

  /// Border color, if not given will be used [FoundationThemeB.page] {fore} theming options.
  final Color? color;

  /// Border width size.
  final double borderWidth;

  /// Content [child] padding.
  final EdgeInsets padding;

  /// Creates a new [BorderedBox] instance.
  const BorderedBox({
    super.key,
    this.color,
    this.borderWidth = .75,
    this.padding = const EdgeInsets.only(
      top: 8,
    ),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = color ?? ThemingUtils.get<IThemeData>(context).page.fore;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
