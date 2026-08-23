import 'package:csm_view/csm_view.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:flutter/material.dart';

/// Represents the sandbox item for [Selector].
final class SelectorItem extends PackageSandboxItemBase<ViewPackageThemeBase> {
  /// Creates a new instance.
  SelectorItem({
    required super.name,
    required super.description,
  });

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, ViewPackageThemeBase theme) {
    return Center(
      child: Selector(),
    );
  }
}
