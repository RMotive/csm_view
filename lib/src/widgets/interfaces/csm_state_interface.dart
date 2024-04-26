/// Interface for [CSMState].
///
/// Defines base behavior for [CSMState] implementations.
///
/// [CSMState] concept: represents a component state properties, effects, etc.
/// Here is usually stored required options, objects, etc to build the UI and methods to request the redraw of the component.
abstract interface class CSMStateInterface {
  /// Request to the [CSMStateHandler] to redraw.
  void effect();
}
