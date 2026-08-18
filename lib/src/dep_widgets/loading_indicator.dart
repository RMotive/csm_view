import 'package:flutter/material.dart';

/// {widget} class.
///
/// Draws a designed loading progress indicator.
class LoadingIndicator extends StatelessWidget {
  /// Circule color.
  final Color foreColor;

  /// Boxfit behavior.
  final BoxFit fit;

  /// Whether the loading indicator just displays the circular progress indicator and not the text hint. 
  final bool hideTextHint;

  /// Padding.
  final EdgeInsets padding;
  const LoadingIndicator({
    super.key,
    required this.foreColor,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 8,
    ),
    this.hideTextHint = false,
    this.fit = BoxFit.fitHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: FittedBox(
        fit: fit,
        child: Column(
          spacing: 8,
          children: <Widget>[
            CircularProgressIndicator(
              strokeWidth: 3,
              backgroundColor: Colors.transparent,
              color: foreColor,
            ),

            if (!hideTextHint)
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 10,
                color: foreColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
