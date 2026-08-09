import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a [PackageSandboxViewBase] item, containing data to build the view and routing handling.
///
/// [ThemeBase] represents the theming type.
abstract class PackageSandboxEntryBase<ThemeBase extends PackageSandboxThemeBase> extends ViewPageBase implements IPackageSandboxEntry<ThemeBase> {
  /// Entry name.
  @override
  final String name;

  @override

  /// Entry image decorator.
  final ImageProvider? image;

  @override

  /// Entry description.
  final DescriptionBuilder<ThemeBase> description;

  /// Creates a new instance.
  const PackageSandboxEntryBase({
    super.key,
    this.image,
    required this.name,
    required this.description,
  });

  @override
  List<IRoutingGraphData> composeRoutes(GlobalKey<NavigatorState> navLayoutKey, GlobalKey<NavigatorState> entryLayoutKey) => <IRoutingGraphData>[];

  @override
  Widget compose(BuildContext context, Size windowSize, Size pageSize) {
    final ThemeBase themeData = ThemingUtils.get<ThemeBase>(context);

    return composeEntry(context, windowSize, themeData);
  }
}
