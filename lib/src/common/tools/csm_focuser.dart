import 'package:flutter/widgets.dart';

/// Tool class for [CSMFocuser].
///
/// Defines final behavior for [CSMFocuser] tool object instances.
///
/// [CSMFocuser] concept: provides useful methods to handle focusing actions alog focus application system.
final class CSMFocuser {
  /// Sets the focus to the given [node].
  static void focus(FocusNode node) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      node.requestFocus();
    });
  }

  /// Removes the focus from the given [node].
  static void unfocus(FocusNode node) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      node.unfocus();
    });
  }
}
