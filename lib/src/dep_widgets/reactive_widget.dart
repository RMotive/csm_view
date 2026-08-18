import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// [Widget] class for [ReactiveWidget].
///
/// [T] the [reactor] type to be handled.
///
/// [ReactiveWidget] concept: defines an usable component to implement a [ReactiveWidgetB] widget
/// to handle dynamic [reactor] with specific scope [state] uses cases.
///
/// [NOTE:] This was created due to the [Page] cannot extend from another class and in some user cases it
/// needs to be dynamic with this specific [state] context scope.
final class ReactiveWidget<T extends IReactor> extends ReactiveWidgetBase<T> {
  /// [Widget] view builder method.
  final Widget Function(BuildContext ctx, T reactor) builder;

  /// Creates a new [ReactiveWidget] instance.
  const ReactiveWidget({
    super.key,
    required super.reactor,
    required this.builder,
  });

  @override
  Widget compose(BuildContext ctx, T state) => builder(ctx, state);
}
