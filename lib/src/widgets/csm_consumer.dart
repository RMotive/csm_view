import 'package:csm_foundation_view/src/common/common_module.dart';
import 'package:flutter/material.dart';

part 'private/csm_consumer_error.dart';
part 'private/csm_consumer_loading.dart';

/// Widget class for [CSMConsumer].
///
/// Defines UI for a [CSMConsumer] implementation.
///
/// [TData] - The type of data to be consumed.
///
/// [CSMConsumer] concept: draws a complex UI based on a network request consuming.
final class CSMConsumer<TData> extends StatefulWidget {
  /// Native implementation asynchronouse abtraction of service call.
  final Future<TData> consume;

  /// Forced time to await before perfoming the consumption.
  final Duration? delay;

  /// Wheter consider an empty object as error.
  final bool emptyAsError;

  /// Custom [Widget] builder to display when the [CSMConsumer] is awaiting for the response.
  final Widget Function(BuildContext ctx)? loadingBuilder;

  /// Custom [Widget] builder to display when the [CSMConsumer] encounters an error.
  final Widget Function(BuildContext ctx, Object? error, TData? data)? errorBuilder;

  /// [Widget] UI built when the [CSMConsumer] gets the consumption resolved as success.
  final Widget Function(BuildContext ctx, TData data) successBuilder;

  /// Generates a new [CSMConsumer] widget.
  const CSMConsumer({
    super.key,
    this.loadingBuilder,
    this.errorBuilder,
    this.delay,
    this.emptyAsError = false,
    required this.consume,
    required this.successBuilder,
  });

  @override
  State<CSMConsumer<TData>> createState() => _CSMConsumerState<TData>();
}

class _CSMConsumerState<TData> extends State<CSMConsumer<TData>> {
  late Future<TData> consume;

  @override
  void initState() {
    super.initState();
    widget.consume;
  }


  /// Applies the [widget.delay] given to the [widget.consume] given.
  Future<TData> delayConsume() async {
    if (widget.delay != null) await Future<void>.delayed(widget.delay as Duration);
    return consume;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TData>(
      future: delayConsume(),
      builder: (BuildContext context, AsyncSnapshot<TData> snapshot) {
        late final Widget display;

        // --> The consumer has reached an exception/error.
        if (snapshot.hasError || (widget.emptyAsError && snapshot.data == null)) {
          if (widget.errorBuilder == null) return const _CSMConsumerError();
          return widget.errorBuilder!(context, snapshot.error, snapshot.data);
        }
        // --> The consumer has reached a success.
        if (snapshot.connectionState == ConnectionState.done) {
          display = widget.successBuilder(context, snapshot.data as TData);
        }
        // --> The consumer is loading.
        else {
          if (widget.loadingBuilder == null) return const _CSMConsumerLoading();
          return widget.loadingBuilder!(context);
        }

        return AnimatedSwitcher(
          duration: 600.miliseconds,
          switchInCurve: Curves.decelerate,
          child: display,
        );
      },
    );
  }
}
