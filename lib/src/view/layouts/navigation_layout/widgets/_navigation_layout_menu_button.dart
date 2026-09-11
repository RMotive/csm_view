part of '../navigation_layout.dart';

/// Draws a [NavigationLayout] menu button for application navigation.
final class _NavigationLayoutMenuButton extends StatefulWidget {
  /// Whether the current button must be selected.
  final bool isSelected;

  /// Navigation layout node data.
  final INavigationLayoutNode navigationNode;

  /// Creates a new instance.
  const _NavigationLayoutMenuButton({
    required this.isSelected,
    required this.navigationNode,
  });

  @override
  State<_NavigationLayoutMenuButton> createState() => _NavigationLayoutMenuButtonState();
}

/// State class for [_NavigationLayoutMenuButton].
final class _NavigationLayoutMenuButtonState extends State<_NavigationLayoutMenuButton> with ThemingStateMixin<_NavigationLayoutMenuButton> {
  /// Wheter the button is currently hovered.
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    ThemingData themeData = getTheme<INavigationLayoutThemeData>().navigationLayout;

    Color fgColor = widget.isSelected
        ? themeData.back
        : isHovered
            ? themeData.accent
            : themeData.fore;
    Color bgColor = widget.isSelected
        ? themeData.fore.withAlpha(178)
        : isHovered
            ? themeData.fore.withAlpha(64)
            : themeData.back;

    return PointerArea(
      cursor: widget.isSelected ? MouseCursor.defer : SystemMouseCursors.click,
      onClick: () {
        if (widget.isSelected) return;

        IRouter router = InjectorUtils.get();

        router.go(context, widget.navigationNode.routeData);
      },
      onHover: (bool hover) {
        setState(() {
          isHovered = hover;
        });
      },
      child: ColoredBox(
        color: bgColor,
        child: SizedBox(
          height: 50,
          width: double.maxFinite,
          child: Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /// Selected Entry mark.
              if (widget.isSelected)
                ColoredBox(
                  color: themeData.accent,
                  child: SizedBox(
                    width: 3,
                    height: double.maxFinite,
                  ),
                ),

              /// Adding padding from spacing row property.
              if (!widget.isSelected) SizedBox.shrink(),

              if (widget.navigationNode.icon != null)
                Icon(
                  widget.navigationNode.icon,
                  size: 20,
                  color: fgColor,
                ),
              Text(
                widget.navigationNode.title,
                style: TextStyle(
                  height: 1.0,
                  fontWeight: FontWeight.w500,
                  color: fgColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
