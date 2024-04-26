import 'dart:async';

import 'package:csm_foundation_view/src/common/common_module.dart';
import 'package:csm_foundation_view/src/router/router_module.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

part '../private/csm_routing_listener.dart';

//* --> Dependencies.
/// [CSMRouter] injection.
final CSMRouter _routeDriver = CSMRouter.i;

/// Base for [CSMRouterTree].
///
/// Defines base behavior for [CSMRouterTree] implementations.
///
/// [CSMRouterTree] concept: defines the [RouterTree] configured to the [CSMApplication].
/// indicating all [Routing] configurations, behaviors and route nodes calculations along [CSMRouteNode]'s,
/// [CMSRouteLayout]'s and [CMSRouteWhisper] implementations, and all custom implementations based on their [Bases].
abstract class CSMRouterTreeBase extends GoRouter {
  /// Default [Navigation] instance to use if the main application doesn't provide one.
  static final Navigation _kNavigation = Navigation();

  /// Stores a flag to indicate if the [CSMRouter]´s been already initd.
  static bool _routerInitd = false;

  /// Stores the current path resolved.
  static String _currentPath = "";

  /// Generates a new [CSMRouterTreeBase] behavior handler.
  CSMRouterTreeBase({
    CSMRouteOptions? devRoute,
    required List<CSMRouteBase> routes,
    FutureOr<CSMRouteOptions?> Function(BuildContext, CSMRouterOutput)? redirect,
    GlobalKey<NavigatorState>? navigator,
  }) : super.routingConfig(
          navigatorKey: navigator ?? _kNavigation,
          routingConfig: _CSMRoutingListener(
            RoutingConfig(
              routes: <RouteBase>[
                for (CSMRouteBase routeBase in routes) routeBase.compose(),
              ],
              redirect: (BuildContext context, GoRouterState state) async {
                // --> Driver init
                if (!_routerInitd) {
                  CSMRouter.initRouteTree(routes);
                  CSMRouter.initNavigator(navigator ?? _kNavigation);
                  _routerInitd = true;
                }

                // --> Evaluating dev route redirect.
                if (devRoute != null && state.fullPath != null) {
                  String? devRedirect = _routeDriver.devRedirect(devRoute, _currentPath, state.fullPath);
                  if (devRedirect != null) {
                    _currentPath = devRedirect;
                    return devRedirect;
                  }
                }
                if (redirect == null) return null;

                // --> Evaluate custom redirect injection.
                final String? targetPath = state.fullPath;
                if (targetPath == null) return null;
                final CSMRouteOptions targetOptions = _routeDriver.getOptions(targetPath);
                CSMRouterOutput output = CSMRouterOutput.fromGo(state, targetOptions);
                CSMRouteOptions? redirector = await redirect.call(context, output);
                if (redirector == null) return null;
                String? calculatedTargetPath = _routeDriver.getAbsolute(redirector);
                _currentPath = calculatedTargetPath;
                return calculatedTargetPath;
              },
            ),
          ),
        );
}
