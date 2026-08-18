import 'dart:async';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

part 'async_widget_error.dart';
part 'async_widget_progress.dart';

/// {widget} class.
///
///
/// [T] type of the result data object for the [Future] invokation.
///
/// Defines a complex [Widget] that handles asynchronous calls to wait for a result data object, drawing
/// different views depending on the [Future] invokation state and custom given building evaluations.
final class AsyncWidget<T> extends StatefulWidget {
  /// Whether the [T] type is [void].
  final bool isVoid;

  /// Forced time to await before perfoming the consumption.
  final Duration? delay;

  /// Native implementation asynchronouse abtraction of service call.
  final FutureOr<T> future;

  /// Validation check for [data] if it's empty considering it a failure.
  final bool Function(T data)? emptyCheck;

  /// Custom [Widget] builder to display when the [AsyncWidget] is awaiting for the response.
  final Widget Function(BuildContext ctx)? loadingBuilder;

  /// [Widget] UI built when the [AsyncWidget] gets the consumption resolved as success.
  final Widget Function(BuildContext ctx, T data) successBuilder;

  /// Custom [Widget] builder to display when the [AsyncWidget] encounters an error.
  final Widget Function(BuildContext ctx, Object? error, T? data)? errorBuilder;

  /// Whether [AsyncWidget] should cache the result [Widget] intself and don't rebuild it even though the
  /// state has received updates that doesn't affect the [future] data be re-fetched.
  ///
  ///
  /// NOTE: Originaly this [AsyncWidget] handles by default a cached widget builder function that
  /// recalls the last result [Widget] building passing [BuildContext] and last resolved [T] object result but this
  /// rebuilds the [Widget] every time the parent emits changes to this one, so enabling this option the [AsyncWidget] will
  /// cache a more deeper resuñted [Widget] instance and won't rebuilt it even though this [State] gets updated by the parent
  /// only will get rebuilt when [AsyncWidget] determines the [future] must be recalculated, this when [future] function references changes or when [agent] reference changes.
  final bool isStatic;

  /// Creates a new [AsyncWidget] widget.
  const AsyncWidget({
    super.key,
    this.delay,
    this.emptyCheck,
    this.errorBuilder,
    this.loadingBuilder,
    this.isVoid = false,
    this.isStatic = false,
    required this.future,
    required this.successBuilder,
  });

  @override
  State<AsyncWidget<T>> createState() => _AsyncWidgetState<T>();
}

/// (private) [State] class for [AsyncWidget].
///
/// Handles the [State] behavior for [AsyncWidget].
final class _AsyncWidgetState<T> extends State<AsyncWidget<T>> {
  /// Cached [Widget] when this is static and one has been resulted.
  Widget? cachWidget;

  /// Cached [Widget] builder for performance improvements.
  Widget Function()? cachWidgetBuilder;

  /// Stores the last Future connection state result.
  late ConnectionState connState;

  /// Cached [Future] invokation metadata.
  late Future<T> cachFuture = _internalFuture();

  @override
  void initState() {
    connState = ConnectionState.none;
    cachFuture = _internalFuture();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AsyncWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.future != oldWidget.future) {
      connState = ConnectionState.none;
      cachWidget = null;
      cachWidgetBuilder = null;
      cachFuture = _internalFuture();
    }

    if ((oldWidget.isStatic != widget.isStatic) && (widget.isStatic) && (cachWidgetBuilder != null)) {
      cachWidget = cachWidgetBuilder!();
    }
  }

  /// Calculates the internal [Future] instance to work with, applying [delay] if there's and evaluations.
  Future<T> _internalFuture() async {
    if (widget.delay != null) {
      await Future<void>.delayed(widget.delay as Duration);
    }

    return await widget.future;
  }

  @override
  Widget build(BuildContext context) {
    if (connState == ConnectionState.done && widget.isStatic && cachWidget != null) {
      return cachWidget as Widget;
    }

    return (cachWidgetBuilder != null) && (connState == ConnectionState.done)
        ? cachWidgetBuilder!()
        : FutureBuilder<T>(
            future: cachFuture,
            builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
              final T? data = snapshot.data;
              connState = snapshot.connectionState;

              /// --> Connection state is loading.
              if (connState != ConnectionState.done) {
                cachWidgetBuilder = () => const _AsyncWidgetProgress();

                if (widget.loadingBuilder != null) {
                  cachWidgetBuilder = () => widget.loadingBuilder!(context);
                }
              } else {
                final bool wrongData = (data == null && (!widget.isVoid) && (null is! T));
                final bool isInvalid = widget.emptyCheck?.call(data as T) ?? false;

                if (snapshot.hasError || wrongData || isInvalid) {
                  cachWidgetBuilder = () => const _AsyncWidgetError();

                  if (widget.errorBuilder != null) {
                    cachWidgetBuilder = () => widget.errorBuilder!(context, snapshot.error, snapshot.data);
                  }
                } else {
                  cachWidgetBuilder = () => widget.successBuilder(context, snapshot.data as T);
                }
              }

              final Widget layWidget = cachWidgetBuilder!();
              if (widget.isStatic) {
                cachWidget = layWidget;
              }

              return AnimatedSwitcher(
                switchInCurve: Curves.decelerate,
                duration: 600.miliseconds,
                child: layWidget,
                layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                  return Stack(
                    alignment: Alignment.topLeft, // Adjust alignment as needed
                    children: <Widget>[
                      ...previousChildren,
                      if (currentChild != null) currentChild,
                    ],
                  );
                },
              );
            },
          );
  }
}
