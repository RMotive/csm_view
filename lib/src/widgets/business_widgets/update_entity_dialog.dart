import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Dialog;

///
final class UpdateEntityDialog<TEntity extends IEntity<TEntity>> extends StatelessWidget {
  /// Dialog title.
  final String? title;

  /// Differences found during update process to confirm.
  final List<ObjectDifference> differences;

  ///  Creates a new instance.
  UpdateEntityDialog({
    super.key,
    this.title,
    required this.differences,
  });

  @override
  Widget build(BuildContext context) {
    return DialogView(
      title: title ?? 'Confirm $TEntity edit',
      acceptLabel: 'Edit',
      showCancelButton: true,
      child: EntityDifferencesTreeView(
        differences: differences,
      ),
    );
  }
}
