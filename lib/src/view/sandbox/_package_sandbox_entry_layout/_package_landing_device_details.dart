part of '../abstractions/bases/package_sandbox_view_base.dart';

///
final Future<BaseDeviceInfo> deviceInfo = DeviceInfoPlugin().deviceInfo;

/// Internal view fragment for [PackageLandingView] view composition that only displays the running device information.
final class _PackageLandingDeviceDetails extends StatelessWidget with PlatformMixin {
  const _PackageLandingDeviceDetails();

  @override
  Widget build(BuildContext context) {
    PackageSamdboxThemeBase theme = ThemingUtils.get(context);

    return AsyncWidget<BaseDeviceInfo>(
      future: deviceInfo,
      successBuilder: (BuildContext ctx, BaseDeviceInfo data) {
        String systemVersion = '---';
        String system = ' ${defaultTargetPlatform.name.toStartUpperCase()}';
        String platformValue = ' $platform';
        if (data is WebBrowserInfo) {
          systemVersion = data.appVersion?.split(' ').reversed.elementAt(0) ?? systemVersion;
          platformValue += ' ($systemVersion)';
        } else if (data is LinuxDeviceInfo) {
          systemVersion = data.version ?? systemVersion;
        } else if (data is WindowsDeviceInfo) {
          systemVersion = data.displayVersion;
        } else if (data is AndroidDeviceInfo) {
          systemVersion = data.version.incremental;
        } else if (data is IosDeviceInfo) {
          systemVersion = data.systemVersion;
        }

        platformValue += '\n';
        if (data is! WebBrowserInfo) {
          system += ' ($systemVersion)';
        }

        return RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: theme.page.fore,
            ),
            children: <InlineSpan>[
              TextSpan(
                text: 'Device information \n',
              ),

              // --> Platform line
              TextSpan(
                text: 'Platform:',
              ),
              TextSpan(
                text: platformValue,
                style: TextStyle(
                  color: platform.color,
                ),
              ),

              // --> Device system.
              TextSpan(
                text: 'System:',
              ),
              TextSpan(
                text: system,
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
