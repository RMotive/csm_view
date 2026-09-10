import 'package:csm_view/csm_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Icons;

/// Represents a [dark] mode theme.
class PackageSandboxThemeDark extends PackageSandboxThemeBase {
  /// Creates a new instance.
  PackageSandboxThemeDark([
    String? themeId,
  ]) : super(
          themeId ?? 'package-landing-theme-dark',
          icon: const Icon(Icons.dark_mode),
          iconBackground: Colors.black54,
          page: ThemingData(
            back: Color(0xFF1C1C1D),
            fore: Colors.white,
            accent: Colors.red[900]!,
          ),
          welcomeCardTheming: ThemingData(
            back: Color(0xFF333333),
            fore: Colors.white,
            accent: Colors.red,
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
          dialog: ThemingData(
            back: Colors.black87,
            fore: Colors.white,
            accent: Colors.brown[900]!,
          ),
          navigationLayout: ThemingData(
            back: Colors.blue[900]!,
            fore: Colors.white70,
            accent: Colors.orange,
          ),
          primaryControlCard: StatefulControlThemeData<CardControlThemeData>(
            $default: CardControlThemeData(
              borderColor: Colors.orange,
            ),
            atHover: CardControlThemeData(
              bgColor: Color.lerp(Colors.orange, Color(0xFF1C1C1D), .5),
              txtStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            atSelected: CardControlThemeData(
              bgColor: Colors.orange,
            ),
            atFocused: CardControlThemeData(),
          ),
        );
}
