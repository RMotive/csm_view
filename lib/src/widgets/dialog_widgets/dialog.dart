import 'dart:async';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {widget} class.
///
/// Draws a {csm} designed dialog prividing basic interaction to confirm or cancel what the dialog is presenting.
final class Dialog extends StatefulWidget {
  /// Dialog title.
  final String title;

  /// Text content.
  final Text? content;

  /// Rich Text content.
  ///
  /// If [content] property is set, this rich text property will have no effect.
  final RichText? richContent;

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

  const Dialog({
    super.key,
    this.onClose,
    this.onAccept,
    this.content,
    this.themingData,
    this.richContent,
    this.showCancelButton = true,
    this.title = 'Confirmation',
    this.acceptLabel = 'Accept',
  });

  @override
  State<Dialog> createState() => _DialogState();
}

/// {state} class.
///
/// Handles [State] for [Dialog] {widget}.
final class _DialogState extends State<Dialog> {
  /// {state} [Widget] control error theming options.
  late ThemingData errorThemingData;

  /// {state} [Widget] control theming options.
  late ThemingData themingData;

  /// {state} whether the {accept} action button is loading.
  bool isLoading = false;

  @override
  void initState() {
    ServicesBinding.instance.keyboard.addHandler(_escapeKeyHandler);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    errorThemingData = ThemingUtils.get(context).controlError;
    themingData = ThemingUtils.get(context).control;
  }

  /// Handles a callback for [ServicesBinding] to listen when {keyboard} keys-up on {esc} key button, to close the dialog.
  bool _escapeKeyHandler(KeyEvent event) {
    final String key = event.logicalKey.keyLabel;

    if (event is KeyDownEvent && key == 'Escape') {
      _onCloseDialog();
    }
    return false;
  }

  /// {event} event triggered when the [Dialog] is requested to be closed.
  void _onCloseDialog() {
    if (isLoading) {
      return;
    }

    widget.onClose?.call();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
                color: themingData.back,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    /// --> Dialog header
                    ColoredBox(
                      color: themingData.accent,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              widget.title,
                              style: TextStyle(
                                color: themingData.foreAlt ?? themingData.back,
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
                                      color: errorThemingData.fore,
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
                            style: TextStyle(color: themingData.fore),
                            child: widget.content ??
                                widget.richContent ??
                                const Text(
                                  'Are you sure you want to continue?',
                                ),
                          ),
                        ),
                      ),
                    ),

                    /// --> Dialog Footer
                    ColoredBox(
                      color: themingData.accent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        child: Row(
                          spacing: 12,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
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

                            /// --> Cancel Button
                            if (widget.showCancelButton)
                              ButtonFlat(
                                label: 'Cancel',
                                disabled: isLoading,
                                theming: errorThemingData,
                                onClick: () => _onCloseDialog(),
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
