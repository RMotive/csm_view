import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' hide RouteData;

///
abstract interface class IRoutingGraph implements RouterConfig<RouteMatchList> {
  /// { View } application routing graph routes.
  final List<IRoutingGraphData> routes;

  /// Creates a new instance.
  const IRoutingGraph(this.routes);
}
