import 'package:csm_view/csm_view.dart';

final class SelectorCardsConfig<TValue> {
  /// Number of cards per row.
  final int? rowCardsCount;

  /// Defined card size. Only when [style] is [SelectorStyles.cards].
  final WidgetSize? cardSize;

  /// Event callback when [SelectorCards] values selection has changed. Will provide
  /// the new selected values [newSelection], the previous selection values [prevSelection] and
  /// the difference between the [newSelection] and [prevSelection] as [delta].
  final Function(List<TValue> newSelection, List<TValue> prevSelection, [List<TValue>? delta])? onMultiSelection;

  /// Event callback when [SelectorCards] value selection has changed. Will provide
  /// the new selected value [newSelected] and [prevSelected] value.
  final Function(TValue? newSelected, TValue? prevSelected)? onSingleSelection;

  const SelectorCardsConfig({
    double? spacing,
    this.cardSize,
    this.rowCardsCount,
    this.onMultiSelection,
    this.onSingleSelection,
  }) : assert(
          (cardSize != null) != (rowCardsCount != null),
          'Just one [cardsSize] or [rowCardsCount] property must be provided, not both, and at least one, to determine correctly each card size.',
        );
}
