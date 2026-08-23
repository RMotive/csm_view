import 'package:csm_view/src/widgets/abstractions/interfaces/ireactor.dart';
import 'package:flutter/material.dart';

/// [interface] for [IReactiveWidget].
///
///
/// Defines behavior for a [IReactiveWidget] implementation wich is a [Widget] that handles state management internally
/// independent from the route tree rebuild.
abstract interface class IReactiveWidget<T extends IReactor> {
  /// [Widget] reactor.
  final T reactor;

  /// Creates a new [IReactiveWidget] instance.
  const IReactiveWidget(this.reactor);

  /// [Widget] view building proxy to rebuild after a [reactor] instruction.
  Widget compose(BuildContext ctx, T reactor);
}
