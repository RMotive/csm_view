part of '../entity_table.dart';

/// {widget} class.
///
/// Draws the whole [EntityTable] content rows and their behavior.
final class _EntityTableContent<TEntity extends IEntity<TEntity>> extends StatefulWidget {
  /// If by default the given [TEntity] row is selected.
  final int? preSelect;

  /// Content entities to draw.
  final List<TEntity> entities;

  /// Columns configured for the table.
  final List<EntityTableColumnData<TEntity>> columns;

  ///
  final void Function(int? itemIndex)? onSelection;

  /// {event} triggered when a row is selected, overriding the default behavior of opening the details drawer with the selected entity data.
  final void Function(TEntity entity)? overrideTap;

  /// Creates a new [_EntityTableContent] instance.
  const _EntityTableContent({
    super.key,
    this.preSelect,
    this.onSelection,
    this.overrideTap,
    required this.columns,
    required this.entities,
  });

  @override
  State<_EntityTableContent<TEntity>> createState() => _EntityTableContentState<TEntity>();
}

/// {state} class.
///
/// Handles the [State] for [_EntityTableContent].
final class _EntityTableContentState<TEntity extends IEntity<TEntity>> extends State<_EntityTableContent<TEntity>> {
  /// {state} stores the current selected [TEntity] row reference.
  int? selEntity;

  @override
  void didUpdateWidget(covariant _EntityTableContent<TEntity> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entities != widget.entities) {
      selEntity = null;
    }

    if (oldWidget.preSelect != widget.preSelect) {
      selEntity = widget.preSelect;
    }
  }

  @override
  void initState() {
    if (widget.preSelect != null) {
      selEntity = widget.preSelect;
    }
    super.initState();
  }

  /// {event} triggered when a row is selected.
  ///
  ///
  /// [index] internal reference to detect row selected.
  ///
  /// [entity] object data reference selected.
  void onRowSelected(int index, TEntity entity) {
    final bool des = (index == selEntity);
    setState(() {
      selEntity = (des) ? null : index;
      widget.onSelection?.call(selEntity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints boxConstraints) {
        boxConstraints = boxConstraints.boxed();

        final double colWidth = boxConstraints.biggest.width / widget.columns.length;

        return SizedBox(
          height: boxConstraints.biggest.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 3,
              children: List<Widget>.generate(
                widget.entities.length,
                (int index) {
                  final TEntity entity = widget.entities[index];

                  final bool sel = selEntity == index;

                  return PointerArea(
                    cursor: SystemMouseCursors.click,
                    onClick: () => widget.overrideTap != null ? widget.overrideTap!(entity) : onRowSelected(index, entity),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: !sel ? null : Colors.blueGrey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        child: Row(
                          children: List<Widget>.generate(
                            widget.columns.length,
                            (int index) {
                              EntityTableColumnData<TEntity> column = widget.columns[index];

                              return ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: column.width ?? _kColumnWidth,
                                ),
                                child: SizedBox(
                                  width: column.width ?? colWidth,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 8,
                                    ),
                                    child: Builder(
                                      builder: (BuildContext context) {
                                        if (column.customFactory != null) {
                                          return column.customFactory!(entity, index, context);
                                        }

                                        final String cellValue = column.factory!(
                                              entity,
                                              index,
                                              context,
                                            ) ??
                                            '---';
                                        final Widget textWidget = Text(
                                          cellValue,
                                          maxLines: 2,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: ThemingUtils.get(context).page.fore,
                                          ),
                                        );
                                        return textWidget;
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
