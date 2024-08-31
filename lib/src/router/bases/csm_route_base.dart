import 'dart:async';

import 'package:csm_view/src/common/common_module.dart';
import 'package:csm_view/src/router/router_module.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Base for [CSMRoute].
///
/// Provides specific handlers and properties to indicate the base neccesary functions for a
/// [CSMRoute] concept behavior.
abstract class CSMRouteBase implements CSMRouteInterface {
  /// Defines the [NavigatorState] that is upper in the context treee than the current Route in the three.
  /// This works to encapsulate different groups of [Routes] in dedicated [NavigatorState]s.
  @override
  final Navigation? parentNavigation;

  /// Routes below the current Route node.
  /// Note: this don't mean [subRoutes] will be wrapped by this route, this means
  /// that [routes] path will be calculated after this [CSMRouteOptions].
  @override
  final List<CSMRouteBase> routes;

  /// Generates an [CSMRouteBase] implementation.
  const CSMRouteBase({
    this.parentNavigation,
    this.routes = const <CSMRouteBase>[],
  });

  @override
  RouteBase compose({
    bool isSub = false,
    FutureOr<CSMRouteOptions?> Function(BuildContext ctx, CSMRouterOutput output)? injectRedirection,
  });

  @override
  CustomTransitionPage<T> noTransition<T>(Widget page) {
    return CustomTransitionPage<T>(
      child: page,
      transitionDuration: 0.seconds,
      reverseTransitionDuration: 0.seconds,
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return child;
      },
    );
  }
}
