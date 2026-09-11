part of '../navigation_layout.dart';

/// Represents a { View } navigation layout.
final class NavigationLayoutRoutingGraphData extends RoutingGraphLayoutBase implements INavigationLayout {
  /// Header application logo.
  @override
  final ImageProvider? appLogo;

  /// Home [RouteData] used to draw a direction header button to access it easier.
  @override
  final RouteData? homeRouteData;

  /// The navigation entries to be handled, drawing navigation buttons and the routing behavior.
  @override
  final List<INavigationLayoutNode> navigationNodes;

  /// Layout displayed user data.
  @override
  final INavigationLayoutHeaderUserData? userData;

  /// Solution specific user information builder to get and calculate user information to display at header user button.
  @override
  final INavigationLayoutHeaderUserData? Function()? userDataBuilder;

  /// Creates a new [NavigationLayoutRoutingGraphData] instance.
  NavigationLayoutRoutingGraphData({
    this.appLogo,
    this.userData,
    this.homeRouteData,
    this.userDataBuilder,
    required super.routes,
    this.navigationNodes = const <INavigationLayoutNode>[],
  }) : super(
          layoutBuilder: (BuildContext ctx, RoutingData routingData, Widget page) {
            return NavigationLayout(
              page: page,
              appLogo: appLogo,
              userData: userData,
              routingData: routingData,
              homeRouteData: homeRouteData,
              userDataBuilder: userDataBuilder,
              navigationNodes: navigationNodes,
            );
          },
        );
}
