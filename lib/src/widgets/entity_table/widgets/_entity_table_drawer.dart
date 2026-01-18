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

  /// [TEntity] factory.
  final TEntity Function() factory;

  /// Event callback when close drawer action button is invoked.
  final void Function() onCloseDrawer;

  /// [EntityTable] invokation for the [TEntity] scoped [ViewServiceI.view].
  final Future<ViewOutput<TEntity>> viewInvokation;

  /// Creates a new [_EntityTableDrawer] instance.
  const _EntityTableDrawer({
    required this.adapter,
    required this.factory,
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
  bool isEditMode = false;

  /// Composes the {state} properties related with the [EntityTable] adaption configurations.
  void composeAdaption() {
    deleterAdaption = widget.adapter.composeDeleter();
    editorAdaption = widget.adapter.composeEditor();
  }

  @override
  void initState() {
    composeAdaption();
    super.initState();
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
  void dispose() {
    isEditMode = false;
    deleterAdaption = null;
    editorAdaption = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BorderedBox(
      padding: const EdgeInsets.all(12.0),
      child: AsyncWidget<ViewOutput<TEntity>>(
        future: widget.viewInvokation,
        loadingBuilder: (_) => _EntityTableLoadingIndicator(),
        errorBuilder: (_, __, ___) => _EntityTableErrorIndicator(),
        successBuilder: (BuildContext buildContext, ViewOutput<TEntity> data) {
          final TEntity? entityObj = widget.selReference == null ? null : data.entities[widget.selReference as int];

          return AnimatedSwitcher(
            duration: 300.miliseconds,
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: entityObj == null
                ? _EntityTableDrawerContent(
                    header: _EntityTableDrawerHeader(
                      title: 'No $TEntity content',
                      actions: <_EntityTableDrawerAction>[],
                    ),
                    child: ErrorMessageWidget(
                      message: 'No $TEntity selected to view content',
                    ),
                  )
                : isEditMode
                // -> Editing content view.
                ? _EntityTableDrawerEditor<TEntity>(
                        entity: entityObj,
                    factory: widget.factory,
                    editor: editorAdaption,
                    onCancelEditing: () {
                      setState(() {
                        isEditMode = false;
                      });
                    },
                  )
                // -> View content view.
                : _EntityTableDrawerContent(
                    header: _EntityTableDrawerHeader(
                      title: '$TEntity Details',
                      actions: <_EntityTableDrawerAction>[
                        // -> Edit mode action.
                        if (editorAdaption != null)
                          _EntityTableDrawerAction(
                            action: 'Edit $TEntity',
                            icon: Icons.edit_outlined,
                            onClick: () {
                              setState(() {
                                isEditMode = true;
                              });
                            },
                          ),

                        // -> Remove action.
                        if (deleterAdaption != null && entityObj != null)
                          _EntityTableDrawerAction(
                            icon: Icons.delete_forever_outlined,
                            action: 'Delete',
                            fore: errTheming.fore,
                            onClick: () => deleterAdaption?.callback(buildContext, entityObj),
                          ),

                        // -> Close details action.
                        _EntityTableDrawerAction(
                          action: 'Close Details',
                          icon: Icons.keyboard_arrow_right,
                          onClick: widget.onCloseDrawer,
                        ),
                      ],
                      
                    ),
                        child: widget.adapter.composeViewer(buildContext, entityObj),
                  ),
          );
        },
      ),
    );
  }
}
