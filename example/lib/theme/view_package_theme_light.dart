import 'package:csm_view/csm_view.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:flutter/material.dart';

final class CSMViewThemeLight extends PackageSandboxThemeLight implements ViewPackageThemeBase {
  @override
  ThemingData navigationLayout = ThemingData(
    back: Colors.blue[900]!,
    fore: Colors.white70,
    accent: Colors.orange,
  );
}
