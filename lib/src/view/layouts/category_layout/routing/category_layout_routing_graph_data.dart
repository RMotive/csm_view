part of '../category_layout.dart';

/// Handles the convertion of a [CategoryLayoutRoutingGraphData] to its [RouteNode] representation for a [RouteLayoutI], generating correctly the
/// [LayoutI], and inner [RouteNodeI]s composition.
final class CategoryLayoutRoutingGraphData extends RoutingGraphLayoutBase {
  /// Pages grouped at this category.
  final List<ICategoryLayoutPage> pages;

  /// Creates a new [CategoryLayoutRoutingGraphData] instance.
  CategoryLayoutRoutingGraphData({
    required this.pages,
  }) : super(
          routes: <IRoutingGraphData>[
            for (ICategoryLayoutPage page in pages)
              RoutingGraphNode(
                page.routeData,
                routes: page.composeRoutes(),
                pageBuilder: page.composePage,
              ),
          ],
          layoutBuilder: (BuildContext ctx, RoutingData routingData, Widget page) {
            return CategoryLayout(
              page: page,
              pages: pages,
              routingData: routingData,
            );
          },
        );
}
