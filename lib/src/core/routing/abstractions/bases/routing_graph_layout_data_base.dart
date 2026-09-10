import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Route, LayoutBuilder;
import 'package:go_router/go_router.dart' hide RouteData;

/// Represents a [RoutingGraphBase] layout route data.
abstract class RoutingGraphLayoutBase extends RoutingGraphDataBase implements IRoutingGraphLayout {
  /// Identifier to the restoration scope along [RouterBase]´s implementation restoration manager.
  @override
  final String? restoration;

  /// Observers for a [RouteLayout]. Used to subscribe custom observers at the [Routing] native framwork.
  @override
  final List<NavigatorObserver>? observers;

  /// Custom [Navigation]. To handle operations along its children routes.
  @override
  final NavigationState? navigatorStateKey;

  /// Handles the build for a dynamic transition at the routing event.
  @override
  final Page<dynamic> Function(IViewLayout layout)? transitionBuild;

  /// When the client enters into this route, will be redirected to this resolved redirect function.
  @override
  final Redirection? redirection;

  /// Build function to create the [Layout] UI and draw it in the screen.
  @override
  final LayoutBuilder layoutBuilder;

  /// A complex Route object to indicate the existance of a route nodes wrapper into the Route manager.
  /// This means that this object only creates the clnfiguration for handle the redirection/direction of
  /// a complex [CSMLayoutBase] with its calculated [CSMPage] routed.
  const RoutingGraphLayoutBase({
    super.parentNavigationState,
    this.restoration,
    this.navigatorStateKey,
    this.observers,
    this.transitionBuild,
    this.redirection,
    required super.routes,
    required this.layoutBuilder,
  });

  @override
  RouteBase compose({
    bool isSub = false,
    Redirection? redirection,
  }) {
    final IRouter router = InjectorUtils.get();

    return ShellRoute(
      observers: observers,
      navigatorKey: navigatorStateKey,
      parentNavigatorKey: parentNavigationState,
      restorationScopeId: restoration ?? GlobalKey().toString(),
      pageBuilder: (BuildContext context, GoRouterState state, Widget child) {
        String path = state.uri.toString();
        RouteData route = router.getRouteData(path);
        IViewLayout layoutLaid = layoutBuilder(context, RoutingData.fromGo(state, route), child);
        return transitionBuild?.call(layoutLaid) ?? noTransition(layoutLaid);
      },
      routes: <RouteBase>[
        for (IRoutingGraphData route in routes)
          route.compose(
            isSub: isSub,
            redirection: redirection,
          ),
      ],
    );
  }
}
