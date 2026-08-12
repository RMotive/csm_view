import 'package:csm_view/csm_view.dart';

/// Represents a [PackageSandboxViewBase] items group, creates a navigation access for the whole group
/// displaying inner items.
///
/// [ThemeBase] themee base type.
final class PackageSandboxGroup<ThemeBase extends PackageSandboxThemeBase> extends PackageSandboxGroupBase<ThemeBase> {
  /// Creates a new instance.
  const PackageSandboxGroup({
    super.icon,
    super.image,
    required super.items,
    required super.name,
    required super.description,
  });
}
