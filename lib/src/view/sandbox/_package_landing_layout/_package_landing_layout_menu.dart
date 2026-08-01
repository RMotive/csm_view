part of '../abstractions/bases/package_sandbox_view_base.dart';

///
final class _PackageLandingLayoutMenu<TLandingThemeBase extends PackageSamdboxThemeBase> extends StatelessWidget {
  final double menuWidth;

  final RouteData routeData;

  final _Graph<TLandingThemeBase> routingGraph;

  const _PackageLandingLayoutMenu({
    required this.menuWidth,
    required this.routingGraph,
    required this.routeData,
  });

  @override
  Widget build(BuildContext context) {
    final TLandingThemeBase theme = ThemingUtils.get(context);
    final IRouter router = InjectorUtils.get();

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: <Widget>[
            for (MapEntry<RouteData, IPackageSandboxItem<TLandingThemeBase>> routingLeaf in routingGraph.entries) ...<Widget>[
              Builder(
                builder: (BuildContext context) {
                  final bool isSelected = routeData == routingLeaf.key;
                  final ThemingData buttonTheme = isSelected ? theme.page : theme.landingHeader;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: PointerArea(
                      cursor: SystemMouseCursors.click,
                      child: SizedBox(
                        width: menuWidth - 16,
                        child: TextButton(
                          style: ButtonStyle(
                            shape: WidgetStateOutlinedBorder.resolveWith(
                              (Set<WidgetState> states) {
                                return RoundedRectangleBorder();
                              },
                            ),
                            backgroundColor: WidgetStateColor.resolveWith(
                              (Set<WidgetState> states) {
                                return buttonTheme.back.withAlpha(200);
                              },
                            ),
                          ),
                          onPressed: isSelected
                              ? null
                              : () {
                                  router.go(context, routingLeaf.key);
                                },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              routingLeaf.key.name,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: buttonTheme.fore,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ],
        ),
      ),
    );
  }
}
