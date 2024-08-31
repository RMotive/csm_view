import 'package:csm_view/src/common/common_module.dart';
import 'package:csm_view/src/router/router_module.dart';
import 'package:flutter/material.dart';

/// Interface for [CSMRouteLayout].
///
/// Specifies methods that should be performed successfuly
/// by a [CSNRouteLayout] concept implementation.
abstract interface class CSMRouteLayoutInterface {
  /// Identifier to the restoration scope along [Router]´s implementation restoration manager.
  final String? restoration;

  /// Observers for a [RouteLayout]. Used to subscribe custom observers at the [Routing] native framwork.
  final List<NavigatorObserver>? observers;

  /// Custom [Navigation]. To handle operations along its children routes.
  final Navigation? navigation;

  /// Handles the build for a dynamic transition at the routing event.
  final Page<dynamic> Function(CSMLayoutBase layout)? transitionBuild;

  /// When the client enters into this route, will be redirected to this resolved redirect function.
  final CSMRedirection? redirect;

  /// Build function to create the [Layout] UI and draw it in the screen.
  final CSMLayoutBuild layoutBuild;

  const CSMRouteLayoutInterface(
    this.transitionBuild,
    this.layoutBuild,
    this.restoration,
    this.navigation,
    this.observers,
    this.redirect,
  );
}
