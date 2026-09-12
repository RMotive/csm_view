import 'package:csm_view/csm_view.dart';
import 'package:csm_view/src/view/widgets/controls/selector/abstractions/interfaces/iselector_widget.dart';
import 'package:flutter/material.dart';

export 'abstractions/interfaces/iselector_enum.dart';
export 'selector_cards.dart';

/// Represents the available [Selector] styles.
enum SelectorStyles {
  ///
  cards,
}

/// A [Widget] that allows to select single or multiple items along given options.
final class Selector<TValue> extends StatelessWidget implements ISelectorWidget<TValue> {
  /// Control style.
  final SelectorStyles style;

  /// Spacing between values.
  final double? spacing;

  /// Selectable values.
  final List<NamedValue<TValue>> values;

  /// Event callback when [SelectorCards] value selection has changed. Will provide
  /// the new selected value [newSelected] and [prevSelected] value.
  @override
  final Function(TValue? newSelected, TValue? prevSelected)? onSingleSelection;

  /// Event callback when [SelectorCards] values selection has changed. Will provide
  /// the new selected values [newSelection], the previous selection values [prevSelection] and
  /// the difference between the [newSelection] and [prevSelection] as [delta].
  @override
  final Function(List<TValue> newSelection, List<TValue> prevSelection, [List<TValue>? delta])? onMultiSelection;

  //* Selector configs.

  /// Configuration for [SelectorStyles.cards].
  final SelectorCardsConfig<TValue>? cardsConfig;

  /// Creates a new instance.
  Selector({
    super.key,
    required this.values,
    this.spacing,
    this.cardsConfig,
    this.onMultiSelection,
    this.onSingleSelection,
    this.style = SelectorStyles.cards,
  }) : assert(
          style == SelectorStyles.cards && cardsConfig != null,
          'Specific selector style configurations is required',
        );

  @override
  Widget build(BuildContext context) {
    if (style == SelectorStyles.cards && cardsConfig != null) {
      return SelectorCards<TValue>(
        values: values,
        spacing: spacing,
        configs: cardsConfig!,
        onMultiSelection: onMultiSelection,
        onSingleSelection: onSingleSelection,
      );
    }

    return SizedBox();
  }
}
