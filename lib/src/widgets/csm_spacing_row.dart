import 'package:csm_view/src/widgets/bases/widgets_bases_module.dart';
import 'package:flutter/material.dart';

/// Widget class for [CSMSpacingRow].
///
/// Defines UI for a [CSMSpacingRow] implementation.
///
/// [CSMSpacingRow] concept: draws a [Row] calculating space between each child and if indicated at the start and end of the [Row].
class CSMSpacingRow extends CSMSpacingBase<Row> {
  /// Generates a new [CSMSpacingRow] widget.
  const CSMSpacingRow({
    super.key,
    required super.children,
    super.spacing,
    super.calSpacing,
    super.textBaseline,
    super.textDirection,
    super.crossAlignment = CrossAxisAlignment.center,
    super.mainAlignment = MainAxisAlignment.start,
    super.mainSize = MainAxisSize.max,
    super.verticalDirection = VerticalDirection.down,
    super.includeEnd = false,
    super.includeStart = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAlignment,
      mainAxisAlignment: mainAlignment,
      mainAxisSize: mainSize,
      textBaseline: textBaseline,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: <Widget>[
        if (includeStart)
          SizedBox.square(
            dimension: spacing,
          ),
        for (int i = 0; i < children.length; i++) ...<Widget>{
          if (i != 0)
            SizedBox.square(
              dimension: spacing,
            ),
          children[i],
        },
        if (includeEnd)
          SizedBox.square(
            dimension: spacing,
          )
      ],
    );
  }
}
