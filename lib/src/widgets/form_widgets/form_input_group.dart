import 'package:flutter/material.dart';

/// Draws a [Widget] that handles a group of inputs for a [FormArea].
final class FormInputGroup extends StatelessWidget {
  /// Main axis (horizontal) alligment.
  final WrapAlignment alignemnt;

  /// Run axis (vertical) alligment.
  final WrapAlignment runAlignment;

  /// Spacing between items along the main axis (horizontal).
  final double spacing;

  /// Spacing between items along the run axis (vertical).
  final double runSpacing;

  /// Box width.
  final double? width;

  /// Minimum width each input can have.
  final double minInputWidth;

  /// Whether the [Widget] should lay all [children] auto calculating space along axis.
  final bool autoInputWidth;

  /// Children widgets.
  final List<Widget> children;

  /// Creates a new instance.
  const FormInputGroup({
    super.key,
    this.spacing = 12,
    this.runSpacing = 12,
    this.minInputWidth = 275,
    this.autoInputWidth = true,
    this.width = double.maxFinite,
    this.children = const <Widget>[],
    this.alignemnt = WrapAlignment.spaceEvenly,
    this.runAlignment = WrapAlignment.spaceEvenly,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: LayoutBuilder(
        builder: (_, BoxConstraints constrains) {
          List<Widget> children = this.children;

          if (autoInputWidth) {
            double boxSpace = constrains.maxWidth;
            double spacingReduction = runSpacing * (children.length - 1);

            double naturalSpace = boxSpace - spacingReduction;

            double inputSpace = naturalSpace / children.length;

            if (inputSpace < minInputWidth) {
              inputSpace = minInputWidth;
            }

            children = children.map(
              (Widget e) {
                return SizedBox(
                  width: inputSpace,
                  child: e,
                );
              },
            ).toList();
          }

          return Wrap(
            alignment: alignemnt,
            runAlignment: runAlignment,
            spacing: spacing,
            runSpacing: runSpacing,
            children: children,
          );
        },
      ),
    );
  }
}
