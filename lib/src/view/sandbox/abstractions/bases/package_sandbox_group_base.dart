import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a [PackageSandboxViewBase] items group, creates a navigation access for the whole group
/// displaying inner items.
///
/// [ThemeBase] themee base type.
abstract class PackageSandboxGroupBase<ThemeBase extends PackageSandboxThemeBase> extends PackageSandboxEntryBase<ThemeBase> implements IPackageSandboxGroup<ThemeBase> {
  /// Group items.
  @override
  final List<IPackageSandboxItem<ThemeBase>> items;

  /// Creates a new instance.
  const PackageSandboxGroupBase({
    super.key,
    super.image,
    required this.items,
    required super.name,
    required super.description,
  }) : assert(items.length > 0, 'Sandbox entries group must have items');

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, ThemeBase theme) {
    return SizedBox(
      child: Center(
        child: Text('This is an entries group'),
      ),
    );
  }
}
