import 'package:csm_foundation_view/src/widgets/models/options/widgets_models_options_module.dart';
import 'package:flutter/material.dart';

/// Widget class for [CSMForm].
///
/// Defines UI for a [CSMForm] implementation.
///
/// [CSMForm] concept: creates a [Form] concept manager, providing features to handle validations,
/// state management and submittion..
final class CSMForm extends StatelessWidget {
  /// Options to indicate how to behave.
  final CSMFormOptions options;

  /// The form context UI to draw.
  final Widget child;

  /// Generates a new [CSMForm] widget.
  const CSMForm({
    super.key,
    required this.child,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: options.key,
      autovalidateMode: options.validateMode,
      canPop: options.canDismiss,
      onChanged: options.onChange,
      onPopInvoked: options.onPop,
      child: child,
    );
  }
}
