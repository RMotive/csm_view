import 'package:csm_view/csm_view.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:flutter/material.dart';

/// Draws a package landing entry for [ExpandibleSection].
final class PropertyGroupViewerEntry extends PackageLandingEntryBase<ViewPackageThemeBase> {
  /// Creates a new instance.
  PropertyGroupViewerEntry()
      : super(
          name: 'Property Group Viewer',
          description: (PackageLandingThemeBase theme, Color foreColor) {
            return TextSpan(
              text: 'A property view group for simplified entities values summary.',
              style: TextStyle(
                color: foreColor,
              ),
            );
          },
        );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, PackageLandingThemeBase theme) {
    return SizedBox(
      child: Center(
        child: ExpandibleSection(
          title: 'Example Viewer Group',
          children: <Widget>[
            PropertyViewer<String>(
              label: 'Property 1',
              value: 'First value',
            ),
            PropertyViewer<String>(
              label: 'Property 2',
              value: 'Second value',
            ),
            PropertyViewer<String>(
              label: 'Property 3',
              value: 'Third value',
            ),
          ],
        ),
      ),
    );
  }
}
