import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

final class PackageSandboxConfigurableItem<ThemeBase extends PackageSandboxThemeBase> extends PackageSandboxItemBase<ThemeBase> {
  /// Builder for the main item content.
  ///
  /// [viewContext] framweork building context.
  ///
  /// [windowSize] current window size.
  ///
  /// [theme] current theme data.
  final Widget Function(BuildContext viewContext, Size windowSize, ThemeBase theme) viewBuilder;

  /// Builder for the configurations panel content.
  ///
  /// [viewContext] framweork building context.
  ///
  /// [windowSize] current window size.
  ///
  /// [theme] current theme data.
  final Widget Function(BuildContext viewContext, Size windowSize, ThemeBase theme) configsBuilder;

  /// Creates a new instance.
  const PackageSandboxConfigurableItem({
    required super.name,
    required super.description,
    required this.viewBuilder,
    required this.configsBuilder,
  });

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, ThemeBase theme) {
    return Stack(
      children: <Widget>[],
    );
  }
}
