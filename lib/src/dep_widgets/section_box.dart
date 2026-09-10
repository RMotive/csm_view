import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Draws a section box with a title and content.
final class SectionBox extends StatelessWidget {
  /// Displayed title of the section.
  final String title;

  /// Section content to render.
  final Widget child;

  /// Padding calculated from the parent widget.
  final EdgeInsets outterPadding;

  /// Whether this section is optional.
  final bool isOptional;

  /// Overrides the built-in border color.
  final Color? borderColor;

  /// Title text style.
  final TextStyle? textStyle;

  /// Creates a new instance.
  const SectionBox({
    super.key,
    this.isOptional = false,
    this.outterPadding = const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 20,
    ),
    this.borderColor,
    this.textStyle,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    ThemingData theming = ThemingUtils.get(context).page;

    final Color bColor = isOptional
        ? theming.fore.withValues(
            alpha: .5,
          )
        : borderColor ?? theming.accent;

    return Padding(
      padding: outterPadding,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(
              width: 2,
              color: bColor,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
          ),
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 20,
                ),
                child: Transform.translate(
                  offset: const Offset(
                    0,
                    -40,
                  ),
                  child: ColoredBox(
                    color: theming.back,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: textStyle ??
                            TextStyle(
                              color: theming.fore,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(
                  top: 20,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
