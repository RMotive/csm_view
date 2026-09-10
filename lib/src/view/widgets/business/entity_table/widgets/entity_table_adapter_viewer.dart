import 'package:flutter/widgets.dart';

/// Draws the [EntityTable] entity details view widget
final class EntityTableViewer extends StatelessWidget {
  /// Viewer children.
  final List<Widget> children;

  /// Creates a new instance.
  const EntityTableViewer({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
