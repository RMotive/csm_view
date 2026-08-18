import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Route;
import 'package:go_router/go_router.dart' hide RouteData;

/// Represents a [RoutingGraphBase] leaf configuration.
abstract interface class IRoutingGraphData {
  /// Used for nested navigations.
  final NavigationState? parentNavigationState;

  /// Nested graph leafs.
  final List<IRoutingGraphData> routes;

  /// Creates a new instance.
  const IRoutingGraphData({
    this.parentNavigationState,
    this.routes = const <IRoutingGraphData>[],
  });

  /// Performs the build for a [Page] for no transition route.
  CustomTransitionPage<T> noTransition<T>(Widget page);

  /// Composes the current object into a [GoRouter] framework translation.
  ///
  /// [isSub] - Whether the current [IRoutingGraphData] has a parent leaf.
  ///
  /// [redirection] - Redirection handler.
  RouteBase compose({
    bool isSub = false,
    Redirection? redirection,
  });
}
