part of 'entity_differences_tree_view.dart';

/// Draws a [Widget] for [EntityDifferencesTreeView], that displays and handles the recursivity of display for a
/// nested entity differences.
final class _EntityDifferencesTreeViewBranch extends StatefulWidget {
  /// Nested entity differences depth.
  final int depth;

  /// Entity differences.
  final ObjectDifference difference;

  /// Creates a new instance.
  const _EntityDifferencesTreeViewBranch({
    required this.difference,
    required this.depth,
  });

  @override
  State<_EntityDifferencesTreeViewBranch> createState() => _EntityDifferencesTreeViewBranchState();
}

/// [State] class for [_EntityDifferencesTreeViewBranch].
final class _EntityDifferencesTreeViewBranchState extends State<_EntityDifferencesTreeViewBranch> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final List<ObjectDifference> inner = widget.difference.innerDifferences ?? const <ObjectDifference>[];

    return Row(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PointerArea(
          onClick: () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: <Widget>[
                AnimatedRotation(
                  turns: _expanded ? 0.25 : 0.0,
                  duration: const Duration(milliseconds: 150),
                  child: Icon(
                    Icons.chevron_right,
                    color: ThemingUtils.get(context).page.fore,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.difference.property.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${inner.length} change${inner.length == 1 ? '' : 's'} inside',
                  ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(
                  milliseconds: 200,
                ),
                curve: Curves.easeInOut,
                child: ClipRect(
                  child: _expanded
                      ? _EntityDifferencesTreeViewLevel(
                          differences: inner,
                          depth: widget.depth,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
