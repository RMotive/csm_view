import 'package:csm_view/src/core/theming/models/theming_data.dart';
import 'package:csm_view/src/view/sandbox/abstractions/bases/package_sandbox_theme_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Icons;

/// Represents a [light] mode theme.
class PackageSandboxThemeLight extends PackageSandboxThemeBase {
  /// Creates a new instance.
  PackageSandboxThemeLight([
    String? themeId,
  ]) : super(
          themeId ?? 'package-landing-theme-light',
          icon: Icon(Icons.light_mode),
          iconBackground: Colors.white60,
          page: ThemingData(
            back: Color(0xfff2f2f2),
            fore: Colors.black,
            accent: Colors.blue.shade900,
          ),
          landingHeader: ThemingData(
            back: Colors.blue.shade900,
            fore: Colors.white,
            accent: Colors.white70,
          ),
          welcomeCardTheming: ThemingData(
            back: Colors.blue.shade900,
            fore: Colors.white,
            accent: Colors.white70,
          ),
          control: ThemingData(
            back: Colors.white60,
            fore: Colors.black,
            accent: Colors.grey,
          ),
          controlError: ThemingData(
            back: Colors.transparent,
            fore: Colors.red,
            accent: Colors.redAccent,
          ),
          controlSuccess: ThemingData(
            back: Colors.transparent,
            fore: Colors.green,
            accent: Colors.greenAccent,
          ),
          controlDisabled: const ThemingData(
            back: Colors.grey,
            fore: Colors.black,
            accent: Colors.blueGrey,
          ),
          dialog: ThemingData(
            back: Color(0xfff2f2f2),
            fore: Colors.black,
            accent: Colors.brown[900]!,
          ),
        );
}
