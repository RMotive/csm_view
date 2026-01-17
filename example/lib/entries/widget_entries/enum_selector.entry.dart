import 'package:csm_view/csm_view.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:flutter/material.dart';

enum ExampleEnums {
  optionOne,
  optionTwo,
  optionThree,
}

/// Package landing entry for [PropertyViewer].
final class EnumSelectorEntry extends PackageLandingEntryBase<ViewPackageThemeBase> {
  /// Creates a new instance.
  EnumSelectorEntry()
      : super(
          name: 'Enum Selector',
          description: (ViewPackageThemeBase theme, Color foreColor) {
            return TextSpan(
              text: 'A selector dropdown for Enum values.',
            );
          },
        );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, ViewPackageThemeBase theme) {
    return Padding(
      padding: EdgeInsetsGeometry.only(
        top: 12,
      ),
      child: Column(
        spacing: 12,
        children: <Widget>[
          EnumSelector<ExampleEnums>(
            values: ExampleEnums.values,
            onSelect: (ExampleEnums value) {},
          ),
        ],
      ),
    );
  }
}
