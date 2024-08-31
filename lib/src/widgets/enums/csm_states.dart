import 'package:csm_view/src/theme/theme_module.dart';

/// Enum for [CSMStates].
///
/// Defines an enumerator for [CSMStates] implementation.
///
/// [CSMStates] concept: describes a control state.
enum CSMStates {
  hovered,
  selected,
  none;

  /// Evaluates the values per state.
  T evaluate<T>({
    T? onHover,
    T? onSelect,
    required T onIdle,
  }) {
    switch (this) {
      case CSMStates.hovered:
        return onHover ?? onIdle;
      case CSMStates.selected:
        return onSelect ?? onIdle;
      default:
        return onIdle;
    }
  }

  /// Evaluates the factories per state.
  T evaluateFactories<T>({
    T Function()? onHover,
    T Function()? onSelect,
    required T Function() onIdle,
  }) {
    switch (this) {
      case CSMStates.hovered:
        return onHover?.call() ?? onIdle();
      case CSMStates.selected:
        return onSelect?.call() ?? onIdle();
      default:
        return onIdle();
    }
  }

  /// Evaluates the given [options] to calculate a resolved [CSMGenericThemeOptions] by the current state.
  CSMGenericThemeOptions evaluateTheme(CSMStateThemeOptions options) {
    switch (this) {
      case CSMStates.hovered:
        return options.hovered ?? options.main;
      case CSMStates.selected:
        return options.selected ?? options.main;
      default:
        return options.main;
    }
  }
}
