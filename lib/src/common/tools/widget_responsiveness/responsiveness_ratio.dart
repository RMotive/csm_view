/// Options class for [CSMClampRatio].
///
/// Defines specifications for a [CSMClampRatio].
///
/// [CSMClampRatio] concept: specifications to describe how a complex clamping operation
/// should be performed, calculating a ratio between [maxBreak] and [minBreak] calculateing the percent in relation with the
/// [minValue], [maxValue] ratio.
final class ResponsivenessRatio {
  /// Defines the min possible value resolution.
  final double minValue;

  /// Defines where the min possible value gets resolved.
  final double minBreak;

  /// Defines the max possible value resolution.
  final double maxValue;

  /// Defines where the max possible gets resolved.
  final double maxBreak;

  /// Generates a new [ResponsivenessRatio] options.
  const ResponsivenessRatio({
    required this.minValue,
    required this.minBreak,
    required this.maxValue,
    required this.maxBreak,
  });

  /// Creates a [ResponsivenessRatio] struct instance.
  const ResponsivenessRatio.record(double minBreak, double maxBreak, double minValue, double maxValue)
      : this(
          minValue: minValue,
          maxValue: maxValue,
          minBreak: minBreak,
          maxBreak: maxBreak,
        );
}
