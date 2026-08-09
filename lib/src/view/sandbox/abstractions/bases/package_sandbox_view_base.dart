import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:csm_view/src/core/utils/widget_adaption_utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part '../../_package_landing_layout/_package_landing_layout.dart';
part '../../_package_landing_layout/_package_landing_layout_menu.dart';
part '../../_package_landing_layout/_package_landing_layou_header.dart';

part '../../_package_sandbox_entry_layout/_package_landing_entry_layout.dart';
part '../../_package_sandbox_entry_layout/_package_landing_device_details.dart';

part '../../_page_sandbox_welcome/_package_sandbox_welcome.dart';
part '../../_page_sandbox_welcome/_package_sandbox_welcome_item_card.dart';

typedef _Graph<TThemeB extends PackageSamdboxThemeBase> = Map<RouteData, IPackageSandboxItem<TThemeB>>;

/// View home route.
final RouteData _homeRouteData = RouteData(
  '',
  name: 'home',
);

/// Represents a package sandbox view, which provides user interactive interfaces to see and check how package
/// components behave.
/// 
/// [ThemeBase] represents the theme type.
abstract class PackageSandboxViewBase<ThemeBase extends PackageSamdboxThemeBase> extends ViewModuleBase {
  /// Package name.
  final String name;

  /// Package description.
  final DescriptionBuilder<ThemeBase> description;

  /// Package playground items.
  final List<IPackageSandboxItem<ThemeBase>> sandboxItems;

  /// Creates a new instance.
  const PackageSandboxViewBase({
    super.key,
    required this.name,
    required this.description,
    required this.sandboxItems,
  });

  @override
  List<ThemeBase> bootstrapTheming();

  @override
  List<IRoutingGraphData> bootstrapRouting() {
    final NavigationState itemLayoutKey = GlobalKey();
    final NavigationState navigationLayoutKey = GlobalKey();

    final (_Graph<ThemeBase> navigationGraph, _Graph<ThemeBase> packageEntriesGraph, List<IRoutingGraphData> routesGraph) = composeContextGraphs(itemLayoutKey, navigationLayoutKey);

    return <IRoutingGraphData>[
      /// --> Landing Navigation Layour
      RoutingGraphLayout(
        navigatorStateKey: navigationLayoutKey,
        routes: <IRoutingGraphData>[
          /// --> Home Route
          RoutingGraphNode(
            _homeRouteData,
            pageBuilder: (BuildContext ctx, _) => _PackageSandboxWelcome<ThemeBase>(
              name: name,
              routingGraph: navigationGraph,
              description: description,
            ),
          ),

          /// --> Entry Layout
          RoutingGraphLayout(
            routes: routesGraph,
            navigatorStateKey: itemLayoutKey,
            layoutBuilder: (BuildContext ctx, RoutingData routingData, Widget page) {
              IPackageSandboxItem<ThemeBase> landingEntry = packageEntriesGraph.entries
                  .firstWhere(
                    (MapEntry<RouteData, IPackageSandboxItem<ThemeBase>> element) => element.key == routingData.targetRoute,
                  )
                  .value;

              return _PackageLandingEntryLayout<ThemeBase>(
                page: page,
                routingData: routingData,
                landingEntry: landingEntry,
              );
            },
          ),
        ],
        layoutBuilder: (BuildContext ctx, RoutingData routingData, Widget page) {
          return _PackageLandingViewLayout<ThemeBase>(
            page: page,
            routingData: routingData,
            themes: bootstrapTheming(),
            routingGraph: navigationGraph,
          );
        },
      ),
    ];
  }

  @override
  Widget bootstrapBuild(BuildContext context, Widget? app) {
    PackageSamdboxThemeBase theme = ThemingUtils.get(context);

    return super.bootstrapBuild(
      context,
      ColoredBox(
        color: theme.page.back,
        child: Theme(
          data: ThemeData(
            textTheme: TextTheme(
              headlineSmall: TextStyle(
                color: theme.page.fore,
              ),
            ),
          ),
          child: DefaultTextStyle(
            key: UniqueKey(),
            style: TextStyle(
              color: theme.page.fore,
            ),
            child: app!,
          ),
        ),
      ),
    );
  }

  /// Composes the view contexts grapths.
  ///
  /// [itemLayoutKey] is the [NavigationState] for the layout that handles how each item view is built.
  ///
  /// [navigationLayourKey] is the [NavigationState] for the view navigation layout where user selects items.
  (_Graph<ThemeBase>, _Graph<ThemeBase>, List<IRoutingGraphData>) composeContextGraphs(NavigationState itemLayoutKey, NavigationState navigationLayoutKey) {
    _Graph<ThemeBase> navigationGraph = <RouteData, IPackageSandboxItem<ThemeBase>>{};
    _Graph<ThemeBase> packageItemsGraph = <RouteData, IPackageSandboxItem<ThemeBase>>{};

    List<IRoutingGraphData> routes = <IRoutingGraphData>[];
    for (IPackageSandboxItem<ThemeBase> landingEntry in sandboxItems) {
      String entryRoutePath = landingEntry.name.toLowerCase().replaceAll(' ', '_');

      RouteData entryRoute = RouteData(entryRoutePath, name: landingEntry.name);

      navigationGraph[entryRoute] = landingEntry;
      packageItemsGraph[entryRoute] = landingEntry;

      void nestedRoutesIterator(List<IRoutingGraphData> nestedRoutes) {
        for (IRoutingGraphData nestedRoute in nestedRoutes) {
          if (nestedRoute is RoutingGraphNodeDataBase) {
            packageItemsGraph[nestedRoute.route] = landingEntry;
          }

          nestedRoutesIterator(nestedRoute.routes);
        }
      }

      List<IRoutingGraphData> nestdRoutes = landingEntry.composeRoutes(navigationLayoutKey, itemLayoutKey);
      routes.add(
        RoutingGraphNode(
          entryRoute,
          routes: nestdRoutes,
          pageBuilder: (BuildContext ctx, RoutingData routeData) => landingEntry,
        ),
      );
      nestedRoutesIterator(
        landingEntry.composeRoutes(navigationLayoutKey, itemLayoutKey),
      );
    }

    return (navigationGraph, packageItemsGraph, routes);
  }
}
