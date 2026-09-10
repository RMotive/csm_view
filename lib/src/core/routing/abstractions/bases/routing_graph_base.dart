import 'package:csm_view/csm_view.dart';
import 'package:csm_view/src/core/routing/abstractions/interfaces/irouting_graph.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router, Route;
import 'package:go_router/go_router.dart' hide RouteData;

part '../../_router_listener.dart';

/// Represents a { View } complex routing graph configuration.
abstract class RoutingGraphBase extends GoRouter implements IRoutingGraph {
  /// Default [NavigationState] instance to use if the main application doesn't provide one.
  static final NavigationState _kNavigation = NavigationState();

  /// Stores the current path resolved.
  static String _currentPath = "";

  /// Routing graph routes.
  @override
  final List<IRoutingGraphData> routes;

  /// Creates a new instance.
  RoutingGraphBase({
    RouteData? devRoute,
    required this.routes,
    Redirection? redirect,
    GlobalKey<NavigatorState>? navigator,
  }) : super.routingConfig(
          navigatorKey: navigator ?? _kNavigation,
          routingConfig: _RouterListener(
            RoutingConfig(
              routes: <RouteBase>[
                for (IRoutingGraphData routeBase in routes) routeBase.compose(),
              ],
              redirect: (BuildContext context, GoRouterState state) async {
                final IRouter router = InjectorUtils.get();

                // --> Evaluating dev route redirect.
                if (devRoute != null && state.fullPath != null) {
                  String? devRedirect = router.resolveDevRedirection(devRoute, _currentPath, state.fullPath);
                  if (devRedirect != null) {
                    _currentPath = devRedirect;
                    return devRedirect;
                  }
                }
                if (redirect == null) return null;

                // --> Evaluate custom redirect injection.
                final String? targetPath = state.fullPath;
                if (targetPath == null) return null;
                final RouteData targetOptions = router.getRouteData(targetPath);
                final RoutingData output = RoutingData.fromGo(state, targetOptions);
                final RouteData? redirector = await redirect.call(context, output);
                if (redirector == null) return null;
                String? calculatedTargetPath = router.getAbsolutePath(redirector);
                _currentPath = calculatedTargetPath;
                return calculatedTargetPath;
              },
            ),
          ),
        );
}
