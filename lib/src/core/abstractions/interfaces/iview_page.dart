import 'package:flutter/material.dart' hide Route;

/// Represents a { View Module } page.
abstract interface class IViewPage implements StatelessWidget {
  /// Composes a complex page into the [_ThemeManagerUpdater].
  ///
  /// [context] - Framework view building context.
  ///
  /// [windowSize] - Virtual application container view size.
  ///
  /// [pageSize] - Current available space for this [IViewPage] building context.
  Widget compose(BuildContext context, Size windowSize, Size pageSize);
}
