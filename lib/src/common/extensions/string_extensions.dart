import 'package:flutter/foundation.dart';

/// Provide extensions for [String] type.
extension StringExtension on String {
  /// Checks whether the current [String] starts with an Upper case letter.
  bool get startUppercase {
    final String startLetter = substring(0, 1);
    return startLetter.toUpperCase() == startLetter;
  }

  /// Replaces [String] start letter with Upper casing.
  String toStartUpperCase() {
    if (startUppercase) return this;
    final String startLetter = substring(0, 1);
    return '${startLetter.toUpperCase()}${substring(1, length)}';
  }

  /// Converts the current [String] into an [Uint8List] using base64 convertion.
  Uint8List toByteArray() {
    return Uint8List.fromList(codeUnits);
  }
}
