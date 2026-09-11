part of '../../navigation_layout.dart';

/// Represents a navigation layout node, drawing a button to access the page at the menu.
abstract class NavigationLayoutNodeBase implements INavigationLayoutNode {
  /// Navigation button title.
  @override
  final String title;

  /// Navigation button target route.
  @override
  final RouteData routeData;

  /// Button image builder.
  @override
  final ImageProvider Function(BuildContext context)? imageBuilder;

  /// Button icon builder.
  @override
  final IconData? icon;

  /// Creates a new instance
  const NavigationLayoutNodeBase({
    this.icon,
    this.imageBuilder,
    required this.title,
    required this.routeData,
  });
}
