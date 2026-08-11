part of '../abstractions/bases/package_sandbox_view_base.dart';

/// A card displayed that displays the information of each [IPackageSandboxItem] and its [RouteData] to handle routing when it's clicked.
///
/// [ThemeBase] type of the theme.
final class _PackageSandboxWelcomeItemCard<ThemeBase extends PackageSandboxThemeBase> extends StatelessWidget {
  /// Route data for redirection behavior.
  final RouteData routeData;

  /// Sandbox item data.
  final IPackageSandboxEntry<ThemeBase> sandboxItem;

  /// Creates a new instance.
  const _PackageSandboxWelcomeItemCard({
    super.key,
    required this.routeData,
    required this.sandboxItem,
  });

  /// Event when the component is clicked.
  ///
  /// [viewContext] is the framework building provided context.
  void onClick(BuildContext viewContext) {
    final IRouter router = InjectorUtils.get();

    router.go(viewContext, routeData);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBase theme = ThemingUtils.get(context);

    return PointerArea(
      cursor: SystemMouseCursors.click,
      onClick: () => onClick(context),
      child: Card(
        elevation: 8,
        color: theme.welcomeCardTheming.back,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              //* Card image decorator.
              Expanded(
                flex: 1,
                child: (sandboxItem.image == null)
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
                        image: sandboxItem.image!,
                      ),
              ),
        
              //* Card content.
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    //* Card title.
                    Tooltip(
                      message: sandboxItem.name,
                      child: Text(
                        sandboxItem.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    //* Card description
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text.rich(
                            sandboxItem.description(theme, theme.welcomeCardTheming.fore),
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
