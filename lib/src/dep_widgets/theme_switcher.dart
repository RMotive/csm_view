import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// {widget} class.
///
/// Draws a complex [Widget] that handles switching along configured application themes.
final class ThemeSwitcher extends StatelessWidget {
  /// Application configured themes.
  final List<IThemeData>? themes;

  /// Creates a new [ThemeSwitcher] instance.
  const ThemeSwitcher({
    super.key,
    this.themes,
  }) : assert((themes == null) || (themes.length > 0), 'If [themes] property is given, can\'t be empty');

  @override
  Widget build(BuildContext context) {
    ThemeManager themeManager = ThemeManager.of(context);
    List<IThemeData> themes = this.themes ?? themeManager.themes;

    return Visibility(
      visible: themes.length > 1,
      replacement: SizedBox(),
      child: Visibility(
        visible: themes.length == 2,
        replacement: ErrorWidget(
          'Not Implemented View For More Than 2 Themes Switching',
        ),
        child: Material(
          color: Colors.transparent,
          child: Switch(
            value: themeManager.themeData == themes[0],
            activeThumbColor: Colors.white,
            trackColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                  return themes[0].iconBackground;
              }

                return themes[1].iconBackground;
              },
            ),
            thumbIcon: WidgetStateProperty.resolveWith<Icon>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return themes[0].icon;
                }

                return themes[1].icon;
              },
            ),
            onChanged: (bool value) {
              themeManager.change(
                value ? themes[0].runtimeType : themes[1].runtimeType,
              );
            },
          ),
        ),
      ),
    );
  }
}
