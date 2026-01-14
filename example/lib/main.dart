
import 'package:csm_view/csm_view.dart';
import 'package:example/entries/checkbox_entry.dart';
import 'package:example/entries/enum_selector.entry.dart';
import 'package:example/entries/form_input_group_entry.dart';
import 'package:example/entries/navigation_layout_entry.dart';
import 'package:example/entries/property_group_viewer_entry.dart';
import 'package:example/entries/property_viewer_entry.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:example/theme/view_package_theme_dark.dart';
import 'package:example/theme/view_package_theme_light.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    ViewPackageLanding(),
  );
}

///
final class ViewPackageLanding extends PackageLandingViewBase<ViewPackageThemeBase> {
  /// Creates a new instance.
  ViewPackageLanding()
      : super(
          name: 'View Package',
          description: (ViewPackageThemeBase theme, Color foreColor) {
            return TextSpan(
              text: 'Landing package example for { CSM View } package',
              style: TextStyle(
                color: foreColor,
              ),
            );
          },
          packageEntries: <IPackageLandingEntry<ViewPackageThemeBase>>[
            NavigationLayoutEntry(
              themes: <IThemeData>[
                CSMViewThemeDark(),
                CSMViewThemeLight(),
              ],
            ),
            CheckboxInputEntry(),
            PropertyViewerEntry(),
            EnumSelectorEntry(),
            FormInputGroupEntry(),
            PropertyGroupViewerEntry(),
          ],
        );

  @override
  List<ViewPackageThemeBase> bootstrapTheming() {
    return <ViewPackageThemeBase>[
      CSMViewThemeDark(),
      CSMViewThemeLight(),
    ];
  }
}
