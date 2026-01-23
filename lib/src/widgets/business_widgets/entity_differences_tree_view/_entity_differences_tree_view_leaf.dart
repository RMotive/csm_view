part of 'entity_differences_tree_view.dart';

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
