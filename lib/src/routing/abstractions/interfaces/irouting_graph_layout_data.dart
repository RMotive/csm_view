import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide LayoutBuilder, Router;

/// Represents a [RoutingGraphBase] layout route data.
abstract interface class IRoutingGraphLayout implements IRoutingGraphData {
  /// Identifier to the restoration scope along [RouterBase]´s implementation restoration manager.
  final String? restoration;

  /// Used to subscribe custom observers at the [RouterBase] native framwork.
  final List<NavigatorObserver>? observers;

  /// Current [Navigator] state global access key.
  final NavigationState? navigatorStateKey;

  /// Handles the build for a dynamic transition at the routing event.
  final Page<dynamic> Function(IViewLayout layout)? transitionBuild;

  /// When the client enters into this route, will be redirected to this resolved redirect function.
  final Redirection? redirection;

  /// Build function to create the [Layout] UI and draw it in the screen.
  final LayoutBuilder layoutBuilder;

  const IRoutingGraphLayout(
    this.transitionBuild,
    this.layoutBuilder,
    this.restoration,
    this.navigatorStateKey,
    this.observers,
    this.redirection,
  );
}
