import 'package:flutter/material.dart';

/// Represents a theme data for a stateful control type [Widget].
///
/// [TControlThemeData] defines the type of theme data the control uses.
///
///
/// The priority calculation is following meeting their conditions:
///
///   1. Disabled state.
///   2. Loading state.
///   3. Error state.
///   4. Hover & Focused state.
///   5. Hover & Selected state.
///   6. Focused
///   7. Selected
///   8. Hovered.
///   9. Default (idle) no state.
final class StatefulControlThemeData<TControlThemeData> {
  /// Theme data to use at any [WidgetState] when there's no
  /// a theme data configured for it, and used when the [Widget] is at no state (idle).
  final TControlThemeData $default;

  /// When the control has [WidgetState.hovered] state.
  final TControlThemeData atHover;

  /// When the control has [WidgetState.selected] state.
  final TControlThemeData atSelected;

  /// When the control has [WidgetState.focused] state.
  final TControlThemeData atFocused;

  /// When the control has [WidgetState.hovered] & [WidgetState.focused].
  final TControlThemeData? atHoverFocused;

  /// When the control has [WidgetState.hovered] & [WidgetState.selected].
  final TControlThemeData? atHoverSelected;

  /// When the control has [WidgetState.error].
  final TControlThemeData? atError;

  ///  When the control has [WidgetState.disabled].
  final TControlThemeData? atDisabled;

  /// When the control is loading.
  final TControlThemeData? atLoading;

  /// Creates a new instance.
  const StatefulControlThemeData({
    required this.$default,
    required this.atHover,
    required this.atFocused,
    required this.atSelected,
    this.atHoverFocused,
    this.atHoverSelected,
    this.atError,
    this.atLoading,
    this.atDisabled,
  });
}
