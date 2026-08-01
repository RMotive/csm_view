import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Stores the configuration of a CSMPackageLanding entry, meaning this will configure how the
/// button and the component will be displayed in the package landing application.
final class PackageSandboxItem<ThemeBase extends PackageSamdboxThemeBase> extends PackageSandboxItemBase<ThemeBase> {
  /// Composition widget function, how will be drawn teh component in the landing application.
  ///
  /// [ctx] the parent build context.
  ///
  /// [windowSize] computed current window size.
  final Widget Function(BuildContext buildContext, Size windowSize, ThemeBase theme) contentBuilder;

  /// Creates a new [PackageSandboxItem] object indicating how to draw and handle a new component entry
  /// at the Package Landing application.
  const PackageSandboxItem({
    super.key,
    super.image,
    required super.name,
    required super.description,
    required this.contentBuilder,
  });

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, ThemeBase theme) {
    return contentBuilder(buildContext, windowSize, theme);
  }
}
