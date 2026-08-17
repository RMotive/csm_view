import 'package:csm_view/csm_view.dart';

typedef PSThemeBase = PackageSandboxThemeBase;
typedef PSItem<ThemeBase extends PSThemeBase> = IPackageSandboxItem<ThemeBase>;
typedef PSItems<ThemeBase extends PSThemeBase> = List<PSItem<ThemeBase>>;
typedef PSItemsGraph<ThemeBase extends PSThemeBase> = Map<RouteData, PSItem<ThemeBase>>;

/// Provides utility methods for [Sandbox] feature purposes.
final class SandboxUtils {
  /// Builds the graph relation for given [sandboxItems] creating their [RouteData] for
  /// navigation in the application.
  static PSItemsGraph<ThemeBase> buildRoutingGraph<ThemeBase extends PSThemeBase>(PSItems<ThemeBase> sandboxItems) {
    Map<RouteData, PSItem<ThemeBase>> graph = <RouteData, PSItem<ThemeBase>>{};

    for (IPackageSandboxItem<ThemeBase> sandboxItem in sandboxItems) {
      String trimmedName = sandboxItem.name.replaceAll(' ', '_');
      String routePath = trimmedName.toLowerCase();
      RouteData routeData = RouteData(
        routePath,
        name: trimmedName,
      );

      graph[routeData] = sandboxItem;
    }

    return graph;
  }

  /// Builds the view routes format for the navigation framework based on given [sandboxItemsGraph], using their built
  /// [RouteData] and each [IPackageSandboxItem] they represent.
  static Iterable<IRoutingGraphData> buildGraphRoutes<ThemeBase extends PSThemeBase>(PSItemsGraph<ThemeBase> sandboxItemsGraph) sync* {
    for (MapEntry<RouteData, PSItem<ThemeBase>> graphItem in sandboxItemsGraph.entries) {
      yield RoutingGraphNode(
        graphItem.key,
        pageBuilder: (_, __) => graphItem.value,
      );
    }
  }
}
