/// Options class for [CSMResponsiveBreak].
///
/// Defines specifications for a [CSMResponsiveBreak].
///
/// [CSMResponsiveBreak] concept: specifications to describe possible values for a responsive break to resolve.
/// Represents three properties values for different screen sizes.
final class CSMResponsiveBreakOptions<T> {
  /// Resolved when the frame is [small].
  final T small;

  /// Resolved when the frame is [medium].
  final T medium;

  /// Resolved when the frame is [large].
  final T large;

  /// Generates a new [CSMResponsiveBreakOptions] options.
  const CSMResponsiveBreakOptions({
    required this.small,
    required this.medium,
    required this.large,
  });

  /// Generates a new [CSMResponsiveBreakOptions] options from record.
  const CSMResponsiveBreakOptions.record(T small, T medium, T large)
      : this(
          small: small,
          medium: medium,
          large: large,
        );
}
