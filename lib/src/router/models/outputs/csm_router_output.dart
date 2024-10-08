import 'package:csm_view/src/router/router_module.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

/// [CSMRouter] Application router dependency.
final CSMRouter _router = CSMRouter.i;

/// Output for [CSMRouter].
///
/// This output stores [Output] concept information for a [CSMRouting] operation,
/// this means is given to the [CSMPage] buildt with his [CSMRouting] output resulted information.
final class CSMRouterOutput {
  /// Options given for the route at development time.
  final CSMRouteOptions route;

  /// Absolute route tree web path.
  final String absolutePath;

  /// Unique generated key (this is automatically generated by the native framework router [GoRouter]).
  final ValueKey<String>? pageKey;

  /// Generates a new [CSMRouterOutput] instance.
  const CSMRouterOutput({
    this.pageKey,
    required this.route,
    required this.absolutePath,
  });

  /// Generates a new [CSMRouterOutput] instance.
  ///
  /// Based on the native framework ([GoRouter]) operation metadata result, and
  /// development time specified [CSMRouteOptions].
  factory CSMRouterOutput.fromGo(GoRouterState goState, CSMRouteOptions options) {
    String? absolutePath = _router.getAbsolute(options);

    return CSMRouterOutput(
      route: options,
      pageKey: goState.pageKey,
      absolutePath: absolutePath,
    );
  }
}
