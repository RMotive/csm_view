import 'package:csm_foundation_view/src/widgets/interfaces/csm_state_interface.dart';
import 'package:flutter/material.dart';

/// Interface for [CSMDynamicWidget].
///
/// Defines base behavior for [CSMDynamicWidget] implementations.
///
/// [CSMDynamicWidget] concept: generates a handler to listen effect request to redraw components.
abstract interface class CSMDynamicWidgetInterface<T extends CSMStateInterface> {
  /// State to receive redraw request through [effect]´s.
  final T state;

  const CSMDynamicWidgetInterface(this.state);

  /// Indicates to subclass design its UI based on the given state[T].
  Widget compose(BuildContext ctx, T state);
}
