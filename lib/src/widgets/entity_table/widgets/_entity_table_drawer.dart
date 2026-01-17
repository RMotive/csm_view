part of '../entity_table.dart';

/// {widget} class.
///
/// [TEntity] type of the business entity to handle.
///
/// Draws a details animated drawer for [EntityTable] when an [TEntity] is selected.
final class _EntityTableDrawer<TEntity extends IEntity<TEntity>> extends StatefulWidget {
  /// Current displayed [TEntity] instance details.
  final int? selReference;

  /// [EntityTable] adapter to handle every possible interaction with the entities displayed.
  final IEntityTableAdapter<TEntity> adapter;

  /// Event callback when close drawer action button is invoked.
  final void Function() onCloseDrawer;

  /// [EntityTable] invokation for the [TEntity] scoped [ViewServiceI.view].
  final Future<ViewOutput<TEntity>> viewInvokation;

  /// Creates a new [_EntityTableDrawer] instance.
  const _EntityTableDrawer({
    required this.adapter,
    required this.selReference,
    required this.onCloseDrawer,
    required this.viewInvokation,
  });

  @override
  State<_EntityTableDrawer<TEntity>> createState() => _EntityTableDrawerState<TEntity>();
}

/// {state} class.
///
/// Handles [State] behavior for [_EntityTableDrawer] widget.
final class _EntityTableDrawerState<TEntity extends IEntity<TEntity>> extends State<_EntityTableDrawer<TEntity>> {
  /// {ref} [State] theming effect reference.
  final UniqueKey themingRef = UniqueKey();

  /// {state} current deleter adaption options.
  late EntityTableAdapterDeleter<TEntity>? deleterAdaption;

  /// {state} current editor adaption options.
  late EntityTableAdapterEditor<TEntity>? editorAdaption;

  /// {state} current error theming information.
  late ThemingData errTheming;

  /// {state} whether the drawer [TEntity] details is on {edition} mode.
  bool editMode = false;

  /// Composes the {state} properties related with the [EntityTable] adaption configurations.
  void composeAdaption() {
    deleterAdaption = widget.adapter.composeDeleter();
    editorAdaption = widget.adapter.composeEditor();
  }

  @override
  void initState() {
    super.initState();
    composeAdaption();
  }

  @override
  void didChangeDependencies() {
    errTheming = ThemingUtils.get(context).controlError;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant _EntityTableDrawer<TEntity> oldWidget) {
    if (oldWidget.adapter != widget.adapter) {
      composeAdaption();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BorderedBox(
      padding: const EdgeInsets.all(12.0),
      child: AsyncWidget<ViewOutput<TEntity>>(
        future: widget.viewInvokation,
        errorBuilder: (_, __, ___) => _EntityTableErrorIndicator(),
        loadingBuilder: (_) => _EntityTableLoadingIndicator(),
        successBuilder: (BuildContext buildContext, ViewOutput<TEntity> data) {
          final TEntity? entityRef = widget.selReference == null ? null : data.entities[widget.selReference as int];

          return Column(
            spacing: 30,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// --> Drawer header section
              Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  /// --> Drawer header title.
                  Text(
                    editMode ? 'Editing $TEntity' : '$TEntity Details',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  /// --> Drawer header actions.
                  if (entityRef != null)
                    Expanded(
                      child: Row(
                        spacing: 6,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          /// --> View Mode ACtions.
                          if (!editMode) ...<Widget>[
                            /// ---> Edit Action
                            if (editorAdaption != null)
                              _EntityTableDrawerAction(
                                action: 'Edit $TEntity',
                                icon: Icons.edit_outlined,
                                onClick: () {
                                  setState(() {
                                    editMode = true;
                                  });
                                },
                              ),

                            /// ---> Remove Action
                            if (deleterAdaption != null)
                              _EntityTableDrawerAction(
                                icon: Icons.delete_forever_outlined,
                                action: 'Delete',
                                fore: errTheming.fore,
                                onClick: () => deleterAdaption?.callback(buildContext, entityRef),
                              ),                            
                            
                            /// --> Close Action
                            _EntityTableDrawerAction(
                              fore: errTheming.fore,
                              action: 'Close Details',
                              onClick: widget.onCloseDrawer,
                              icon: Icons.arrow_right_sharp,
                            ),
                          ]

                          /// --> Edit Mode Actions.
                          else ...<Widget>[
                            /// --> Save Edit Action
                            _EntityTableDrawerAction(
                              action: 'Save Edition',
                              icon: Icons.save_as_outlined,
                              onClick: () => editorAdaption?.onUpdate(context, entityRef),
                            ),

                            /// --> Cancel Edit Mode Action
                            _EntityTableDrawerAction(
                              action: 'Canel Edition',
                              icon: Icons.cancel_outlined,
                              fore: errTheming.accent,
                              onClick: () {
                                setState(() {
                                  editMode = false;
                                });
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                ],
              ),

              // --> Details custom content
              if (entityRef != null)
                Expanded(
                  child: Visibility(
                    visible: editMode,
                    child: editorAdaption?.formBuilder.call(buildContext, entityRef) ?? SizedBox(),
                    replacement: widget.adapter.composeViewer(buildContext, entityRef),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
