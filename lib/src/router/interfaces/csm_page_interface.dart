import 'package:flutter/material.dart';

/// Interface for [CSMPage].
///
/// Defines required hebavior for [CSMPage] implementation.
///
/// [CSMPage] concept: is a complex UI that designs a full user display page, wrapping content and displaying custom designs at a resolved [RouteNode].
abstract interface class CSMPageInterface {
  /// Composes and displays a complex UI for a specific [RouteNode].
  Widget compose(BuildContext ctx, Size window);
}
