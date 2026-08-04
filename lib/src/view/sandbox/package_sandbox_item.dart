import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents an interactive sandbox for a package component. 
/// 
/// [ThemeBase] represents the base theming data. 
final class PackageSandboxItem<ThemeBase extends PackageSamdboxThemeBase> extends PackageSandboxItemBase<ThemeBase> {
  /// Composition widget function, how will be drawn teh component in the landing application.
  ///
  /// [buildContext] the parent build context.
  ///
  /// [windowSize] computed current window size.
  /// 
  /// [theme] is the current theming data instance.
  final Widget Function(BuildContext buildContext, Size windowSize, ThemeBase theme) contentBuilder;

  /// Creates a new instance
  const PackageSandboxItem({
    super.key,
    super.image,
    required super.name,
    required super.description,
    required this.contentBuilder,
  });

  @override
  Widget composeView(BuildContext buildContext, Size windowSize, ThemeBase theme) {
    return contentBuilder(buildContext, windowSize, theme);
  }
}
