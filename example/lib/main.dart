import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:example/entries/groups/business_widgets/business_widgets_group.dart';
import 'package:example/entries/groups/controls_widgets/controls_widgets_group.dart';
import 'package:example/entries/groups/view_base/view_base_group.dart';
import 'package:example/entries/groups/widgets/widgets_group.dart';
import 'package:example/mocks/service_mock.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:example/theme/view_package_theme_dark.dart';
import 'package:example/theme/view_package_theme_light.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    PakageExampleSandbox(),
  );
}

/// Package sandbox configuration, entry point where the example sandbox is built and configured.
final class PakageExampleSandbox extends PackageSandboxViewBase<ViewPackageThemeBase> {
  /// Creates a new instance.
  PakageExampleSandbox()
      : super(
          name: 'CSM View',
          description: (ViewPackageThemeBase theme, Color foreColor) {
            return TextSpan(
              text: 'Sandbox solution to interact and consult details about ',
              style: TextStyle(
                color: foreColor,
                fontSize: 16,
              ),
              children: <InlineSpan>[
                //* Package name
                TextSpan(
                  text: 'CSM View',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextSpan(
                  text: ' widgets and another components',
                ),
              ],
            );
          },
          sandboxEntries: <IPackageSandboxEntry<ViewPackageThemeBase>>[
            //* Groups
            ViewBaseGroup(),
            WidgetsGroup(),
            BusinessWidgetsGroup(),
            ControlsWidgetsGroup(),
          ],
        );

  @override
  List<ViewPackageThemeBase> bootstrapTheming() {
    return <ViewPackageThemeBase>[
      CSMViewThemeDark(),
      CSMViewThemeLight(),
    ];
  }

  @override
  FutureOr<void> initView(BuildContext context) {
    InjectorUtils.addSingleton<IServiceEx>(ServiceMock());

    return super.initView(context);
  }
}
