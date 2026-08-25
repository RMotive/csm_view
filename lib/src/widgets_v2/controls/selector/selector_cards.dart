import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';

part '_selector_card.dart';

///
final class SelectorCards<TValue> extends StatelessWidget {
  /// Number of cards per row.
  final int? rowCardsCount;

  /// Defined cards size.
  final WidgetSize? cardsSize;

  /// Selectable values.
  final List<NamedValue<TValue>> values;

  /// Creates a new instance.
  const SelectorCards({
    super.key,
    this.cardsSize,
    this.rowCardsCount,
    required this.values,
  }) : assert(
          (cardsSize != null) != (rowCardsCount != null),
          'Just one [cardsSize] or [rowCardsCount] property must be provided, not both, and at least one, to determine correctly each card size.',
        );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints boxConstraints) {
        boxConstraints = boxConstraints.normalize();

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: values.map(
            (NamedValue<TValue> value) {
              return _SelectorCard<TValue>(
                value: value,
                size: cardsSize,
              );
            },
          ).toList(),
        );
      },
    );
  }
}
