import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Draws a checkbox [Widget] to interact.
final class CheckboxInput extends StatefulWidget {
  /// Checkbox label.
  final String label;

  /// Font size.
  final double fontSize;

  /// Whether the checkbox should init checked.
  final bool startChecked;

  /// [Widget] theming data, when no provided by default is used [IThemeData.page].
  final ThemingData? theming;

  /// Whether the [Widget] is disabled.
  final bool disabled;

  /// Callback when the value has changed.
  final void Function(bool value) onChanged;

  /// Creates a new instance
  const CheckboxInput({
    super.key,
    this.theming,
    this.fontSize = 16,
    this.label = 'Select',
    this.disabled = false,
    this.startChecked = false,
    required this.onChanged,
  });

  @override
  State<CheckboxInput> createState() => _CheckboxInputState();
}

/// State class for [CheckboxInput].
final class _CheckboxInputState extends State<CheckboxInput> {
  late bool checkValue = widget.startChecked;

  bool isHovered = false;

  @override
  void didUpdateWidget(covariant CheckboxInput oldWidget) {
    if (oldWidget.startChecked != widget.startChecked) {
      checkValue = widget.startChecked;
    }

    if (oldWidget.disabled != widget.disabled) {
      checkValue = widget.startChecked;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    ThemingData theming = widget.theming ?? ThemingUtils.get(context).page;
    ThemingData themingDisabled = ThemingUtils.get(context).controlDisabled;

    Color fgColor = theming.fore;
    Color bgColor = Colors.transparent;

    if (isHovered) {
      fgColor = fgColor.withAlpha(178);
    }
    if (checkValue) {
      bgColor = theming.fore;
      fgColor = theming.back;

      if (isHovered) {
        bgColor = theming.fore.withAlpha(178);
      }
    }

    if (widget.disabled) {
      fgColor = themingDisabled.back;
      bgColor = Colors.transparent;
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Text(
          '${widget.label}:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: widget.disabled ? fgColor : theming.fore,
            fontSize: widget.fontSize,
          ),
        ),
        PointerArea(
          onClick: widget.disabled
              ? null
              : () {
                  setState(() {
                    checkValue = !checkValue;
                  });

                  widget.onChanged(checkValue);
                },
          onHover: widget.disabled
              ? null
              : (bool $in) {
                  setState(() {
                    isHovered = $in;
                  });
                },
          cursor: widget.disabled ? MouseCursor.defer : SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: fgColor,
                width: 2,
              ),
              color: bgColor,
            ),
            child: checkValue
                ? Icon(
                    Icons.check,
                    size: 18,
                    color: fgColor,
                    fontWeight: FontWeight.w600,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
