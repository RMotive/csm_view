import 'package:csm_foundation_view/src/widgets/bases/widgets_bases_module.dart';
import 'package:flutter/material.dart';

/// Widget class for [CSMDynamicWidget].
///
/// Defines UI for a [CSMDynamicWidget] implementation.
///
/// [TData] - The type of data to be consumed.
///
/// [CSMDynamicWidget] concept: defines an usable component to implement a [CSMDynamicWidgetBase] widget
/// to handle dynamic [state] with specific scope [state] uses cases.
///
/// [NOTE:] This was created due to the [CSMPage] cannot extend from another class and in some user cases it
/// needs to be dynamic with this specific [state] context scope.
final class CSMDynamicWidget<T extends CSMStateBase> extends CSMDynamicWidgetBase<T> {
  /// UI desginer, how the widget will look like.
  final Widget Function(BuildContext ctx, T state) designer;

  /// Generates a new [CSMDynamicWidget] widget.
  const CSMDynamicWidget({
    super.key,
    required super.state,
    required this.designer,
  });

  @override
  Widget compose(BuildContext ctx, T state) => designer(ctx, state);
}
