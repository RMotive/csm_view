import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Utilities class that provides methods for theming.
final class ThemingUtils {
  /// Gets the current application [TBase].
  static TBase get<TBase extends IThemeData>(BuildContext context) {
    return ThemeManager.of(context).castData();
  }
}
