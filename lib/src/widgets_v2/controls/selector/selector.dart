import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

export 'abstractions/interfaces/iselector_enum.dart';
export 'selector_cards.dart';

/// Represents the available [Selector] styles.
enum SelectorStyles {
  ///
  cards,
}

/// A [Widget] that allows to select single or multiple items along given options.
final class Selector<TValue> extends StatelessWidget {
  /// View style.
  final SelectorStyles style;

  /// Selectable values.
  final List<NamedValue<TValue>> values;

  //* Properties for [CARDS] selector style.

  /// Number of cards per row only when [style] is [SelectorStyles.cards].
  final int? rowCardsCount;

  /// Defined card size. Only when [style] is [SelectorStyles.cards].
  final WidgetSize? cardSize;

  /// Creates a new instance.
  const Selector({
    super.key,
    this.cardSize,
    this.rowCardsCount,
    required this.values,
    this.style = SelectorStyles.cards,
  }) : assert(
          style == SelectorStyles.cards && ((rowCardsCount != null) != (cardSize != null)),
          'Property [rowCardsCount] or [cardSize] must be provided when [style] is ${SelectorStyles.cards}',
        );

  /// Creates a new instance from [ISelectorEnum] values.
  static Selector<TEnum> fromEnum<TEnum extends ISelectorEnum>(List<TEnum> values) {
    return Selector<TEnum>(
      values: values.map(
        (TEnum value) {
          return NamedValue<TEnum>(value.name, value);
        },
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SelectorCards<TValue>(
      values: values,
      cardsSize: cardSize,
      rowCardsCount: rowCardsCount,
    );
  }
}
