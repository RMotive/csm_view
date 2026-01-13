import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a { View } whisper that is a modal view page.
abstract interface class IViewWhisperForm implements IViewPage {
  /// Whisper title.
  final String title;

  /// Whisper controls width.
  final double controlsWidth;

  /// Creates a new instance.
  const IViewWhisperForm(this.title, this.controlsWidth);

  /// Event called after the whisper is closed.
  FutureOr<void> onClose();

  /// Event called when the whisper perform action is triggered.
  FutureOr<void> onPerform();

  /// Composes the form.
  Widget composeForm(GlobalKey<FormState> formState, BuildContext context, Size windowSize, Size pageSize);
}
