import 'package:csm_view/csm_view.dart';

/// Represents a [PackageSandboxViewBase] items group, creates a navigation access for the whole group
/// displaying inner items.
///
/// [ThemeBase] themee base type.
abstract interface class IPackageSandboxGroup<ThemeBase extends PackageSandboxThemeBase> implements IPackageSandboxEntry<ThemeBase> {
  /// Group items.
  final List<IPackageSandboxItem<ThemeBase>> sandboxItems;

  /// Creates a new instance.
  const IPackageSandboxGroup(
    this.sandboxItems,
  );
}
