import 'package:csm_foundation_view/src/router/router_module.dart';

/// Class for [CSMRouteWhisper]
///
/// Define a final behavior for a [CSMRouteWhisper] concept.
/// That handles a [DialogRoute] over the route tree.
final class CSMRouteWhisper<T> extends CSMRouteWhisperBase<T> {
  /// Generates a [CSMRouteWhisper] object.
  CSMRouteWhisper(
    super.routeOptions, {
    required super.pageBuild,
    required super.whisperOptions,
    super.routes,
    super.onExit,
    super.redirect,
    super.parentNavigation,
  });
}
