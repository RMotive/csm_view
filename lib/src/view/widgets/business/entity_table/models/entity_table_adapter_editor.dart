import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

export 'entity_table_adapter_editor_data.dart';

/// Represents an [EntityTable] editor mode configuration.
///
/// [TEntity] - Type of the [IEntity] the entity table is based on.
final class EntityTableAdapterEditor<TEntity extends IEntity<TEntity>> {
  /// {event} triggered when edition is being saved.
  ///
  /// [data] - Edition data context.
  final void Function(EntityTableAdapterEditorData<TEntity> data) onUpdate;

  /// Editor form building function.
  ///
  /// [data] - Edition data context.
  final Widget Function(EntityTableAdapterEditorData<TEntity> data) formBuilder;

  /// Creates a new [EntityTableAdapterEditor] instance.
  const EntityTableAdapterEditor({
    required this.onUpdate,
    required this.formBuilder,
  });
}
