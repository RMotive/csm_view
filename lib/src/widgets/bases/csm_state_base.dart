import 'package:csm_foundation_view/src/widgets/interfaces/csm_state_interface.dart';
import 'package:flutter/foundation.dart';

/// Base for [CSMState].
///
/// Represents a state notifier for an use of [CSMStateHandler] widget for [CSMState].
///
/// [CSMState] concept: represents a component state properties, effects, etc.
/// Here is usually stored required options, objects, etc to build the UI and methods to request the redraw of the component.
abstract class CSMStateBase extends ChangeNotifier implements CSMStateInterface {
  @override
  @Deprecated('Wrong lexical CSM use, better use effect()')
  void notifyListeners() => effect();

  /// Request to the [CSMStateHandler] to redraw.
  @override
  void effect() {
    super.notifyListeners();
  }
}
