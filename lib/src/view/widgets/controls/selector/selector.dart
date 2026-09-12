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

  /// Creates a new instance from [ISelectorEnum] values.
  /// 
  /// [values] Selection value options.
  ///
  /// [spacing] Spacing between values.
  ///
  /// [style] control style.
  ///
  /// [onSingleSelection] Event callback when [SelectorCards] value selection has changed. Will provide
  /// the new selected value [newSelected] and [prevSelected] value.
  ///
  /// [onMultiSelection] Event callback when [SelectorCards] values selection has changed. Will provide
  /// the new selected values [newSelection], the previous selection values [prevSelection] and
  /// the difference between the [newSelection] and [prevSelection] as [delta].
  static Selector<TEnum> fromEnum<TEnum extends ISelectorEnum>({
    required List<TEnum> values,
    double? spacing,
    SelectorCardsConfig<TEnum>? cardsConfig,
    SelectorStyles style = SelectorStyles.cards,
    Function(TEnum? newSelected, TEnum? prevSelected)? onSingleSelection,
    Function(List<TEnum> newSelection, List<TEnum> prevSelection, [List<TEnum>? delta])? onMultiSelection,
  }) {
    assert(values.isNotEmpty, 'Given values cannot be');

    return Selector<TEnum>(
      style: style,
      spacing: spacing,
      cardsConfig: cardsConfig,
      onMultiSelection: onMultiSelection,
      onSingleSelection: onSingleSelection,
      values: values.map(
        (TEnum value) {
          return NamedValue<TEnum>(value.name, value);
        },
      ).toList(),
    );
  }

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
