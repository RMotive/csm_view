import 'package:csm_view/src/core/abstractions/interfaces/iview_page.dart';
import 'package:flutter/material.dart';

/// Represents a { View Module } page.
abstract class ViewPageBase extends StatelessWidget implements IViewPage {
  /// Creates a new instance.
  const ViewPageBase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return LayoutBuilder(
      builder: (_, BoxConstraints constrains) {
        constrains = constrains.copyWith(
          minWidth: 500,
          minHeight: 500,
        );
        final BoxConstraints normalizedConstriants = constrains.normalize();
        Size pageSize = normalizedConstriants.biggest;

        final ScrollController hScroll = ScrollController();
        final ScrollController vScroll = ScrollController();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: hScroll,
          child: SingleChildScrollView(
            controller: vScroll,
            child: ConstrainedBox(
              constraints: normalizedConstriants,
              child: compose(
                context,
                screenSize,
                pageSize,
              ),
            ),
          ),
        );
      },
    );
  }
}
