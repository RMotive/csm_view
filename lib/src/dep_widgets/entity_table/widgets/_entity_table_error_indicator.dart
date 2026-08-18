part of '../entity_table.dart';

/// {private} {widget} class.
///
/// Draws an error display message when an error has being caugth during [EntityTable] phase.
final class _EntityTableErrorIndicator extends StatelessWidget {
  /// Display error width.
  static const double _displayWidth = 300;

  /// Creates a new [_EntityTableErrorIndicator] instance.
  const _EntityTableErrorIndicator();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constrains) {
        constrains = constrains.boxed();
        Size boxingSize = constrains.biggest;
        ThemingData errorTheming = ThemingUtils.get(context).controlError;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (boxingSize.width / 2) - (_displayWidth / 2),
          ),
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                size: 48,
                Icons.signal_wifi_connected_no_internet_4_rounded,
                color: errorTheming.accent,
              ),
              MessageWidget(
                width: _displayWidth,
                text: 'Connection error',
                themeData: errorTheming,
              ),
            ],
          ),
        );
      },
    );
  }
}
