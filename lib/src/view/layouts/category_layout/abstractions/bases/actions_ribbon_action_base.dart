part of '../../category_layout.dart';

/// Represents a [CategoryLayout] action at the [ICategoryLayoutPage] actions ribbon.
abstract class ActionsRibbonActionBase implements IActionsRibbonAction {
  /// Action title.
  @override
  final String title;

  /// Action description.
  @override
  final String? description;

  /// Creates a new instance.
  const ActionsRibbonActionBase({
    required this.title,
    this.description,
  });

  @override
  Icon composeIcon(Color fgColor) {
    return Icon(
      Icons.check_box_outline_blank_outlined,
      color: fgColor,
    );
  }

  @override
  FutureOr<List<UserFeedback>>? canExecute(BuildContext context) => null;

  @override
  Widget compose(GlobalKey<CategoryLayoutMessengerState> messengerRef) {
    return _ActionButton(
      actionData: this,
      messengerRef: messengerRef,
    );
  }
}
