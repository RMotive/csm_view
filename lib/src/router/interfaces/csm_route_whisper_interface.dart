import 'package:csm_view/src/router/router_module.dart';

/// Interface for [CSMRouteWhisper].
///
/// Specifies methods that should be performed successfuly by a
/// [CSMRouteWhisper] concept implementation.
abstract interface class CSMRouteWhisperInterface {
  /// Specific options for the [Whisper] [Dialog] to show.
  final CSMRouteWhisperOptions whisperOptions;

  const CSMRouteWhisperInterface({
    required this.whisperOptions,
  });
}
