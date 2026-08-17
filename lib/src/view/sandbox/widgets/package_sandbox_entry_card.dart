import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// A card displayed that displays the information of each [IPackageSandboxItem] and its [RouteData] to handle routing when it's clicked.
///
/// [ThemeBase] type of the theme.
final class PackageSandboxWelcomeEntryCard<ThemeBase extends PackageSandboxThemeBase> extends StatelessWidget {
  /// Route data for redirection behavior.
  final RouteData routeData;

  /// Sandbox item data.
  final IPackageSandboxEntry<ThemeBase> sandboxItem;

  /// Creates a new instance.
  const PackageSandboxWelcomeEntryCard({
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
    ThemingData cardTheme = theme.welcomeCardTheming;

    return PointerArea(
      cursor: SystemMouseCursors.click,
      onClick: () => onClick(context),
      child: Card(
        elevation: 8,
        color: cardTheme.back,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              //* Card header.
              Row(
                spacing: 12,
                children: <Widget>[
                  //* Card image decorator.
                  sandboxItem.image != null
                      ? Image(
                          image: sandboxItem.image!,
                          width: 48,
                          height: 48,
                          color: cardTheme.fore,
                        )
                      : Icon(
                          sandboxItem.icon != null ? sandboxItem.icon! : Icons.widgets,
                          color: cardTheme.fore,
                          size: 48,
                        ),

                  //* Card title.
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Tooltip(
                          message: sandboxItem.name,
                          child: Text(
                            sandboxItem.name,
                            style: TextStyle(
                              fontSize: 18,
                              color: cardTheme.fore,
                              fontWeight: FontWeight.w900,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //* Card content.
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    //* Card description
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text.rich(
                            sandboxItem.description(theme, cardTheme.fore),
                            style: TextStyle(
                              fontSize: 15,
                              color: cardTheme.fore,
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
