part of '../navigation_layout.dart';

/// Represents a navigation layout node, drawing a button to access the page at the menu.
final class NavigationLayoutNode extends NavigationLayoutNodeBase {
  /// Creates a new instance.
  const NavigationLayoutNode({
    super.icon,
    super.imageBuilder,
    required super.title,
    required super.routeData,
  });
}
