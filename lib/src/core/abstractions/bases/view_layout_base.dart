import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a { View } application layout.
abstract class ViewLayoutBase extends ViewPageBase implements IViewLayout {
  /// Content to be wrapped by the [ViewLayoutBase].
  @override
  final Widget page;

  /// Resolved routing data.
  @override
  final RoutingData routingData;

  /// Creates a new instance.
  const ViewLayoutBase({
    super.key,
    required this.page,
    required this.routingData,
  });
}
