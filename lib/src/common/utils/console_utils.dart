import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Mixin that provides console messaging methods.
final class ConsoleUtils {
  /// Indicates the key to display on timemark property at advise messages.
  static const String _kAdviseTimemarkKeyDisplay = "Timemark";

  /// Indicates the key to display on extra details property at advise messages.
  static const String _kAdviseDetailsKeyDisplay = "Details";

  /// Writes a sucess advise in console.
  ///
  /// [message] message header that will be displayed.
  ///
  /// [info]? if is set, additional information that will be displayed by each entry as a new row.
  ///
  /// [startWithUpper]? if is set, overrides the object instance property [_startMessageUpper] to
  /// calculate if the header message should start with upper-case or not.
  static void successLog(
    String message, {
    bool startWithUpper = true,
    Map<String, dynamic>? info,
    Color color = Colors.teal,
  }) =>
      _advise(message, color, info: info, startWithUpper: startWithUpper);

  /// Writes a warning advise in console.
  ///
  /// [message] message header that will be displayed.
  ///
  /// [info]? if is set, additional information that will be displayed by each entry as a new row.
  ///
  /// [startWithUpper]? if is set, overrides the object instance property [_startMessageUpper] to
  /// calculate if the header message should start with upper-case or not.
  static void warningLog(
    String message, {
    bool startWithUpper = true,
    Map<String, dynamic>? info,
    Color color = Colors.amber,
  }) =>
      _advise(message, color, info: info, startWithUpper: startWithUpper);

  /// Writes an exception advise in console.
  ///
  /// [subject] message header that will be displayed.
  ///
  /// [x] exception catched to advise.
  ///
  /// [t] tracer for exception source.
  ///
  /// [info]? if is set, additional information that will be displayed by each entry as a new row.
  ///
  /// [startWithUpper]? if is set, overrides the object instance property [_startMessageUpper] to
  /// calculate if the header message should start with upper-case or not.
  static void exceptionLog(
    String subject,
    Exception x,
    StackTrace t, {
    bool startWithUpper = true,
    Map<String, dynamic>? info,
    Color color = Colors.red,
  }) =>
      _advise(
        subject,
        color,
        info: <String, dynamic>{
          "message": x,
          "trace": t.toString().replaceAll('\t', '').replaceAll('\n', '').replaceAll('     ', ''),
        }..addEntries(
            info?.entries ?? <MapEntry<String, dynamic>>[],
          ),
        startWithUpper: startWithUpper,
      );

  /// Writes a message advise in console.
  ///
  /// [message] message header that will be displayed.
  ///
  /// [info]? if is set, additional information that will be displayed by each entry as a new row.
  ///
  /// [startWithUpper]? if is set, overrides the object instance property [_startMessageUpper] to
  /// calculate if the header message should start with upper-case or not.
  static void messageLog(
    String message, {
    bool startWithUpper = true,
    Map<String, dynamic>? info,
    Color color = Colors.blueGrey,
  }) =>
      _advise(message, color, info: info, startWithUpper: startWithUpper);

  /// Main advisor encapsuled method, each method that represents a new advise action depends on call this one,
  /// this method takes the relevant data to write and advise colorized console messages based on the provided inputs.
  ///
  /// DEV NOTE: Always when you create a new one method in this helper abount write new messages, keep the name format and
  /// the call to this main handler method.
  static void _advise(String message, Color color, {Map<String, dynamic>? info, bool startWithUpper = true}) {
    final String adviseHeader = _formatMessage(message, color, includeTag: true);
    debugPrint(adviseHeader);
    final String timemark = DateTime.now().toIso8601String();
    final String adviseTimemark = _formatMessage('$_kAdviseTimemarkKeyDisplay: $timemark', color);
    debugPrint(adviseTimemark);
    if (info == null) return;
    final String adviseDetailsDisplay = _formatMessage('$_kAdviseDetailsKeyDisplay:', color);
    debugPrint(adviseDetailsDisplay);
    printObject(1, '\t', color, info);
  }

  /// Formats and handles the standarizationg of the displayed message.
  ///
  /// Here the message is case-formatted and colorized.
  static String _formatMessage(String message, Color color, {bool startWithUpper = true, bool includeTag = false}) {
    String standarized = message;
    if (startWithUpper) {
      standarized = standarized.toStartUpperCase();
    }

    final String colorizedTag = _colorize(Colors.white, '[ { View } ]');
    final String colorizedHeader = _colorize(color, standarized);
    String display = colorizedHeader;
    if (includeTag) display = '$colorizedTag $colorizedHeader';
    return display;
  }

  static void printObject(int depthLevel, String depthIndent, Color color, Map<String, dynamic> details) {
    for (MapEntry<String, dynamic> detail in details.entries) {
      final String key = detail.key;
      final dynamic content = detail.value;
      if (content is! Map) {
        final String standardFormat = '$depthIndent[$key]: $content';
        final String standardDisplayAdvise = _formatMessage(standardFormat, color);
        debugPrint(standardDisplayAdvise);
        continue;
      }

      final String newObjectFormat = '$depthIndent[$key]:';
      final String newObjectKeyDisplay = _formatMessage(newObjectFormat, color);
      debugPrint(newObjectKeyDisplay);
      final Map<String, dynamic> castedContentToObject = (content as Map<String, dynamic>);
      printObject(depthLevel + 1, '$depthIndent\t', color, castedContentToObject);
    }
  }

  /// Wraps a string in a colorized ansii scape to be understandable by the debug console.
  static String _colorize(Color color, String msg) => '\u001b[38;2;${color.r};${color.g};${color.b}m$msg\u001b[0m';
}
