part of '../entity_table.dart';

/// Draws a [Widget] for [_EntityTableDrawer] that handles its content.
final class _EntityTableDrawerContent extends StatelessWidget {
  /// Content header.
  final _EntityTableDrawerHeader header;

  /// Drawer content child.
  final Widget child;

  /// Creates a new instance.
  const _EntityTableDrawerContent({
    required this.child,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 30,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // -> Content header
        header,

        // -> Content child.
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: child,
          ),
        ),
      ],
    );
  }
}
