part of 'abstractions/bases/routing_graph_base.dart';

/// Private class for [_RouterListener].
///
/// Defines final private behavior for a specific use of [_RouterListener].
///
/// [_RouterListener] concept: a necessary implementation of a contract to listen
/// at [RoutingConfig] notifications sent by the [RoutingConfig] abstraction implementation over
/// the native functions.
final class _RouterListener extends ValueListenable<RoutingConfig> {
  const _RouterListener(this.value);

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}

  @override
  final RoutingConfig value;
}
