import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:example/entries/groups/business_widgets/business_widgets_group.dart';
import 'package:example/entries/groups/view_base/view_base_group.dart';
import 'package:example/entries/groups/widgets/widgets_group.dart';
import 'package:example/mocks/service_mock.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:example/theme/view_package_theme_dark.dart';
import 'package:example/theme/view_package_theme_light.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    ViewPackageLanding(),
  );
}

///
final class ViewPackageLanding extends PackageSandboxViewBase<ViewPackageThemeBase> {
  /// Creates a new instance.
  ViewPackageLanding()
      : super(
          name: 'View Package',
          description: (ViewPackageThemeBase theme, Color foreColor) {
            return TextSpan(
              text: 'Landing package example for { CSM View } package',
              style: TextStyle(
                color: foreColor,
              ),
            );
          },
          sandboxEntries: <IPackageSandboxEntry<ViewPackageThemeBase>>[
            //* Groups
            ViewBaseGroup(),
            WidgetsGroup(),
            BusinessWidgetsGroup(),
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
