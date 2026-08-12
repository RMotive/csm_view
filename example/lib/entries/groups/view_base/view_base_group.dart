import 'package:csm_view/csm_view.dart';
import 'package:example/entries/groups/view_base/navigation_layout_entry.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:example/theme/view_package_theme_dark.dart';
import 'package:example/theme/view_package_theme_light.dart';
import 'package:flutter/material.dart';

final class ViewBaseGroup extends PackageSandboxGroupBase<ViewPackageThemeBase> {
  ViewBaseGroup()
      : super(
          name: 'View Base',
          icon: Icons.foundation,
          description: (ViewPackageThemeBase theme, Color foreColor) {
            TextStyle remarkStyle = TextStyle(
              color: theme.welcomeCardTheming.accent,
              fontWeight: FontWeight.w900,
            );

            return TextSpan(
              text: 'Widgets that are base for any view implementation, handle ',
              children: <InlineSpan>[
                TextSpan(
                  text: 'core',
                  style: remarkStyle,
                ),
                TextSpan(
                  text: ' behaviors, interactions and/or operations. Provide easier and standarized view along ',
                ),
                TextSpan(
                  text: 'CSM',
                  style: remarkStyle,
                ),
                TextSpan(
                  text: ' design standards, making all products and/or customizations aligned',
                ),
              ],
            );
          },
          items: <IPackageSandboxItem<ViewPackageThemeBase>>[
            NavigationLayoutEntry(
              themes: <IThemeData>[
                CSMViewThemeDark(),
                CSMViewThemeLight(),
              ],
            ),
          ],
        );
}
