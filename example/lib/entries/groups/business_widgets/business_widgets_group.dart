import 'package:csm_view/csm_view.dart';
import 'package:example/entries/groups/business_widgets/entity_table_entry.dart';
import 'package:example/entries/groups/business_widgets/password_input_entry.dart';
import 'package:example/entries/groups/business_widgets/update_entity_dialog_entry.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:flutter/material.dart';

final class BusinessWidgetsGroup extends PackageSandboxGroupBase<ViewPackageThemeBase> {
  BusinessWidgetsGroup()
      : super(
          name: 'Business Widgets',
          description: (ViewPackageThemeBase theme, Color foreColor) {
            return TextSpan();
          },
          items: <IPackageSandboxItem<ViewPackageThemeBase>>[
            EntityTableEntry(),
            PasswordInputEntry(),
            UpdateEntityDialogEntry(),
          ],
        );
}
