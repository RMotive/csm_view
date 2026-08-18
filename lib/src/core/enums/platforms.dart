import 'package:flutter/material.dart';

/// Enum for [Platforms].
///
/// Defines an enumerator for a [Platforms] implementation.
///
///[Platforms] concept: describes a possible platform for the current application running context.
enum Platforms {
  web('Browser', Colors.amber),
  mobile('Mobile Device', Colors.deepOrangeAccent),
  desktop('Desktop Device', Colors.greenAccent);

  /// Descriptive name.
  final String name;

  /// Color identification.
  final Color color;

  const Platforms(this.name, this.color);

  @override
  String toString() => name;
}
