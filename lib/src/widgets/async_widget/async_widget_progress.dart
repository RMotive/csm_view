part of 'async_widget.dart';

/// Private widget for [AsyncWidget].
///
/// Defines UI for a [AsyncWidget] implementation.
///
/// [_AsyncWidgetProgress] concept: draws a [Widget] to indicate the [AsyncWidget]
/// is loading and awaiting for a [consumption] response.
class _AsyncWidgetProgress extends StatelessWidget {
  const _AsyncWidgetProgress();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          color: Theme.of(context).tabBarTheme.indicatorColor,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            "Recovering data...",
            style: Theme.of(context).textTheme.labelLarge?.apply(
                  fontStyle: FontStyle.italic,
                ),
          ),
        ),
      ],
    );
  }
}
