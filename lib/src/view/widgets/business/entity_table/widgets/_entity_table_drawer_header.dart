part of '../entity_table.dart';

/// Draws a [Widget] for [_EntityTableDrawer] that displays the drawer action header and action buttons.
final class _EntityTableDrawerHeader extends StatelessWidget {
  /// Header title.
  final String title;

  /// Drawer mode actions.
  final List<_EntityTableDrawerAction> actions;

  /// Creates a new instance.
  const _EntityTableDrawerHeader({
    required this.title,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        /// --> Drawer header title.
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
          ),
        ),

        /// --> Drawer header actions.
        Expanded(
          child: Row(
            spacing: 6,
            mainAxisAlignment: MainAxisAlignment.end,
            children: actions,
          ),
        ),
      ],
    );
  }
}
