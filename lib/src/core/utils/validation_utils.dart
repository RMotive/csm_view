import 'package:csm_view/csm_view.dart';

/// Provides utilities methods for property validations.
final class ValidationUtils {
  /// Provides a [TextInput] validator method for [String] values.
  ///
  /// [messageLabel] - Label to add the validation message.
  ///
  /// [value] - Property value to validate.
  ///
  /// [isOptional] - Whether the value is optional.
  ///
  /// [minLength] - Value min length requirement.
  ///
  /// [maxLength] - Value max length restriction.
  String? stringValidator(
    String messageLabel,
    String? value, [
    bool isOptional = false,
    int minLength = 0,
    int maxLength = 0,
  ]) {
    if (!isOptional && (value == null || value.isEmpty)) {
      return '$messageLabel cannot be empty';
    }

    if (value == null) {
      return null;
    }

    if (minLength > 0 && value.length < minLength) {
      return '$messageLabel does not meet min length ($minLength)';
    }

    if (maxLength > 0 && value.length > maxLength) {
      return '$messageLabel overrides max length ($maxLength)';
    }

    return null;
  }

  /// Provides a [TextInput] validator method for phone [String] values.
  ///
  /// [messageLabel] - Label to add the validation message.
  ///
  /// [phone] - Phone value to validate.
  ///
  /// [isOptional] - Whether the phone value is optional.
  String? phoneValidator(
    String messageLabel,
    String? phone, [
    bool isOptional = false,
  ]) {
    if (!isOptional && (phone == null || phone.isEmpty)) {
      return '$messageLabel cannot be empty';
    }

    if (phone == null) return null;

    String digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length < 10) {
      return '$messageLabel number must be 10 digits.';
    }

    return null;
  }

  /// Provides a [TextInput] validator method fot email [String] values.
  ///
  /// [messageLabel] - Label to add the validation message.
  ///
  /// [email] - eMail value to validate.
  ///
  /// [isOptional] - Whether the eMail value is optional.
  String? emailValidator(
    String messageLabel,
    String? email, [
    bool isOptional = false,
  ]) {
    if (!isOptional && (email == null || email.isEmpty)) {
      return '$messageLabel cannot be empty';
    }

    if (email == null) return null;

    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email)) {
      return '$messageLabel is not a valid eMail value.';
    }

    return null;
  }
}
