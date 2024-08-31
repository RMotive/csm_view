import 'package:csm_view/src/router/router_module.dart';

/// Class for [CSMRouteLayout]
///
/// Define a final behavior for a [CSMRouteLayout] concept.
/// That handles a [RouteLayout] at the route tree.
final class CSMRouteLayout extends CSMRouteLayoutBase {
  /// Generates a [CSMRouteLayout] object.
  const CSMRouteLayout({
    required super.layoutBuild,
    super.parentNavigation,
    super.routes,
    super.restoration,
    super.navigation,
    super.observers,
    super.transitionBuild,
    super.redirect,
  });
}
