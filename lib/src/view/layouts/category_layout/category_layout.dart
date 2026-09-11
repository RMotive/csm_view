import 'dart:async';

import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart' hide Route, Router;

// > Encapsulating [/abstractions]

// >> Encapsulating [/abstractions/interfaces]
part 'abstractions/interfaces/iactions_ribbon_node.dart';
part 'abstractions/interfaces/icategory_layout_page.dart';
part 'abstractions/interfaces/iactions_ribbon_action.dart';
part 'abstractions/interfaces/icategory_layout_theme_data.dart';

// >> Encapsulating [/abstractions/bases]
part 'abstractions/bases/actions_ribbon_action_base.dart';
part 'abstractions/bases/category_layout_page_base.dart';

// > Encapsulating [/actions_ribbon]
part 'actions_ribbon/actions_ribbon_group.dart';
part 'actions_ribbon/actions_ribbon_action.dart';

// >> Encapsulating [/actions_ribbon/generic_actions]
part 'actions_ribbon/generic_actions/actions_ribbon_create.dart';
part 'actions_ribbon/generic_actions/actions_ribbon_refresh.dart';

// > Encapsulating [/routing]
part 'routing/category_layout_page.dart';
part 'routing/category_layout_routing_graph_data.dart';

// > Encapsulating [/widgets]
part 'widgets/_message_chip.dart';
part 'widgets/_action_button.dart';
part 'widgets/_category_layout_messenger.dart';
part 'widgets/_category_layout_ribbon.dart';

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
