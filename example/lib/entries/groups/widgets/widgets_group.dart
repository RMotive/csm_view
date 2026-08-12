import 'package:csm_view/csm_view.dart';
import 'package:example/entries/groups/widgets/checkbox_input_entry.dart';
import 'package:example/entries/groups/widgets/enum_selector.entry.dart';
import 'package:example/entries/groups/widgets/form_input_group_entry.dart';
import 'package:example/entries/groups/widgets/property_group_viewer_entry.dart';
import 'package:example/entries/groups/widgets/property_viewer_entry.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:flutter/cupertino.dart';

final class WidgetsGroup extends PackageSandboxGroupBase<ViewPackageThemeBase> {
  /// Creates a new instance.
  WidgetsGroup()
      : super(
          name: 'Widgets',
          description: (ViewPackageThemeBase theme, Color foreColor) {
            return TextSpan(
              text: 'Generic widgets that are generally used to compose more complex widgets, these are commonly small and simple behavior handlers or view simplifiers.',
            );
          },
          items: <IPackageSandboxItem<ViewPackageThemeBase>>[
            CheckboxInputEntry(),
            EnumSelectorEntry(),
            FormInputGroupEntry(),
            PropertyViewerEntry(),
            PropertyGroupViewerEntry(),
          ],
        );
}
