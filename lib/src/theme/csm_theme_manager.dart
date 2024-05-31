import 'dart:convert';

import 'package:csm_foundation_view/csm_foundation_view.dart';
import 'package:flutter/material.dart';

/// Stores the provate reference for the static change notifier for the Theming handling.
///
/// NOTE: DONT USE DIRECTLY THIS TO NOTIFY ALL LISTENERS ABOUT A CHANGE.
ValueNotifier<CSMThemeBase>? _notifier;

/// Stores the private reference for the static theme collections provided by the configuration.
List<CSMThemeBase> _themes = <CSMThemeBase>[];

/// Validates and returns the correct object to handle listeners notifications when the
/// theme has changed.
ValueNotifier<CSMThemeBase> get _validNotifier {
  if (_notifier == null) throw const CosmosThemeManagerInitError();
  return _notifier as ValueNotifier<CSMThemeBase>;
}

/// Indicates to the global theme manager change and update all listeners
/// about the update of the current theme to use.
///
/// [identifier] - theme identifier set at the [CSMTheme] implementation to localize it.
/// [saveLocalKey] - special storage key to store the theme result at local storage.
void updateTheme<TTheme extends CSMThemeBase>(
  String identifier, {
  String? saveLocalKey,
}) {
  if (saveLocalKey != null) {}
  CSMThemeBase? base = _themes.where((CSMThemeBase element) => element.identifier == identifier).firstOrNull;
  if (base == null) throw Exception('The identifier wasn\'t found in the themes subscribed');
  try {
    _validNotifier.value = base;
  } on CosmosThemeManagerInitError {
    initTheme(base, _themes);
    _validNotifier.value = base;
  } catch (_) {
    rethrow;
  }
}

/// Looks for local storaged references about the theme selected by the user
/// to use it.
///
/// If the theme reference is found will return a Theme Base reference.
Future<TTheme?> getStoredTheme<TTheme extends CSMThemeBase>(
  String storeKey, {
  List<TTheme>? forcedThemes,
}) async {
  if (forcedThemes != null && forcedThemes.isNotEmpty) _themes = forcedThemes;
  if (_themes.isEmpty) throw Exception('No theme collection initialized, use property forcedThemes to subscribe the collection');
  Map<String, dynamic>? isMapped = jsonDecode('');
  if (isMapped == null || !isMapped.containsKey(storeKey)) return null;
  String themeStoredIdentifier = isMapped[storeKey];
  for (CSMThemeBase theme in _themes) {
    if (theme.identifier == themeStoredIdentifier) return theme as TTheme;
  }

  return null;
}

/// Looks for the current theme subscribed and being handled for the global theme notifier manager.
/// This doesn't look for the [CSMThemeBase] reference from a persistive way, this just will return
/// the theme reference previously init by application initialization.
///
/// [updateEffect] Will subscribe a listener to the theme changer manager and will trigger your setState function
/// provided to update your [StatefulWidget] state after the widget state was did setup and the theme as well.
/// after the subscription of the [updateEffect] ensure add the [disposeEffect] on your [dispose] method to remove the
/// listener and ensure the application performance and avoid any ilogical behavior from the framework work pipeline.
///
/// IMPORTANT NOTE: Avoid the use of [updateEffect] on [StatelessWidget]. This subscription is only
/// considered to notify the current theme change to [StatefulWidget] that doesn't update its state after the application
/// gets restarted by the theme notifier handler.
///
/// RECOMMENDED USE (For [StatefulWidget]):
/// '''dart
///   "State"
///   late CosmosThemeBase theme;
///
///   @override
///   void initState() {
///     super.initState();
///     theme = getTheme<ThemeBase>(
///       updateEffect: updateThemeEffect
///     );
///   }
///
///   @override
///   void dispose() {
///     disposeGetTheme<ThemeBase>(updateThemeEffect);
///     super.dispose();
///   }
///   void updateThemeEffect(ThemeBase effect) => setState(() {});
/// '''
TTheme getTheme<TTheme extends CSMThemeBase>({VoidCallback? updateEfect}) {
  if (updateEfect != null) {
    _validNotifier.addListener(updateEfect);
  }
  return _validNotifier.value as TTheme;
}

/// Will remove the [updateEffect] subscribed on [getTheme] for [StatefulWidget] that
/// use the theme listening functions.
///
/// [disposeEffect] the subscribed function to be removed from the notifier manager stack.
///
/// RECOMMENDED USE (For [StatefulWidget]):
/// '''dart
///   "State"
///   late CosmosThemeBase theme;
///
///   @override
///   void initState() {
///     super.initState();
///     theme = getTheme<ThemeBase>(
///       updateEffect: updateThemeEffect
///     );
///   }
///
///   @override
///   void dispose() {
///     disposeGetTheme<ThemeBase>(updateThemeEffect);
///     super.dispose();
///   }
///   void updateThemeEffect(ThemeBase effect) => setState(() {});
/// '''
void disposeEffect<TTheme extends CSMThemeBase>(VoidCallback updateEffect) {
  _validNotifier.removeListener(updateEffect);
}

/// Provides a global reference for the theme change manager.
///
/// NOTE: Preferrely avoid use it, use it just in specific complex cases, if you have
/// a [StatefulWidget] that needs update the theme after a change and after its state is setup.
/// you can subscribe an [updateEffect] to the method [getTheme] as the next example:
/// ```dart
///   CosmosThemeBase? theme = getTheme(
///     updateEffect: setState(() => {{ `your state update` }}),
///   );
/// ```
///
///
/// RECOMMENDED USE (For [StatefulWidget]):
/// '''dart
///   "State"
///   late CosmosThemeBase theme;
///
///   @override
///   void initState() {
///     super.initState();
///     theme = getTheme<ThemeBase>(
///       updateEffect: updateThemeEffect
///     );
///   }
///
///   @override
///   void dispose() {
///     disposeGetTheme<ThemeBase>(updateThemeEffect);
///     super.dispose();
///   }
///   void updateThemeEffect(ThemeBase effect) => setState(() {});
/// '''
ValueNotifier<CSMThemeBase> get listenTheme => _validNotifier;

void initTheme<TThemeBase extends CSMThemeBase>(TThemeBase defaultTheme, List<TThemeBase> themes) {
  _themes = themes;
  _Theme.loadTheme(defaultTheme);
}

final class _Theme<TThemeBase extends CSMThemeBase> {
  static _Theme<CSMThemeBase>? ins;

  late final TThemeBase defTheme;

  _Theme._(TThemeBase defaultTheme) {
    defTheme = defaultTheme;
  }

  static loadTheme<TThemeBase extends CSMThemeBase>(TThemeBase defaultTheme) {
    ins ??= _Theme<TThemeBase>._(defaultTheme);
    _notifier = ValueNotifier<CSMThemeBase>(ins!.defTheme);
  }
}
