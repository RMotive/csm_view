import 'package:flutter/services.dart';

/// Handles formatter behavior for emails.
final class EmailFormatter extends TextInputFormatter {
  static final RegExp _allowed = RegExp(r'[a-zA-Z0-9@._\-+]');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String filtered = newValue.text.toLowerCase().split('').where((String c) => _allowed.hasMatch(c)).join();

    return newValue.copyWith(
      text: filtered,
      selection: TextSelection.collapsed(offset: filtered.length),
    );
  }
}
