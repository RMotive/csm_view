import 'dart:async';

import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart' hide Route, Router;

part '_category_layout_messenger.dart';
part 'abstractions/bases/actions_ribbon_action_base.dart';
part 'widgets/_action_button.dart';
part 'widgets/_category_layout_ribbon.dart';
part 'widgets/_message_chip.dart';

/// Draws [LayoutI] implementation for a {Category} concept wich holds and routes along several {EntityPages} / {Pages} with their own
/// actions and behaviors, draws an actions ribbon handled layout and inner paging routing behaviors.
final class CategoryLayout extends ViewLayoutBase {
  /// Category pages.
  final List<ICategoryLayoutPage> pages;

  /// Creates a new [CategoryLayout] instance.
  const CategoryLayout({
    required super.page,
    required super.routingData,
    required this.pages,
  }) : assert(pages.length > 0, 'Must be at least one article configured');

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    final GlobalKey<CategoryLayoutMessengerState> messengerRef = GlobalKey();

    return Padding(
      padding: EdgeInsetsGeometry.all(8),
      child: Column(
        children: <Widget>[
          /// --> Action/Navigation Ribbons
          _CategoryLayoutRibbon(
            pages: pages,
            messengerRef: messengerRef,
            routeData: routingData.targetRoute,
          ),

          /// --> Content Box (message system/page content)
          Expanded(
            child: Stack(
              children: <Widget>[
                /// Page Content
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  child: page,
                ),

                /// Messaging system.
                _CategoryLayoutMessenger(
                  key: messengerRef,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
