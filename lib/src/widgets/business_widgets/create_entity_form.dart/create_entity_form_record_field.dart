import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Draws a [Widget] that displays a [CreateEntityFormRecord] property value.
final class CreateEntityFormRecordField<TValue> extends StatelessWidget {
  /// Propertie title.
  final String label;

  /// Propertie value.
  final TValue? value;

  /// Min text component width.
  final double? minWidth;

  /// Max text component width.
  final double? maxWidth;

  /// Font size.
  final double fontSize;

  const CreateEntityFormRecordField({
    super.key,
    this.minWidth,
    this.maxWidth,
    this.fontSize = 14,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    ThemingData theming = ThemingUtils.get(context).page;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? maxWidth ?? 0,
        maxWidth: maxWidth ?? double.maxFinite,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: <Widget>[
          Text(
            '$label:',
            style: TextStyle(
              fontSize: fontSize + 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (value case String? stringVal)
            Text(
              stringVal ?? '---',
              style: TextStyle(
                color: theming.fore,
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),

          /// --> Property is a [bool]
          if (value case bool boolVal) ...<Widget>[
            Icon(
              !boolVal ? Icons.close : Icons.check,
              size: fontSize * 1.25,
              color: theming.fore,
            ),
          ],

          /// --> Property is a [DateTime]
          if (value case DateTime dateTimeVal) ...<Widget>[
            Text(
              DateFormat.yMMMd().add_jms().format(dateTimeVal),
              style: TextStyle(
                color: theming.fore,
                fontSize: fontSize,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
