part of '../entity_table.dart';

/// {private} {widget} class.
///
/// Draws a [ProgressIndicator] for the [EntityTable] when is consuming remote data.
final class _EntityTableLoadingIndicator extends StatelessWidget {
  /// Inner [ProgressIndicator] height.
  static const double _loaderSize = 50;

  /// Creates a new [_EntityTableLoadingIndicator] instance.
  const _EntityTableLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints boxConstraints) {
        ThemingData theming = ThemingUtils.get(context).page;
        boxConstraints = boxConstraints.boxed();
        final Size boxingSize = boxConstraints.biggest;

        return SizedBox.fromSize(
          size: boxingSize,
          child: Center(
            child: SizedBox.fromSize(
              size: Size.square(_loaderSize),
              child: LoadingIndicator(
                foreColor: theming.fore,
              ),
            ),
          ),
        );
      },
    );
  }
}
