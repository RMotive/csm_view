import 'package:flutter/material.dart';

/// Interface for [CSMLayout].
///
/// Defines requirements for a [CSMLayout] implementation.
///
/// [CSMLayout] Concept: A specified UI wrapper that wraps its content ([page]).
/// The [CSMLayout] receives the [page] based on the [Routing] result, then the [CSMLayout] will be
/// drawn with the given [page] resulted.
abstract interface class CSMLayoutInterface {
  /// Content to be wrapped by the [CSMLayout].
  final Widget page;

  const CSMLayoutInterface(this.page);
}
