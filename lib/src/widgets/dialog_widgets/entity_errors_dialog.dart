import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Dialog, Router;
import 'package:go_router/go_router.dart';

/// {widget} class. Builds a widget dialog to show to the user a list of invalidations.
final class EntityErrorsDialog extends StatelessWidget {
  /// Dialog title.
  final String title;

  /// content header text.
  final String? header;

  /// Invalidation list.
  final List<EntityErrors<Object>> errors;

  /// Current context to show the dialog.
  final BuildContext context;

  const EntityErrorsDialog({
    super.key,
    required this.title,
    required this.errors,
    required this.context,
    this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      showCancelButton: false,
      title: title,
      content: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
              text: '${header != null ? '$header\n\n' : ''}Invalid values found, Verify the following values and try again:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              children: List<TextSpan>.generate(
                errors.length,
                (int index) => TextSpan(
                  text: '\n\u2022 ${errors[index].property.name}: ${errors[index].reason}',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ))),
      themingData: ThemingUtils.get(context).controlError,
      onAccept: context.pop,
    );
  }
}
