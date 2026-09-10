import 'dart:async';

import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents an [IEntity] based { view } page for a [CategoryLayout].
///
/// [TEntityTableAdapter] - Type of the inner [EntityTable] adapter configuration.
abstract class CategoryEntityViewPageBase<TEntity extends IEntity<TEntity>, TEntityTableAdapter extends IEntityTableAdapter<TEntity>> implements ICategoryLayoutPage {
  /// Button title.
  @override
  final String title;

  /// Page target [Route] object instance.
  @override
  final RouteData routeData;

  /// Category page action ribbon configuration.
  @override
  late final List<IActionsRibbonNode>? actions;

  @protected
  late final TEntityTableAdapter adapter;

  /// Creates a new instance.
  CategoryEntityViewPageBase({
    required this.title,
    required this.routeData,
  }) {
    adapter = composeAdapter();
    actions = composeActions(adapter);
  }

  /// Composes the authentication token for the server request.
  FutureOr<String?>? composeAuth() => null;

  /// Composes the required [TAdapter] instance to use at the inner [EntityTable] at the entity page.
  TEntityTableAdapter composeAdapter();

  /// Composes the required {controller} for the inner [CategoryLayout] ribbon actions controlling.
  /// 
  /// [context] - Application build context.
  ///
  /// [adapter] - [EntityTable] adapter proxy.
  List<IActionsRibbonNode> composeActions(TEntityTableAdapter adapter);

  @override
  List<IRoutingGraphData> composeRoutes() => <IRoutingGraphData>[];
}
