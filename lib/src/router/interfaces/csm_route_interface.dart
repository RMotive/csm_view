import 'dart:async';

import 'package:csm_foundation_view/src/common/common_module.dart';
import 'package:csm_foundation_view/src/router/router_module.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Interface for [CSMRoute].
///
/// Specifies methods that should be performed successfuly
/// by a [CSMRoute] concept implementation.
abstract interface class CSMRouteInterface {
  /// Defines the [NavigatorState] that is upper in the context treee than the current Route in the three.
  /// This works to encapsulate different groups of [Routes] in dedicated [NavigatorState]s.
  final Navigation? parentNavigation;

  /// Routes below the current Route node.
  /// Note: this don't mean [subRoutes] will be wrapped by this route, this means
  /// that [routes] path will be calculated after this [CSMRouteOptions].
  final List<CSMRouteBase> routes;

  const CSMRouteInterface({
    this.parentNavigation,
    this.routes = const <CSMRouteBase>[],
  });

  /// Performs the build for a [Page] for no transition route.
  CustomTransitionPage<T> noTransition<T>(Widget page);

  /// Performs the composition from a [CSMRoute] concept to the native framework route handler [GoRouter].
  RouteBase compose({
    bool isSub = false,
    FutureOr<CSMRouteOptions?> Function(BuildContext ctx, CSMRouterOutput output)? injectRedirection,
  });
}
