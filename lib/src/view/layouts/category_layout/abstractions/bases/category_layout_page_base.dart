part of './../../category_layout.dart';

/// Represents a [CategoryLayout] page.
abstract class CategoryLayoutPageBase implements ICategoryLayoutPage {
  /// Page title.
  @override
  final String title;

  /// Page route data.
  @override
  final RouteData routeData;

  /// Category page action ribbon configuration.
  @override
  final List<IActionsRibbonNode>? actions;

  /// Creates a new instance.
  const CategoryLayoutPageBase({
    required this.title,
    required this.routeData,
    this.actions,
  });
}
