import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {model} class.
///
/// Data model class that stores information about how to display a field summary at a [CreateEntityFormRecord].
final class CreateEntityFormRecordField extends StatelessWidget {
  /// Propertie title.
  final String label;

  /// Propertie value.
  final String? value;

  /// Min text component width.
  final double? minWidth;

  /// Max text component width.
  final double? maxWidth;

  const CreateEntityFormRecordField({
    super.key,
    this.minWidth,
    this.maxWidth,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    String val = (value?.isEmpty ?? true) ? '---' : value!;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? maxWidth ?? 0,
        maxWidth: maxWidth ?? double.maxFinite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: <Widget>[
          Text('$label:'),
          Text(val, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
