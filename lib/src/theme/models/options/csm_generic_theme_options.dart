import 'package:flutter/material.dart';

/// Options class for [CSMGenericTheme].
///
/// Defines specifications for a [CSMGenericTheme].
///
/// [CSMGenericTheme] concept: specifications to describe the base theme for a generic component component.
final class CSMGenericThemeOptions {
  /// Defines the control surface color
  final Color? background;

  /// Defines the inner text color.
  final Color? foreground;

  /// Defines the control border color
  final Color? borderColor;

  /// Defines a reference into the assets to fetch an icon.
  final String? iconRef;

  /// Wheter the control has an icon can use this property
  /// if this property is unset, then will use [foreground].
  final Color? _iconColor;

  /// Wheter the control has an icon can use this property
  /// if this property is unset, then will use [foreground].
  Color get iconColor => _iconColor ?? foreground!;

  /// Defines the control inner text style that will be used.
  ///
  /// If the text style doesn't have defined a [color] then will be overriden with
  /// the property [foreground] from this instance.
  final TextStyle? _textStyle;

  /// [TextStyle] by the theme calculation.
  TextStyle? get textStyle {
    return _textStyle?.copyWith(
      color: _textStyle.color ?? foreground,
    );
  }

  /// Generates a new [CSMGenericThemeOptions] options.
  const CSMGenericThemeOptions({
    this.background,
    this.foreground,
    this.borderColor,
    this.iconRef,
    TextStyle? textStyle,
    Color? iconColor,
  })  : _textStyle = textStyle,
        _iconColor = iconColor;

  /// Generates a new [CSMGenericThemeOptions] as a factory.
  ///
  /// Replacing all the given properties with the previous existent ones.
  CSMGenericThemeOptions replace({
    Color? background,
    Color? foreground,
    Color? borderColor,
    String? iconRef,
    Color? iconColor,
    TextStyle? textStyle,
  }) {
    return CSMGenericThemeOptions(
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      borderColor: borderColor ?? this.borderColor,
      iconRef: iconRef ?? iconRef,
      iconColor: iconColor ?? _iconColor,
      textStyle: textStyle ?? _textStyle,
    );
  }
}
