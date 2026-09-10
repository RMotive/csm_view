/// Options class for [CSMResponsiveBreak].
///
/// Defines specifications for a [CSMResponsiveBreak].
///
/// [CSMResponsiveBreak] concept: specifications to describe possible values for a responsive break to resolve.
/// Represents three properties values for different screen sizes.
final class ResponsivenessBreakpoint<T> {
  /// Resolved when the frame is [small].
  final T small;

  /// Resolved when the frame is [medium].
  final T medium;

  /// Resolved when the frame is [large].
  final T large;

  /// Generates a new [ResponsivenessBreakpoint] options.
  const ResponsivenessBreakpoint({
    required this.small,
    required this.medium,
    required this.large,
  });

  /// Generates a new [ResponsivenessBreakpoint] options from record.
  const ResponsivenessBreakpoint.record(T small, T medium, T large)
      : this(
          small: small,
          medium: medium,
          large: large,
        );
}
