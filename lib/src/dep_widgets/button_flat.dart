import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

typedef StatesSet = Set<WidgetState>;
typedef MStates = WidgetState;

/// {widget} class.
///
/// Draws a {csm} designed button flat handling interaction and component design.
final class ButtonFlat extends StatefulWidget {
  /// Control width.
  final double? width;

  /// Control height.
  final double? height;

  /// Control title.
  final String label;

  /// Flag to disable control events.
  final bool disabled;

  /// Theme scheme options.
  final ThemingData? theming;

  /// Trigger method on tap control for [FutureOr] functions.
  final FutureOr<void> Function()? onClick;

  /// Creates a new [ButtonFlat] instance.
  const ButtonFlat({
    super.key,
    this.width,
    this.height = 40,
    this.label = 'Hello!',
    this.disabled = false,
    this.theming,
    required this.onClick,
  });

  @override
  State<ButtonFlat> createState() => _ButtonFlatState();
}

/// {state} class.
///
/// Handles [State] for [ButtonFlat] {widget}.
final class _ButtonFlatState extends State<ButtonFlat> {
  /// {state} [Widget] component theming options.
  late ThemingData theming;

  /// {state} Whether the component is loading data.
  bool isLoading = false;

  @override
  void initState() {
    if (widget.theming != null) {
      theming = widget.theming!;
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {

    if (widget.theming == null) {
      theming = ThemingUtils.get<IThemeData>(context).control;
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ButtonFlat oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.theming != oldWidget.theming) {
      theming = widget.theming ?? ThemingUtils.get<IThemeData>(context).control;
    }
  }

  Color bgStateColorize(StatesSet currentStates) {
    final Color hlightColor = theming.accent;
    final Color reducedColor = hlightColor.withValues(alpha: .7);
    if (widget.disabled) {
      return reducedColor.withValues(alpha: .3);
    }

    return switch (currentStates) {
      (StatesSet state) when state.contains(MStates.hovered) => hlightColor,
      _ => reducedColor,
    };
  }

  Color olStateColorize(StatesSet currentStates) {
    final Color hlightColor = theming.accent;
    if (widget.disabled) {
      return Colors.transparent;
    }
    return switch (currentStates) {
      (StatesSet state) when state.contains(MStates.pressed) => hlightColor,
      _ => Colors.transparent,
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextButton(
        style: ButtonStyle(
          enableFeedback: true,
          backgroundColor: WidgetStateColor.resolveWith(bgStateColorize),
          overlayColor: WidgetStateColor.resolveWith(olStateColorize),
          shape: WidgetStateProperty.all(const LinearBorder()),
        ),
        onPressed: (isLoading || widget.disabled)
            ? null
            : () async {
                if (widget.onClick == null) return;
                setState(() => isLoading = true);
                await widget.onClick!();
                setState(() => isLoading = false);
              },
        child: Center(
          child: Visibility(
            visible: !isLoading,
            replacement: LoadingIndicator(
              hideTextHint: true,
              foreColor: theming.foreAlt ?? theming.fore,
            ),
            child: Text(
              widget.label,
              style: TextStyle(
                color: theming.foreAlt ?? theming.fore,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
