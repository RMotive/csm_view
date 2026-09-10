import 'package:csm_view/csm_view.dart';
import 'package:flutter/widgets.dart' hide Router, Route;
import 'package:go_router/go_router.dart' hide RouteData;

/// Represents a [RoutingGraphBase] data.
abstract class RoutingGraphDataBase implements IRoutingGraphData {
  @override
  final NavigationState? parentNavigationState;

  @override
  final List<IRoutingGraphData> routes;

  /// Creates a new instance.
  const RoutingGraphDataBase({
    this.parentNavigationState,
    this.routes = const <RoutingGraphDataBase>[],
  });

  @override
  RouteBase compose({
    bool isSub = false,
    Redirection? redirection,
  });

  @override
  CustomTransitionPage<T> noTransition<T>(Widget page) {
    return CustomTransitionPage<T>(
      child: page,
      transitionDuration: 0.seconds,
      reverseTransitionDuration: 0.seconds,
      transitionsBuilder: (_, __, ___, Widget child) => child,
    );
  }
}
