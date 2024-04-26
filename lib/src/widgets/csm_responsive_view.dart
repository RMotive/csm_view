import 'package:flutter/widgets.dart';

/// Widget class for [CSMResponsiveView].
///
/// Defines UI for a [CSMResponsiveView] implementation.
///
/// [CSMResponsiveView] concept: handle draw decission based on specific width window breakpoints, specifying what to draw when
/// the screen is large, medium or small.
final class CSMResponsiveView extends StatelessWidget {
  /// This view will be shown when the screen width is >= 1024
  final Widget onLarge;

  /// This view will be shown when the screen width is >= 600 and < 1024
  final Widget? onMedium;

  /// This view will be shown when the screen width is < 600
  final Widget onSmall;

  /// Generates a new [CSMResponsiveView] widget.
  const CSMResponsiveView({
    super.key,
    required this.onLarge,
    required this.onSmall,
    this.onMedium,
  });

  @override
  Widget build(BuildContext context) {
    Size viewSurface = MediaQuery.sizeOf(context);

    if (viewSurface.width < 600) return onSmall;
    if (viewSurface.width < 1024) return onMedium ?? onLarge;
    return onLarge;
  }
}
