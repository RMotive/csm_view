part of '../abstractions/bases/package_landing_view_base.dart';


///
final class _ApplicationMenuReactor extends ReactorBase {
  /// Reactor context reference for the context;
  bool _isOpen = true;

  /// Toogles the application menu reverting their current state.
  ///
  ///
  /// [forceState] if this is provided then will force the inner state without toogling the current value.
  void toogle([bool? forceState]) {
    if (forceState != null) {
      _isOpen = forceState;
    } else {
      _isOpen = !_isOpen;
    }

    react();
  }
}

final _ApplicationMenuReactor _menuReactor = _ApplicationMenuReactor();

/// [LayoutB] implementation for a [PackageLandingView].
///
///
/// This layout draws the navigation view through the package configured entries.
final class _PackageLandingViewLayout<T extends PackageLandingThemeBase> extends ViewLayoutBase {
  final _Graph<T> routingGraph;

  /// The current configured application themes implementations.
  final List<IThemeData> themes;

  /// Creates a new [_PackageLandingViewLayout] instance.
  const _PackageLandingViewLayout({
    required super.page,
    required super.routingData,
    
    required this.themes,
    required this.routingGraph,
  });

  @override
  Widget compose(BuildContext context, Size windowSize, Size pageSize) {
    final PackageLandingThemeBase theme = ThemingUtils.get(context);

    return Title(
      title: routingData.targetRoute.name,
      color: Colors.black,
      child: Column(
        children: <Widget>[
          _PackageLandingLayouHeader(
            entryTitle: routingData.targetRoute.name,
            applicationThemes: themes,
            menuReactor: _menuReactor,
          ),
          Expanded(
            child: ReactiveWidget<_ApplicationMenuReactor>(
              reactor: _menuReactor,
              builder: (BuildContext buildContext, _ApplicationMenuReactor reactor) {
                const double menuWidth = 250;
                final double currMenuWidth = reactor._isOpen ? menuWidth : 0;

                return Stack(
                  children: <Widget>[
                    // --> Page section
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: pageSize.width - currMenuWidth,
                        child: page,
                      ),
                    ),

                    // --> Application menu section
                    AnimatedPositioned(
                      duration: 200.miliseconds,
                      left: reactor._isOpen ? 0 : -menuWidth,
                      width: menuWidth,
                      child: ColoredBox(
                        color: theme.landingHeader.back,
                        child: SizedBox(
                          width: menuWidth,
                          height: pageSize.height,
                          child: _PackageLandingLayoutMenu<T>(
                            menuWidth: menuWidth,
                            routingGraph: routingGraph,
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
    );
  }
}
