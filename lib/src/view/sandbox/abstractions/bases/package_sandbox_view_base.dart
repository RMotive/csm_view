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

part '../../_page_landing_welcome/_package_landing_welcome.dart';
part '../../_page_landing_welcome/_package_landing_welcome_entry.dart';

typedef _Graph<TThemeB extends PackageSamdboxThemeBase> = Map<RouteData, IPackageSandboxItem<TThemeB>>;

final RouteData _homeRouteData = RouteData(
  '',
  name: 'home',
);

///
abstract class PackageSandboxViewBase<ThemeBase extends PackageSamdboxThemeBase> extends ViewModuleBase {
  /// Package name.
  final String name;

  /// Package description.
  final DescriptionBuilder<ThemeBase> description;

  /// Package playground entry.
  final List<IPackageSandboxItem<ThemeBase>> packageEntries;

  const PackageSandboxViewBase({
    super.key,
    required this.name,
    required this.description,
    required this.packageEntries,
  });

  @override
  List<ThemeBase> bootstrapTheming();

  @override
  List<IRoutingGraphData> bootstrapRouting() {
    final NavigationState entriesLayoutKey = GlobalKey();
    final NavigationState navigationLayoutKey = GlobalKey();

    final (_Graph<ThemeBase> navigationGraph, _Graph<ThemeBase> packageEntriesGraph, List<IRoutingGraphData> routesGraph) = composeContextGraphs(entriesLayoutKey, navigationLayoutKey);

    return <IRoutingGraphData>[
      /// --> Landing Navigation Layour
      RoutingGraphLayout(
        navigatorStateKey: navigationLayoutKey,
        routes: <IRoutingGraphData>[
          /// --> Home Route
          RoutingGraphNode(
            _homeRouteData,
            pageBuilder: (BuildContext ctx, _) => _PackageLandingWelcome<ThemeBase>(
              packageName: name,
              routingGraph: navigationGraph,
              packageDescription: description,
            ),
          ),

          /// --> Entry Layout
          RoutingGraphLayout(
            routes: routesGraph,
            navigatorStateKey: entriesLayoutKey,
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

  (_Graph<ThemeBase>, _Graph<ThemeBase>, List<IRoutingGraphData>) composeContextGraphs(NavigationState entriesLayoutKey, NavigationState navigationLayoutKey) {
    _Graph<ThemeBase> navigationGraph = <RouteData, IPackageSandboxItem<ThemeBase>>{};
    _Graph<ThemeBase> pakcageEntriesGraph = <RouteData, IPackageSandboxItem<ThemeBase>>{};

    List<IRoutingGraphData> routes = <IRoutingGraphData>[];
    for (IPackageSandboxItem<ThemeBase> landingEntry in packageEntries) {
      String entryRoutePath = landingEntry.name.toLowerCase().replaceAll(' ', '_');

      RouteData entryRoute = RouteData(entryRoutePath, name: landingEntry.name);

      navigationGraph[entryRoute] = landingEntry;
      pakcageEntriesGraph[entryRoute] = landingEntry;

      void nestedRoutesIterator(List<IRoutingGraphData> nestedRoutes) {
        for (IRoutingGraphData nestedRoute in nestedRoutes) {
          if (nestedRoute is RoutingGraphNodeDataBase) {
            pakcageEntriesGraph[nestedRoute.route] = landingEntry;
          }

          nestedRoutesIterator(nestedRoute.routes);
        }
      }

      List<IRoutingGraphData> nestdRoutes = landingEntry.composeRoutes(navigationLayoutKey, entriesLayoutKey);
      routes.add(
        RoutingGraphNode(
          entryRoute,
          routes: nestdRoutes,
          pageBuilder: (BuildContext ctx, RoutingData routeData) => landingEntry,
        ),
      );
      nestedRoutesIterator(
        landingEntry.composeRoutes(navigationLayoutKey, entriesLayoutKey),
      );
    }

    return (navigationGraph, pakcageEntriesGraph, routes);
  }
}
