import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// {abstract} class.
///
///
/// [ThemeBase] type of the [IThemeData] application base theming implementation.
///
/// Defines and handles base behavior for [PackageSandboxItemBase] implementations, wich are complex [PackageLanding] view entries
/// to be routed and displayed correctly as a package development helping.
abstract class PackageSandboxItemBase<ThemeBase extends PackageSamdboxThemeBase> extends ViewPageBase implements IPackageSandboxItem<ThemeBase> {
  /// The name of the landing entry.
  @override
  final String name;

  /// Image to represent the package at the [Welcome] page cards.
  @override
  final ImageProvider? image;

  /// The landing entry description.
  @override
  final DescriptionBuilder<ThemeBase> description;

  /// Creates a new [PackageSandboxItemBase]
  const PackageSandboxItemBase({
    super.key,
    this.image,
    required this.name,
    required this.description,
  });

  @override
  List<IRoutingGraphData> composeRoutes(GlobalKey<NavigatorState> navigationLayoutKey, GlobalKey<NavigatorState> entryLayoutKey) => <IRoutingGraphData>[];

  @override
  Widget compose(BuildContext context, Size windowSize, Size pageSize) {
    final ThemeBase theme = ThemingUtils.get<ThemeBase>(context);

    return composeView(
      context,
      windowSize,
      theme,
    );
  }
}
