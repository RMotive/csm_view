import 'package:csm_view/src/widgets/form_widgets/form_area/form_controller.dart';
import 'package:flutter/material.dart';

export 'form_controller.dart';

/// Draws a [Widget] that handles a [Form] area with its [child].
final class FormArea extends StatelessWidget {
  /// Controller.
  final FormController controller;

  /// Child content.
  final Widget child;

  /// Creates a new instance.
  const FormArea({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.key,
      autovalidateMode: controller.validateMode,
      canPop: controller.canDismiss,
      onChanged: controller.onChange,
      onPopInvokedWithResult: controller.onPop,
      child: child,
    );
  }
}
