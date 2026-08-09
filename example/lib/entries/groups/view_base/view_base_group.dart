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
            return TextSpan();
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
