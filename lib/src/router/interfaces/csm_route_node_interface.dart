import 'dart:async';

import 'package:csm_foundation_view/src/common/common_module.dart';
import 'package:csm_foundation_view/src/router/router_module.dart';
import 'package:flutter/material.dart';

/// Interface for [CSMRouteNode].
///
/// Specifies methods that should be performed successfuly
/// by a [CSNRouteNode] concept implementation.
abstract interface class CSMRouteNodeInterface {
  /// Routing options to handle the location and behavior.
  final CSMRouteOptions routeOptions;

  /// Build function to create the UI Page [CSMPageBase] and draw it in the screen.
  final CSMPageBuild pageBuild;

  /// When the client enters into this route, will be redirected to this resolved redirect function.
  final CSMRedirection? redirect;

  /// Custom Page build for use another animation and page transition options.
  final Page<dynamic> Function(CSMPageBase page)? transitionBuild;

  /// Callback invoked when the current route is popped or removed from the history.
  /// (.go() can remove it from the history too.)
  final FutureOr<bool> Function(BuildContext ctx, CSMRouterOutput output)? onExit;

  const CSMRouteNodeInterface(this.routeOptions, this.pageBuild, this.redirect, this.transitionBuild, this.onExit);

  /// Calculates the node path based on the parse if it has parent nodes.
  ///
  /// [isSub]: Wheter the current node has a parent node.
  String calNodePath([bool isSub = false]);
}
