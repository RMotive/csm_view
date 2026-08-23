import 'package:csm_client_core/csm_client_core.dart';
import 'package:flutter/material.dart';

/// Represents an [EntityTable] deletion mode configuration.
///
/// [TEntity] - Type of the [IEntity] the [EntityTable] is based on.
final class EntityTableAdapterDeleter<TEntity extends IEntity<TEntity>> {
  /// Callback invoked when the user request to delete an [EntityTable] entity.
  ///
  ///
  /// [buildContext] current [Widget] tree calcualted context.
  ///
  /// [entity] entity requested to be removed.
  final void Function(BuildContext buildContext, TEntity entity) callback;

  /// Creates a new [EntityTableAdapterDeleter] instance.
  const EntityTableAdapterDeleter({
    required this.callback,
  });
}
