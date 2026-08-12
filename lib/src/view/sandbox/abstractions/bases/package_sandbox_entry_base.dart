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
  /// Entry image decorator, if not provided [icon] property would be used.
  final ImageProvider? image;

  @override

  /// Icon image decorator, if not provided [image] property would be used.
  final IconData? icon;

  @override

  /// Entry description.
  final DescriptionBuilder<ThemeBase> description;

  /// Creates a new instance.
  const PackageSandboxEntryBase({
    super.key,
    this.image,
    this.icon,
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
