part of '../abstractions/bases/package_sandbox_view_base.dart';

final class _PackageLandingWelcomeEntry<T extends PackageSamdboxThemeBase> extends StatelessWidget {
  final IPackageSandboxItem<T> landingEntry;

  final RouteData route;

  const _PackageLandingWelcomeEntry({
    super.key,
    required this.route,
    required this.landingEntry,
  });

  @override
  Widget build(BuildContext context) {
    final T theme = ThemingUtils.get(context);
    final IRouter router = InjectorUtils.get();

    return PointerArea(
      cursor: SystemMouseCursors.click,
      onClick: () {
        router.go(context, route);
      },
      child: Card.filled(
        elevation: 8,
        color: theme.welcomeCardTheming.back,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: landingEntry.image == null
                    ? Placeholder(
                        color: Colors.red,
                        strokeWidth: 2,
                        child: Center(
                          child: Text(
                            'No image provider set',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    : Image(
                        image: landingEntry.image!,
                      ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    // --> Entry card title
                    Tooltip(
                      message: landingEntry.name,
                      child: Text(
                        landingEntry.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text.rich(
                            landingEntry.description(theme, theme.welcomeCardTheming.fore),
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
