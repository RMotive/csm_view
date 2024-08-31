import 'package:csm_view/src/common/common_module.dart';
import 'package:flutter/widgets.dart';

/// Options class for [CSMInputHandler].
///
/// Defines specifications for a [CSMInputHandler].
///
/// [CSMInputHandler] concept: specifications for an input handling references, like
/// focus controller, editing controller and who should it be handled.
final class CSMInputHandlerOptions {
  /// Input control state identification
  final String name;

  /// Input control text edition controller.
  final TextEditingController? textController;

  /// Input control focus handler controller.
  final FocusNode? focusController;

  /// Generates a new [CSMInputHandlerOptions] options.
  const CSMInputHandlerOptions(
    this.name, {
    this.textController,
    this.focusController,
  });

  /// Generates a new [CSMInputHandlerOptions] options.
  ///
  /// Auto generates all controllers for this options.
  factory CSMInputHandlerOptions.auto(String name) {
    return CSMInputHandlerOptions(
      name,
      focusController: FocusNode(),
      textController: TextEditingController(),
    );
  }

  /// Request for the input text
  /// If the current input doesn`t have a text editing controller, will be returned [''] empty string.
  String get text {
    if (textController != null) return (textController?.text as String);
    CSMAdvisor('CONTROL-[($name)]').warning('Current controller context doesn\'t have a text editing controller');
    return '';
  }

  /// Request to get the focus to the current input context.
  void focus() {
    if (focusController != null) return CSMFocuser.focus(focusController as FocusNode);
    CSMAdvisor('CONTROL-[($name)]').warning('Current controller context doesn\'t have a focus controller');
    return;
  }
}
