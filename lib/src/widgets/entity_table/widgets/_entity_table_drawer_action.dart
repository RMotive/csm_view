part of '../entity_table.dart';

/// {widget} class.
///
/// Draws an action button design and handles it's behavior for [_EntityTableDrawer].
final class _EntityTableDrawerAction extends StatefulWidget {
  /// Custom action button inner [Icon] color.
  final Color? fore;

  /// Icon to display for the button.
  final IconData icon;

  /// Descriptive action name to display on hovering the action button.
  final String action;

  /// Callback event triggered when action button got clicked.
  final VoidCallback onClick;

  /// Creates a new [_EntityTableDrawerAction] instance.
  const _EntityTableDrawerAction({
    this.fore,
    required this.action,
    required this.icon,
    required this.onClick,
  });

  @override
  State<_EntityTableDrawerAction> createState() => _EntityTableDrawerActionState();
}

/// Handles [State] for [_EntityTableDrawer].
final class _EntityTableDrawerActionState extends State<_EntityTableDrawerAction> {
  /// {state} [FoundationThemeB.page] theming reference.
  late IThemeData themeData = ThemingUtils.get(context);

  /// {state} current calcualted button fore color.
  late Color fgColor;

  /// {state} current calcualted button back color.
  late Color bgColor;

  @override
  void didChangeDependencies() {
    themeData = ThemingUtils.get(context);
    fgColor = widget.fore ?? themeData.control.back;
    bgColor = themeData.control.fore;

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant _EntityTableDrawerAction oldWidget) {
    if (oldWidget.fore != widget.fore) {
      fgColor = widget.fore ?? themeData.control.back;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.action,
      child: PointerArea(
        cursor: SystemMouseCursors.click,
        onHover: (bool $in) {
          setState(() {
            bgColor = themeData.page.fore;
            if ($in) {
              bgColor = bgColor.withValues(
                alpha: .75,
              );
            }
          });
        },
        onClick: widget.onClick,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bgColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Icon(
              widget.icon,
              color: fgColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
