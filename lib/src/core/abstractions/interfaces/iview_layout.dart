import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a { View } application layout.
abstract interface class IViewLayout extends Widget {
  /// Current layout page to wrap.
  final Widget page;

  /// Routing working data.
  final RoutingData routingData;

  /// Creates a new [IViewLayout] object.
  const IViewLayout(
    this.page,
    this.routingData, {
    super.key,
  });
}
