import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a [PackageSandboxViewBase] item, containing data to build the view and routing handling.
///
/// [ThemeBase] represents the theming type.
abstract interface class IPackageSandboxEntry<ThemeBase extends PackageSandboxThemeBase> implements IViewPage {
  /// Entry name.
  final String name;

  /// Entry image decorator.
  final ImageProvider? image;

  /// Icon image decorator, if not provided [image] property would be used.
  final IconData? icon;

  /// Entry description.
  final DescriptionBuilder<ThemeBase> description;

  /// Creates a new instance.
  const IPackageSandboxEntry(
    this.name,
    this.icon,
    this.image,
    this.description,
  );

  /// Composes the sandbox item user view.
  ///
  /// [buildContext] framework building context data.
  ///
  /// [windowSize] represents the available application window space.
  ///
  /// [theme] current theming data.
  Widget composeEntry(BuildContext buildContext, Size windowSize, ThemeBase theme);

  /// Composes needed nested routes.
  ///
  /// [navLayoutKey] navigation layout key.
  ///
  /// [entryLayoutKey] entry layout key.
  List<IRoutingGraphData> composeRoutes(GlobalKey<NavigatorState> navLayoutKey, GlobalKey<NavigatorState> entryLayoutKey) => <IRoutingGraphData>[];
}
