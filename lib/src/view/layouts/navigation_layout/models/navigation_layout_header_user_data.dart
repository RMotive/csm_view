part of '../navigation_layout.dart';

/// Data {model} implementation to store user information required for [NavigationLayout] header user button.
final class NavigationLayoutHeaderUserData implements INavigationLayoutHeaderUserData {
  /// User name.
  @override
  final String name;

  /// User last name.
  @override
  final String lastName;

  /// User email information.
  @override
  final String email;

  @override
  String get fullName => '$name $lastName';

  /// User full name monogram.
  @override
  String get monogram => '${name[0].toUpperCase()}${lastName[0].toUpperCase()}';

  /// Creates a new [NavigationLayoutHeaderUserData] instance.
  const NavigationLayoutHeaderUserData({
    required this.name,
    required this.email,
    required this.lastName,
  });
}
