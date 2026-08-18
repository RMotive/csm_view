part of 'entity_differences_tree_view.dart';

/// Draws a [Widget] for [EntityDifferencesTreeView] that handles a level of the tree.
final class _EntityDifferencesTreeViewLevel extends StatelessWidget {
  /// Level current depth.
  final int depth;

  /// Entity differences.
  final List<ObjectDifference> differences;

  /// Creates a new instance.
  const _EntityDifferencesTreeViewLevel({
    required this.differences,
    required this.depth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: differences
          .map(
            (ObjectDifference diff) => Padding(
              padding: EdgeInsets.only(left: depth * 16.0),
              child: diff.innerDifferences == null
                  ? _EntityDifferencesTreeViewLeaf(
                      difference: diff,
                    )
                  : _EntityDifferencesTreeViewBranch(
                      difference: diff,
                      depth: depth,
                    ),
            ),
          )
          .toList(),
    );
  }
}
