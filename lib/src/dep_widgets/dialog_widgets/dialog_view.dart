import 'dart:async';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {widget} class.
///
/// Draws a {csm} designed dialog prividing basic interaction to confirm or cancel what the dialog is presenting.
final class DialogView extends StatefulWidget {
  /// Dialog title.
  final String title;

  /// Widget tree child.
  final Widget child;

  /// Show an optional cancel button.
  final bool showCancelButton;

  /// Accept button text.
  final String acceptLabel;

  /// Trigger on close dialog.
  final VoidCallback? onClose;

  /// Trigger on accept dialog.
  final FutureOr<void> Function()? onAccept;

  /// Custom theming information.
  final ThemingData? themingData;

  /// Creates a new instance.
  const DialogView({
    super.key,
    this.onClose,
    this.onAccept,
    this.themingData,
    this.showCancelButton = true,
    this.title = 'Confirmation',
    this.acceptLabel = 'Accept',
    required this.child,
  });

  @override
  State<DialogView> createState() => _DialogViewState();
}

/// {state} class.
///
/// Handles [State] for [DialogView] {widget}.
final class _DialogViewState extends State<DialogView> {
  /// Current application theme data.
  late IThemeData themeData;

  /// {state} whether the {accept} action button is loading.
  bool isLoading = false;

  @override
  void initState() {
    ServicesBinding.instance.keyboard.addHandler(_escapeKeyHandler);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    themeData = ThemingUtils.get(context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    ServicesBinding.instance.keyboard.removeHandler(_escapeKeyHandler);
    super.dispose();
  }

  /// Handles a callback for [ServicesBinding] to listen when {keyboard} keys-up on {esc} key button, to close the dialog.
  bool _escapeKeyHandler(KeyEvent event) {
    final String key = event.logicalKey.keyLabel;

    if (event is KeyDownEvent && key == 'Escape') {
      _onCloseDialog();
    }
    return false;
  }

  /// {event} event triggered when the [DialogView] is requested to be closed.
  void _onCloseDialog() {
    if (isLoading) {
      return;
    }

    widget.onClose?.call();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Color ribbonColor = themeData.dialog.accent;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _onCloseDialog,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
              maxHeight: 450,
            ),
            child: GestureDetector(
              onTap: () {},
              child: ColoredBox(
                color: themeData.dialog.back,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    /// --> Dialog header
                    ColoredBox(
                      color: ribbonColor,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              widget.title,
                              style: TextStyle(
                                color: themeData.dialog.fore,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: isLoading ? null : () => _onCloseDialog(),
                                    icon: Icon(
                                      Icons.cancel_outlined,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// --> Dialog Content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: themeData.dialog.fore,
                            ),
                            child: widget.child,
                          ),
                        ),
                      ),
                    ),

                    /// --> Dialog Footer
                    ColoredBox(
                      color: ribbonColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        child: Row(
                          spacing: 20,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            /// --> Cancel Button
                            if (widget.showCancelButton)
                              ButtonFlat(
                                label: 'Cancel',
                                disabled: isLoading,
                                theming: ThemingData(
                                  back: themeData.controlError.back,
                                  fore: themeData.control.fore,
                                  accent: themeData.controlError.accent,
                                ),
                                onClick: () => _onCloseDialog(),
                              ),

                            /// --> Accept Button
                            ButtonFlat(
                              label: widget.acceptLabel,
                              onClick: () async {
                                if (widget.onAccept == null) {
                                  return;
                                }
                                isLoading = true;
                                await widget.onAccept!();
                                isLoading = false;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
