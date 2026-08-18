part of 'async_widget.dart';

/// Private widget for [AsyncWidget].
///
/// Defines UI for a [AsyncWidget] implementation.
///
/// [_AsyncWidgetError] concept: draws a [Widget] to indicate the [AsyncWidget] has reached
/// an error during [consumption] process.
final class _AsyncWidgetError extends StatelessWidget {
  const _AsyncWidgetError();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.error,
          size: theme.primaryIconTheme.size,
          color: theme.colorScheme.error,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Error cacthed",
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.error,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
