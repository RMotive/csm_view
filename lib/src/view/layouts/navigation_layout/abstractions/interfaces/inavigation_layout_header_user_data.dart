part of '../../navigation_layout.dart';

/// Represents solution user displayable data.
abstract interface class INavigationLayoutHeaderUserData {
  /// User name.
  final String name;

  /// User last name.
  final String lastName;

  /// User email information.
  final String email;

  /// User full name.
  String get fullName;

  /// User full name monogram.
  String get monogram;

  /// Creates a new instance.
  const INavigationLayoutHeaderUserData(this.name, this.lastName, this.email);
}
