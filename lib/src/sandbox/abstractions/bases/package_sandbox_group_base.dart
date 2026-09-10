import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a [PackageSandboxViewBase] items group, creates a navigation access for the whole group
/// displaying inner items.
///
/// [ThemeBase] themee base type.
abstract class PackageSandboxGroupBase<ThemeBase extends PackageSandboxThemeBase> extends PackageSandboxEntryBase<ThemeBase> implements IPackageSandboxGroup<ThemeBase> {
  /// Group items.
  @override
  final List<IPackageSandboxItem<ThemeBase>> sandboxItems;

  /// Group items routing graph, for navigation behaviors.
  @override
  late final Map<RouteData, IPackageSandboxEntry<ThemeBase>> routingGraph;

  /// Creates a new instance.
  PackageSandboxGroupBase({
    super.key,
    super.icon,
    super.image,
    required this.sandboxItems,
    required super.name,
    required super.description,
  }) : assert(
          sandboxItems.isNotEmpty,
          'Sandbox entries group must have items',
        ) {
    routingGraph = SandboxUtils.buildRoutingGraph(sandboxItems);
  }

  @override
  List<IRoutingGraphData> composeRoutes(GlobalKey<NavigatorState> navLayoutKey, GlobalKey<NavigatorState> entryLayoutKey) {
    return SandboxUtils.buildGraphRoutes(
      routingGraph,
      navLayoutKey,
      entryLayoutKey,
    ).toList();
  }

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, ThemeBase theme) {
    return PackageSandboxWelcomeEntryCardDashboard<ThemeBase>(
      sandboxEntries: routingGraph,
    );
  }
}
