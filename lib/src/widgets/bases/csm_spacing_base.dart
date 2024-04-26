import 'package:csm_foundation_view/src/widgets/widgets_module.dart';
import 'package:flutter/material.dart';

/// Base for [CSMSpacing].
///
/// Defines base behavior for [CSMSpacing] implementations.
///
/// [CSMSpacing] concept: a [Widget] that performs spacing calculations along its children.
abstract class CSMSpacingBase<T extends Flex> extends StatelessWidget implements CSMSpacingInterface {
  /// Determines the draw alignment at cross axis.
  @override
  final CrossAxisAlignment crossAlignment;

  /// Determines the draw alignment at main axis.
  @override
  final MainAxisAlignment mainAlignment;

  /// Deterimnes the director to draw items at vertical axis.
  @override
  final VerticalDirection verticalDirection;

  /// Determine how much space should take the [T] at his main axis (vertical).
  @override
  final MainAxisSize mainSize;

  /// How the text will be aligned at horizontal axis.
  @override
  final TextBaseline? textBaseline;

  /// Determines how the text render flows.
  @override
  final TextDirection? textDirection;

  /// Wheter the [T] should space itself at his start.
  @override
  final bool includeStart;

  /// Wheter the [Widget] should space itself at his end.
  @override
  final bool includeEnd;

  /// How much space use between item.
  @override
  final double? spacing;

  /// Calculates how much space use between item (the space calculated is set before the item).
  @override
  final double? Function(int i)? calSpacing;

  /// Widgets to draw inside the [T].
  @override
  final List<Widget> children;

  /// Generates a new [CSMSpacing] behavior handler.
  const CSMSpacingBase({
    super.key,
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
  }) : assert((spacing == null) != (calSpacing == null), 'Must only set one between [spacing] and [calSpacing]');
}
