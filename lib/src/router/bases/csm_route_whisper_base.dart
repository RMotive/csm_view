import 'package:csm_foundation_view/src/router/router_module.dart';
import 'package:flutter/material.dart';

/// Base for [CSMRouteWhisper].
///
/// Provides specific handlers and properties to indicate the base neccesary functions for a
/// [CSMRouteWhisper] concept behavior.
abstract class CSMRouteWhisperBase<T> extends CSMRouteNodeBase implements CSMRouteWhisperInterface {
  /// Specific options for the [Whisper] [Dialog] to show.
  @override
  final CSMRouteWhisperOptions whisperOptions;

  /// Generates a [CSMRouteWhisperBase] implementation.
  CSMRouteWhisperBase(
    super.routeOptions, {
    required this.whisperOptions,
    required super.pageBuild,
    super.routes,
    super.onExit,
    super.redirect,
    super.parentNavigation,
  }) : super(
          transitionBuild: (CSMPageBase page) {
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
class _Whisper<T> extends Page<T> {
  /// [Whisper] display options.
  final CSMRouteWhisperOptions options;

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
