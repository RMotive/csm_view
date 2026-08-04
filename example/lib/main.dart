import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:example/entries/layout_entries/navigation_layout_entry.dart';
import 'package:example/entries/widget_entries/business_widgets_entries/entity_table_entry.dart';
import 'package:example/entries/widget_entries/business_widgets_entries/password_input_entry.dart';
import 'package:example/entries/widget_entries/business_widgets_entries/update_entity_dialog_entry.dart';
import 'package:example/entries/widget_entries/checkbox_entry.dart';
import 'package:example/entries/widget_entries/enum_selector.entry.dart';
import 'package:example/entries/widget_entries/form_input_group_entry.dart';
import 'package:example/entries/widget_entries/property_group_viewer_entry.dart';
import 'package:example/entries/widget_entries/property_viewer_entry.dart';
import 'package:example/mocks/service_mock.dart';
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
final class ViewPackageLanding extends PackageSandboxViewBase<ViewPackageThemeBase> {
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
          sandboxItems: <IPackageSandboxItem<ViewPackageThemeBase>>[
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
            EntityTableEntry(),
            PasswordInputEntry(),
            UpdateEntityDialogEntry(),
          ],
        );

  @override
  List<ViewPackageThemeBase> bootstrapTheming() {
    return <ViewPackageThemeBase>[
      CSMViewThemeDark(),
      CSMViewThemeLight(),
    ];
  }

  @override
  FutureOr<void> initView(BuildContext context) {
    InjectorUtils.addSingleton<IServiceEx>(ServiceMock());

    return super.initView(context);
  }
}
