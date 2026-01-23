import 'package:csm_client_core/csm_client_core.dart';
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
              return UpdateEntityDialog<EntityEx>(
                differences: <ObjectDifference>[
                  // --> String example difference
                  ObjectDifference(
                    PropertyInfo(
                      'String Property',
                      String,
                      'Old Value',
                    ),
                    'Old Value',
                    'New Value',
                    null,
                  ),

                  // --> Nested entity difference.
                  ObjectDifference(
                    PropertyInfo(
                      'Nested Entity',
                      EntityEx,
                      EntityEx(),
                    ),
                    null,
                    null,
                    <ObjectDifference>[
                      // --> Nested Entity Value Difference
                      ObjectDifference(
                        PropertyInfo('Nested Property', String, 'old Value 2'),
                        'old Value 2',
                        'New Value 2',
                        null,
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
