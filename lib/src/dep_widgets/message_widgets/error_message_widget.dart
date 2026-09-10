import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Draws an error message user-friendly to norify about an error found.
final class ErrorMessageWidget extends StatelessWidget {
  /// Text message value to display.
  final String message;

  /// Creates a new [ErrorMessageWidget] instance.
  const ErrorMessageWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: MessageWidget(
        text: message,
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        themeData: ThemingUtils.get<IThemeData>(context).controlError,
      ),
    );
  }
}
