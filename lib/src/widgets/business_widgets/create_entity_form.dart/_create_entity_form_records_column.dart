part of 'create_entity_form.dart';

/// {widget} class.
///
/// [_CreateEntityFormRecordsColumn] Section to display the [TModel] item value based on [itemDesigner] method.
final class _CreateEntityFormRecordsColumn<TEntity extends EntityI<TEntity>> extends StatefulWidget {
  /// Section width.
  final double width;

  /// Custom item designer.
  final RecordDesigner<TEntity> recordDesigner;

  /// State values for added items.
  final List<CreateEntityFormRecordReactor<TEntity>> recordReactors;

  /// Callback to add a new item.
  final void Function() onAdd;

  /// Callback to remove the current item.
  final void Function() onRemove;

  /// Callback to select the current item.
  final void Function(CreateEntityFormRecordReactor<TEntity> selected) onSelect;

  /// Creates a new [_CreateEntityFormRecordsColumn] instance.
  const _CreateEntityFormRecordsColumn({
    required this.width,
    required this.recordReactors,
    required this.recordDesigner,
    required this.onAdd,
    required this.onRemove,
    required this.onSelect,
  });

  @override
  State<_CreateEntityFormRecordsColumn<TEntity>> createState() => _CreateEntityFormRecordsColumnState<TEntity>();
}

/// {state} class.
///
/// Handles [State] for [_CreateEntityFormRecordsColumn].
final class _CreateEntityFormRecordsColumnState<TEntity extends EntityI<TEntity>>
    extends State<_CreateEntityFormRecordsColumn<TEntity>> {
  ///
  late FoundationThemeB theming = Theming.get<FoundationThemeB>(context);

  ///
  late List<CreateEntityFormRecordReactor<TEntity>> recordReactors = widget.recordReactors;

  /// {state} stores the current selected record.
  int currRecordIdx = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theming = Theming.get<FoundationThemeB>(context);
  }

  @override
  Widget build(BuildContext context) {
    SimpleTheming dangerTheme = theming.error;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Column(
        spacing: 12,
        children: <Widget>[
          /// --> Actions Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 8,
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Records: (${recordReactors.length})',
                    style: TextStyle(
                      color: theming.page.fore,
                    ),
                  ),
                ),
                // --> Add item action
                PointerArea(
                  onClick:() {
                    currRecordIdx = recordReactors.length;
                    widget.onAdd();
                  },
                  cursor: SystemMouseCursors.click,
                  child: Icon(
                    Icons.add_circle,
                    size: 24,
                    color: theming.page.fore,
                  ),
                ),
                // --> Remove selection
                PointerArea(
                  onClick: widget.onRemove,
                  cursor: SystemMouseCursors.click,
                  child: Icon(
                    Icons.remove_circle,
                    size: 24,
                    color: dangerTheme.fore,
                  ),
                ),
              ],
            ),
          ),

          /// --> Stack Column
          Expanded(
            child: LayoutBuilder(
              builder: (_, BoxConstraints constrains) {
                final ScrollController ctrl = ScrollController();
                WidgetsBinding.instance.addPostFrameCallback((
                  Duration timestamp,
                ) {
                  ctrl.animateTo(
                    0,
                    duration: 300.miliseconds,
                    curve: Curves.easeOut,
                  );
                });

                return ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 0,
                    maxHeight: constrains.maxHeight,
                  ),
                  child: ListView.builder(
                    itemCount: recordReactors.length,
                    controller: ctrl,
                    itemBuilder: (BuildContext buildContext, int index) {
                      final bool currentActive = currRecordIdx == index;
                      return PointerArea(
                        cursor: currentActive ? MouseCursor.defer : SystemMouseCursors.click,
                        onClick: () {
                          currRecordIdx = index;
                          widget.onSelect(recordReactors[index]);                          
                        },
                        child: ReactiveWidget<CreateEntityFormRecordReactor<TEntity>>(
                          reactor: recordReactors[index],
                          builder: (BuildContext ctx, CreateEntityFormRecordReactor<TEntity> recordReactor) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: SizedBox(
                                width: widget.width,
                                child: widget.recordDesigner(
                                  recordReactor.entity,
                                  currentActive,
                                  recordReactor.isValid,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
