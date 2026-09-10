import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a { View } routing context handler.
abstract interface class IRouter {


  /// Moves the application [context] routing to the given [routeData] location.
  ///
  /// [route] target desired [RouteData] information.
  ///
  /// [ignoreRedirection] whether the [RouterBase] should avoid any [Redirection] trigger.
  ///
  /// [pushHistory] whether the [RouterBase] should push into the history the target [route] or just go directly to it removing all the previous [RouterBase] history.
  ///
  /// [extraData] extra data shared along [RouteData] resolutions.
  ///
  /// [allowLogs] whether the nethod can print logs.
  void go(BuildContext context, RouteData routeData, {bool ignoreRedirection, bool allowLogs, bool pushHistory, DataMap? extraData});

  /// Gets the [RouteData] from the given { View } application's [absolutePath].
  ///
  /// [absolutePath] - { View } application's path to get [RouteData].
  ///
  /// [allowLogs] - Whether the method must display logs.
  RouteData getRouteData(String absolutePath, [bool allowLogs]);

  /// Gets the absolute path calculation from a specific [RouteData] into the calculated [RouterBase] tree.
  ///
  /// [route] the required [RouteData]'s absolute path calculation.
  ///
  /// [allowLogs] whether the method can announce logs.
  String getAbsolutePath(RouteData route, [bool allowLogs]);

  /// Resolves development working route redirection.
  ///
  /// [routeData] - Target development route data.
  ///
  /// [currentPath] - Current { View } application's route path.
  ///
  /// [targetPath] - Routing request { View } application's target path.
  ///
  /// [allowLogs] - Whether the method must display logs.
  String? resolveDevRedirection(RouteData routeData, String currentPath, String? targetPath, [bool allowLogs]);
}
