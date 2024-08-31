import 'dart:async';
import 'package:csm_view/src/common/common_module.dart';
import 'package:csm_view/src/router/router_module.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final CSMRouter _routeDriver = CSMRouter.i;

/// Base for [CSMRouteNode].
///
/// Provides specific handlers and properties to indicate the base neccesary functions for a
/// [CSMRouteNode] concept behavior.
/// A single Route object to indicate the existance of a Route into the Route manager.
/// This means that this object only creates the clnfiguration for handle the redirection/direction of
/// a complex/simple UI Page ([CSMPageBase]).
class CSMRouteNodeBase extends CSMRouteBase implements CSMRouteNodeInterface {
  /// Routing options to handle the location and behavior.
  @override
  final CSMRouteOptions routeOptions;

  /// Build function to create the UI Page [CSMPageBase] and draw it in the screen.
  @override
  final CSMPageBuild pageBuild;

  /// When the client enters into this route, will be redirected to this resolved redirect function.
  @override
  final CSMRedirection? redirect;

  /// Custom Page build for use another animation and page transition options.
  @override
  final Page<dynamic> Function(CSMPageBase page)? transitionBuild;

  /// Callback invoked when the current route is popped or removed from the history.
  /// (.go() can remove it from the history too.)
  @override
  final FutureOr<bool> Function(BuildContext ctx, CSMRouterOutput state)? onExit;

  /// A single Route object to indicate the existance of a Route into the Route manager.
  /// This means that this object only creates the clnfiguration for handle the redirection/direction of
  /// a complex/simple UI Page ([CSMPageBase]).
  const CSMRouteNodeBase(
    this.routeOptions, {
    required this.pageBuild,
    super.parentNavigation,
    super.routes,
    this.redirect,
    this.transitionBuild,
    this.onExit,
  });

  @override
  RouteBase compose({
    bool isSub = false,
    CSMRouteOptions? developmentRoute,
    bool applicationStart = true,
    CSMRedirection? injectRedirection,
  }) {
    return GoRoute(
      path: calNodePath(isSub),
      name: routeOptions.name,
      parentNavigatorKey: parentNavigation,
      onExit: onExit == null
          ? null
          : (BuildContext context, GoRouterState state) => onExit!.call(
                context,
                CSMRouterOutput.fromGo(state, routeOptions),
              ),
      redirect: (BuildContext ctx, GoRouterState state) async {
        if (_routeDriver.devRedirectNode()) {
          return null;
        }

        CSMRouterOutput output = CSMRouterOutput.fromGo(state, routeOptions);
        FutureOr<CSMRouteOptions?>? resultOptions;
        resultOptions = injectRedirection?.call(ctx, output) ?? redirect?.call(ctx, output);
        CSMRouteOptions? calcualtedRedirectionResult = await resultOptions;
        if (calcualtedRedirectionResult == null) return null;
        String? absolutePath = _routeDriver.getAbsolute(calcualtedRedirectionResult);
        return absolutePath;
      },
      routes: <RouteBase>[
        for (CSMRouteBase cr in routes) cr.compose(isSub: true),
      ],
      pageBuilder: (BuildContext context, GoRouterState state) {
        CSMRouterOutput routeOutput = CSMRouterOutput.fromGo(state, routeOptions);
        CSMPageBase pageLaid = pageBuild(context, routeOutput);

        return transitionBuild?.call(pageLaid) ?? noTransition(pageLaid);
      },
    );
  }

  @override
  String calNodePath([bool isSub = false]) {
    String parsedPath = routeOptions.path;
    if (routeOptions.path.startsWith('/')) {
      if (isSub) parsedPath = parsedPath.substring(1, parsedPath.length);
    }

    return parsedPath;
  }
}
