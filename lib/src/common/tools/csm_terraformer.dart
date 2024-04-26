import 'package:csm_foundation_view/src/common/common_module.dart';
import 'package:csm_foundation_view/src/common/enums/csm_platforms.dart';
import 'package:flutter/foundation.dart';

/// Tool class for [CSMTerraformer].
///
/// Defines final behavior for [CSMTerraformer] tool object instances.
///
/// [CSMTerraformer] concept: provides useful methods to get and evaluate fastest way the current running platform.
final class CSMTerraformer {
  /// Simplify to get the current running platform.
  static final TargetPlatform _platform = defaultTargetPlatform;

  /// Wheter currently is running web.
  static bool get isWeb => kIsWeb;

  /// Wheter currently is running mobile.
  static bool get isMobile => CSMMatcher.isSomeone(_platform, <TargetPlatform>[TargetPlatform.android, TargetPlatform.fuchsia, TargetPlatform.iOS]);

  /// Wheter currently is running desktop.
  static bool get isDesktop => CSMMatcher.isSomeone(_platform, <TargetPlatform>[TargetPlatform.linux, TargetPlatform.macOS, TargetPlatform.windows]);

  /// Gets the current running platform.
  static CSMPlatforms get context => isWeb
      ? CSMPlatforms.web
      : isMobile
          ? CSMPlatforms.mobile
          : CSMPlatforms.desktop;
}
