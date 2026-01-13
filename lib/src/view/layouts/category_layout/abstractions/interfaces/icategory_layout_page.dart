import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a [CategoryLayout] page.
abstract interface class ICategoryLayoutPage {
  /// Page title.
  final String title;

  /// Page route data.
  final RouteData routeData;

  /// Category page action ribbon configuration.
  final List<IActionsRibbonNode>? actions;

  /// Creates a new instance.
  const ICategoryLayoutPage({
    required this.title,
    required this.routeData,
    this.actions,
  });

  /// Composes the inner [CategoryLayout] entry nested [RouteB] implementations, used to subscribe dinamic routes subscription for this entry
  /// [RouteNode] created providing routing access from inner [CategoryLayoutRibbonControllerI] interactions.
  List<IRoutingGraphData> composeRoutes();

  /// Composes customly a [Widget] to replace the default [CategoryLayout] page selection button icon decorator.
  ///
  /// [fgColor] recommended fore icon [Color] calculated based on the current {CSM} foundation theming management.
  Widget? composeIcon(BuildContext context, Color? fgColor);

  /// Composes the [PageI] implementation that will be drawn into this [CategoryLayout] page entry.
  IViewPage composePage(BuildContext context, RoutingData routingData);
}
