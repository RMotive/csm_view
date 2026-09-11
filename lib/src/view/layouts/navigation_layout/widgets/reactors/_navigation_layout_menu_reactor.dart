part of '../../navigation_layout.dart';

/// Represents a scoped state management reactor for the { Navigation Layout }.
final class _NavigationLayoutMenuReactor extends ReactorBase {
  /// Whether currently the Navigation Menu is visible.
  bool _isOpen = true;

  /// Toogles the current Navigation Menu state.
  void toogle() {
    _isOpen = !_isOpen;
    react();
  }
}
