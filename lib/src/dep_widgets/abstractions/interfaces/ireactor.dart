import 'package:flutter/material.dart';

/// Represents a [ReactorWidget]'s reactor to manage inner states.
abstract interface class IReactor implements Listenable {
  /// Indicates a state recalculation instruction.
  void react();
}
