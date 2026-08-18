import 'package:csm_view/csm_view.dart';
import 'package:device_info_plus/device_info_plus.dart' show DeviceInfoPlugin;
import 'package:flutter/material.dart';

/// Base to describe a component with complex adaptive rendering.
///
/// Each composition of the component is no mandatory but if the application run context tries to compose the
/// component and it returns true will warn about the unsupported component composition for the specific context.
abstract interface class AdaptiveWidgetB extends StatelessWidget {
  /// Base [CSMAdaptiveComponent] constructor.
  ///
  /// [key] widget_tree identification key.
  const AdaptiveWidgetB({super.key});

  /// Composes the component view for Android devices.
  ///
  /// [androidInfo] Android running device information.
  Widget composeAndroid(AndroidDeviceInfo androidInfo) => _UnsupportedCompose('Android');

  /// Composes the component view for iOS devices.
  ///
  /// [iosInfo] iOS running device information.
  Widget composeIOS(IosDeviceInfo iosInfo) => _UnsupportedCompose('iOS');

  /// Composes the component view for Linux devices.
  ///
  /// [linuxInfo] Linux running device information.
  Widget composeLinux(LinuxDeviceInfo linuxInfo) => _UnsupportedCompose('GNU Linux');

  /// Composes the component view for Windows devices
  ///
  /// [windowsInfo] Windows running device information.
  Widget composeWindows(WindowsDeviceInfo windowsInfo) => _UnsupportedCompose('Windows');

  /// Composes the component view for Web Browsers.
  ///
  /// [browserInfo] Browser information.
  Widget composeBrowser(WebBrowserInfo browserInfo) => _UnsupportedCompose('Browser');

  /// Composes the component for all Mobile Devices.
  ///
  /// [deviceInfo] Mobile device information ([AndroidDeviceInfo] and [IosDeviceInfo]).
  Widget composeMobile(BaseDeviceInfo deviceInfo) => _UnsupportedCompose('Mobile');

  /// Composes the component for all Desktop Devices.
  ///
  /// [deviceInfo] Desktop running device information ([LinuxDeviceInfo] and [WindowsDeviceInfo]).
  Widget composeDesktop(BaseDeviceInfo deviceInfo) => _UnsupportedCompose('Desktop');

  @override
  Widget build(BuildContext context) {
    DeviceInfoPlugin deviseInfo = DeviceInfoPlugin();

    return AsyncWidget<BaseDeviceInfo>(
      future: deviseInfo.deviceInfo,
      successBuilder: (BuildContext ctx, BaseDeviceInfo data) {
        if (data is WebBrowserInfo) {
          return composeBrowser(data);
        }

        if (data is LinuxDeviceInfo || data is WindowsDeviceInfo) {
          Widget desktopComponent = composeDesktop(data);
          if (desktopComponent is _UnsupportedCompose) {
            return data is LinuxDeviceInfo
                ? composeLinux(data)
                : data is WindowsDeviceInfo
                    ? composeWindows(data)
                    : desktopComponent;
          }

          return desktopComponent;
        }

        if (data is AndroidDeviceInfo || data is IosDeviceInfo) {
          Widget mobileComponent = composeMobile(data);
          if (mobileComponent is _UnsupportedCompose) {
            return data is AndroidDeviceInfo
                ? composeAndroid(data)
                : data is IosDeviceInfo
                    ? composeIOS(data)
                    : mobileComponent;
          }

          return mobileComponent;
        }

        return _UnsupportedCompose('Unknown platform (${data.data})');
      },
    );
  }
}

/// Small component to display an error for platform evaluation.
final class _UnsupportedCompose extends StatelessWidget {
  /// Displayable context for platform error.
  final String context;

  const _UnsupportedCompose(this.context);

  @override
  Widget build(BuildContext context) {
    return ErrorWidget('Unsupported platform ($context) component compose');
  }
}
