import 'package:csm_view/csm_view.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:flutter/material.dart';

final class CSMViewThemeLight extends PackageSandboxThemeLight implements ViewPackageThemeBase {
  @override
  ThemingData navigationLayout = ThemingData(
    back: Colors.red,
    fore: Colors.black,
    accent: Colors.blue,
  );
}
