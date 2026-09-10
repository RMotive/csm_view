import 'package:csm_view/csm_view.dart';

/// Represents a [RoutingGraphBase] node data.
final class RoutingGraphNode extends RoutingGraphNodeDataBase {
  /// Creates a new instance.
  const RoutingGraphNode(
    super.routeOptions, {
    required super.pageBuilder,
    super.parentNavigationState,
    super.routes,
    super.redirection,
    super.transitionBuilder,
    super.onDispose,
  });
}
