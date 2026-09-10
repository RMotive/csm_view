import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Draws a [Widget] that displays a property value.
///
/// [TValue] - Type of the property value.
final class PropertyViewer<TValue> extends StatelessWidget {
  /// Property name.
  final String label;

  /// Property value.
  final TValue? value;

  /// Font size.
  final double fontSize;

  /// [Widget] theming data, when no provided by default is used [IThemeData.page].
  final ThemingData? theming;

  /// Creates a new instance.
  const PropertyViewer({
    super.key,
    this.theming,
    this.fontSize = 14,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    ThemingData theming = this.theming ?? ThemingUtils.get<IThemeData>(context).page;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: <Widget>[
        Text(
          '$label:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: theming.fore,
            fontSize: fontSize,
          ),
        ),

        /// --> Property is [String] or Null.
        if (value case String? stringVal) ...<Widget>[
          Text(
            stringVal ?? '---',
            style: TextStyle(
              color: theming.fore,
              fontSize: fontSize,
            ),
          ),
        ],

        /// --> Property is a [bool]
        if (value case bool boolVal) ...<Widget>[
          Icon(
            !boolVal ? Icons.close : Icons.check,
            size: fontSize * 1.5,
            color: theming.fore,
          ),
        ],

        /// --> Property is a [DateTime]
        if (value case DateTime dateTimeVal) ...<Widget>[
          Text(
            DateFormat.yMMMd().add_jms().format(dateTimeVal),
            style: TextStyle(
              fontSize: fontSize,
              color: theming.fore,
            ),
          ),
        ],
      ],
    );
  }
}
