import 'package:csm_view/csm_view.dart';
import 'package:csm_view/src/core/theming/abstractions/interfaces/itheme_data.dart';
import 'package:flutter/material.dart';

/// {inherited} {widget} class.
///
/// Handles the inheritance [BuildContext] dependency for the application tree for {theming} management.
final class ThemeManager extends InheritedWidget {
  /// Current {ThemeData} data context.
  final IThemeData themeData;

  /// Current application configured themes.
  final List<IThemeData> themes;

  /// Changes the application theme.
  final void Function(Type newTheme) change;

  /// Creates a new [ThemeManagerA] instance.
  const ThemeManager({
    super.key,
    required this.change,
    required super.child,
    required this.themes,
    required this.themeData,
  });

  /// Cast the current [ThemeDataI] into the given [TBase] type.
  ///
  /// [TBase] reference type for data.
  TBase castData<TBase extends IThemeData>() {
    return themeData as TBase;
  }

  /// Creates the dependency with [ThemeManager].
  static ThemeManager of(BuildContext buildContext) {
    ThemeManager? inst = buildContext.dependOnInheritedWidgetOfExactType<ThemeManager>();
    assert(inst != null, 'No ThemeManager found in context');

    return inst!;
  }

  @override
  bool updateShouldNotify(covariant ThemeManager oldWidget) {
    return themeData != oldWidget.themeData;
  }
}
