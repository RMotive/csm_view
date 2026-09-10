import 'package:flutter/widgets.dart';

/// [utils] for Widget Focus.
///
/// Provides a better methods to communicate with the native [Flutter] focus system for [FocusNode].
final class WidgetFocus {
  /// Schedules a focus instruction to the engine after the frame buildind/drawing finishes.
  ///
  /// [node] focus reference object to bind the correct [Widget] to set the focus.
  static void focus(FocusNode node) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        node.requestFocus();
      },
    );
  }

  /// Schedules an unfocus instruction to the engine after the framing drawing/building finishes.
  static void unfocus(FocusNode node) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        node.unfocus();
      },
    );
  }
}
