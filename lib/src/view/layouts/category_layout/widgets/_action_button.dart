part of '../category_layout.dart';

/// Draws a complex [CategoryLayout] actions ribbon action button and its behavior.
final class _ActionButton extends StatefulWidget {
  /// Action data.
  final IActionsRibbonAction actionData;

  /// [CategoryLayout] user feedback messenger state reference.
  final GlobalKey<CategoryLayoutMessengerState> messengerRef;

  /// Creates a new [_ActionButton] instance.
  const _ActionButton({
    required this.actionData,
    required this.messengerRef,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

/// {state} class.
///
/// Implements [State] handling for [_CategoryLayoutRibbonArticleButton].
final class _ActionButtonState extends State<_ActionButton> {
  /// {state} application theme data.
  late ICategoryLayoutThemeData themeData;

  /// [Widget] current state.
  CSMStates state = CSMStates.none;

  /// {state} whether the current [Widget] is waiting to finish invokation.
  bool isLoading = false;

  /// {state} whether the current [evaluateExecution] result says if the button can be executed or not.
  bool canExecute = true;

  @override
  void initState() {
    evaluateExecution();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    themeData = ThemingUtils.get(context);
    super.didChangeDependencies();
  }

  /// {event} Triggered when the user mouse pointer clicks on the button.
  void onClick() async {
    List<UserFeedback> evaluateExecutionResult = await evaluateExecution();

    if (evaluateExecutionResult.isNotEmpty) {
      CategoryLayoutMessengerState? messengerState = widget.messengerRef.currentState;
      if (messengerState != null && messengerState.mounted) {
        messengerState.pushMessages(evaluateExecutionResult);
      }
      return;
    }

    setState(() {
      isLoading = true;
      state = CSMStates.selected;
    });

    await widget.actionData.perform(context);

    setState(() {
      isLoading = false;
    });
  }

  /// {event} Triggered when the user mouse pointer is in / out button pointer area.
  void onHover(bool $in) {
    setState(() {
      state = $in ? CSMStates.hovered : CSMStates.none;
    });
  }

  /// Evaluates if the current [_ActionButton] can be executed by the user.
  Future<List<UserFeedback>> evaluateExecution() async {
    setState(() {
      isLoading = true;
    });
    FutureOr<List<UserFeedback>>? invokation = widget.actionData.canExecute(context);

    if (invokation == null) {
      setState(() {
        isLoading = false;
      });
      return <UserFeedback>[];
    }

    List<UserFeedback> canExecuteResult = await invokation;
    if (canExecuteResult.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return <UserFeedback>[];
    }

    setState(() {
      canExecute = false;
      isLoading = false;
    });

    return canExecuteResult;
  }

  @override
  Widget build(BuildContext context) {
    InputControlTheming theming = state.evaluateTheme(themeData.categoryLayoutRibbonActionButton);

    Color back = canExecute ? theming.background! : themeData.controlDisabled.back;
    if (!canExecute && state == CSMStates.hovered) {
      back = back.withValues(
        alpha: .7,
      );
    }

    Color fore = canExecute ? theming.foreground! : themeData.controlDisabled.fore;

    return PointerArea(
      cursor: isLoading ? MouseCursor.defer : SystemMouseCursors.click,
      onClick: isLoading ? null : onClick,
      onHover: isLoading ? null : onHover,
      child: Tooltip(
        message: widget.actionData.description,
        waitDuration: 2.seconds,
        child: ColoredBox(
          color: back,
          child: SizedBox.fromSize(
            size: Size.square(75),
            child: Visibility(
              visible: !isLoading,
              replacement: LoadingIndicator(
                fit: BoxFit.fitHeight,
                foreColor: theming.foreground!,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                child: Column(
                  spacing: 8,
                  children: <Widget>[
                    /// ---> Icon Builder
                    IconTheme(
                      data: IconThemeData(
                        size: 28,
                      ),
                      child: widget.actionData.composeIcon(fore),
                    ),

                    /// --> Action title.
                    Text(
                      widget.actionData.title,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 13,
                        color: fore,
                        overflow: TextOverflow.ellipsis,
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
