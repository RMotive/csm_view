part of '../csm_consumer.dart';

/// Private widget for [CSMConsumer].
///
/// Defines UI for a [CSMConsumer] implementation.
///
/// [_CSMConsumerError] concept: draws a [Widget] to indicate the [CSMConsumer] has reached
/// an error during [consumption] process.
final class _CSMConsumerError extends StatelessWidget {
  const _CSMConsumerError();

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
