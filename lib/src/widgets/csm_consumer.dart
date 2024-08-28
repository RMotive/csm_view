import 'dart:async';

import 'package:csm_foundation_view/src/common/common_module.dart';
import 'package:csm_foundation_view/src/widgets/agents/csm_consumer_agent.dart';
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
  final Future<TData> Function() consume;

  /// Forced time to await before perfoming the consumption.
  final Duration? delay;

  /// Wheter consider an empty object as error.
  final bool Function(TData data)? emptyCheck;

  /// Custom [Widget] builder to display when the [CSMConsumer] is awaiting for the response.
  final Widget Function(BuildContext ctx)? loadingBuilder;

  /// Custom [Widget] builder to display when the [CSMConsumer] encounters an error.
  final Widget Function(BuildContext ctx, Object? error, TData? data)? errorBuilder;

  /// [Widget] UI built when the [CSMConsumer] gets the consumption resolved as success.
  final Widget Function(BuildContext ctx, TData data) successBuilder;

  /// Agent to perform actions to the component state instance.
  final CSMConsumerAgent? agent;

  /// Generates a new [CSMConsumer] widget.
  const CSMConsumer({
    super.key,
    this.loadingBuilder,
    this.errorBuilder,
    this.delay,
    this.agent,
    this.emptyCheck,
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
    consume = _delayConsume();
    widget.agent?.addListener(_refreshConsume);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant CSMConsumer<TData> oldWidget) {
    if (oldWidget.agent != widget.agent) {
      widget.agent?.addListener(_refreshConsume);
    }

    super.didUpdateWidget(oldWidget);
  }

  void _refreshConsume() {
    setState(() {
      consume = _delayConsume();
    });
  }

  /// Applies the [widget.delay] given to the [widget.consume] given.
  Future<TData> _delayConsume() async {
    if (widget.delay != null) await Future<void>.delayed(widget.delay as Duration);

    return widget.consume();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TData>(
      future: consume,
      builder: (BuildContext context, AsyncSnapshot<TData> snapshot) {
        late final Widget display;

        // --> Connection state is loading.
        if (snapshot.connectionState != ConnectionState.done) {
          display = widget.loadingBuilder?.call(context) ?? const _CSMConsumerLoading();
        } else {
          // --> The consumer has reached an exception/error.

          final bool consumerVoid = widget.consume is Future<void> Function();
          if (snapshot.hasError || ((snapshot.data == null && (!consumerVoid)) || (widget.emptyCheck != null && widget.emptyCheck!.call(snapshot.data as TData)))) {
            display = widget.errorBuilder?.call(context, snapshot.error, snapshot.data) ?? const _CSMConsumerError();
          } else {
            display = widget.successBuilder(context, snapshot.data as TData);
          }
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
