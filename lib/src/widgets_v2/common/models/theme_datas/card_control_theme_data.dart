import 'package:flutter/material.dart';

/// Represents a theme data configuration for a Card Control [Widget].
final class CardControlThemeData {
  /// Background color.
  final Color? bgColor;

  /// Text style.
  final TextStyle? txtStyle;

  /// Border color.
  final Color? borderColor;

  /// Create a new instance.
  const CardControlThemeData({
    this.bgColor,
    this.txtStyle,
    this.borderColor,
  });
}
