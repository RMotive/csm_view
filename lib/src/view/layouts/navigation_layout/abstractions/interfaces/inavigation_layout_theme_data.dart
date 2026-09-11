part of '../../navigation_layout.dart';

/// Represents a themed data that uses the { CSM } foundation { Navigation Layour }.
abstract interface class INavigationLayoutThemeData implements IThemeData {
  /// { CSM } foundation navigation layout theming data.
  final ThemingData navigationLayout;

  /// Creates a new instance.
  const INavigationLayoutThemeData(this.navigationLayout);
}
