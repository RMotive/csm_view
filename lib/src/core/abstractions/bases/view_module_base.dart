import 'dart:async';
import 'dart:io';

import 'package:csm_view/csm_view.dart';
import 'package:csm_view/src/core/routing/abstractions/interfaces/irouting_graph.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;

part '../../../dep_widgets/_view_module_welcome.dart';
part '../../../dep_widgets/_view_module_size.dart';

/// Represents a solution { View } module.
abstract class ViewModuleBase extends StatefulWidget {
  /// Whether the view displays context sizing frame.
  final bool useSizingFrame;

  /// Whether the view displays legacy debug check banner.
  final bool showLegacyDebugBanner;

  /// Creates a new instance.
  const ViewModuleBase({
    super.key,
    this.useSizingFrame = false,
    this.showLegacyDebugBanner = false,
  });

  ///
  @protected
  Widget bootstrapBuild(BuildContext context, Widget? app) => app ?? _ViewModuleWelcome();

  @protected
  FutureOr<void> initView(BuildContext context) {}

  /// Bootstraps how base logic builds and provides theming data.
  ///
  /// Returns the final themes to use.
  @protected
  List<IThemeData> bootstrapTheming();

  /// Bootstraps how base logic builds view routing data.
  ///
  /// Returns the final view routing graph.
  @protected
  List<IRoutingGraphData> bootstrapRouting();

  /// Boostrapts how base logic builds root redirection.
  ///
  /// Returns the view root redirection evaluation, this one is applied to every route requested, before their own route level redirection evaluation.
  @protected
  FutureOr<RouteData?>? boostrapRedirection(BuildContext context, RoutingData routingData) => null;

  @override
  State<ViewModuleBase> createState() => _ViewModuleBaseState();
}

final class _ViewModuleBaseState extends State<ViewModuleBase> {
  /// Application themes.
  late List<IThemeData> themes;

  /// View initialization callback.
  late FutureOr<void> initViewCall;

  /// Application routes.
  late List<IRoutingGraphData> routes;

  /// Application routing graph.
  late IRoutingGraph routingGraph;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();

    routes = widget.bootstrapRouting();
    themes = widget.bootstrapTheming();
    initViewCall = widget.initView(context);

    InjectorUtils.addSingleton<IRouter>(
      Router(routes),
    );

    routingGraph = RoutingGraph(
      routes: routes,
      redirect: widget.boostrapRedirection,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AsyncWidget<void>(
        isVoid: true,
        future: initViewCall,
        loadingBuilder: (BuildContext ctx) {
          return LoadingIndicator(
            foreColor: Colors.blue[900]!,
          );
        },
        errorBuilder: (BuildContext ctx, Object? error, void data) {
          return ErrorWidget(
            error ?? 'Unknown Error',
          );
        },
        successBuilder: (BuildContext context, void _) {
          return MaterialApp.router(
            routerConfig: routingGraph,
            restorationScopeId: 'view',
            debugShowCheckedModeBanner: widget.showLegacyDebugBanner,
            builder: (BuildContext context, Widget? child) {
              final Widget viewBuild = _ThemeManagerUpdater(
                themes: themes,
                child: Builder(
                  builder: (BuildContext context) {
                    ThemingData pageTheming = ThemingUtils.get<IThemeData>(context).page;

                    return ColoredBox(
                      color: pageTheming.back,
                      child: DefaultTextStyle(
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: pageTheming.fore,
                        ),
                        child: widget.bootstrapBuild(context, child),
                      ),
                    );
                  },
                ),
              );

              if (!kDebugMode || !widget.useSizingFrame) {
                return viewBuild;
              }

              return Stack(
                children: <Widget>[
                  viewBuild,
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 16,
                      left: 16,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: _ViewModuleSize(),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

///
final class _ThemeManagerUpdater extends StatefulWidget {
  ///
  final Widget child;

  final List<IThemeData> themes;

  /// Creates a new instance.
  const _ThemeManagerUpdater({
    required this.child,
    required this.themes,
  });

  @override
  State<_ThemeManagerUpdater> createState() => _ThemeManagerUpdaterState();
}

final class _ThemeManagerUpdaterState extends State<_ThemeManagerUpdater> {
  late IThemeData currentTheme = widget.themes.first;

  @override
  Widget build(BuildContext context) {
    return ThemeManager(
      themes: widget.themes,
      themeData: currentTheme,
      change: (Type newTheme) {
        setState(() {
          currentTheme = widget.themes.firstWhere(
            (IThemeData themeData) => themeData.runtimeType == newTheme,
          );
        });
      },
      child: widget.child,
    );
  }
}
