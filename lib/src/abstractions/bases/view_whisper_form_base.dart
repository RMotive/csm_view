import 'dart:async';
import 'dart:ui';

import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart' hide Router, Route;

/// Represents a { View } whisper that is a modal view page.
abstract class ViewWhisperFormBase extends ViewPageBase implements IViewWhisperForm {
  /// Whisper title.
  @override
  final String title;

  /// Whisper controls width.
  @override
  final double controlsWidth;

  /// Creates a new instance.
  const ViewWhisperFormBase({
    this.title = 'Welcome',
    this.controlsWidth = 125,
  });

  /// Event called after the whisper is closed.
  @override
  FutureOr<void> onClose() {}

  /// Event called when the whisper perform action is triggered.
  @override
  FutureOr<void> onPerform() {}

  /// Composes the form.
  @override
  Widget composeForm(GlobalKey<FormState> formState, BuildContext context, Size windowSize, Size pageSize);

  @override
  @Deprecated('Dont override this method, use composeForm instead')
  Widget compose(BuildContext context, Size windowSize, Size pageSize) {
    /// Theming data.
    IThemeData themeData = ThemingUtils.get(context);

    return LayoutBuilder(
      builder: (_, BoxConstraints boxConstraints) {
        boxConstraints = boxConstraints.boxed();

        return ClipPath(
          clipBehavior: Clip.antiAlias,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Padding(
              padding: EdgeInsetsGeometry.all(
                WidgetResponsiveness.clampRatio(
                  boxConstraints.maxWidth,
                  ResponsivenessRatio(
                    minValue: 10,
                    minBreak: 400,
                    maxValue: 20,
                    maxBreak: 1000,
                  ),
                ),
              ),
              child: ColoredBox(
                color: themeData.page.back,
                child: _FormStateHandler(
                  builder: (BuildContext context, GlobalKey<FormState> stateKey) {
                    return Column(
                      children: <Widget>[
                        // --> Whisper Header
                        ColoredBox(
                          color: themeData.page.accent,
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                vertical: 12,
                                horizontal: 18,
                              ),
                              child: Text(
                                title,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: themeData.page.foreAlt,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // --> Whisper Content
                        Expanded(
                          child: Form(
                            key: stateKey,
                            child: composeForm(stateKey, context, windowSize, pageSize),
                          ),
                        ),

                        // --> Whisper Footer
                        SizedBox(
                          width: double.maxFinite,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 18,
                            ),
                            child: Row(
                              spacing: 16,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                //* --> Close Action Button
                                ButtonFlat(
                                  label: 'Close',
                                  width: controlsWidth,
                                  theming: themeData.controlError,
                                  onClick: () {
                                    Navigator.of(context).pop();

                                    onClose();
                                  },
                                ),

                                //* --> Perform Action Button
                                ButtonFlat(
                                  label: 'Perform',
                                  width: controlsWidth,
                                  onClick: () {
                                    if (stateKey.currentState!.validate()) {
                                      onPerform();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Draws a [StatefulWidget] that handles a preserved [FormState] key.
final class _FormStateHandler extends StatefulWidget {
  /// Child buider.
  final Widget Function(BuildContext context, GlobalKey<FormState> stateKey) builder;

  /// Builds a new instance.
  const _FormStateHandler({
    required this.builder,
  });

  @override
  State<_FormStateHandler> createState() => __FormStateHandlerState();
}

/// [State] class [_FormStateHandler].
final class __FormStateHandlerState extends State<_FormStateHandler> {
  /// Inner [Form] state key.
  final GlobalKey<FormState> _formState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _formState);
  }
}
