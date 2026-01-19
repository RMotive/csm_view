import 'package:csm_view/csm_view.dart' hide RouteData, DialogView;
import 'package:flutter/material.dart';

/// Represents a [RoutingGraphBase] application's whisper route, a whisper is a modal routed page.
abstract class RoutingGraphWhisperDataBase<T> extends RoutingGraphNodeDataBase implements IRoutingGraphWhisperData {
  /// Options for this [RoutingGraphWhisperDataBase].
  @override
  final WhisperOptions whisperOptions;

  /// Creates a new [RoutingGraphWhisperDataBase] implementation.
  RoutingGraphWhisperDataBase(
    super.route, {
    required this.whisperOptions,
    required super.pageBuilder,
    super.routes,
    super.onDispose,
    super.redirection,
    super.parentNavigationState,
  }) : super(
          transitionBuilder: (IViewPage page) {
            return _Whisper<T>(
              whisperOptions,
              builder: (BuildContext ctx) {
                return page;
              },
            );
          },
        );
}

/// Creates an implementation of a [Page].
///
/// This creates a [Page] implementation to handle [DialogRoute] over the [CSM] environemnt.
final class _Whisper<T> extends Page<T> {
  /// [RouteWhisper] display options.
  final WhisperOptions options;

  /// The [Whisper] UI builder.
  final WidgetBuilder builder;

  /// Special [Key] to identiy the [Whisper]([Dialog]).
  final Key? whisperKey;

  /// Handles a new [Whisper] implementation.
  const _Whisper(
    this.options, {
    required this.builder,
    this.whisperKey,
    super.key,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute<T>(
      context: context,
      settings: this,
      anchorPoint: options.anchorPoint,
      barrierColor: options.barrierColor,
      barrierDismissible: options.barrierDismissible,
      barrierLabel: options.barrierLabel,
      useSafeArea: options.safeArea,
      builder: (BuildContext context) {
        return Dialog(
          key: whisperKey,
          backgroundColor: options.background,
          shadowColor: options.shadow,
          elevation: options.elevation,
          alignment: options.alignemnt,
          clipBehavior: options.clip,
          insetAnimationCurve: options.curve,
          insetAnimationDuration: options.duration,
          insetPadding: options.padding,
          surfaceTintColor: options.tint,
          shape: options.shape,
          child: builder(context),
        );
      },
    );
  }
}
