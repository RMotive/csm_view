import 'package:csm_view/csm_view.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:flutter/material.dart';

class PasswordInputEntry extends PackageSandboxItemBase<ViewPackageThemeBase> {
  PasswordInputEntry()
      : super(
          name: 'Password Input',
          description: (ViewPackageThemeBase theme, Color foreColor) {
            return TextSpan(text: 'A business Widget to handle password value types input.');
          },
        );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, ViewPackageThemeBase theme) {
    return Center(
      child: PasswordInput(
        onChanged: (String newValue) {},
      ),
    );
  }
}
