import 'package:csm_view/csm_view.dart';

/// Represents a { View } complex routing graph configuration.
final class RoutingGraph extends RoutingGraphBase {
  /// Creates a new instance.
  ///
  /// [devRoute] - Development time route locator at rebuilds.
  ///
  /// [redirect] - Global graph redirection command check.
  ///
  /// [navigator] - Context scope navigator state key.
  ///
  /// [routes] - Routing graph routes.
  RoutingGraph({
    super.devRoute,
    super.redirect,
    super.navigator,
    required super.routes,
  });
}
