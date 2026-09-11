part of '../../category_layout.dart';

/// Represents a [CategoryLayoutActionsRibbon] node data.
abstract interface class IActionsRibbonNode {
  /// Composes the [IActionsRibbonNode] representation as a [Widget].
  Widget compose(GlobalKey<CategoryLayoutMessengerState> messengerRef);
}
