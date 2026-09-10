part of '../../abstractions/bases/package_sandbox_view_base.dart';

/// Current device data.
final Future<BaseDeviceInfo> deviceInfo = DeviceInfoPlugin().deviceInfo;

/// A component that displays the current running device information as a section.
final class _PackageSandboxDeviceDetails extends StatelessWidget with PlatformMixin {
  /// Creates a new instance.
  const _PackageSandboxDeviceDetails();

  @override
  Widget build(BuildContext context) {
    final PackageSandboxThemeBase theme = ThemingUtils.get(context);

    return AsyncWidget<BaseDeviceInfo>(
      future: deviceInfo,
      successBuilder: (BuildContext ctx, BaseDeviceInfo data) {
        String platformValue = ' $platform';
        String system = ' ${defaultTargetPlatform.name.toStartUpperCase()}';

        String systemVersion = switch (data) {
          WebBrowserInfo info => info.appVersion?.split(' ').reversed.elementAt(0) ?? '---',
          LinuxDeviceInfo info => info.version ?? '---',
          WindowsDeviceInfo info => info.displayVersion,
          AndroidDeviceInfo info => info.version.incremental,
          IosDeviceInfo info => info.systemVersion,
          _ => '---',
        };

        if (data is WebBrowserInfo) {
          platformValue += ' ($systemVersion)';
        } else {
          system += ' ($systemVersion)';
        }

        return RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            style: TextStyle(
              fontSize: 15,
              color: theme.page.fore,
            ),
            children: <InlineSpan>[
              //* Section title.
              TextSpan(
                text: 'Device information: \n',
              ),

              //* Current platform,
              TextSpan(
                text: 'Platform:',
              ),
              TextSpan(
                text: platformValue,
                style: TextStyle(
                  color: platform.color,
                ),
              ),

              //* Current system.
              TextSpan(
                text: '\nSystem:',
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
