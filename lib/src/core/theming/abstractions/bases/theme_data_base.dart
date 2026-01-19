import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a theming data.
abstract class ThemeDataBase implements IThemeData {
  /// Icon to represent visually the theme context.
  @override
  final Icon icon;

  /// Color specified for the frame size display.
  @override
  final Color? frame;

  /// Unique theme identification for the theme manager.
  @override
  final String identifier;

  /// Contrast background color to highlight [icon].
  @override
  final Color iconBackground;

  /// Theming data for all the application pages.
  @override
  final ThemingData page;

  /// Theming data for all application primary controls.
  @override
  final ThemingData control;


  /// Theming data for dialogs.
  @override
  final ThemingData dialog;

  /// Theming data for all application primary controls when they are at { error } state.
  @override
  final ThemingData controlError;

  /// Theming data for all application primary controls when they are at { success } state.
  @override
  final ThemingData controlSuccess;

  /// Theming data for all application primary controls when they are at { disabled } state.
  @override
  final ThemingData controlDisabled;

  /// Creates a new instance.
  const ThemeDataBase(
    this.identifier, {
    this.frame,
    required this.icon,
    required this.page,
    required this.dialog,
    required this.control,
    required this.controlError,
    required this.controlSuccess,
    required this.iconBackground,
    required this.controlDisabled,
  });
}
