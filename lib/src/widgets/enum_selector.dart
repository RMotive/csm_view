import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Draws a [Widget] that allows to select along an [Enum] values.
final class EnumSelector<TEnum extends Enum> extends StatefulWidget {
  /// Control label.
  final String label;

  /// Sets the control value.
  final TEnum? value;

  /// [TEnum] values.
  final List<TEnum> values;

  /// Whether the value selection is required.
  final bool isRequired;

  /// Control focus node.
  final FocusNode? focusNode;

  /// Control text editing controller.
  final TextEditingController? textEditingController;

  /// Event called when an option is selected.
  final FutureOr<void> Function(TEnum value) onSelect;

  /// Creates a new instance.
  const EnumSelector({
    super.key,
    this.value,
    this.focusNode,
    this.textEditingController,
    this.isRequired = false,
    this.label = 'Select an option',
    required this.values,
    required this.onSelect,
  });

  @override
  State<EnumSelector<TEnum>> createState() => _EnumSelectorState<TEnum>();
}

final class _EnumSelectorState<TEnum extends Enum> extends State<EnumSelector<TEnum>> {
  /// Control focus node handler.
  late final FocusNode focusNode = widget.focusNode ?? FocusNode();

  /// Control text editing handler.
  late final TextEditingController textController = widget.textEditingController ?? TextEditingController();

  /// Current selected value.
  late TEnum? currValue = widget.value;

  /// Whether currently is a hovered value.
  TEnum? currHoverValue;

  late IThemeData themeData;

  @override
  void initState() {
    focusNode.addListener(
      () {
        if (focusNode.hasFocus) return;

        setState(() {
          currHoverValue = null;
        });
      },
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EnumSelector<TEnum> oldWidget) {
    if (oldWidget.value != widget.value) {
      currValue = widget.value;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    themeData = ThemingUtils.get(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  /// Converts the seelction [TEnum] values into user-friendly strings.
  String converEnumToString(TEnum value) {
    String spacedValue = value.name.replaceAllMapped(
      RegExp(r'([a-z0-9])([A-Z])'),
      (Match m) => '${m.group(1)} ${m.group(2)}',
    );

    spacedValue = spacedValue.trim();
    Iterable<String> tokens = spacedValue.split(RegExp(r'[\s_\-]+')).where((String word) => word.isNotEmpty);
    Iterable<String> words = tokens.map((String word) => word[0].toUpperCase() + word.substring(1).toLowerCase());

    return words.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Autocomplete<TEnum>(
        focusNode: focusNode,
        textEditingController: textController,
        optionsBuilder: (TextEditingValue textEditingValue) {
          return widget.values.where(
            (TEnum element) {
              String inputValue = textEditingValue.text.toLowerCase().replaceAll(' ', '');
              String elementValue = element.name.toLowerCase().replaceAll(' ', '');

              return elementValue.contains(inputValue);
            },
          );
        },
        displayStringForOption: (TEnum option) => converEnumToString(option),
        fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, void Function() onFieldSubmitted) {
          return TextInput(
            label: widget.label,
            validator: (String? text) {
              if (!widget.isRequired) return null;

              if (text == null || text.isEmpty) {
                return '($TEnum) selection is required.';
              }

              if (!widget.values.any((TEnum element) => element.name.trim().toLowerCase() == text.trim().toLowerCase())) {
                return 'Wrong $TEnum selection.';
              }

              return null;
            },
            focusNode: focusNode,
            controller: textEditingController,
          );
        },
        optionsViewBuilder: (BuildContext context, void Function(TEnum) onSelected, Iterable<TEnum> options) {
          return ColoredBox(
            color: themeData.page.fore,
            child: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (TEnum option in options)
                      ColoredBox(
                        color: currHoverValue == option
                            ? themeData.page.back.withValues(
                                alpha: .15,
                              )
                            : themeData.page.fore,
                        child: SizedBox(
                          width: double.maxFinite,
                          child: PointerArea(
                            onClick: () => onSelected.call(option),
                            cursor: SystemMouseCursors.click,
                            onHover: (bool $in) {
                              setState(() {
                                currHoverValue = option;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsetsGeometry.all(8),
                              child: Text(
                                converEnumToString(option),
                                style: TextStyle(
                                  color: themeData.page.back,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
        onSelected: widget.onSelect,
      ),
    );
  }
}
