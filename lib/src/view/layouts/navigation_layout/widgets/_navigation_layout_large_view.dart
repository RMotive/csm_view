part of '../navigation_layout.dart';

/// Manu width space.
const double _menuWidth = 250;

final _NavigationLayoutMenuReactor _navReactor = _NavigationLayoutMenuReactor();

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
    ThemingData themingData = getTheme<INavigationLayoutThemeData>(context).navigationLayout;

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              _NavigationLayoutHeader(
                logo: appLogo,
                user: userData,
                navReactor: _navReactor,
                homeRouteData: homeRouteData,
              ),
              Expanded(
                child: ReactiveWidget<_NavigationLayoutMenuReactor>(
                  reactor: _navReactor,
                  builder: (BuildContext buildContext, _NavigationLayoutMenuReactor reactor) {
                    double menuWidth = reactor._isOpen ? _menuWidth : 0;

                    return Stack(
                      children: <Widget>[
                        // --> Page section
                        Align(
                          alignment: Alignment.centerRight,
                          child: AnimatedSize(
                            duration: 200.miliseconds,
                            child: SizedBox(
                              width: pageSize.width - menuWidth,
                              child: page,
                            ),
                          ),
                        ),

                        // --> Application menu section
                        AnimatedPositioned(
                          duration: 200.miliseconds,
                          left: reactor._isOpen ? 0 : -_menuWidth,
                          width: _menuWidth,
                          child: ColoredBox(
                            color: themingData.back,
                            child: SizedBox(
                              width: _menuWidth,
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

