import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

part '_entity_differences_tree_view_level.dart';
part '_entity_differences_tree_view_leaf.dart';
part '_entity_differences_tree_view_branch.dart';

/// Draws a [Widget], that shows a beatiful entity updated properties differences.
final class EntityDifferencesTreeView extends StatelessWidget {
  /// Entity differences.
  final List<ObjectDifference> differences;

  /// Creates a new instance.
  const EntityDifferencesTreeView({
    super.key,
    required this.differences,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: differences.isNotEmpty,
      replacement: Center(
        child: ErrorMessageWidget(
          message: 'No differences to show',
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: _EntityDifferencesTreeViewLevel(
            differences: differences,
            depth: 0,
          ),
        ),
      ),
    );
  }
}
