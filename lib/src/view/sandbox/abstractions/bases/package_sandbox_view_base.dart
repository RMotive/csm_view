import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part '../../layouts/_package_sandbox_entry_layout/_package_sandbox_entry_layout.dart';
part '../../layouts/_package_sandbox_entry_layout/_package_sandbox_device_details.dart';

part '../../widgets/_package_sandbox_welcome.dart';

/// Definition for complex sandbox routing graph.
typedef _Graph<TThemeB extends PackageSandboxThemeBase> = Map<RouteData, IPackageSandboxEntry<TThemeB>>;

/// View home route.
final RouteData _homeRouteData = RouteData(
  '',
  name: 'home',
);

/// Represents a package sandbox view, which provides user interactive interfaces to see and check how package
/// components behave.
///
/// [ThemeBase] theme base type.
abstract class PackageSandboxViewBase<ThemeBase extends PackageSandboxThemeBase> extends ViewModuleBase {
  /// Package name.
  final String name;

  /// Package description.
  final DescriptionBuilder<ThemeBase> description;

  /// Package playground items.
  final List<IPackageSandboxEntry<ThemeBase>> sandboxEntries;

  /// Creates a new instance.`
  const PackageSandboxViewBase({
    super.key,
    required this.name,
    required this.description,
    required this.sandboxEntries,
  });

  @override
  List<ThemeBase> bootstrapTheming();

  @override
  List<IRoutingGraphData> bootstrapRouting() {
    final NavigationState itemLayoutKey = GlobalKey();
    final NavigationState navigationLayoutKey = GlobalKey();

    final (_Graph<ThemeBase> navigationGraph, _Graph<ThemeBase> packageEntriesGraph, List<IRoutingGraphData> routesGraph) = composeContextGraphs(itemLayoutKey, navigationLayoutKey);

    return <IRoutingGraphData>[
      ///* NavigationLayout
      RoutingGraphLayout(
        navigatorStateKey: navigationLayoutKey,
        routes: <IRoutingGraphData>[
          //* Home Route
          RoutingGraphNode(
            _homeRouteData,
            pageBuilder: (BuildContext ctx, _) => _PackageSandboxWelcome<ThemeBase>(
              name: name,
              routingGraph: navigationGraph,
              description: description,
            ),
          ),

          //* Entries Layout
          RoutingGraphLayout(
            routes: routesGraph,
            navigatorStateKey: itemLayoutKey,
            layoutBuilder: (BuildContext ctx, RoutingData routingData, Widget page) {
              IPackageSandboxEntry<ThemeBase> sandboxEntry = packageEntriesGraph.entries
                  .firstWhere(
                    (MapEntry<RouteData, IPackageSandboxEntry<ThemeBase>> element) => element.key == routingData.targetRoute,
                  )
                  .value;

              return _PackageSandboxEntryLayout<ThemeBase>(
                page: page,
                routingData: routingData,
                sandboxEntries: sandboxEntry,
              );
            },
          ),
        ],
        layoutBuilder: (BuildContext ctx, RoutingData routingData, Widget page) {
          return NavigationLayout(
            page: page,
            routingData: routingData,
            homeRouteData: _homeRouteData,
            navigationNodes: navigationGraph.entries.map<NavigationLayoutNode>(
              (MapEntry<RouteData, IPackageSandboxEntry<ThemeBase>> navigationRoute) {
                return NavigationLayoutNode(
                  title: navigationRoute.value.name,
                  routeData: navigationRoute.key,
                );
              },
            ).toList(),
          );
        },
      ),
    ];
  }

  @override
  Widget bootstrapBuild(BuildContext context, Widget? app) {
    PackageSandboxThemeBase theme = ThemingUtils.get(context);

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
    _Graph<ThemeBase> navigationGraph = <RouteData, IPackageSandboxEntry<ThemeBase>>{};
    _Graph<ThemeBase> packageItemsGraph = <RouteData, IPackageSandboxEntry<ThemeBase>>{};

    List<IRoutingGraphData> routes = <IRoutingGraphData>[];
    for (IPackageSandboxEntry<ThemeBase> sandboxItem in sandboxEntries) {
      String itemRoutePath = sandboxItem.name.toLowerCase().replaceAll(' ', '_');

      RouteData entryRoute = RouteData(itemRoutePath, name: sandboxItem.name);

      navigationGraph[entryRoute] = sandboxItem;
      packageItemsGraph[entryRoute] = sandboxItem;

      void nestedRoutesIterator(List<IRoutingGraphData> nestedRoutes) {
        for (IRoutingGraphData nestedRoute in nestedRoutes) {
          if (nestedRoute is RoutingGraphNodeDataBase) {
            packageItemsGraph[nestedRoute.route] = sandboxItem;
          }

          nestedRoutesIterator(nestedRoute.routes);
        }
      }

      List<IRoutingGraphData> nestdRoutes = sandboxItem.composeRoutes(navigationLayoutKey, itemLayoutKey);
      routes.add(
        RoutingGraphNode(
          entryRoute,
          routes: nestdRoutes,
          pageBuilder: (BuildContext ctx, RoutingData routeData) => sandboxItem,
        ),
      );
      nestedRoutesIterator(
        sandboxItem.composeRoutes(navigationLayoutKey, itemLayoutKey),
      );
    }

    return (navigationGraph, packageItemsGraph, routes);
  }
}
