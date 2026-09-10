import 'dart:async';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Route;
import 'package:go_router/go_router.dart' hide RouteData;

/// Represents a [RoutingGraphBase] node data.
abstract class RoutingGraphNodeDataBase extends RoutingGraphDataBase implements IRoutingGraphLeafData {
  /// Route information.
  @override
  final RouteData route;

  /// Builder function to build and renderize [IPage] into the interactable [Widget] tree.
  @override
  final PageBuilder pageBuilder;

  /// When the client enters into this route, will be redirected to this resolved [Redirection] function.
  @override
  final Redirection? redirection;

  /// Builder for [IPage] transitions along [RouterBase] events.
  @override
  final Page<void> Function(IViewPage page)? transitionBuilder;

  /// Callback invoked when the current [route] is popped or removed from the [RouterBase] history.
  /// (.go() can remove it from the history too.)
  @override
  final FutureOr<bool> Function(BuildContext ctx, RoutingData routeData)? onDispose;

  /// Creates a new [RoutingGraphNodeDataBase] instance.
  const RoutingGraphNodeDataBase(
    this.route, {
    required this.pageBuilder,
    super.parentNavigationState,
    super.routes,
    this.redirection,
    this.transitionBuilder,
    this.onDispose,
  });

  @override
  RouteBase compose({
    bool isSub = false,
    Redirection? redirection,
  }) {
    final IRouter router = InjectorUtils.get();

    String resolvedPath = resolvePath(isSub);

    return GoRoute(
      path: resolvedPath,
      name: route.name,
      parentNavigatorKey: parentNavigationState,
      onExit: onDispose == null
          ? null
          : (BuildContext context, GoRouterState state) => onDispose!.call(
                context,
                RoutingData.fromGo(state, route),
              ),
      redirect: (BuildContext ctx, GoRouterState state) async {
        RoutingData output = RoutingData.fromGo(state, route);
        FutureOr<RouteData?>? resultOptions = redirection?.call(ctx, output) ?? this.redirection?.call(ctx, output);
        RouteData? calcualtedRedirectionResult = await resultOptions;
        if (calcualtedRedirectionResult == null) return null;
        String? absolutePath = router.getAbsolutePath(calcualtedRedirectionResult);
        return absolutePath;
      },
      routes: <RouteBase>[
        for (IRoutingGraphData cr in routes) cr.compose(isSub: true),
      ],
      pageBuilder: (BuildContext context, GoRouterState state) {
        RoutingData routeOutput = RoutingData.fromGo(state, route);
        IViewPage pageLaid = pageBuilder(context, routeOutput);

        return transitionBuilder?.call(pageLaid) ?? noTransition(pageLaid);
      },
    );
  }

  /// Calculates the node path based on the parse if it has parent nodes.
  ///
  /// [isSub] Wheter the current node has a parent node.
  @override
  String resolvePath([bool isSub = false]) {
    String parsedPath = route.path;
    if (parsedPath.startsWith('/') && isSub) {
      parsedPath = parsedPath.substring(1, parsedPath.length);
    }

    return parsedPath;
  }
}
