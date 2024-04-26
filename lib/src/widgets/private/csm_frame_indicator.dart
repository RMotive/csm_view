part of '../../csm_application.dart';

final class _CSMFrameIndicator extends StatelessWidget {
  const _CSMFrameIndicator();

  @override
  Widget build(BuildContext context) {
    final Size frameSize = MediaQuery.sizeOf(context);
    final CSMThemeBase theme = getTheme();

    return Text(
      frameSize.toString(),
      style: TextStyle(
        fontSize: 16,
        backgroundColor: Colors.transparent,
        decoration: TextDecoration.none,
        color: theme.frame,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
