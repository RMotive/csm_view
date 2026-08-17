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
          icon: Icons.business_center,
          description: (ViewPackageThemeBase theme, Color foreColor) {
            return TextSpan(
              text: 'Complex widgets that handle and uses business data, these commonly comunicate along data servers to analyze, present, or process the data. This widgets also handles some delegated business logic to prevent or calculate final data results.',
            );
          },
          sandboxItems: <IPackageSandboxItem<ViewPackageThemeBase>>[
            EntityTableEntry(),
            PasswordInputEntry(),
            UpdateEntityDialogEntry(),
          ],
        );
}
