import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Provide methods to access and handle theming purposes easely.
mixin ThemingMixin {
  /// Gets the current application theme data based on the given [context].
  TThemeBase getTheme<TThemeBase extends IThemeData>(BuildContext context) {
    return ThemingUtils.get(context);
  }
}
