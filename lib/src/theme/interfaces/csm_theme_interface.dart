import 'package:flutter/material.dart';

/// Interface for [CSMTheme].
///
/// Defines required behavior for a [CSMTheme] implementation.
///
/// [CSMTheme] concept: is a theme template and theme implementation to specify another theme instance along the application.
abstract interface class CSMThemeInterface {
  /// Unique theme identification for the theme manager.
  final String identifier;

  /// Color specified for the frame size display.
  final Color? frame;

  const CSMThemeInterface(this.identifier, this.frame);
}
