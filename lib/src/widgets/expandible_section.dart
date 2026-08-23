import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Draws an expandible section [Widget].
final class ExpandibleSection extends StatelessWidget {
  /// Group title.
  final String? title;

  /// Property viewers.

  /// Spacing between each child.
  final double spacing;

  /// Children alignment.
  final Alignment? alignemnt;

  /// Whether the [Widget] should maintain their inner [children] state. 
  final bool maintainState;

  /// [Widget] theming data, otherwise will use [IThemeData.page].
  final ThemingData? theming;

  /// Whether the viewer starts expanded.
  final bool startExpanded;
  final List<Widget> children;

  /// Title builder, if given will ignote [title] property and will use this one.
  final Widget Function(BuildContext context)? titleBuilder;

  /// Creates a new instance.
  const ExpandibleSection({
    super.key,
    this.title,
    this.theming,
    this.titleBuilder,
    this.spacing = 6,
    this.startExpanded = true,
    this.maintainState = true,
    this.children = const <Widget>[],
    this.alignemnt = Alignment.topLeft,
  });

  @override
  Widget build(BuildContext context) {
    ThemingData theming = this.theming ?? ThemingUtils.get<IThemeData>(context).page;

    return Material(
      color: Colors.transparent,
      child: ExpansionTile(
        title: titleBuilder != null
            ? titleBuilder!.call(context)
            : Text(
                title ?? 'Viewer group',
                style: TextStyle(
                  color: theming.fore,
                ),
              ),
        maintainState: maintainState,
        childrenPadding: EdgeInsets.all(12),
        expandedAlignment: alignemnt,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        iconColor: theming.fore,
        initiallyExpanded: startExpanded,
        collapsedIconColor: theming.fore,
        children: <Widget>[
          for (Widget child in children)
            if (children.indexOf(child) == 0) ...<Widget>[
              child,
            ] else ...<Widget>[
              Padding(
                padding: EdgeInsetsGeometry.only(
                  top: spacing,
                ),
                child: child,
              )
            ]
        ],
      ),
    );
  }
}
