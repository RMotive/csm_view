/// Represents a widget size properties pair, allowing null as normal [Widget] sizing.
final class WidgetSize {
  /// Height value.
  final double? height;

  /// Width value.
  final double? width;

  /// Creates a new instance.
  const WidgetSize(this.width, this.height);

  /// Creates a new instance. From a single value sets [width] & [height].
  factory WidgetSize.sqare(double size) => WidgetSize(size, size);
}
