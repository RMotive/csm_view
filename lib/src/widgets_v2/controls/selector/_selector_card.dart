part of 'selector_cards.dart';

/// A [Widget] that draws a selectable value card item.
final class _SelectorCard<TValue> extends StatelessWidget {
  /// Card text style.
  final TextStyle? textStyle;

  /// Value data.
  final NamedValue<TValue> value;

  /// Card size.
  final WidgetSize? size;

  /// Creates a new instance.
  const _SelectorCard({
    this.size,
    this.textStyle,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    ThemeDataBase theme = ThemingUtils.get<ThemeDataBase>(context);

    return BorderedBox(
      borderWidth: 1.5,
      color: theme.control.accent,
      child: SizedBox(
        width: size?.width,
        height: size?.height,
        child: Center(
          child: Text(
            value.name,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
