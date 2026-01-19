import 'package:csm_view/csm_view.dart';
import 'package:example/mocks/entity_mock.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:flutter/material.dart';

final class UpdateEntityDialogEntry extends PackageLandingEntryBase<ViewPackageThemeBase> {
  /// Creates a new instance.
  UpdateEntityDialogEntry()
      : super(
          name: 'Update Entity Dialog',
          description: (ViewPackageThemeBase theme, Color foreColor) {
            return TextSpan(text: 'A business scoped dialog to confirm an entity edition with the changes summary.');
          },
        );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, ViewPackageThemeBase theme) {
    return Center(
      child: ButtonFlat(
        label: 'Open Dialog',
        onClick: () {
          showDialog(
            context: buildContext,
            builder: (BuildContext context) {
              return UpdateEntityDialog<EntityEx>();
            },
          );
        },
      ),
    );
  }
}
