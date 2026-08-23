import 'package:csm_view/csm_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Represents a [FormArea] controller, wich handles operations and proxies with the [FormArea] is linked to.
final class FormController with ConsoleMixin {
  /// latest calculated [key] to handle the [Form].
  static GlobalKey<FormState>? _key;

  /// the key given by the construction, can be null and
  /// cannot be set directly to [_key] 'cause [static] properties cannot be set by
  /// [const] constructors.
  final GlobalKey<FormState>? _givenKey;

  /// Access to the current [FormWidget] identification key.
  GlobalKey<FormState> get key {
    if (_key != null) return _key as GlobalKey<FormState>;
    _key ??= _givenKey;
    _key ??= GlobalKey();
    return _key as GlobalKey<FormState>;
  }

  /// the [name] provided by the object creation.
  final String? _name;

  /// Access to the current [FormWidget] friendly identification name.
  String get name {
    return _name ?? hashCode.toString();
  }

  /// How the [FormWidget]'s validation will behave.
  final AutovalidateMode? validateMode;

  /// When false, blocks the current route from being popped.
  /// This includes the root route, where upon popping, the Flutter app would exit.
  final bool? canDismiss;

  /// Action to perform each time the [FormWidget] changes.
  final VoidCallback? onChange;

  /// Action to perform each time the [FormWidget] is being tried to be popped.
  ///
  /// [didPop] - wheter the operation has been performed successfuly or not.
  final PopInvokedWithResultCallback<Object?>? onPop;

  /// Generates a new [FormController] options.
  FormController({
    String? name,
    GlobalKey<FormState>? key,
    this.validateMode,
    this.canDismiss,
    this.onChange,
    this.onPop,
  })  : _givenKey = key,
        _name = name;

  //* --> Public methods
  /// Requests to the [FormWidget] to start a validation process.
  bool validate() {
    FormState? formState = _internalCheck();
    if (formState == null) return false;
    return formState.validate();
  }

  /// Requests to the [FormWidget] to start a save process.
  void save() {
    FormState? state = _internalCheck();
    if (state == null) return;
    state.save();
  }

  /// Requests to the [FormWidget] to start a reset process.
  ///
  /// Resets every [FormField] that is a descendant of this [Form] back to its
  /// [FormField.initialValue].
  ///
  /// The [onChange] callback will be called.
  ///
  /// If the [validateMode] property is [AutovalidateMode.always],
  /// the fields will all be revalidated after being reset.
  void reset() {
    FormState? state = _internalCheck();
    if (state == null) return;
    state.reset();
  }

  //* --> Private methods
  /// Validates internally if the current [FormWidget] management has a valid [State] to perform actions.
  FormState? _internalCheck() {
    FormState? formState = key.currentState;
    if (formState == null) {
      exceptionLog(
        'Wrong state management',
        Exception('Form ($name) has faced unhandled state management reaction, maybe it\'s defunc'),
        StackTrace.current,
      );
      return formState;
    }
    return formState;
  }
}
