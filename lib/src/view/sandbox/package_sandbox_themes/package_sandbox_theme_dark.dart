import 'package:csm_view/csm_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Icons;

/// Represents a [dark] mode theme.
class PackageSandboxThemeDark extends PackageSamdboxThemeBase {
  /// Creates a new instance.
  PackageSandboxThemeDark([
    String? themeId,
  ]) : super(
          themeId ?? 'package-landing-theme-dark',
          icon: const Icon(Icons.dark_mode),
          iconBackground: Colors.black54,
          landingHeader: ThemingData(
            back: Colors.grey.shade600,
            fore: Colors.white,
            accent: Colors.white,
          ),
          welcomeCardTheming: ThemingData(
            back: Colors.grey.shade600,
            fore: Colors.white,
            accent: Colors.white,
          ),
          control: const ThemingData(
            back: Colors.black,
            fore: Colors.white,
            accent: Colors.grey,
          ),
          controlError: ThemingData(
            back: Colors.red[400]!,
            fore: Colors.red,
            accent: Colors.redAccent,
          ),
          controlSuccess: const ThemingData(
            back: Colors.transparent,
            fore: Colors.green,
            accent: Colors.greenAccent,
          ),
          controlDisabled: const ThemingData(
            back: Colors.grey,
            fore: Colors.black,
            accent: Colors.blueGrey,
          ),
          page: ThemingData(
            back: Colors.black,
            fore: Colors.white,
            accent: Colors.red[900]!,
          ),
          dialog: ThemingData(
            back: Colors.black87,
            fore: Colors.white,
            accent: Colors.brown[900]!,
          ),
        );
}
