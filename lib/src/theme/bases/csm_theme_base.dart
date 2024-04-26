import 'package:csm_foundation_view/src/theme/theme_module.dart';
import 'package:flutter/material.dart';

/// Base for [CSMTheme].
///
/// Defines base behavior for a [CSMTheme] implementation.
///
/// [CSMTheme] concept: is a theme template and theme implementation to specify another theme instance along the application.
abstract class CSMThemeBase implements CSMThemeInterface {
  /// Unique theme identification for the theme manager.
  @override
  final String identifier;

  /// Color specified for the frame size display.
  @override
  final Color? frame;

  /// Generates a new [CSMTheme] behavior handler.
  const CSMThemeBase(
    this.identifier, {
    this.frame,
  });
}
