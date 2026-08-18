import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget class for [PointerArea].
///
/// Defines UI for a [PointerArea] implementation.
///
/// [PointerArea] concept: a wrapper for a [Widget] that allows to handle pointer behavior at the [child]
/// [Widget] wrapped, like hover behavior and onClick behavior.
final class PointerArea extends StatelessWidget {
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

  /// Whether this widget should prevent other [MouseRegion]s visually behind it
  /// from detecting the pointer.
  ///
  /// This changes the list of regions that a pointer hovers, thus affecting how
  /// their [onHover], [onEnter], [onExit], and [cursor] behave.
  ///
  /// If [opaque] is true, this widget will absorb the mouse pointer and
  /// prevent this widget's siblings (or any other widgets that are not
  /// ancestors or descendants of this widget) from detecting the mouse
  /// pointer even when the pointer is within their areas.
  ///
  /// If [opaque] is false, this object will not affect how [MouseRegion]s
  /// behind it behave, which will detect the mouse pointer as long as the
  /// pointer is within their areas.
  ///
  /// This defaults to true.
  final bool opaque;

  /// How this gesture detector should behave during hit testing when deciding
  /// how the hit test propagates to children and whether to consider targets
  /// behind this one.
  ///
  /// This defaults to [HitTestBehavior.deferToChild] if [child] is not null and
  /// [HitTestBehavior.translucent] if child is null.
  ///
  /// See [HitTestBehavior] for the allowed values and their meanings.
  final HitTestBehavior? behavior;

  /// Generates a new [PointerArea] widget.
  const PointerArea({
    super.key,
    this.onClick,
    this.onHover,
    this.child,
    this.behavior,
    this.opaque = true,
    this.cursor = MouseCursor.defer,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: cursor,
      opaque: opaque,
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
        behavior: behavior,
      ),
    );
  }
}
