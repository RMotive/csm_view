import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route;

/// {page} class.
///
/// Implements an article entry for [CategoryLayout] specifying what [PageI] to draw and hwo to handle routing behavior,
/// also controlles [CategoryLayout] ribbon invokations.
final class CategoryLayoutPage extends CategoryLayoutPageBase {
  /// [RouteNode] page builder for routing management.
  final PageBuilder pageBuilder;

  /// Button icon builder.
  ///
  /// [foreColor] recommended current theme fore color.
  final Widget Function(BuildContext context, Color? fgColor) iconBuilder;

  /// Builds inner [CategoryLayoutPage] nested [RouteB] implementations to be accessable.
  final List<IRoutingGraphData> Function()? routesBuilder;

  /// Creates a new [CategoryLayoutPage] instance.
  const CategoryLayoutPage({
    required super.title,
    this.routesBuilder,
    required super.routeData,
    super.actions,
    required this.pageBuilder,
    required this.iconBuilder,
  });

  @override
  List<IRoutingGraphData> composeRoutes() => routesBuilder?.call() ?? <IRoutingGraphData>[];

  @override
  Widget? composeIcon(BuildContext context, Color? fgColor) => iconBuilder(context, fgColor);

  @override
  IViewPage composePage(BuildContext buildContext, RoutingData routingData) => pageBuilder(buildContext, routingData);
}
