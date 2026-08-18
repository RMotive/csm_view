part of '../entity_table.dart';

/// {widget} class.
///
/// Draws the columns titles and table header for [EntityTable].
final class _EntityTableHeader<TEntity extends IEntity<TEntity>> extends StatelessWidget {
  /// Configrued [EntityTable] managed columns.
  final List<EntityTableColumnData<TEntity>> columns;

  /// Creates a new [_EntityTableHeader] instance.
  const _EntityTableHeader({
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeManager themeManager = ThemeManager.of(context);

    return LayoutBuilder(
      builder: (_, BoxConstraints boxConstraints) {
        boxConstraints = boxConstraints.boxed();

        final Size boxSize = boxConstraints.biggest;
        final double colWidth = boxSize.width / columns.length;

        return DecoratedBox(
          decoration: const BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(width: 1, color: Colors.blueGrey),
            ),
          ),
          child: Row(
            children: <Widget>[
              for (int cont = 0; cont < columns.length; cont++)
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: columns[cont].width ?? _kColumnWidth,
                  ),
                  child: SizedBox(
                    width: columns[cont].width ?? colWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 8,
                      ),
                      child: Text(
                        columns[cont].title,
                        style: TextStyle(
                          color: themeManager.castData<IThemeData>().page.fore,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
