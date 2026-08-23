import 'package:csm_view/src/widgets/abstractions/interfaces/ireactive_widget.dart';
import 'package:csm_view/src/widgets/abstractions/interfaces/ireactor.dart';
import 'package:flutter/widgets.dart';

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
