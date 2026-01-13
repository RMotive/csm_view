import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Draws a generic {Refresh} action button for [CategoryLayoutPageI] acitons ribbon.
final class ActionsRisbbonRefresh extends ActionsRibbonActionBase {
  /// Callback invoked when the action is requested.
  final FutureOr<void> Function(BuildContext context) onRefresh;

  /// Creates a new [ActionsRisbbonRefresh] instance.
  const ActionsRisbbonRefresh({
    required this.onRefresh,
  }) : super(
          title: 'Refresh',
          description: 'Refreshes the current page data',
        );

  @override
  FutureOr<void> perform(BuildContext context) => onRefresh(context);

  @override
  Icon composeIcon(Color fgColor) {
    return Icon(
      Icons.refresh_outlined,
      color: fgColor,
    );
  }
}
