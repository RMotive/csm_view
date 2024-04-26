import 'package:csm_foundation_view/src/router/router_module.dart';
import 'package:flutter/material.dart';

/// Base for [CSMLayout].
///
/// Defines base behavior for a [CSMLayout] implementation.
///
/// [CSMLayout] Concept: A specified UI wrapper that wraps its content ([page]).
/// The [CSMLayout] receives the [page] based on the [Routing] result, then the [CSMLayout] will be
/// drawn with the given [page] resulted.
abstract class CSMLayoutBase extends StatelessWidget implements CSMLayoutInterface {
  /// Content to be wrapped by the [CSMLayout].
  @override
  final Widget page;

  /// Generates a [CSMLayoutBase] behavior handler.
  const CSMLayoutBase({
    super.key,
    required this.page,
  });
}
