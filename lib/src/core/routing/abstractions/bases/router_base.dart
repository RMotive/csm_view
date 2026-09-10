import 'package:csm_view/csm_view.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart' hide RouteData;

/// Type definition for a dictionary of route tree.
typedef _RouteTree = Map<RouteData, String>;

/// Type definition for a dictionary of route tree entry.
typedef _RouteTreeLeaf = MapEntry<RouteData, String>;

/// Represents a { View } routing context handler.
abstract class RouterBase with ConsoleMixin implements IRouter {
  /// Internal reference to look for ignore redirection property in the extra routing info.
  final String _kIgnoreRedirectionKey = "i-r${DateTime.now().toString()}";

  /// Stores the calculation of absolute paths for the giving routing tree initialized in the application.
  final _RouteTree _absoluteContext = <RouteData, String>{};

  /// Stores the calculation of absolute paths as a log details object to announce.
  final Map<String, Object?> _absoluteContextDetails = <String, Object?>{};

  /// Indicates wheter internal logging is enabled
  bool _loggerOn = false;

  /// Indicates wheter [initNavigator] already was called.
  bool _devResolverOn = false;

  /// Creates a new instance.
  ///
  /// [routes] - [RoutingGraphBase] nodes to calculate as the application's routes.
  ///
  /// [allowLogs] - Whether the methods must show console logs.
  RouterBase(List<IRoutingGraphData> routes, [bool allowLogs = false]) {
    for (IRoutingGraphData route in routes) {
      _resolveAbsolutePath(route, '');
    }

    _loggerOn = allowLogs;
    if (_canLog()) {
      successLog(
        'Router tree successfully inited',
        info: <String, Object?>{
          'route-tree': _absoluteContext.map(
            (RouteData key, String value) {
              return MapEntry<String, Object?>("(${key.name} | ${key.path} | ${key.hashCode})", value);
            },
          ),
        },
      );
    }
  }

  @override
  RouteData getRouteData(String absolutePath, [bool allowLogs = false]) {
    for (_RouteTreeLeaf calculation in _absoluteContext.entries) {
      if (absolutePath == calculation.value) return calculation.key;
    }

    if (_canLog(allowLogs)) {
      warningLog(
        'Absolute path not in Router tree',
        info: <String, dynamic>{
          'Absolute Path': absolutePath,
          'Router Tree': _absoluteContextDetails,
        },
      );
    }
    throw Exception('Absolute path not in Router tree');
  }

  @override
  String getAbsolutePath(RouteData route, [bool allowLogs = false]) {
    final bool canLog = _canLog(allowLogs);
    if (!_absoluteContext.containsKey(route)) {
      if (canLog) {
        warningLog(
          'Route not in route tree',
          info: <String, dynamic>{
            'route': route,
            'route-tree': _absoluteContextDetails,
          },
        );
      }
      throw Exception('Route not in Router tree');
    }
    return _absoluteContext[route] as String;
  }

  @override
  String? resolveDevRedirection(RouteData route, String currentPath, String? targetPath, [bool allowLogs = false]) {
    if (!_absoluteContext.containsKey(route)) {
      if (_canLog(allowLogs)) {
        warningLog(
          'Configured development Route isn\' in the Router tree',
          info: <String, dynamic>{
            'Development Route': route,
            'Router Tree': _absoluteContextDetails,
          },
        );
      }
      return null;
    }

    final String devPath = _absoluteContext[route] as String;
    if (currentPath.isEmpty || (devPath == targetPath)) return devPath;
    return null;
  }

  /// Checks if the [resolveDevelopment] is ready to be triggered.
  ///
  ///  Notes:
  ///   - Doesn't contain logs.
  bool devRedirectNode() {
    if (_devResolverOn) return false;

    return (_devResolverOn = true);
  }

  @override
  void go(
    BuildContext context,
    RouteData route, {
    bool ignoreRedirection = false,
    bool allowLogs = false,
    bool pushHistory = false,
    DataMap? extraData,
  }) {
    extraData ??= <String, dynamic>{};

    if (ignoreRedirection) {
      extraData[_kIgnoreRedirectionKey] = true;
    }

    final bool canLog = _canLog(allowLogs);

    if (pushHistory) {
      GoRouter.of(context).pushNamed(route.name, extra: extraData);
    } else {
      GoRouter.of(context).goNamed(route.name, extra: extraData);
    }
    if (canLog) {
      successLog(
        'Success drive',
        info: <String, Object?>{
          'Route': route.hashCode,
          'Route Name': route.name,
          'Route Extra': extraData,
          'Is Push': pushHistory,
        },
      );
    }
  }

  //* --> Private static methods

  /// Calculates an absolute path based on the parent absolute path and the current node [RouteData].
  ///
  ///
  /// [routeNode] absolute path fromn the desired [RouteB].
  ///
  /// [parentAbsolute] the parent node absolute path calculation to join them.
  ///
  /// Notes:
  ///   - Doesn't contain logs.
  void _resolveAbsolutePath(IRoutingGraphData routeNode, String parentAbsolute) {
    if (routeNode is RoutingGraphNodeDataBase) {
      RouteData route = routeNode.route;
      String relativePath = route.path;
      if (relativePath.startsWith('/')) {
        relativePath = relativePath.replaceFirst('/', '');
      }
      String absolutePath = '$parentAbsolute/$relativePath';
      // --> Adding to absolute context
      _absoluteContext[route] = absolutePath;
      // --> Adding to absolute context details
      _absoluteContextDetails[route.toString()] = absolutePath;
      parentAbsolute = absolutePath;
    }
    for (IRoutingGraphData routeLeef in routeNode.routes) {
      _resolveAbsolutePath(routeLeef, parentAbsolute);
    }
  }

  //* --> Private instance methods.

  /// Checks if the [RouterBase] operations can be logged.
  ///
  /// [logging] whether the method can log operations.
  bool _canLog([bool logging = false]) {
    if (!logging) return _loggerOn;
    return logging;
  }
}
