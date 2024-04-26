import 'package:csm_foundation_view/src/common/common_module.dart';
import 'package:csm_foundation_view/src/router/router_module.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// [CSMRouter] dependency gather (for application routing purposes).
final CSMRouter _router = CSMRouter.i;

/// Base for [CSMRouteLayout].
///
/// Provides specific handlers and properties to indicate the base neccesary functions for a
/// [CSMRouteLayout] concept behavior.
/// A [CSMRouteLayout] is as well known at development as a UI wrapper for its children routes,
/// creating a standarized UI that'll be always consistent routing allong all Layout's children routes.
class CSMRouteLayoutBase extends CSMRouteBase implements CSMRouteLayoutInterface {
  /// Identifier to the restoration scope along [Router]´s implementation restoration manager.
  @override
  final String? restoration;

  /// Observers for a [RouteLayout]. Used to subscribe custom observers at the [Routing] native framwork.
  @override
  final List<NavigatorObserver>? observers;

  /// Custom [Navigation]. To handle operations along its children routes.
  @override
  final Navigation? navigation;

  /// Handles the build for a dynamic transition at the routing event.
  @override
  final Page<dynamic> Function(CSMLayoutBase layout)? transitionBuild;

  /// When the client enters into this route, will be redirected to this resolved redirect function.
  @override
  final CSMRedirection? redirect;

  /// Build function to create the [Layout] UI and draw it in the screen.
  @override
  final CSMLayoutBuild layoutBuild;

  /// A complex Route object to indicate the existance of a route nodes wrapper into the Route manager.
  /// This means that this object only creates the clnfiguration for handle the redirection/direction of
  /// a complex [CSMLayoutBase] with its calculated [CSMPage] routed.
  const CSMRouteLayoutBase({
    super.parentNavigation,
    super.routes,
    required this.layoutBuild,
    this.restoration,
    this.navigation,
    this.observers,
    this.transitionBuild,
    this.redirect,
  });

  @override
  RouteBase compose({
    bool isSub = false,
    bool applicationStart = true,
    CSMRedirection? injectRedirection,
    CSMRouteOptions? developmentRoute,
  }) {
    return ShellRoute(
      observers: observers,
      navigatorKey: navigation,
      parentNavigatorKey: parentNavigation,
      restorationScopeId: restoration ?? GlobalKey().toString(),
      pageBuilder: (BuildContext context, GoRouterState state, Widget child) {
        String path = state.uri.toString();
        CSMRouteOptions route = _router.getOptions(path);
        CSMLayoutBase layoutLaid = layoutBuild(context, CSMRouterOutput.fromGo(state, route), child);
        return transitionBuild?.call(layoutLaid) ?? noTransition(layoutLaid);
      },
      routes: <RouteBase>[
        for (CSMRouteBase route in routes)
          route.compose(
            isSub: isSub,
            injectRedirection: injectRedirection,
          ),
      ],
    );
  }
}
