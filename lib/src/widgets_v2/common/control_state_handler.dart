import 'package:csm_view/csm_view.dart';
import 'package:flutter/widgets.dart';

/// Represents a control type [Widget] state management.
mixin ControlStatesHandler<TControlThemeData, TStateWidget extends StatefulWidget> on State<TStateWidget> {
  /// Current control states.
  @protected
  final Set<WidgetState> states = <WidgetState>{};

  /// Current theme stateful control theming data.
  @protected
  late StatefulControlThemeData<TControlThemeData> theming;

  /// Current control theme data to use.
  @protected
  late TControlThemeData tData;

  /// Evaluates based on current [theming], wich [TControlThemeData] matches dependning on current states. To check the calculations priority check
  /// [StatefulControlThemeData] documentation.
  ///
  /// [isLoading] as currently there doesn't exist a direct way to determine a loading [WidgetState] we use this to declare it.
  TControlThemeData evaluateTheming([bool isLoading = false]) {
    if (states.contains(WidgetState.disabled) && theming.atDisabled != null) return theming.atDisabled!;

    if (isLoading && theming.atLoading != null) return theming.atLoading!;

    if (states.contains(WidgetState.error) && theming.atError != null) return theming.atError!;

    if (states.contains(WidgetState.focused)) {
      if (states.contains(WidgetState.hovered) && theming.atHoverFocused != null) return theming.atHoverFocused!;

      return theming.atFocused;
    }

    if (states.contains(WidgetState.selected)) {
      if (states.contains(WidgetState.hovered) && theming.atHoverSelected != null) return theming.atHoverSelected!;

      return theming.atSelected;
    }

    if (states.contains(WidgetState.hovered)) {
      return theming.atHover;
    }

    return theming.$default;
  }

  /// A factory to bypass specific property gathering for the expected [StatefulControlThemeData].
  ///
  /// [themeData] the current application theme data.
  StatefulControlThemeData<TControlThemeData> stateThemingFactory(IThemeData themeData);

  @override
  @mustCallSuper
  void didChangeDependencies() {
    super.didChangeDependencies();

    theming = stateThemingFactory(
      ThemingUtils.get(context),
    );
    tData = evaluateTheming();
  }

  /// Event triggered when the [Widget] gets hovered by the user. Evaluates whether
  /// current [Widget] states should include [WidgetState.hovered] based on given [$event] value, then
  /// recalculates its theming based on result.
  void onHover(bool $event) {
    $event ? states.add(WidgetState.hovered) : states.remove(WidgetState.hovered);

    setState(() {
      tData = evaluateTheming();
    });
  }
}
