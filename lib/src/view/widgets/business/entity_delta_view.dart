import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Draws a [Widget], that shows a beatiful entity updated properties differences.
final class EntityDeltaView extends StatelessWidget {
  /// Entity differences.
  final List<ObjectDifference> differences;

  /// Creates a new instance.
  const EntityDeltaView({
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

/// Draws a [Widget] for [EntityDifferencesTreeView] that handles and shows a leaf in the tree for a property.
final class _EntityDifferencesTreeViewLeaf extends StatelessWidget {
  /// Entity differences.
  final ObjectDifference difference;

  /// Creates a new instance.
  const _EntityDifferencesTreeViewLeaf({
    required this.difference,
  });

  @override
  Widget build(BuildContext context) {
    IThemeData themeData = ThemingUtils.get(context);

    String displayOriginal = difference.originalValue?.toString() ?? "";
    String displayUpdated = difference.differenceValue?.toString() ?? "";

    Type propertyType = difference.property.type;
    if (propertyType == DateTime) {
      displayOriginal = (difference.originalValue as DateTime).toIso8601String();
      displayUpdated = (difference.differenceValue as DateTime).toIso8601String();
    }

    return Column(
      spacing: 2,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          difference.property.name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: <Widget>[
            Expanded(
              child: Text(
                displayOriginal,
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.arrow_right_alt,
              color: themeData.page.fore,
            ),
            Expanded(
              child: Text(
                displayUpdated,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: themeData.controlSuccess.fore,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

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
