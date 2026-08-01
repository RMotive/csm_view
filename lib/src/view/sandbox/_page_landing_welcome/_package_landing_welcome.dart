part of '../abstractions/bases/package_sandbox_view_base.dart';

/// [Widget] for [PackageLandingView].
///
///
/// [T] type of the delegated application theme base usage.
///
/// Draws a view for routing entry point ([Home]) for the landing package view.
final class _PackageLandingWelcome<T extends PackageSamdboxThemeBase> extends ViewPageBase {
  /// Package displayed name.
  final String packageName;

  /// Package displayed description.
  final DescriptionBuilder<T> packageDescription;

  /// Landing routing tree.
  final Map<RouteData, IPackageSandboxItem<T>> routingGraph;

  /// Creates a new [_PackageLandingWelcome] instance.
  const _PackageLandingWelcome({
    required this.packageName,
    required this.routingGraph,
    required this.packageDescription,
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
              'Welcome to $packageName playground!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),

          // Package description.
          Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Text.rich(
                packageDescription(theme, theme.page.fore),
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

                                return _PackageLandingWelcomeEntry<T>(
                                  landingEntry: routingEntry.value,
                                  route: routingEntry.key,
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
