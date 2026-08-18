import 'package:csm_view/csm_view.dart';

/// Represents a [RoutingGraphBase] layout route data.
final class RoutingGraphLayout extends RoutingGraphLayoutBase {
  /// Creates a [RoutingGraphLayout] object.
  const RoutingGraphLayout({
    required super.layoutBuilder,
    required super.routes,
    super.parentNavigationState,
    super.restoration,
    super.navigatorStateKey,
    super.observers,
    super.transitionBuild,
    super.redirection,
  });
}
