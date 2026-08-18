import 'package:flutter/material.dart';

/// Options class for [CSMColorTheme].
///
/// Defines specifications for a [CSMColorTheme].
///
/// [CSMColorTheme] concept: specifications to describe the base theme for a button component.
final class ThemingData {
  /// Base [Color] usually known as [background].
  final Color back;

  /// A secondary [Color] usually contrast when its over [back]-[Color].
  final Color fore;

  /// An alternative [fore]-[Color].
  final Color? foreAlt;

  /// A [accent], [Color] that contrast both [back] and [fore]. [Color]'s.
  final Color accent;

  /// An alternative [accent], [Color].
  final Color? accentAlt;

  /// Generates a new [ThemingData] options.
  const ThemingData({
    this.foreAlt,
    this.accentAlt,
    required this.back,
    required this.fore,
    required this.accent,
  });
}
