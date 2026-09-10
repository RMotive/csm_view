import 'package:csm_view/csm_view.dart';
import 'package:flutter/foundation.dart';

/// Utilities class that provides methods to access platform data.
final class PlatformUtils {
  /// Simplify to get the current running platform.
  static final TargetPlatform _platform = defaultTargetPlatform;

  /// Wheter currently is running web.
  static bool get isWeb => kIsWeb;

  /// Wheter currently is running mobile.
  static bool get isMobile => ComparissonUtils.isAny(
        _platform,
        <TargetPlatform>[
          TargetPlatform.android,
          TargetPlatform.fuchsia,
          TargetPlatform.iOS,
        ],
      );

  /// Wheter currently is running desktop.
  static bool get isDesktop => ComparissonUtils.isAny(
        _platform,
        <TargetPlatform>[
          TargetPlatform.linux,
          TargetPlatform.macOS,
          TargetPlatform.windows,
        ],
      );

  /// Gets the current running platform.
  static Platforms get context => isWeb
      ? Platforms.web
      : isMobile
          ? Platforms.mobile
          : Platforms.desktop;
}
