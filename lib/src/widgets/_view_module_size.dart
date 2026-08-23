part of '../abstractions/bases/view_module_base.dart';

/// Private [Widget] for [_ThemeManagerUpdater] used to display the frame size indicator when [_ThemeManagerUpdater.useSizingFrame] and [kDebugMode] are true.
final class _ViewModuleSize extends StatelessWidget {
  /// Creates a new instance.
  const _ViewModuleSize();

  @override
  Widget build(BuildContext context) {
    Size frameSize = MediaQuery.sizeOf(context);
    IThemeData currentTheme = ThemingUtils.get(context);

    return Text(
      frameSize.toString(),
      style: TextStyle(
        fontSize: 16,
        backgroundColor: Colors.transparent,
        decoration: TextDecoration.none,
        color: currentTheme.frame,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
