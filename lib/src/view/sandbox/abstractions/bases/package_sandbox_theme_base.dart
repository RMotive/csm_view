import 'package:csm_view/csm_view.dart';

/// Represents a [PackageLandingView] theme data.
abstract class PackageSandboxThemeBase extends ThemeDataBase implements INavigationLayoutThemeData {

  /// application [Welcome] page landing entries cards [ThemingData] options.
  final ThemingData welcomeCardTheming;

  @override
  final ThemingData navigationLayout;

  /// Creates a new instance.
  const PackageSandboxThemeBase(
    super.identifier, {
    required this.navigationLayout,
    required this.welcomeCardTheming,
    
    required super.icon,
    required super.page,
    required super.dialog,
    required super.control,
    required super.primaryControlCard,
    required super.controlError,
    required super.iconBackground,
    required super.controlSuccess,
    required super.controlDisabled,
  });
}
