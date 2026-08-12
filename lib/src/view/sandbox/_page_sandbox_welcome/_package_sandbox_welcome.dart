part of '../abstractions/bases/package_sandbox_view_base.dart';

/// A welcome view page for the [PackageSandboxViewBase].
///
/// [ThemeBase] type of the delegated application theme base usage.
final class _PackageSandboxWelcome<ThemeBase extends PackageSandboxThemeBase> extends ViewPageBase {
  /// Name of the package being sandbox'd.
  final String name;

  /// General description of the package being sandbox'd.
  final DescriptionBuilder<ThemeBase> description;

  /// View routing grapth.
  final Map<RouteData, IPackageSandboxEntry<ThemeBase>> routingGraph;

  /// Creates a new [_PackageSandboxWelcome] instance.
  const _PackageSandboxWelcome({
    required this.name,
    required this.routingGraph,
    required this.description,
  });

  @override
  Widget compose(BuildContext context, Size windowSize, Size pageSize) {
    final ThemeBase theme = ThemingUtils.get(context);

    return SizedBox.fromSize(
      size: pageSize,
      child: Column(
        children: <Widget>[
          //* Welcome title header.
          Padding(
            padding: EdgeInsets.all(16),
            child: RichText(
              text: TextSpan(
                text: 'Welcome to ',
                style: Theme.of(context).textTheme.headlineSmall,
                children: <InlineSpan>[
                  //* Package name.
                  TextSpan(
                    text: name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  TextSpan(
                    text: ' sandbox',
                  ),
                ],
              ),
            ),
          ),

          //* Description
          Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Text.rich(
                description(
                  theme,
                  theme.page.fore,
                ),
              ),
            ),
          ),

          //* Sandbox entries cards.
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox.expand(
                child: LayoutBuilder(
                  builder: (BuildContext viewContext, BoxConstraints cardsContainerConstraints) {
                    const BoxConstraints cardConstraints = BoxConstraints(
                      maxWidth: 425,
                      minWidth: 225,
                    );
                    cardsContainerConstraints = cardsContainerConstraints.normalize();
                    double widthSpace = cardsContainerConstraints.biggest.width;
                    double cardWidth = widthSpace / 4;

                    return SingleChildScrollView(
                      child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: routingGraph.entries.map<Widget>(
                          (MapEntry<RouteData, IPackageSandboxEntry<ThemeBase>> sandboxRoutedEntry) {
                            return ConstrainedBox(
                              constraints: cardConstraints,
                              child: AspectRatio(
                                aspectRatio: 2 / 1,
                                child: SizedBox(
                                  width: cardWidth,
                                  child: _PackageSandboxWelcomeItemCard<ThemeBase>(
                                    routeData: sandboxRoutedEntry.key,
                                    sandboxItem: sandboxRoutedEntry.value,
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
