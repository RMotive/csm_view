import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a package [PackageSandboxViewBase] showcase entry.
abstract interface class IPackageSandboxItem<ThemeBase extends PackageSamdboxThemeBase> implements IViewPage {
  /// The name of the component.
  final String name;

  /// Image to represent the package at the [Welcome] page cards.
  final ImageProvider? image;

  /// The component description.
  final DescriptionBuilder<ThemeBase> description;

  /// Creates a new [IPackageSandboxItem] instance.
  const IPackageSandboxItem({
    this.image,
    required this.name,
    required this.description,
  });

  /// Composes nested [RouteB] implementations when the {entry} inner component needs to access a navigation route by its own behavior.
  List<IRoutingGraphData> composeRoutes(GlobalKey<NavigatorState> navigationLayoutKey, GlobalKey<NavigatorState> entryLayoutKey) => <IRoutingGraphData>[];

  /// Custom composition method for [IPackageSandboxItem] implementations to bypass [IPage], [compose].
  ///
  /// [buildContext] native framework building context data.
  ///
  /// [windowSize] represents the available application widnow space boundties.
  ///
  /// [theme] gives a reference for the current application managed theming information.
  Widget composeEntry(BuildContext buildContext, Size windowSize, ThemeBase theme);
}
