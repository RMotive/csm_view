import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Provides mixin utilities methods on [State] classes to access [context] directly.
mixin ThemingStateMixin<TState extends StatefulWidget> on State<TState> {
  /// Gets the current application theme data based on the given [context].
  TThemeBase getTheme<TThemeBase extends IThemeData>() {
    return ThemingUtils.get(context);
  }
}
