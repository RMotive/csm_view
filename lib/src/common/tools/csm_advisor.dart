import 'dart:math';
import 'package:csm_view/src/common/common_module.dart';
import 'package:flutter/material.dart';

/// Tool class for [CSMAdvisor].
///
/// Defines final behavior for [CSMAdvisor] instances.
///
/// This class provides several logging methods to write standarized and colorful
/// console messages about actions or processes.
///
/// Considerations:
///   Default colors:
///     Success:
final class CSMAdvisor {
  /// Indicates the key to display on timemark property at advise messages.
  static const String _kAdviseTimemarkKeyDisplay = "Timemark";

  /// Indicates the key to display on extra details property at advise messages.
  static const String _kAdviseDetailsKeyDisplay = "Details";

  /// Stores an advisor tag to separate advisors along the application lifecycle
  final String _advisorTag;

  /// Stores and defines if all messages wroten with this instnace will be tuned into
  /// messages that start with uppercase.
  final bool _startMessageUpper;

  /// Color for all the messages tag
  ///
  /// This color will be visible in the tags for all messages.
  final Color _tagColor;

  /// Color for success messages.
  final Color _successColor;

  /// Color for waning messages.
  final Color _warningColor;

  /// Color for advise messages.
  final Color _messageColor;

  /// Color for advise exceptions.
  final Color _exceptionColor;

  /// Gets the advisor tag in a to-display format.
  String get _tag => _advisorTag.toUpperCase().substring(0, min(30, _advisorTag.length));

  /// Generates a new [CSMAdvisor] tool object.
  const CSMAdvisor(
    String advisorTag, {
    bool startMessageUpper = true,
    Color tagColor = Colors.orangeAccent,
    Color successColor = Colors.tealAccent,
    Color warningColor = Colors.amberAccent,
    Color messageColor = Colors.lightBlue,
    Color exceptionColor = Colors.red,
  })  : _startMessageUpper = startMessageUpper,
        _tagColor = tagColor,
        _successColor = successColor,
        _warningColor = warningColor,
        _messageColor = messageColor,
        _exceptionColor = exceptionColor,
        _advisorTag = advisorTag;

  /// Writes a sucess advise in console.
  ///
  /// [message] message header that will be displayed.
  ///
  /// [info]? if is set, additional information that will be displayed by each entry as a new row.
  ///
  /// [startWithUpper]? if is set, overrides the object instance property [_startMessageUpper] to
  /// calculate if the header message should start with upper-case or not.
  void success(
    String message, {
    Map<String, dynamic>? info,
    bool? startWithUpper,
  }) =>
      _advise(message, _successColor, info: info, startWithUpper: startWithUpper);

  /// Writes a warning advise in console.
  ///
  /// [message] message header that will be displayed.
  ///
  /// [info]? if is set, additional information that will be displayed by each entry as a new row.
  ///
  /// [startWithUpper]? if is set, overrides the object instance property [_startMessageUpper] to
  /// calculate if the header message should start with upper-case or not.
  void warning(
    String message, {
    Map<String, dynamic>? info,
    bool? startWithUpper,
  }) =>
      _advise(message, _warningColor, info: info, startWithUpper: startWithUpper);

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
  void exception(
    String subject,
    Exception x,
    StackTrace t, {
    Map<String, dynamic>? info,
    bool? startWithUpper,
  }) =>
      _advise(subject, _exceptionColor,
          info: <String, dynamic>{
            "message": x,
            "trace": t.toString().replaceAll('\t', '').replaceAll('\n', '').replaceAll('     ', ''),
          }..addEntries(
              info?.entries ?? <MapEntry<String, dynamic>>[],
            ),
          startWithUpper: startWithUpper);

  /// Writes a message advise in console.
  ///
  /// [message] message header that will be displayed.
  ///
  /// [info]? if is set, additional information that will be displayed by each entry as a new row.
  ///
  /// [startWithUpper]? if is set, overrides the object instance property [_startMessageUpper] to
  /// calculate if the header message should start with upper-case or not.
  void message(String message, {Map<String, dynamic>? info, bool? startWithUpper}) => _advise(message, _messageColor, info: info, startWithUpper: startWithUpper);

  /// Main advisor encapsuled method, each method that represents a new advise action depends on call this one,
  /// this method takes the relevant data to write and advise colorized console messages based on the provided inputs.
  ///
  /// DEV NOTE: Always when you create a new one method in this helper abount write new messages, keep the name format and
  /// the call to this main handler method.
  void _advise(String message, Color color, {Map<String, dynamic>? info, bool? startWithUpper}) {
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
  String _formatMessage(String message, Color color, {bool? startWithUpper, bool includeTag = false}) {
    String standarized = message;
    if ((_startMessageUpper && (startWithUpper != false)) || (startWithUpper == true)) {
      standarized = standarized.toStartUpperCase();
    }

    final String colorizedTag = _colorize(_tagColor, '[(*)$_tag]');
    final String colorizedHeader = _colorize(color, standarized);
    String display = colorizedHeader;
    if (includeTag) display = '$colorizedTag $colorizedHeader';
    return display;
  }

  void printObject(int depthLevel, String depthIndent, Color color, Map<String, dynamic> details) {
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
  String _colorize(Color color, String msg) => '\u001b[38;2;${color.red};${color.green};${color.blue}m$msg\u001b[0m';
}
