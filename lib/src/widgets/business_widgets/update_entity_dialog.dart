import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Dialog;

///
final class UpdateEntityDialog<TEntity extends IEntity<TEntity>> extends StatelessWidget {
  /// Dialog title.
  final String? title;

  ///  Creates a new instance.
  UpdateEntityDialog({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return DialogView(
      title: title ?? 'Confirm $TEntity edit',
      acceptLabel: 'Edit',
      showCancelButton: true,
    );
  }
}
