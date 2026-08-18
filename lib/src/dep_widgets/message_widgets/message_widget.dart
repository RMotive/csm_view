import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Draws a designed message displayed box mainly to let user know important things.
final class MessageWidget extends StatelessWidget {
  /// Message text.
  final String text;

  /// When set, fixes the [Widget] height.
  final double? height;

  /// When set, fixes the [Widget] width.
  final double? width;

  /// Draws a [Widget] inner padding.
  final EdgeInsets padding;

  /// When set overrides the theme data to use.
  /// When not set, the [FoundationThemeB.control] theme data will be used.
  ///
  /// It uses:
  ///
  ///   - [SimpleTheming.accent] to define border color.
  ///
  ///   - [SimpleTheming.fore] to define text color.
  ///
  ///   - [SimpleTheming.back] to define background color (applies a 30% oppacity filter).
  final ThemingData? themeData;

  /// Creates a new [MessageWidget] instance.
  const MessageWidget({
    super.key,
    this.width,
    this.height,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 8,
    ),
    this.themeData,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    ThemingData themeData = this.themeData ?? ThemingUtils.get<IThemeData>(context).control;
    EdgeInsets padding = this.padding;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: themeData.back.withValues(
          alpha: .3,
        ),
        border: Border.fromBorderSide(
          BorderSide(
            color: themeData.accent,
            width: 2,
          ),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: padding,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: themeData.fore,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
