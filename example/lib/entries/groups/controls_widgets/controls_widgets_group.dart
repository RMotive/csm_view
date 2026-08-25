import 'package:csm_view/csm_view.dart';
import 'package:example/entries/groups/controls_widgets/items/selector_item.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:flutter/material.dart';

/// Represents the group of [Control Widgets]. Those who allow interactions with the system with no direct data input.
final class ControlsWidgetsGroup extends PackageSandboxGroupBase<ViewPackageThemeBase> {
  /// Creates a new instance.
  ControlsWidgetsGroup()
      : super(
          name: 'Controls Widgets',
          description: (ViewPackageThemeBase theme, Color foreColor) {
            return TextSpan(
              text: 'These widgets handle basic interaction with the system with no direct input, like buttons, switches, gestures or any other interaction with the system.',
            );
          },
          sandboxItems: <IPackageSandboxItem<ViewPackageThemeBase>>[
            SelectorItem(),
          ],
        );
}
