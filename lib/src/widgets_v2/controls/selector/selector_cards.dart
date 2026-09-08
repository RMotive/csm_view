import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:csm_view/src/widgets_v2/controls/selector/abstractions/interfaces/iselector_widget.dart';
import 'package:flutter/material.dart';

export 'models/selector_cards_config.dart';

part '_selector_card.dart';

///
final class SelectorCards<TValue> extends StatefulWidget implements ISelectorWidget<TValue> {
  /// Spacing between cards.
  final double spacing;

  /// Selectable values.
  final List<NamedValue<TValue>> values;

  /// Pre selected items.
  final List<NamedValue<TValue>> preSelection;

  /// [Widget] configuration.
  final SelectorCardsConfig<TValue> configs;

  /// Event callback when [SelectorCards] value selection has changed. Will provide
  /// the new selected value [newSelected] and [prevSelected] value.
  @override
  final Function(TValue? newSelected, TValue? prevSelected)? onSingleSelection;

  /// Event callback when [SelectorCards] values selection has changed. Will provide
  /// the new selected values [newSelection], the previous selection values [prevSelection] and
  /// the difference between the [newSelection] and [prevSelection] as [delta].
  @override
  final Function(List<TValue> newSelection, List<TValue> prevSelection, [List<TValue>? delta])? onMultiSelection;

  /// Creates a new instance.
  const SelectorCards({
    super.key,
    required this.values,
    required this.configs,
    double? spacing,
    this.onMultiSelection,
    this.onSingleSelection,
    this.preSelection = const <NamedValue<Never>>[],
  }) : spacing = spacing ?? 4;

  @override
  State<SelectorCards<TValue>> createState() => _SelectorCardsState<TValue>();
}

final class _SelectorCardsState<TValue> extends State<SelectorCards<TValue>> {
  /// Whether the config is for a single selection selector.
  late bool isSingleSelection = widget.configs.onSingleSelection != null;

  /// Selected items.
  Map<String, NamedValue<TValue>> selection = <String, NamedValue<TValue>>{};

  @override
  void initState() {
    super.initState();

    /// Filling selection with given preselected values.
    for (NamedValue<TValue> preSelectedValue in widget.preSelection) {
      selection[preSelectedValue.name] = preSelectedValue;
    }
  }

  @override
  void didUpdateWidget(covariant SelectorCards<TValue> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.configs != widget.configs) {
      isSingleSelection = widget.configs.onSingleSelection != null;
    }
  }

  /// Event callback when an option is selected.
  void onOptionSelected(NamedValue<TValue> value) {
    bool isSelected = selection.containsKey(value.name);

    if (isSelected) {
      selection.remove(value.name);
    } else if (isSingleSelection) {
      selection.clear();
      selection[value.name] = value;
    } else {
      selection[value.name] = value;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints boxConstraints) {
        boxConstraints = boxConstraints.normalize();

        return Wrap(
          spacing: widget.spacing,
          runSpacing: widget.spacing,
          children: widget.values.map(
            (NamedValue<TValue> value) {
              return _SelectorCard<TValue>(
                value: value,
                size: widget.configs.cardSize,
                isSelected: selection.containsKey(value.name),
                onClick: () => onOptionSelected(value),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
