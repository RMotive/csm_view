import 'package:csm_view/csm_view.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:flutter/material.dart';

/// Package landing entry for [PropertyViewer].
final class PropertyViewerEntry extends PackageLandingEntryBase<ViewPackageThemeBase> {
  /// Creates a new instance.
  PropertyViewerEntry()
      : super(
          name: 'Property Viewer',
          description: (ViewPackageThemeBase theme, Color foreColor) {
            return TextSpan(
              text: 'An entity property viewer widget, used to display information based on its type.',
            );
          },
        );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, ViewPackageThemeBase theme) {
    return Column(
      spacing: 12,
      children: <Widget>[
        /// --> String property viewer.
        ExpandibleSection(
          title: 'String Property Viewer',
          children: <Widget>[
            PropertyViewer<String>(
              label: 'String Value',
              value: 'Hello i\'m a String value.',
            ),
            PropertyViewer<String>(
              label: 'String Value (null)',
              value: null,
            ),
          ],
        ),

        /// --> Boolean property viewer.
        ExpandibleSection(
          title: 'Boolean Property Viewer',
          children: <Widget>[
            PropertyViewer<bool>(
              label: 'Bool Value (true)',
              value: true,
            ),
            PropertyViewer<bool>(
              label: 'Bool Value (false)',
              value: false,
            ),
            PropertyViewer<bool>(
              label: 'Bool Value (null)',
              value: null,
            ),
          ],
        ),

        /// --> DateTime property viewer.
        ExpandibleSection(
          title: 'DateTime Property Viewer',
          children: <Widget>[
            PropertyViewer<DateTime>(
              label: 'DateTime Value',
              value: DateTime(2000, 5, 12, 12),
            ),
            PropertyViewer<DateTime>(
              label: 'DateTime Value (null)',
              value: null,
            ),
          ],
        ),
      ],
    );
  }
}
