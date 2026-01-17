part of '../entity_table.dart';

/// Draws a [Widget] for [EntityTable] to handle the edited entity state.
final class _EntityTableDrawerEditor<TEntity extends IEntity<TEntity>> extends StatefulWidget {
  /// [TEntity] to be updated.
  final TEntity entity;

  /// [TEntity] reference emtpty object.
  final TEntity Function() factory;

  /// Editor content builder.
  final Widget Function(BuildContext context, TEntity entityRef)? builder;

  /// Creates a new instance.
  const _EntityTableDrawerEditor({
    required this.factory,
    required this.entity,
    required this.builder,
  });

  @override
  State<_EntityTableDrawerEditor<TEntity>> createState() => __EntityTableDrawerEditorState<TEntity>();
}

final class __EntityTableDrawerEditorState<TEntity extends IEntity<TEntity>> extends State<_EntityTableDrawerEditor<TEntity>> {
  /// [TEntity] to be updated reference to not affect instances.
  late TEntity refEntity;

  @override
  void initState() {
    super.initState();
    loadRef();
  }

  @override
  void didUpdateWidget(covariant _EntityTableDrawerEditor<TEntity> oldWidget) {
    if (oldWidget.entity != widget.entity) {
      loadRef();
    }
    super.didUpdateWidget(oldWidget);
  }

  void loadRef() {
    Map<String, Object?> entityData = widget.entity.encode();
    refEntity = widget.factory();
    refEntity.decode(entityData);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.builder == null) {
      return Center(
        child: ErrorMessageWidget(
          message: 'No $TEntity editor implemented',
        ),
      );
    }

    return widget.builder!.call(
      context,
      refEntity,
    );
  }
}
