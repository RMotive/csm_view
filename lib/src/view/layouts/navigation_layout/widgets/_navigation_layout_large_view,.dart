part of '../navigation_layout.dart';

/// Draws the [NavigationLayout] on large devices view.
final class _NavigationLayoutLargeView extends _NavigationLayoutViewBase with ThemingMixin {
  /// Creates a new instance.
  _NavigationLayoutLargeView({
    super.appLogo,
    super.userData,
    super.homeRouteData,
    super.userDataBuilder,
    required super.page,
    required super.pageSize,
    required super.routingData,
    required super.navigationNodes,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('Not recalled');
    const double menuWidth = 250;
    final _NavigationLayoutMenuReactor navReactor = _NavigationLayoutMenuReactor();

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              _NavigationLayoutHeader(
                logo: appLogo,
                user: userData,
                navReactor: navReactor,
                homeRouteData: homeRouteData,
              ),
              Expanded(
                child: ReactiveWidget<_NavigationLayoutMenuReactor>(
                  reactor: navReactor,
                  builder: (BuildContext buildContext, _NavigationLayoutMenuReactor reactor) {
                    final double currMenuWidth = reactor._isOpen ? menuWidth : 0;
                    final ThemingData themingData = getTheme<INavigationLayoutThemeData>(context).navigationLayout;

                    return Stack(
                      children: <Widget>[
                        // --> Page section
                        Align(
                          alignment: Alignment.centerRight,
                          child: AnimatedSize(
                            duration: 200.miliseconds,
                            child: SizedBox(
                              width: pageSize.width - currMenuWidth,
                              child: page,
                            ),
                          ),
                        ),

                        // --> Application menu section
                        AnimatedPositioned(
                          duration: 200.miliseconds,
                          left: reactor._isOpen ? 0 : -menuWidth,
                          width: menuWidth,
                          child: ColoredBox(
                            color: themingData.back,
                            child: SizedBox(
                              width: menuWidth,
                              height: pageSize.height,
                              child: _NavigationLayoutMenu(
                                navigationNodes: navigationNodes,
                                routeData: routingData.targetRoute,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

