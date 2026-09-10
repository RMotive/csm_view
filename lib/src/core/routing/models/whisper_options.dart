import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents [IRoutingGraphWhisperData] options data.
final class WhisperOptions {
  /// Where the [RouteWhisper] would be anchored.
  final Offset? anchorPoint;

  /// The color for the background barrier at the animation time.
  final Color? barrierColor;

  /// Indicates if the barrier should be dismissed at [ESC] button or tapping the barrier.
  final bool barrierDismissible;

  /// [UNKNOWN]
  final String? barrierLabel;

  /// Indicates if the [Whisper] must be anchored after viewport safe area.
  final bool safeArea;

  /// Elevation for the UI above the barrier.
  final double elevation;

  /// Color for the [Whisper] background.
  final Color background;

  /// Where the [Whisper] should be aligned.
  final AlignmentGeometry? alignemnt;

  /// Color for the [Whisper] shadoe, shadow displayed at the elevation calculation.
  final Color shadow;

  /// Handlers the content clip behavior related to its
  final Clip clip;

  /// How the animation behaves.
  final Curve curve;

  /// How much the animation lasts.
  final Duration duration;

  /// Sets a padding aroung the [Whisper].
  final EdgeInsets? padding;

  /// What kind of shape should be drawn for the [Whisper].
  final ShapeBorder? shape;

  /// The color used as a surface tint overlay on the [Whisper] background color
  /// which reflects the [Whisper´s] [elevation].
  final Color? tint;

  /// Creates a new instance.
  const WhisperOptions({
    this.tint,
    this.shape,
    this.alignemnt,
    this.anchorPoint,
    this.barrierColor,
    this.barrierLabel,
    this.elevation = 0,
    this.safeArea = true,
    this.clip = Clip.none,
    this.padding = EdgeInsets.zero,
    this.curve = Curves.decelerate,
    this.barrierDismissible = true,
    this.shadow = Colors.transparent,
    this.background = Colors.transparent,
    this.duration = const Duration(milliseconds: 100),
  });
}
