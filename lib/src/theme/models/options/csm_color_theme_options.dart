import 'package:flutter/material.dart';

/// Options class for [CSMColorTheme].
///
/// Defines specifications for a [CSMColorTheme].
///
/// [CSMColorTheme] concept: specifications to describe the base theme for a button component.
final class CSMColorThemeOptions {
  /// Base [Color] usually known as [background].
  final Color main;

  /// A secondary [Color] usually contrast when its over [main]-[Color].
  final Color fore;

  /// An alternative [fore]-[Color].
  final Color? foreAlt;

  /// A [highlight], [Color] that contrast both [main] and [fore]. [Color]'s.
  final Color highlight;

  /// An alternative [highlight], [Color].
  final Color? hightlightAlt;

  /// Generates a new [CSMColorThemeOptions] options.
  const CSMColorThemeOptions(
    this.main,
    this.fore,
    this.highlight, {
    this.foreAlt,
    this.hightlightAlt,
  });
}
