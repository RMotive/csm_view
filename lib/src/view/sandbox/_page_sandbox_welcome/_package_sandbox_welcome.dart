part of '../abstractions/bases/package_sandbox_view_base.dart';


/// Composes a welcome view page for the [PackageSandboxViewBase].
/// 
/// [T] type of the delegated application theme base usage.
final class _PackageSandboxWelcome<T extends PackageSamdboxThemeBase> extends ViewPageBase {
  /// Name of the package being sandbox'd.
  final String name;

  /// General description of the package being sandbox'd.
  final DescriptionBuilder<T> description;

  /// View routing grapth.
  final Map<RouteData, IPackageSandboxItem<T>> routingGraph;

  /// Creates a new [_PackageSandboxWelcome] instance.
  const _PackageSandboxWelcome({
    required this.name,
    required this.routingGraph,
    required this.description,
  });

  @override
  Widget compose(BuildContext context, Size windowSize, Size pageSize) {
    final T theme = ThemingUtils.get(context);

    return SizedBox.fromSize(
      size: pageSize,
      child: Column(
        children: <Widget>[
          // Welcome title header.
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Welcome to $name playground!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),

          // Package description.
          Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Text.rich(
                description(theme, theme.page.fore),
              ),
            ),
          ),

          // Dashboard entries access section.
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (BuildContext buildContext, BoxConstraints boxConstraints) {
                  final ScrollController gridScroll = ScrollController();

                  return Scrollbar(
                    controller: gridScroll,
                    thumbVisibility: true,
                    trackVisibility: true,
                    thickness: 5,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: gridScroll,
                      child: ConstrainedBox(
                        constraints: boxConstraints
                            .copyWith(
                              minWidth: 700,
                            )
                            .normalize(),
                        child: LayoutBuilder(
                          builder: (BuildContext buildContext, BoxConstraints boxConstraints) {
                            final WidgetResponsiveness widgetResponsiveness = WidgetResponsiveness.i;
                            final double gridWidth = boxConstraints.constrainWidth();
                            double minExtent = WidgetAdaptionUtils.adaptProperty<double>(
                              mobileValue: gridWidth / 2,
                              defaultValue: widgetResponsiveness.breakProperty(
                                ResponsivenessBreakpoint<double>(
                                  small: 250,
                                  medium: 300,
                                  large: 350,
                                ),
                              ),
                            );

                            return GridView.builder(
                              itemCount: routingGraph.entries.length,
                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: minExtent,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                childAspectRatio: 1.75,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                MapEntry<RouteData, IPackageSandboxItem<T>> routingEntry = routingGraph.entries.elementAt(index);

                                return _PackageSandboxWelcomeItemCard<T>(
                                  sandboxItem: routingEntry.value,
                                  routeData: routingEntry.key,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
