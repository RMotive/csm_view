import 'package:flutter/material.dart';

/// Represents a [ReactorWidget]'s reactor to manage inner states.
abstract interface class IReactor implements Listenable {
  /// Indicates a state recalculation instruction.
  void react();
}

/// Represents a [ReactorWidget]'s reactor to manage inner states.
abstract class ReactorBase extends ChangeNotifier implements IReactor {
  @override
  @Deprecated('Wrong lexical CSM use, better use effect()')
  void notifyListeners() => react();

  @override
  void react() {
    super.notifyListeners();
  }
}

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

/// [abtract] for [ReactiveWidgetBase].
///
///
/// Defines and handles base behavior for [ReactiveWidgetBase] implementations, wich are [Widget] that handles and manipulates
/// states internally independant from outside [Widget] tree rebuilds, restoring after a view refresh.
abstract class ReactiveWidgetBase<T extends IReactor> extends StatelessWidget implements IReactiveWidget<T> {
  /// [Widget] reactor.
  @override
  final T reactor;

  /// Creates a new [ReactiveWidgetBase] widget.
  const ReactiveWidgetBase({
    super.key,
    required this.reactor,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: reactor,
      builder: (BuildContext ctx, _) {
        return compose(ctx, reactor);
      },
    );
  }

  @override
  Widget compose(BuildContext ctx, T state);
}

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
