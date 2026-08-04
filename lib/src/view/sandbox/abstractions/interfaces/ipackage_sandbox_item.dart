import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a package sandbox item who composes an user interface page to interact and read how a package component works.
///
/// [ThemeBase] represents the theming type.
abstract interface class IPackageSandboxItem<ThemeBase extends PackageSamdboxThemeBase> implements IViewPage {
  /// Component's name.
  final String name;

  /// Image to represent the package at the [Welcome] page cards.
  final ImageProvider? image;

  /// Component's description.
  final DescriptionBuilder<ThemeBase> description;

  /// Creates a new instance.
  const IPackageSandboxItem({
    this.image,
    required this.name,
    required this.description,
  });

  /// Composes inner nested routes when the component needs to access a navigation route by its own behavior.
  List<IRoutingGraphData> composeRoutes(GlobalKey<NavigatorState> navigationLayoutKey, GlobalKey<NavigatorState> entryLayoutKey) => <IRoutingGraphData>[];

  /// Composes the sandbox item user view.
  ///
  /// [buildContext] framework building context data.
  ///
  /// [windowSize] represents the available application window space.
  ///
  /// [theme] current theming data.
  Widget composeView(BuildContext buildContext, Size windowSize, ThemeBase theme);
}
