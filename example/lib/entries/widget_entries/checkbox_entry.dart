import 'package:csm_view/csm_view.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:flutter/material.dart' hide Checkbox;

final class CheckboxInputEntry extends PackageLandingEntryBase<ViewPackageThemeBase> {
  /// Creates a new instance.
  CheckboxInputEntry()
      : super(
          name: 'Checkbox Widget',
          description: (ViewPackageThemeBase theme, Color foreColor) {
            return TextSpan(
                text: 'A checkbox selector.',
                style: TextStyle(
                  color: foreColor,
                ));
          },
        );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, ViewPackageThemeBase theme) {
    return Center(
      child: Row(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CheckboxInput(
            label: 'Select Is Master (enabled)',
            startChecked: true,
            onChanged: (bool value) {},
          ),
          CheckboxInput(
            label: 'Select Is Master (disabled)',
            startChecked: true,
            disabled: true,
            onChanged: (bool value) {},
          )
        ],
      ),
    );
  }
}
