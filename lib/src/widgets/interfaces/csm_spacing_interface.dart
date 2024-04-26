import 'package:flutter/material.dart';

/// Interface for [CSMSpacing].
///
/// Defines base behavior for [CSMSpacing] implementations.
///
/// [CSMSpacing] concept: a [Widget] that performs spacing calculations along its children.
abstract interface class CSMSpacingInterface {
  /// Determines the draw alignment at horizontal axis.
  final CrossAxisAlignment crossAlignment;

  /// Determines the draw alignment at vertical axis.
  final MainAxisAlignment mainAlignment;

  /// Deterimnes the director to draw items at vertical axis.
  final VerticalDirection verticalDirection;

  /// Determine how much space should take the [Column] at his main axis (vertical).
  final MainAxisSize mainSize;

  /// How the text will be aligned at horizontal axis.
  final TextBaseline? textBaseline;

  /// Determines how the text render flows.
  final TextDirection? textDirection;

  /// Wheter the [Column] should space itself at his start.
  final bool includeStart;

  /// Wheter the [Column] should space itself at his end.
  final bool includeEnd;

  /// How much space use between item.
  final double? spacing;

  /// Calculates how much space use between item (the space calculated is the left one of the item).
  final double? Function(int i)? calSpacing;

  /// Widgets to draw inside the [Column].
  final List<Widget> children;

  const CSMSpacingInterface({
    required this.children,
    this.spacing,
    this.calSpacing,
    this.textBaseline,
    this.textDirection,
    this.crossAlignment = CrossAxisAlignment.center,
    this.mainAlignment = MainAxisAlignment.start,
    this.mainSize = MainAxisSize.max,
    this.verticalDirection = VerticalDirection.down,
    this.includeEnd = false,
    this.includeStart = false,
  });
}
