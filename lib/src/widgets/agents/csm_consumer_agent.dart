import 'package:flutter/material.dart';

/// Agent class for [CSMConsumer].
///
/// Provides several actions to stablish a communication between the component
/// instance and the parent component that creates it.
final class CSMConsumerAgent extends ChangeNotifier {
  /// Request to the consumer to refresh its UI and re consume data.
  void refresh() {
    notifyListeners();
  }
}
