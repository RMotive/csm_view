import 'package:intl/intl.dart';

/// Provide extension members for [DateTime] type.
extension DateTimeExtensions on DateTime {
  /// Full user-friendly date string.
  String get fullDateTime => DateFormat.yMMMd().add_jm().format(this);
}
