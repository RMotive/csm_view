import 'package:csm_view/csm_view.dart';
import 'package:example/entries/groups/view_base/navigation_layout_entry.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:example/theme/view_package_theme_dark.dart';
import 'package:example/theme/view_package_theme_light.dart';
import 'package:flutter/cupertino.dart';

final class ViewBaseGroup extends PackageSandboxGroupBase<ViewPackageThemeBase> {
  ViewBaseGroup()
      : super(
          name: 'View Base',
          description: (ViewPackageThemeBase theme, Color foreColor) {
            TextStyle remarkStyle = TextStyle(
              color: theme.page.accent,
              fontWeight: FontWeight.bold,
            );

            return TextSpan(
              style: TextStyle(
                color: foreColor,
              ),
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
                  text: 'CSM ',
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
