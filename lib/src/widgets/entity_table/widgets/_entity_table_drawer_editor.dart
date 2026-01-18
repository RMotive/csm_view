part of '../entity_table.dart';

/// Draws a [Widget] for [EntityTable] to handle the edited entity state.
final class _EntityTableDrawerEditor<TEntity extends IEntity<TEntity>> extends StatefulWidget {
  /// [TEntity] to be updated.
  final TEntity entity;

  /// [TEntity] reference emtpty object.
  final TEntity Function() factory;

  /// Editor adapter.
  final EntityTableAdapterEditor<TEntity>? editor;

  /// Callback event when the editing has been cancelled.
  final VoidCallback onCancelEditing;

  /// Creates a new instance.
  const _EntityTableDrawerEditor({
    required this.entity,
    required this.factory,
    required this.editor,
    required this.onCancelEditing,
  });

  @override
  State<_EntityTableDrawerEditor<TEntity>> createState() => __EntityTableDrawerEditorState<TEntity>();
}

final class __EntityTableDrawerEditorState<TEntity extends IEntity<TEntity>> extends State<_EntityTableDrawerEditor<TEntity>> {
  /// [TEntity] to be updated reference to not affect instances.
  late TEntity refEntity;

  /// Edition context data.
  late EntityTableAdapterEditorData<TEntity> data;

  /// Whether the current edition context can save changes.
  bool canSave = false;

  @override
  void initState() {
    super.initState();
    loadRef();

    data = EntityTableAdapterEditorData<TEntity>(widget.entity, context, refEntity, toogleSaveButton);
  }

  @override
  void didUpdateWidget(covariant _EntityTableDrawerEditor<TEntity> oldWidget) {
    final bool entityChanged = oldWidget.entity != widget.entity;
    final bool editorChanged = oldWidget.editor != widget.editor;

    if (entityChanged) {
      loadRef();
    }

    if (entityChanged || editorChanged) {
      data = EntityTableAdapterEditorData<TEntity>(widget.entity, context, refEntity, toogleSaveButton);
    }

    super.didUpdateWidget(oldWidget);
  }

  void loadRef() {
    Map<String, Object?> entityData = widget.entity.encode();
    refEntity = widget.factory();
    refEntity.decode(entityData);
  }

  void toogleSaveButton(bool canSave) {
    setState(() {
      canSave = canSave;
    });
  }

  @override
  Widget build(BuildContext context) {
    final EntityTableAdapterEditor<TEntity>? editor = widget.editor;
    if (editor == null) {
      return Center(
        child: ErrorMessageWidget(
          message: 'No $TEntity editor implemented',
        ),
      );
    }

    return _EntityTableDrawerContent(
      header: _EntityTableDrawerHeader(
        title: 'Editing $TEntity',
        actions: <_EntityTableDrawerAction>[
          // -> Save changes action
          _EntityTableDrawerAction(
            icon: Icons.save,
            isDisabled: !canSave,
            action: 'Save Changes',
            onClick: () => editor.onUpdate,
          ),

          // -> Cancel changes action
          _EntityTableDrawerAction(
            action: 'Cancel Editing',
            icon: Icons.cancel_sharp,
            onClick: widget.onCancelEditing,
            fore: ThemingUtils.get(context).controlError.fore,
          ),
        ],
      ),
    );
  }
}
