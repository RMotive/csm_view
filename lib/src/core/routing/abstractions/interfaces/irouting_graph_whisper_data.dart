import 'package:csm_view/csm_view.dart';

/// Represents a [RoutingGraphBase] application's whisper route, a whisper is a modal routed page.
abstract interface class IRoutingGraphWhisperData implements IRoutingGraphData {
  /// Options data.
  final WhisperOptions whisperOptions;

  /// Creates a new instance.
  const IRoutingGraphWhisperData({
    required this.whisperOptions,
  });
}
