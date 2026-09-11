part of '../category_layout.dart';

/// Represents a group of action buttons to be composed along [CategoryLayoutPageI] actions ribbon.
final class ActionsRibbonGroup implements IActionsRibbonNode {
  /// Group title.
  final String title;

  /// Group actions.
  final List<IActionsRibbonAction> actions;

  /// Creates a new [ActionsRibbonGroup] instance.
  const ActionsRibbonGroup({
    required this.title,
    required this.actions,
  });

  @override
  Widget compose(GlobalKey<CategoryLayoutMessengerState> messengerRef) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size sectionSize = constraints.biggest;

        return DecoratedBox(
          decoration: const BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(
                width: 1,
                color: Colors.blueGrey,
              ),
            ),
          ),
          child: SizedBox.fromSize(
            size: sectionSize,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  spacing: 4,
                  children: <Widget>[
                    for (IActionsRibbonAction action in actions) action.compose(messengerRef),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
