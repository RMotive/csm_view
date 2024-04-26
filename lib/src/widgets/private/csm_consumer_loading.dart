part of '../csm_consumer.dart';

/// Private widget for [CSMConsumer].
///
/// Defines UI for a [CSMConsumer] implementation.
///
/// [_CSMConsumerLoading] concept: draws a [Widget] to indicate the [CSMConsumer]
/// is loading and awaiting for a [consumption] response.
class _CSMConsumerLoading extends StatelessWidget {
  const _CSMConsumerLoading();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          color: Theme.of(context).indicatorColor,
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
