import 'package:csm_foundation_view/src/common/common_module.dart';
import 'package:csm_foundation_view/src/router/router_module.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Type definition for a dictionary of route tree.
typedef _RouteTree = Map<CSMRouteOptions, String>;

/// Type definition for a dictionary of route tree entry.
typedef _RouteTreeEntry = MapEntry<CSMRouteOptions, String>;

/// --> Dependency gather of [CSMAdvisor].
///
/// Internal advisor impl to announce [RouteDriver] context messages.
const CSMAdvisor _advisor = CSMAdvisor('route-driver');

/// This helper provides several functionallities for Cosmos Foundation routing.
class CSMRouter {
  /// Internal reference to look for ignore redirection property in the extra routing info.
  final String _kIgnoreRedirectionKey = "i-r${DateTime.now().toString()}";

  // --> Singleton impl.
  /// --> Already singleton inited object.
  ///
  /// Stores the local static instance of the Manager that will be used along all its invokes.
  static CSMRouter? _instance;
  CSMRouter._();

  /// Gathers the current application [RouteDriver] manager instance.
  ///
  /// If you know it's the first time that you gather this singleton object (init gather), you must invoke
  /// [initNavigator] method to initialize the internal [NavigatorState] to manage the routing, and recommended
  /// if you're using [CSMRouteBase] invoke [initRouteTree] to initialize the route tree calculation that is a
  /// dependency to the correct functionallity along [CSMRouteBase] nodes and layouts routing.
  static CSMRouter get i => _instance ??= CSMRouter._();

  /// --> Local manager navigator subscribed along the main application and the driver manager usage.
  ///
  /// This is subscribed after [initNavigator] static method that is already subscribed to the
  /// initialization method of [Cosmos] default application methods, for custom applications
  /// that uses several managers from [Cosmos] nor using [CosmosApp] or [CosmosRouting]. Needs to
  /// invoke the method [initNavigator] to initialize dependencies.
  static Navigation? _navigator;

  /// --> Local manager navigator subscribed along the main application and the driver manager usage.
  ///
  /// This is subscribed after [initNavigator] static method that is already subscribed to the
  /// initialization method of [Cosmos] default application methods, for custom applications
  /// that uses several managers from [Cosmos] nor using [CosmosApp] or [CosmosRouting]. Needs to
  /// invoke the method [initNavigator] to initialize dependencies.
  static Navigation get _nav {
    if (_navigator != null) return _navigator as Navigation;
    throw Exception('NavigatorState dependency lack. Left use of [initNavigator] method');
  }

  /// Stores the calculation of absolute paths for the giving routing tree initialized in the application.
  static final _RouteTree _absoluteContext = <CSMRouteOptions, String>{};

  /// Stores the calculation of absolute paths as a log details object to announce.
  static final JObject _absoluteContextDetails = <String, dynamic>{};

  /// Indicates wheter internal logging is enabled
  static bool _advisorEnabled = false;

  /// Indicates wheter [initRouteTree] already was called.
  static bool _isTreeInited = false;

  /// Indicates wheter [initNavigator] already was called.
  static bool _isDevResolver = false;

  //* --> Public static methods

  /// Initializes the mandatory dependency for navigation along the router management implementation of your application.
  ///
  /// [nav] : [NavigatorState] that the manager will use along the application to enroute.
  /// [log] : Wheter the method can announce logs.
  static void initNavigator(Navigation nav, {bool? log}) {
    _navigator ??= nav;
    if (i._canLog(log)) {
      _advisor.success(
        'Navigator inited',
        info: <String, dynamic>{
          'nav-hash': _nav.hashCode,
        },
      );
    }
  }

  /// Initializes the RouteTree used for applications that use [CosmosRouting] impl.
  ///
  /// [routes] : Route tree subscribed to the application routing options that will be used
  /// to calculate the internal route tree for [CosmosRouting] impls.
  /// [log] : Wheter the method can announce logs.
  static void initRouteTree(List<CSMRouteBase> routes, {bool? log}) {
    if (_isTreeInited) return;
    for (CSMRouteBase route in routes) {
      _calAbsolute(route, '');
    }
    _isTreeInited = true;
    if (i._canLog(log)) {
      _advisor.success(
        'Successfully route tree inited',
        info: <String, dynamic>{
          'route-tree': _absoluteContext.map(
            (CSMRouteOptions key, String value) {
              return JEntry("(${key.name} | ${key.path} | ${key.hashCode})", value);
            },
          ),
        },
      );
    }
  }

  /// Sets the global context of logs for [RouteDriver] invokes.
  static void turnLogs(bool enable) {
    _advisorEnabled = enable;
  }

  //* --> Public instance methods

  /// Gets the absolute path calculation from a specific [CSMRouteOptions] instance into the calculated Route Tree.
  ///
  /// [instance] : The required [CSMRouteOptions]'s absolute path calculation.
  /// [log] : Wheter the method can announce logs.
  String getAbsolute(CSMRouteOptions instance, {bool? log}) {
    final bool canLog = _canLog(log);
    if (!_isTreeInited) {
      if (canLog) {
        _advisor.warning('Route tree not initialized yet');
      }
      throw Exception('Route tree not initialized yet');
    }

    if (!_absoluteContext.containsKey(instance)) {
      if (canLog) {
        _advisor.warning(
          'Route not in route tree',
          info: <String, dynamic>{
            'route': instance,
            'route-tree': _absoluteContextDetails,
          },
        );
      }
      throw Exception('Route not in route tree');
    }
    return _absoluteContext[instance] as String;
  }

  /// Gets the [CSMRouteOptions] from a given absolute path.
  ///
  /// [absolutePath] : Absolute path to get the [CSMRouteOptions].
  /// [log] : Wheter the method can announce logs.
  CSMRouteOptions getOptions(
    String absolutePath, {
    bool? log,
  }) {
    for (_RouteTreeEntry calculation in _absoluteContext.entries) {
      if (absolutePath == calculation.value) return calculation.key;
    }

    if (_canLog(log)) {
      _advisor.warning(
        'Absolute path not in route tree',
        info: <String, dynamic>{
          'absolute-path': absolutePath,
          'route-tree': _absoluteContextDetails,
        },
      );
    }
    throw Exception('Absolute path not in route tree');
  }

  /// Evaluates if the development route redirection should be performed into the master routing redirection.
  ///
  /// [devRoute] : [CosmosRouting] devRoute specified.
  /// [currentPath] : The current application path.
  /// [targetPath] : The target path where the application wants to go.
  String? devRedirect(CSMRouteOptions devRoute, String currentPath, String? targetPath, {bool? log}) {
    if (!_absoluteContext.containsKey(devRoute)) {
      if (_canLog(log)) {
        _advisor.warning(
          'devRoute not in route tree',
          info: <String, dynamic>{
            'dev-route': devRoute,
            'route-tree': _absoluteContextDetails,
          },
        );
      }
      return null;
    }

    final String devPath = _absoluteContext[devRoute] as String;
    if (currentPath.isEmpty || (devPath == targetPath)) return devPath;
    return null;
  }

  /// Evaluates if the development route redirection should be performed into a node redirection.
  ///
  ///  Notes:
  ///   - Doesn't contain logs.
  bool devRedirectNode() {
    if (_isDevResolver) return false;
    _isDevResolver = true;
    return true;
  }

  /// Routes the application to the desired node.
  ///
  /// [options] : [CSMRouteOptions] to the desired route node target.
  /// [ignoreRedirection] : Indicates if the drive should ignore target node redirection.
  /// [push] : Indicates if the history should push the route.
  /// [extra] : Extra data subscribed to the target route node.
  /// [log] : Wheter the nethod can announce logs.
  void drive(
    CSMRouteOptions options, {
    bool ignoreRedirection = false,
    bool push = false,
    JObject? extra,
    bool? log,
  }) {
    if (ignoreRedirection) {
      extra ??= <String, dynamic>{};
      if (!extra.containsKey(_kIgnoreRedirectionKey)) {
        extra.addEntries(
          <JEntry>[
            JEntry(_kIgnoreRedirectionKey, true),
          ],
        );
      }
    }

    final bool canLog = _canLog(log);
    final NavigatorState? navState = _nav.currentState;
    final BuildContext? navCtx = navState?.context;
    final BuildContext? navigation = _nav.currentContext;

    if (navCtx == null || !navCtx.mounted || navigation == null || !navigation.mounted) {
      if (canLog) {
        _advisor.warning('Can\'t perform driving cause the Navigator is defunct');
      }
      return;
    }

    if (push) {
      navigation.pushNamed(options.name, extra: extra);
    } else {
      navigation.goNamed(options.name, extra: extra);
    }
    if (canLog) {
      _advisor.success(
        'Success drive',
        info: <String, dynamic>{
          'route-name': options.name,
          'route-extra': extra,
          'context': navigation.hashCode,
          'push': push,
        },
      );
    }
  }

  /// Removes all the route history until the current route node.
  void cleanHistory() {
    _nav.currentState?.popUntil(
      (Route<dynamic> route) => route.isActive,
    );
  }

  //* --> Private static methods

  /// Calculates an absolute path based on the parent absolute path and the current node [CSMRouteOptions].
  ///
  /// [routeNode] : [CSMRouteBase] where the absolute path is desired.
  /// [parentAbsolute] : The parent node absolute path calculation to join them.
  ///
  /// Notes:
  ///   - Doesn't contain logs.
  static void _calAbsolute(CSMRouteBase routeNode, String parentAbsolute) {
    if (routeNode is CSMRouteNodeBase) {
      CSMRouteOptions routeOptions = routeNode.routeOptions;
      String relativePath = routeOptions.path;
      if (relativePath.startsWith('/')) {
        relativePath = relativePath.replaceFirst('/', '');
      }
      String absolutePath = '$parentAbsolute/$relativePath';
      // --> Adding to absolute context
      _absoluteContext[routeOptions] = absolutePath;
      // --> Adding to absolute context details
      _absoluteContextDetails[routeOptions.toString()] = absolutePath;
      parentAbsolute = absolutePath;
    }
    for (CSMRouteBase routeLeef in routeNode.routes) {
      _calAbsolute(routeLeef, parentAbsolute);
    }
  }

  //* --> Private instance methods.

  /// Evaluates if the method can advise.
  ///
  /// [log] : The method parameter that indicates wheter the method can log (method invokation context).
  bool _canLog(bool? log) {
    if (log == null) return _advisorEnabled;
    return log;
  }
}
