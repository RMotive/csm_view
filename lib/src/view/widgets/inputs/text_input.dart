import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {widget} class.
///
/// Draws a {csm} business designed input for text type values.
final class TextInput extends StatefulWidget {
  /// Control title.
  final String? label;

  /// hint text.
  final String? hint;

  /// Control width.
  final double? width;

  /// Control height.
  final double? height;

  /// Control initial value.
  final String? initialValue;

  /// Display text on error.
  final String? errorText;

  /// Flag to add focus listener.
  final bool focusEvents;

  /// Move automaticatly the mouse pointer to this [TextInput] on load.
  final bool autofocus;

  /// Replace the characters by "*" characters to hide sensible input data.
  final bool isPrivate;

  /// Set the widget has enabled or disabled.
  final bool isEnabled;

  /// Border color on input error.
  final bool showErrorColor;

  /// Max input text lenght.
  final int? maxLength;

  /// Max input text lines.
  final int? maxLines;

  /// Don't trigger an empty error validation on empty input.
  final bool isOptional;

  /// Shows additional text at the end of the title label.
  final String? suffixLabel;

  /// Shows an icon at the end of the editable text area.
  final Widget? suffixIcon;

  /// Input text background color.
  final Color? backgroundColor;

  /// Mandatory fix input text lenght.
  ///
  /// If the input lengh is not equal to [maxLenght] value, wil trigger a input text validation error.
  final bool isFixedLength;

  /// Trigger method on tap input text.
  final void Function()? onTap;

  /// Set a custom focusNode.
  final FocusNode? focusNode;

  /// Set a custom controller.
  final TextEditingController? controller;

  /// Custom input validator method.
  final String? Function(String? text)? validator;

  /// Trigger method on input changes.
  final void Function(String text)? onChanged;

  /// Trigger method on lost focus event.
  final Function(PointerDownEvent)? onTapOutside;

  /// This values refers to the waiting time before sending an [OnChange]
  /// notification after the user has typed the last character on the input field.
  final Duration? deBounce;

  /// Set a input text formatter.
  final List<TextInputFormatter>? formatter;

  /// Set an keyboard type: Only characters, only numbers, etc...
  final TextInputType? keyboardType;

  /// Text input auto fill platform hint.
  final Iterable<String> autofillHints;

  /// Main control theming data.
  final ThemingData? controlTheming;

  /// Control theming when it is at { error } state.
  final ThemingData? controlErrorTheming;

  /// Control theming when it is at { success } stat.
  final ThemingData? controlsSuccessTheming;

  /// Creates a new [TextInput] instance.
  const TextInput({
    super.key,
    this.hint,
    this.onTap,
    this.width,
    this.label,
    this.height,
    this.validator,
    this.errorText,
    this.focusNode,
    this.maxLength,
    this.onChanged,
    this.controller,
    this.suffixIcon,
    this.suffixLabel,
    this.initialValue,
    this.backgroundColor,
    this.focusEvents = false,
    this.autofocus = true,
    this.isFixedLength = false,
    this.isOptional = false,
    this.showErrorColor = false,
    this.onTapOutside,
    this.deBounce,
    this.maxLines = 1,
    this.isEnabled = true,
    this.isPrivate = false,
    this.formatter,
    this.controlTheming,
    this.keyboardType,
    this.autofillHints = const <String>[],
    this.controlErrorTheming,
    this.controlsSuccessTheming,
  })  : assert(
          isFixedLength ? maxLength != null : true,
          'When using isFixedLength property a maxLength property must be set',
        ),
        assert(
          initialValue == null || controller == null,
          'If initialvalue provided, can not use controller',
        );

  @override
  State<TextInput> createState() => _TextInputState();
}

/// {state} class.
///
/// Handles [State] fdor [TextInput] {widget}.
final class _TextInputState extends State<TextInput> {
  // --> Theming state data.
  late ThemingData theme;
  late ThemingData errorTheme;
  late ThemingData successTheme;

  /// Border width decoration value.
  static const double _borderWidth = 2;

  final GlobalKey<FormFieldState<String>> textFieldFormState = GlobalKey<FormFieldState<String>>();

  /// Controller for inner [TextFormField] behavior.
  late TextEditingController? textInputCtrl = widget.initialValue != null ? null : widget.controller ?? TextEditingController();

  /// [Focus] identifier node for this [Widget] instance.
  late FocusNode focusNode = widget.focusNode ?? FocusNode();

  /// {state} whether the suffix is being shown.
  late bool showSuffix;

  /// {state} debounce timer object.
  Timer? _deBouncer;

  /// {state} whether there's an error validation text for current input value.
  late String? errorText = widget.errorText;

  /// {state} whether the value has changed since validation.
  bool changeSinceValidation = false;

  @override
  void initState() {
    if (widget.focusEvents) setFocus();

    showSuffix = !widget.isOptional || widget.suffixLabel == null;

    if (showSuffix) {
      focusNode.addListener(
        () {
          setState(() {});
        },
      );
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isOptional != oldWidget.isOptional || widget.suffixLabel != oldWidget.suffixLabel) {
      showSuffix = !widget.isOptional || widget.suffixLabel == null;
    }

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.dispose();
      textInputCtrl = widget.controller ?? TextEditingController();
    }

    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.dispose();
      focusNode = widget.focusNode ?? FocusNode();
    }

    if (widget.errorText != oldWidget.errorText) {
      errorText = widget.errorText;
    }

    /// --> Theming state update.
    IThemeData currentThemeData = ThemingUtils.get(context);
    if (widget.controlTheming != oldWidget.controlTheming) {
      theme = widget.controlTheming ?? currentThemeData.control;
    }

    if (widget.controlErrorTheming != oldWidget.controlErrorTheming) {
      errorTheme = widget.controlErrorTheming ?? currentThemeData.controlError;
    }

    if (widget.controlsSuccessTheming != oldWidget.controlsSuccessTheming) {
      successTheme = widget.controlsSuccessTheming ?? currentThemeData.controlSuccess;
    }
  }

  @override
  void didChangeDependencies() {
    IThemeData currentThemeData = ThemingUtils.get(context);

    theme = widget.controlTheming ?? currentThemeData.control;
    errorTheme = widget.controlErrorTheming ?? currentThemeData.controlError;
    successTheme = widget.controlsSuccessTheming ?? currentThemeData.controlSuccess;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    focusNode.dispose();
    _deBouncer?.cancel();
    textInputCtrl?.dispose();
    super.dispose();
  }

  void setFocus() {
    focusNode.addListener(
      () {
        if (focusNode.hasFocus) {
          _scrollToField();
        }
      },
    );
  }

  // Center scroll to control field
  void _scrollToField() {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: 0.2, // Aligment ratio
    );
  }

  @override
  Widget build(BuildContext context) {
    Color counterColor = widget.isEnabled ? successTheme.accent : Colors.grey;

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: TextFormField(
          key: textFieldFormState,
          autofocus: widget.autofocus,
          initialValue: widget.initialValue,
          validator: (String? value) {
            if (widget.isFixedLength && (value?.length ?? 0) < (widget.maxLength ?? 0) && !changeSinceValidation) {
              errorText = 'Length must be strictly (${widget.maxLength})';
              return errorText;
            }

            return widget.validator?.call(value);
          },
          forceErrorText: null,
          obscureText: widget.isPrivate,
          controller: textInputCtrl,
          focusNode: focusNode,
          cursorOpacityAnimates: true,
          cursorWidth: 2.2,
          cursorErrorColor: errorTheme.accent,
          cursorColor: theme.fore,
          enabled: widget.isEnabled,
          inputFormatters: widget.formatter,
          keyboardType: widget.keyboardType,
          onTap: widget.onTap,
          onTapOutside: widget.onTapOutside,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          autofillHints: widget.autofillHints,
          onChanged: (String typedText) {
            setState(() {
              errorText = null;

              if (textFieldFormState.currentState!.hasError) {
                changeSinceValidation = true;
                textFieldFormState.currentState!.validate();
                changeSinceValidation = false;
              }
            });

            if (widget.deBounce == null) {
              widget.onChanged?.call(typedText);
              return;
            }

            if (_deBouncer?.isActive ?? false) {
              _deBouncer?.cancel();
            }

            _deBouncer = Timer(widget.deBounce!, () {
              widget.onChanged?.call(typedText);
            });
          },
          style: TextStyle(
            color: widget.isEnabled ? theme.fore : Colors.grey,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            labelText: showSuffix ? widget.label : null,
            errorText: errorText,
            isDense: true,
            suffixIcon: widget.suffixIcon,
            suffixIconColor: theme.fore,
            label: !showSuffix
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(widget.label ?? ""),
                      Text(
                        widget.suffixLabel!,
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.fore.withValues(alpha: .5),
                        ),
                      ),
                    ],
                  )
                : null,
            counterStyle: TextStyle(
              color: counterColor,
            ),
            labelStyle: TextStyle(
              color: theme.fore,
            ),
            errorStyle: TextStyle(
              color: errorTheme.fore,
              fontSize: 14,
            ),
            hintStyle: TextStyle(
              color: theme.fore.withValues(alpha: .7),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.showErrorColor
                    ? errorTheme.fore
                    : theme.accent.withValues(
                        alpha: .5,
                      ),
                width: _borderWidth,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.fore.withValues(
                  alpha: .4,
                ),
                width: _borderWidth,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorTheme.accent.withValues(
                  alpha: .7,
                ),
                width: _borderWidth,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorTheme.accent,
                width: _borderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.accent,
                width: _borderWidth + 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
