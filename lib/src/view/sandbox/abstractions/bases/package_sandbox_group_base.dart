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

  ///
  late final Map<RouteData, IPackageSandboxItem<ThemeBase>> _sanbodItemsRoutingContext;

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
    _sanbodItemsRoutingContext = SandboxUtils.buildRoutingGraph(sandboxItems);
  }

  @override
  List<IRoutingGraphData> composeRoutes(GlobalKey<NavigatorState> navLayoutKey, GlobalKey<NavigatorState> entryLayoutKey) {
    return SandboxUtils.buildGraphRoutes(_sanbodItemsRoutingContext).toList();
  }

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, ThemeBase theme) {
    return PackageSandboxWelcomeEntryCardDashboard(
      sandboxEntries: _sanbodItemsRoutingContext,
    );
  }
}
