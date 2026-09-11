part of '../entity_table.dart';

/// Represents [EntityTableAdapterEditor] data to interact with the inner [Widget].
final class EntityTableAdapterEditorData<TEntity extends IEntity<TEntity>> {
  /// Stores the building context.
  final BuildContext context;

  /// Stores the original entity data
  ///
  /// DONT OVERRIDE ITS PROPERTIES UNLESS.
  final TEntity entity;

  /// Stores the [TEntity] reference to apply the changes.
  final TEntity entityRef;

  /// Changes the [EntityTableAdapterEditor] section save edit button state.
  final void Function(bool canSave) toogleSaveButton;

  /// Creates a new instance.
  const EntityTableAdapterEditorData(
    this.entity,
    this.context,
    this.entityRef,
    this.toogleSaveButton,
  );
}
