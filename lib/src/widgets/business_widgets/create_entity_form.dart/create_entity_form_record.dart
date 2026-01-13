import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {widget} class.
///
/// Draws a base designed component to display as a {record} summary for [CreateEntityForm] stack..
final class CreateEntityFormRecord extends StatelessWidget {
  /// Item selection status.
  final bool selected;

  /// Fields to display as summary.
  final List<CreateEntityFormRecordField> fields;

  /// Layout expansion behavior flag.
  final bool expand;

  /// Data validation status.
  final bool valid;

  const CreateEntityFormRecord({
    super.key,
    this.expand = false,
    this.valid = true,
    required this.fields,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    FoundationThemeB fountTheme = Theming.get(context);
    final SimpleTheming pageTheme = fountTheme.page;
    final SimpleTheming dangerTheme = fountTheme.error;

    return DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            width: valid ? 0 : 1.5,
            color: valid ? Colors.transparent : dangerTheme.accent,
          ),
        ),
      ),
      child: ColoredBox(
        color: pageTheme.fore.withAlpha(selected ? 126 : 64),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultTextStyle(
            style: TextStyle(
              color: pageTheme.accentAlt ?? Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            child: IntrinsicWidth(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: fields,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
