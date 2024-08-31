import 'package:csm_view/src/router/router_module.dart';

/// Class for [CSMRouteNode]
///
/// Define a final behavior for a [CSMRouteNode] concept.
/// That handles a [RouteNode] at the route tree.
final class CSMRouteNode extends CSMRouteNodeBase {
  /// Generates a [CSMRouteNode] object.
  const CSMRouteNode(
    super.routeOptions, {
    required super.pageBuild,
    super.parentNavigation,
    super.routes,
    super.redirect,
    super.transitionBuild,
    super.onExit,
  });
}
