import 'package:csm_view/csm_view.dart';
import 'package:flutter/foundation.dart';

/// Mixin to provide platform data access methods.
mixin PlatformMixin {
  /// Simplify to get the current running platform.
  TargetPlatform get _platform => defaultTargetPlatform;

  /// Wheter currently is running web.
  bool get isWeb => kIsWeb;

  /// Wheter currently is running mobile.
  bool get isMobile => ComparissonUtils.isAny(
        _platform,
        <TargetPlatform>[
          TargetPlatform.android,
          TargetPlatform.fuchsia,
          TargetPlatform.iOS,
        ],
      );

  /// Wheter currently is running desktop.
  bool get isDesktop => ComparissonUtils.isAny(
        _platform,
        <TargetPlatform>[
          TargetPlatform.linux,
          TargetPlatform.macOS,
          TargetPlatform.windows,
        ],
      );

  /// Gets the current running platform.
  Platforms get platform => isWeb
      ? Platforms.web
      : isMobile
          ? Platforms.mobile
          : Platforms.desktop;
}
