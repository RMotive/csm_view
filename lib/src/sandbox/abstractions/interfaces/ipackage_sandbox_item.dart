import 'package:csm_view/csm_view.dart';

/// Represents a package sandbox item who composes an user interface page to interact and read how a package component works.
///
/// [ThemeBase] represents the theming type.
abstract interface class IPackageSandboxItem<ThemeBase extends PackageSandboxThemeBase> implements IPackageSandboxEntry<ThemeBase> {

  /// Creates a new instance.
  const IPackageSandboxItem();
}
