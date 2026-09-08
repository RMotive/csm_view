import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// {widget} class.
///
/// [DropUp] Displays a interactable control. When this control is tapped, deploy an aditional section in a drop up animation.
/// The content in this section is an interactable list of [T] items.
class DropUp<T> extends StatefulWidget {
  /// Initial selection item.
  final T item;

  /// Options list to display.
  final List<T> items;

  /// Message to show on hover.
  final String? tooltip;

  /// Trigger method on select an item.
  final FutureOr<void> Function(T item) onChange;

  /// Flag to enabled or disabled widget.
  final bool disabled;

  const DropUp({
    super.key,
    this.tooltip,
    this.disabled = false,
    required this.item,
    required this.items,
    required this.onChange,
  });

  @override
  State<DropUp<T>> createState() => _DropUpState<T>();
}

/// {state} class.
///
/// Hanldes [State] for [DropUp] {widget}.
final class _DropUpState<T> extends State<DropUp<T>> with TickerProviderStateMixin {
  /// {state} theming effect reference.
  final UniqueKey themingRef = UniqueKey();

  /// Layer link instance for overlaying control.
  final LayerLink layerLink = LayerLink();

  /// Options cascade overlay entry.
  OverlayEntry? overlay;

  /// Currently selected item.
  late T currValue = widget.items[0];

  /// {state} current application theming information.
  late IThemeData themeData;

  /// {state} [Widget] background color.
  late Color bgColor;

  /// {state} [Widget] foreground color.
  late Color fgColor;

  /// --> {DropUp} Animation Configuration <--

  /// Controller for {DropUp} animation interactions.
  late final AnimationController dropUpAnimCtrl = AnimationController(
    vsync: this,
    duration: 300.miliseconds,
  );

  /// Animation value handler for {DropUp} linked animation.
  late Animation<double> dropUpAnimTween = CurvedAnimation(
    parent: dropUpAnimCtrl,
    curve: Curves.easeInOut,
  );

  /// Animation value handler for {IconRotation} linked animation.
  late final Animation<double> iconRotAnimTween = Tween<double>(
    begin: 0.0,
    end: .5,
  ).animate(
    CurvedAnimation(
      parent: dropUpAnimCtrl,
      curve: Curves.easeInOut,
    ),
  );

  @override
  void initState() {
    assert(
      widget.items.isNotEmpty,
      'The items list can\'t be empty',
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    themeData = ThemingUtils.get(context);
    _defineColors();
  }

  @override
  void didUpdateWidget(covariant DropUp<T> oldWidget) {
    if (widget.disabled != oldWidget.disabled) {
      _defineColors();
    }
    if (currValue != widget.item) {
      currValue = widget.item;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    overlay?.dispose();
    dropUpAnimCtrl.dispose();
    super.dispose();
  }

  /// {event} triggered when [DropUp] has been clicked.
  void onClick() {
    if (widget.disabled) return;
    if (widget.items.length <= 1) return;

    toogleDropUp(overlay != null);
  }

  /// {event} triggered when [DropUp] has a {hover} interaction.
  void onHover(bool $in) {
    setState(() {
      _defineColors();
    });
  }

  /// Defines the [DropUp] {widget} background color dependning on the current [state].
  void _defineColors() {
    fgColor = themeData.control.fore;
    bgColor = themeData.control.back;

    if (widget.disabled || widget.items.length <= 1) {
      bgColor = themeData.controlDisabled.back;
      fgColor = themeData.controlDisabled.fore;
      return;
    }
    
  }

  /// Toogles the drop up component handled opning / closing it.
  ///
  ///
  /// [close] whether the action is to close it.
  Future<void> toogleDropUp([bool close = false]) async {
    if (close) {
      await dropUpAnimCtrl.reverse().then(
        (void value) {
          setState(() {});
        },
      );
      overlay?.remove();
      overlay = null;
      return;
    }

    overlay = _composeOverlay();
    Overlay.of(context).insert(overlay as OverlayEntry);
    dropUpAnimCtrl.forward().then(
      (void value) {
        setState(() {});
      },
    );
  }

  /// Composes the overlayed {DropUp} drawer widget and it's linked positioned relative with the main [DropUp] {widget}.AboutDialog
  OverlayEntry _composeOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size boxSize = renderBox.size;
    Offset boxOffset = renderBox.localToGlobal(Offset.zero);
    double topOffset = boxOffset.dy + boxSize.height;

    return OverlayEntry(
      builder: (BuildContext context) {
        return Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (PointerDownEvent event) => toogleDropUp(true),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: topOffset,
                left: boxOffset.dx,
                width: boxSize.width,
                child: CompositedTransformFollower(
                  link: layerLink,
                  followerAnchor: Alignment.bottomLeft,
                  offset: const Offset(0, 0),
                  showWhenUnlinked: false,
                  child: SizeTransition(
                    sizeFactor: dropUpAnimTween,
                    child: ColoredBox(
                      color: bgColor,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 250),
                        child: SizedBox(
                          height: 16 + ((widget.items.length - 1) * 32),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListView.builder(
                              itemCount: widget.items.length,
                              itemBuilder: (_, int index) {
                                bool isCurrent = widget.items[index] == currValue;

                                return MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      toogleDropUp(true).then(
                                        (void value) {
                                          if (!isCurrent) {
                                            setState(() {
                                              currValue = widget.items[index];
                                              widget.onChange(currValue);
                                            });
                                          }
                                        },
                                      );
                                    },
                                    child: SizedBox(
                                      height: 32,
                                      width: boxSize.width,
                                      child: Center(
                                        child: Text(
                                          '${widget.items[index]}',
                                          style: TextStyle(
                                            color: fgColor,
                                            fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      waitDuration: 300.miliseconds,
      message: widget.disabled || overlay != null ? '' : widget.tooltip ?? '',
      child: CompositedTransformTarget(
        link: layerLink,
        child: PointerArea(
          cursor: widget.disabled ? MouseCursor.defer : SystemMouseCursors.click,
          onClick: onClick,
          onHover: onHover,
          child: ColoredBox(
            color: bgColor,
            child: SizedBox(
              width: 75,
              height: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    '$currValue',
                    style: TextStyle(
                      color: fgColor,
                    ),
                  ),
                  RotationTransition(
                    turns: iconRotAnimTween,
                    child: Icon(
                      Icons.arrow_drop_up_rounded,
                      color: fgColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
