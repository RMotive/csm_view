import 'package:csm_foundation_view/src/router/router_module.dart';
import 'package:flutter/material.dart';

/// Base for [CSMPage].
///
/// Defines base hebavior for [CSMPage] implementation.
///
/// [CSMPage] concept: is a complex UI that designs a full user display page, wrapping content and displaying custom designs.
abstract class CSMPageBase extends StatelessWidget implements CSMPageInterface {
  const CSMPageBase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return LayoutBuilder(
      builder: (_, BoxConstraints constrains) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constrains.maxWidth,
              minHeight: constrains.maxHeight,
            ),
            child: compose(context, screenSize),
          ),
        );
      },
    );
  }
}
