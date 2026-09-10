part of 'selector_cards.dart';

/// A [Widget] that draws a selectable value card item.
final class _SelectorCard<TValue> extends StatefulWidget {
  /// Value data.
  final NamedValue<TValue> value;

  /// Card size.
  final WidgetSize? size;

  /// Whether the item is selected.
  final bool isSelected;

  /// Control theming. When not provided takaes from [IThemeData.primaryControlCard].
  final StatefulControlThemeData<CardControlThemeData>? theming;

  /// Event callback when control gets clicked.
  final VoidCallback onClick;

  /// Creates a new instance.
  const _SelectorCard({
    this.size,
    this.theming,
    required this.value,
    required this.onClick,
    required this.isSelected,
  });

  @override
  State<_SelectorCard<TValue>> createState() => _SelectorCardState<TValue>();
}

final class _SelectorCardState<TValue> extends State<_SelectorCard<TValue>> with ControlStatesHandler<CardControlThemeData, _SelectorCard<TValue>> {
  @override
  StatefulControlThemeData<CardControlThemeData> stateThemingFactory(IThemeData themeData) {
    if (widget.theming != null) return widget.theming!;

    return themeData.primaryControlCard;
  }

  @override
  void initState() {
    super.initState();

    if (widget.isSelected) {
      states.add(WidgetState.selected);
    }
  }

  @override
  void didUpdateWidget(covariant _SelectorCard<TValue> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.theming != null) {
      theming = widget.theming!;
      tData = evaluateTheming();
    }

    widget.isSelected ? states.add(WidgetState.selected) : states.remove(WidgetState.selected);
    tData = evaluateTheming();
  }

  /// Event callback when this gets clicked.
  void onClick() {
    widget.onClick();
  }

  @override
  Widget build(BuildContext context) {
    return PointerArea(
      cursor: SystemMouseCursors.click,
      onHover: onHover,
      onClick: onClick,
      child: AnimatedContainer(
        duration: 5.seconds,
        decoration: BoxDecoration(
          border: BoxBorder.fromBorderSide(
            BorderSide(
              color: tData.borderColor ?? Colors.transparent,
              width: 1,
            ),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
          color: tData.bgColor,
        ),
        child: SizedBox(
          width: widget.size?.width,
          height: widget.size?.height,
          child: AspectRatio(
            aspectRatio: 2 / 1,
            child: Center(
              child: Text(
                widget.value.name,
                style: tData.txtStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
