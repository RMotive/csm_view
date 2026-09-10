import 'dart:async';

import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents an [IEntity] based table adapter configuration.
abstract interface class IEntityTableAdapter<TEntity extends IEntity<TEntity>> {
  /// Creates a new instance.
  const IEntityTableAdapter();

  /// Composes the auth token to use for direct {csm} services comunication.
  FutureOr<String> composeAuth();

  /// Adds a callback action triggered when the [refresh] operation has been called.
  ///
  /// [callback] action callback to subscribe to notifier handle.
  void listenRefresh(VoidCallback callback);

  /// Refreshes the [EntityTable] instance adapted.
  void refresh();

  /// Disposes [IEntityTableAdapter] instance resources.
  void dispose();

  /// Composes the conifgurations adapted for {Edition} [EntityTable] behavior.
  EntityTableAdapterEditor<TEntity>? composeEditor();

  /// Composes the conifgurations adapted for {Deeltion} [EntityTable] behavior.
  EntityTableAdapterDeleter<TEntity>? composeDeleter();

  /// Composes the view details drawer at the [EntityTable].
  Widget composeViewer(BuildContext buildContext, TEntity entity);
}
