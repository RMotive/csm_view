import 'dart:async';

import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents an action button to be rendered along [CategoryLayoutPageI] actions ribbon.
final class ActionsRibbonAction extends ActionsRibbonActionBase {
  /// Callback invoked when action is requested.
  final FutureOr<void> Function() onPerform;

  /// Builder invokation to compose the button [Icon] decorator.
  ///
  ///
  /// [foreColor] engine handled recommended icon color.
  final Icon Function(Color foreColor)? iconBuilder;

  /// Callback function triggered on action context building that determines if the
  /// action can be executed if {false} will disable it.
  ///
  ///
  /// [messageBus] collection [String] reference to store all user feedback messages about why the action can't be executed.
  final FutureOr<List<UserFeedback>> Function(BuildContext context)? onCanExecute;

  /// Creates a new [ActionsRibbonActionI] instance.
  const ActionsRibbonAction({
    required super.title,
    required this.onPerform,
    this.iconBuilder,
    this.onCanExecute,
  });

  @override
  FutureOr<void> perform(BuildContext context) => onPerform;

  @override
  Icon composeIcon(Color fgColor) {
    if (iconBuilder == null) {
      return super.composeIcon(fgColor);
    }

    return iconBuilder!.call(fgColor);
  }

  @override
  FutureOr<List<UserFeedback>>? canExecute(BuildContext context) {
    if (onCanExecute == null) return null;

    return onCanExecute?.call(context);
  }
}
