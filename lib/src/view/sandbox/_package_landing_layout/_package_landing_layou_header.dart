part of '../abstractions/bases/package_sandbox_view_base.dart';

/// [Widget] implementation for [_PackageLandingViewLayout].
///
///
/// Draws a view for the [_PackageLandingViewLayout] header.
final class _PackageLandingLayouHeader extends StatelessWidget {
  /// The current routed [PackageSandboxEntry] displayed.
  final String entryTitle;

  /// The [List] of available subscribed application themes implementations.
  final List<IThemeData> applicationThemes;

  /// [ReactorI] handler for the application menu, this allows to open or close it dinamycally as it's state.
  final _ApplicationMenuReactor menuReactor;

  /// Createsa a new [_PackageLandingLayouHeader] instance.
  const _PackageLandingLayouHeader({
    required this.entryTitle,
    required this.menuReactor,
    required this.applicationThemes,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeManager themeManager = ThemeManager.of(context);
    final PackageSamdboxThemeBase theme = themeManager.castData();

    final IRouter router = InjectorUtils.get();

    return ColoredBox(
      color: theme.landingHeader.back,
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 12,
          ),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      menuReactor.toogle();
                    },
                    icon: Icon(
                      Icons.menu,
                      color: theme.landingHeader.accent,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      entryTitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.landingHeader.fore,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: theme.landingHeader.accent,
                    ),
                    onPressed: () {
                      router.go(context, _homeRouteData);
                    },
                  ),
                  ThemeSwitcher(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
