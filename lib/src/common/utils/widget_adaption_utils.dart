import 'package:csm_view/csm_view.dart';
import 'package:flutter/foundation.dart';

/// Utilities class that provides methods for [Widget] adaption.
final class WidgetAdaptionUtils {
  /// Calculates the current runtime platform to return the one that matches the platform.
  static T adaptProperty<T>({
    required T defaultValue,
    T? browserValue,
    T? mobileValue,
    T? desktopValue,
    T? androidValue,
    T? iosValue,
    T? linuxValue,
    T? windowsValue,
  }) {
    T result = defaultValue;
    switch (PlatformUtils.context) {
      case Platforms.web:
        result = browserValue ?? defaultValue;
      case Platforms.mobile:
        result = (mobileValue ?? (defaultTargetPlatform == TargetPlatform.iOS ? iosValue : androidValue)) ?? defaultValue;
      case Platforms.desktop:
        result = (desktopValue ?? (defaultTargetPlatform == TargetPlatform.windows ? windowsValue : linuxValue)) ?? defaultValue;
    }

    return result;
  }
}
