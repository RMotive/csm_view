import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route, Router;

/// Represents a [RoutingGraphBase] leaf, an application's final graph route.
abstract interface class IRoutingGraphLeafData {
  /// Route information.
  final RouteData route;

  /// Builder function to build and renderize [IPage] into the interactable [Widget] tree.
  final PageBuilder pageBuilder;

  /// When the client enters into this route, will be redirected to this resolved [Redirection] function.
  final Redirection? redirection;

  /// Builder for [IPage] transitions along [RouterBase] events.
  final Page<void> Function(IViewPage page)? transitionBuilder;

  /// Callback invoked when the current [route] is popped or removed from the [RouterBase] history.
  ///
  /// .go() and .pop() removes from history.
  final FutureOr<bool> Function(BuildContext ctx, RoutingData routeData)? onDispose;

  /// Creates a new [IRoutingGraphLeafData] instance.
  const IRoutingGraphLeafData(this.route, this.pageBuilder, this.redirection, this.transitionBuilder, this.onDispose);

  /// Calculates the node path based on the parse if it has parent nodes.
  ///
  /// [isSub] Wheter the current node has a parent node.
  String resolvePath([bool isSub = false]);
}
