part of '../entity_create_form.dart';

/// {widget} class.
///
/// Draws a base designed component to display as a {record} summary for [CreateEntityForm] stack..
final class CreateEntityFormRecord extends StatelessWidget {
  /// Item selection status.
  final bool selected;

  /// Fields to display as summary.
  final List<CreateEntityFormRecordField<Object>> fields;

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
    IThemeData themeData = ThemingUtils.get(context);
    ThemingData pageTheming = themeData.page;
    ThemingData errorTheming = themeData.controlError;

    return DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            width: valid ? 0 : 1.5,
            color: valid ? Colors.transparent : errorTheming.accent,
          ),
        ),
      ),
      child: ColoredBox(
        color: pageTheming.fore.withAlpha(selected ? 126 : 64),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultTextStyle(
            style: TextStyle(
              color: pageTheming.accentAlt ?? Colors.black,
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
