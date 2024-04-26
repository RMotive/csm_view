part of '../bases/csm_router_tree_base.dart';

/// Private class for [_CSMRoutingListener].
///
/// Defines final private behavior for a specific use of [_CSMRoutingListener].
///
/// [_CSMRoutingListener] concept: a necessary implementation of a contract to listen
/// at [RoutingConfig] notifications sent by the [RoutingConfig] abstraction implementation over
/// the native functions.
final class _CSMRoutingListener extends ValueListenable<RoutingConfig> {
  const _CSMRoutingListener(this.value);

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}

  @override
  final RoutingConfig value;
}
