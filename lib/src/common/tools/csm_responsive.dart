import 'dart:ui';

import 'package:csm_view/src/common/common_module.dart';

/// Tool class for [CSMResponsive].
///
/// Defines final behavior for [CSMResponsive] tool object instances.
///
/// [CSMResponsive] concept: provides several useful methods to calculate and handle responsive calculations for UI, dynamically.
///
/// Specialized on surface calculations to conditionally decide between several properties or another
/// kind of values based on its base default breakpoints or custom provided breakpoints.
///
/// Default considerations.
/// Breakpoints:
///   For small devices: 0 >= breakpoint < 600
///   For medium devices 600 >= breakpoint < 1200
///   For large devices  1200 => breakpoint
final class CSMResponsive {
  static CSMResponsive? _instance;
  // Avoid self instance
  CSMResponsive._();

  /// Helper intance reference.
  static CSMResponsive get i => _instance ??= CSMResponsive._();

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
  bool get isLargeDevice {
    final double windowSurface = _defaultViewReference.physicalSize.width;
    return windowSurface >= _bpMedium;
  }

  /// Calculates the resolved value based on the default breakpoints values and the provided
  /// values provided in [options].
  ///
  /// Default considerations.
  /// Breakpoints:
  ///   For small devices: 0 >= breakpoint < 600
  ///   For medium devices 600 >= breakpoint < 1200
  ///   For large devices  1200 => breakpoint
  T breakProperty<T>(CSMResponsiveBreakOptions<T> options) {
    final double screenSurface = _defaultViewReference.physicalSize.width;
    if (screenSurface < _bpSmall) return options.small;
    if (screenSurface < _bpMedium) return options.medium;
    return options.large;
  }

  /// Calculates the resolved value based on a custom breakpoints list with the values provided
  /// in [breakpints].
  ///
  /// The breakpoints are calculated from the lowest breakpoint value to the highest one.
  /// While the screen surface width is lower than the given breakpoint will return the breakpoint options value.
  /// ```dart
  ///   if (screenWidth < breakPointOption.breakpoint) return breakpointOption.value;
  /// ```
  ///
  /// NOTE: This responsive calculation methods are quite expensive, recommended use it with the lower amount of breakpoint possible.
  T customBreakProperty<T>(List<CSMPropertyBreakRecord<T>> breakpoints) {
    final double screenSurface = PlatformDispatcher.instance.displays.first.size.width;
    List<CSMPropertyBreakRecord<T>> sortedBreaks = breakpoints.sortBreakpoints();
    for (CSMPropertyBreakRecord<T> breakPoint in sortedBreaks) {
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
  static double clampRatio(double current, CSMClampRatioOptions options) {
    final CSMClampRatioOptions cts = options;

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
