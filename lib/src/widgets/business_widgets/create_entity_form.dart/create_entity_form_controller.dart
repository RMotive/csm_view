import 'package:flutter/foundation.dart';

/// [class] implementation.
///
/// Implements a proxy controller to handle and interact with a [CreateEntityForm] outside the scope.
final class CreateEntityFormController extends ChangeNotifier {
  /// Creates a new [CreateEntityFormController] instance.
  CreateEntityFormController();

  /// Triggers a [create] {event} invokation at the [CreateEntityForm] controlled.
  void create() {
    notifyListeners();
  }
}
