import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents an interactive sandbox for a package component.
///
/// [ThemeBase] represents the base theming data.
final class PackageSandboxItem<ThemeBase extends PackageSandboxThemeBase> extends PackageSandboxItemBase<ThemeBase> {
  /// Builder for the item view content.
  ///
  /// [viewContext] framweork building context.
  ///
  /// [windowSize] current window size.
  ///
  /// [theme] current theme data.
  final Widget Function(BuildContext viewContext, Size windowSize, ThemeBase theme) viewBuilder;

  /// Creates a new instance
  const PackageSandboxItem({
    super.key,
    super.image,
    required super.name,
    required super.description,
    required this.viewBuilder,
  });

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, ThemeBase theme) => viewBuilder(buildContext, windowSize, theme);
}
