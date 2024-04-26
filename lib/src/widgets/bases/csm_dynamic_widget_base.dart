import 'package:csm_foundation_view/src/widgets/bases/csm_state_base.dart';
import 'package:csm_foundation_view/src/widgets/interfaces/csm_dynamic_widget_interface.dart';
import 'package:flutter/widgets.dart';

/// Widget class for [CSMDynamicWidget].
///
/// Defines UI for a [CSMDynamicWidget] implementation.
///
/// [CSMDynamicWidget] concept: generates a handler to listen effect request to redraw components.
abstract class CSMDynamicWidgetBase<T extends CSMStateBase> extends StatelessWidget implements CSMDynamicWidgetInterface<T> {
  /// State to receive redraw request through [effect]´s.
  @override
  final T state;

  /// Generates a new [CSMDynamicWidgetBase] widget.
  const CSMDynamicWidgetBase({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: state,
      builder: (BuildContext ctx, _) {
        return compose(ctx, state);
      },
    );
  }

  @override
  Widget compose(BuildContext ctx, T state);
}
