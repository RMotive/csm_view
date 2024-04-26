import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget class for [CSMPointerHandler].
///
/// Defines UI for a [CSMPointerHandler] implementation.
///
/// [CSMPointerHandler] concept: a wrapper for a [Widget] that allows to handle pointer behavior at the [child]
/// [Widget] wrapped, like hover behavior and onClick behavior.
final class CSMPointerHandler extends StatelessWidget {
  /// Callback invoked when the [PointerHandler] detects a hover on or hover out action.
  ///
  /// [$in] - indicates if the event is a hover in (true) or hover out (false).
  final void Function(bool $in)? onHover;

  /// Callback invoked when the [PointerHandler] detects a click/tap action at the [Widget].
  final VoidCallback? onClick;

  /// Indicates the cursor to display at the [PointerHandler] context.
  final MouseCursor cursor;

  /// [Widget] to wrap and handle [PointerHandler] events.
  final Widget? child;

  /// Generates a new [CSMPointerHandler] widget.
  const CSMPointerHandler({
    super.key,
    this.cursor = MouseCursor.defer,
    this.onClick,
    this.onHover,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: cursor,
      onEnter: onHover != null
          ? (PointerEnterEvent event) {
              onHover?.call(true);
            }
          : null,
      onExit: onHover != null
          ? (PointerExitEvent event) {
              onHover?.call(false);
            }
          : null,
      child: GestureDetector(
        onTap: onClick,
        child: child,
      ),
    );
  }
}
