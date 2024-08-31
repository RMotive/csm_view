import 'package:csm_view/src/theme/theme_module.dart';
import 'package:flutter/material.dart';

/// Options class for [CSMStateTheme].
///
/// Defines specifications for a [CSMStateTheme].
///
/// [CSMStateTheme] concept: specifications to describe the base theme for a state component.
/// this means there will be a base theme per state to be resolved by the current component state.
final class CSMStateThemeOptions {
  /// The button default state theme to use.
  ///
  /// If there's not another state defined, but the control is in one of the other
  /// states, will use this[main] as default values.
  final CSMGenericThemeOptions main;

  /// Defines a theme struct for the control when it is hovered.
  final CSMGenericThemeOptions? _hovered;

  /// Defines a theme struct for the control when it is hovered.
  CSMGenericThemeOptions? get hovered {
    if (_hovered == null) return null;

    Color? background = _hovered.background;
    Color? foreground = _hovered.foreground;
    TextStyle? textStyle = _hovered.textStyle;

    return _hovered.replace(
      background: background ?? main.background,
      foreground: foreground ?? main.foreground,
      textStyle: textStyle ?? main.textStyle,
    );
  }

  /// Defines a theme struct for the control when it is selected.
  final CSMGenericThemeOptions? _selected;

  /// Defines a theme struct for the control when it is selected.
  CSMGenericThemeOptions? get selected {
    if (_selected == null) return null;

    Color? background = _selected.background;
    Color? foreground = _selected.foreground;
    TextStyle? textStyle = _selected.textStyle;

    return _selected.replace(
      background: background ?? main.background,
      foreground: foreground ?? main.foreground,
      textStyle: textStyle ?? main.textStyle,
    );
  }

  /// Generates a new [CSMStateThemeOptions] options.
  const CSMStateThemeOptions({
    required this.main,
    CSMGenericThemeOptions? hoverStruct,
    CSMGenericThemeOptions? selectStruct,
  })  : _selected = selectStruct,
        _hovered = hoverStruct;
}
