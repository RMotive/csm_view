import 'package:csm_view/csm_view.dart';

/// Represents a [PackageLandingView] theme data.
abstract class PackageSandboxThemeBase extends ThemeDataBase {
  /// Application header [ThemingData] options.
  final ThemingData landingHeader;

  /// application [Welcome] page landing entries cards [ThemingData] options.
  final ThemingData welcomeCardTheming;

  /// Creates a new instance.
  const PackageSandboxThemeBase(
    super.identifier, {
    required super.icon,
    required super.page,
    required super.control,
    required this.landingHeader,
    required super.controlError,
    required super.iconBackground,
    required super.controlSuccess,
    required super.controlDisabled,
    required this.welcomeCardTheming,
    required super.dialog,
  });
}
