import 'dart:ui';

import 'package:csm_view/csm_view.dart';

///  [Singleton] [Tool] for Widget Responsiveness.
///
/// Provides complex calculations based on the application runtine screen parameters to determine the best parameters for each component
/// to be drawn.
///
/// Default considerations.
/// Breakpoints:
///   For small devices: 0 >= breakpoint < 600
///   For medium devices 600 >= breakpoint < 1200
///   For large devices  1200 => breakpoint
final class WidgetResponsiveness {
  /// Stores the internal object creation lock.
  static WidgetResponsiveness? _instance;

  /// Avoid self instance
  WidgetResponsiveness._();

  /// Helper intance reference.
  static WidgetResponsiveness get i => _instance ??= WidgetResponsiveness._();

  /// Breakpoint value for small devices.
  final double _bpSmall = 600;

  /// Breakpoint value for medium devices.
  final double _bpMedium = 1200;

  /// Internal reference shortcut to get the default subscribed [FlutterView].
  /// This has pyhiscal view devices, app window related properties.
  FlutterView get _defaultViewReference {
    return PlatformDispatcher.instance.views.first;
  }

  /// Gives a shortcut to indicate if the current window surface context is considered as a
  /// large device.
  ///
  /// Consider that by default is a large device when:
  ///   windowSurface >= [1200]
  bool get isLarge {
    final double windowSurface = _defaultViewReference.physicalSize.width;
    return windowSurface >= _bpMedium;
  }

  /// Calculates the resolved value based on the default breakpoints values and the provided
  /// values provided in [options].
  /// 
  /// [width] width space.
  ///
  /// Default considerations.
  /// Breakpoints:
  ///   For small devices: 0 >= breakpoint < 600
  ///   For medium devices 600 >= breakpoint < 1200
  ///   For large devices  1200 => breakpoint
  T breakProperty<T>(double width, ResponsivenessBreakpoint<T> options) {
    final double screenSurface = width;
    if (screenSurface < _bpSmall) return options.small;
    if (screenSurface < _bpMedium) return options.medium;
    return options.large;
  }

  /// Calculates the resolved value based on a custom breakpoints list with the values provided
  /// in [breakpints].
  ///
  /// [width] width space.
  ///
  /// The breakpoints are calculated from the lowest breakpoint value to the highest one.
  /// While the screen surface width is lower than the given breakpoint will return the breakpoint options value.
  /// ```dart
  ///   if (screenWidth < breakPointOption.breakpoint) return breakpointOption.value;
  /// ```
  ///
  /// NOTE: This responsive calculation methods are quite expensive, recommended use it with the lower amount of breakpoint possible.
  T customBreakProperty<T>(double width, List<ResponsivenessBreakpointValue<T>> breakpoints) {
    final double screenSurface = width;
    List<ResponsivenessBreakpointValue<T>> sortedBreaks = breakpoints.sortBreakpoints();
    for (ResponsivenessBreakpointValue<T> breakPoint in sortedBreaks) {
      if (screenSurface < breakPoint.breakpoint) return breakPoint.value;
    }
    // --> Means that the current screen size is higher than the last one breakpoint, so ->
    return sortedBreaks.last.value;
  }

  /// Calculates a clamped window ratio based on a given start and end break for a min and max values based on the current
  /// value percent related to the min and max breaks to get the current value for the min and max vlaue gaps.
  ///
  /// Example:
  ///   current: 100
  ///   minVal: 100
  ///   maxVal: 200
  ///   minBreak: 0
  ///   maxBreak: 100
  ///   result -> 200 cause the current value hits the max break and the max break represents the 200 max value
  ///
  /// Example 2:
  ///   current: 75
  ///   minVal: 100
  ///   maxVal: 200
  ///   minBreak: 0
  ///   maxBreak: 100
  ///   result -> 150
  ///   cause the percent resulted in the min and max break gap related with the current value = 75%
  ///   and then we calculate the 75% of the max possible value.
  static double clampRatio(double current, ResponsivenessRatio options) {
    final ResponsivenessRatio cts = options;

    // --> Simple validations
    if (current <= cts.minBreak) return cts.minValue;
    if (current >= cts.maxBreak) return cts.maxValue;

    final double breakGap = cts.maxBreak - cts.minBreak;
    final double valueGap = cts.maxValue - cts.minValue;
    final double alpha = current - cts.minBreak;
    final double percent = alpha / breakGap;
    final double valueResolved = (cts.minValue + (valueGap * percent));

    return valueResolved;
  }
}
