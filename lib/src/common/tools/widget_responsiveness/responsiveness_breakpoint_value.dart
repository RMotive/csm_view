/// Record class for [ResponsivenessBreakpointValue].
///
/// Defines a structured object for a [ResponsivenessBreakpointValue] implementation.
///
/// [ResponsivenessBreakpointValue] concept: a set of data that describes a responsive breakpoint calculation, indicating where to break([breakpoint]) and what to resolve
/// at that brek([value]).
final class ResponsivenessBreakpointValue<T> {
  /// Where the responsive calculator will break this calculation.
  final double breakpoint;

  /// The value to resolve at break.
  final T value;

  /// Generates a new [ResponsivenessBreakpointValue] record.
  const ResponsivenessBreakpointValue(this.breakpoint, this.value);

  @override
  String toString() => 'BP: $breakpoint, V: $value';
}
