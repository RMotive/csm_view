import 'package:csm_view/csm_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' hide RouteData;

/// Represents a [RoutingGraphBase] route change data.
final class RoutingData {
  /// The routing operation target route.
  final RouteData targetRoute;

  /// Absolute routing grapth path.
  final String absolutePath;

  /// Stores routing parameters.
  final Map<String, String> parameters;

  /// Stores routing query parameters.
  final Map<String, List<String>> queryData;

  /// Sub-Route page key.
  final ValueKey<String>? pageKey;

  /// Creates a new instance.
  const RoutingData({
    this.pageKey,
    this.parameters = const <String, String>{},
    this.queryData = const <String, List<String>>{},
    required this.targetRoute,
    required this.absolutePath,
  });

  /// Creates a new instance from a [GoRouterState] and a [RouteData] object.
  ///
  /// [goState] - [GoRouter] framework's state data.
  ///
  /// [routeData] - [RoutingGraphBase] data.
  factory RoutingData.fromGo(GoRouterState goState, RouteData routeData) {
    final IRouter router = InjectorUtils.get();

    String? absolutePath = router.getAbsolutePath(routeData);

    return RoutingData(
      targetRoute: routeData,
      pageKey: goState.pageKey,
      absolutePath: absolutePath,
      parameters: goState.pathParameters,
      queryData: goState.uri.queryParametersAll,
    );
  }
}
