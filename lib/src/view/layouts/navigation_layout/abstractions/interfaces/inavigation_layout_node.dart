part of '../../navigation_layout.dart';

/// Represents a navigation layout node, drawing a button to access the page at the menu.
abstract interface class INavigationLayoutNode {
  /// Navigation button title.
  final String title;

  /// Navigation button target route.
  final RouteData routeData;

  /// Button image builder.
  final ImageProvider Function(BuildContext context)? imageBuilder;

  /// Button icon builder.
  final IconData? icon;

  /// Creates a new instance.
  const INavigationLayoutNode({
    required this.title,
    required this.routeData,
    this.icon,
    this.imageBuilder,
  }) : assert(icon != null || imageBuilder != null);
}
