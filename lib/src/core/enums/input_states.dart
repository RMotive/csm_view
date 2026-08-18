import 'package:csm_view/csm_view.dart';

/// Enum for [InputStates].
///
/// Defines an enumerator for [InputStates] implementation.
///
/// [InputStates] concept: describes a control state.
enum InputStates {
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
      case InputStates.hovered:
        return onHover ?? onIdle;
      case InputStates.selected:
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
      case InputStates.hovered:
        return onHover?.call() ?? onIdle();
      case InputStates.selected:
        return onSelect?.call() ?? onIdle();
      default:
        return onIdle();
    }
  }

  /// Evaluates the given [options] to calculate a resolved [CSMGenericThemeOptions] by the current state.
  InputControlTheming evaluateTheme(StateControlTheming options) {
    switch (this) {
      case InputStates.hovered:
        return options.hovered ?? options.main;
      case InputStates.selected:
        return options.selected ?? options.main;
      default:
        return options.main;
    }
  }
}
