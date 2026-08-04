import 'package:csm_view/csm_view.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:flutter/material.dart';

/// Package landing entry for [PropertyViewer].
final class FormInputGroupEntry extends PackageSandboxItemBase<ViewPackageThemeBase> {
  /// Creates a new instance.
  FormInputGroupEntry()
      : super(
          name: 'Form Input Group',
          description: (ViewPackageThemeBase theme, Color foreColor) {
            return TextSpan(
              text: 'A Widget that lays out a group of a Form Area inputs.',
            );
          },
        );

  @override
  Widget composeView(BuildContext buildContext, Size windowSize, ViewPackageThemeBase theme) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          /// --> Group of 2
          FormInputGroup(
            children: <Widget>[
              TextInput(
                width: 500,
                label: 'First Input',
              ),
              TextInput(
                width: 500,
                label: 'Second Input',
              )
            ],
          ),

          /// --> Group of 3
          FormInputGroup(
            children: <Widget>[],
          ),

          /// Group of 4.
          FormInputGroup(
            children: <Widget>[],
          ),
        ],
      ),
    );
  }
}
