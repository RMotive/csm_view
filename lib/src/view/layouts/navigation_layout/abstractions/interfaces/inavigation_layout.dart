part of '../../navigation_layout.dart';

/// Represents a { View } navigation layout.
abstract interface class INavigationLayout {
  /// Header application logo.
  final ImageProvider? appLogo;

  /// Layout home route.
  final RouteData? homeRouteData;

  /// Layout displayed user data.
  final INavigationLayoutHeaderUserData? userData;

  /// Layout nodes.
  final List<INavigationLayoutNode> navigationNodes;

  /// Solution specific user information builder to get and calculate user information to display at header user button.
  final INavigationLayoutHeaderUserData? Function()? userDataBuilder;

  /// Creates a new instance.
  const INavigationLayout(this.appLogo, this.homeRouteData, this.userData, this.userDataBuilder, this.navigationNodes);
}
