part of '../../abstractions/bases/package_sandbox_view_base.dart';

/// A layout that shows the item data, and the composed view on a standarized way along all items.
///
/// [ThemeBase] theme base type.
final class _PackageSandboxEntryLayout<ThemeBase extends PackageSandboxThemeBase> extends ViewLayoutBase {
  /// Sandbox item data.
  final IPackageSandboxEntry<ThemeBase> sandboxEntries;

  /// Creates a new instance.
  const _PackageSandboxEntryLayout({
    required super.page,
    required super.routingData,
    required this.sandboxEntries,
  });

  @override
  Widget compose(BuildContext context, Size windowSize, Size pageSize) {
    const double headerItemsSpacing = 8;
    const double headerPadding = 16;

    final ThemeBase theme = ThemingUtils.get(context);

    final double paddedBox = pageSize.width - (headerItemsSpacing + (headerPadding * 2));
    double descriptionWidth = paddedBox * .65;
    double deviceInfoWidth = paddedBox * .35;
    if (paddedBox < 600) {
      descriptionWidth = paddedBox;
      deviceInfoWidth = paddedBox;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 450,
      ),
      child: SizedBox.fromSize(
        size: pageSize,
        child: Padding(
          padding: const EdgeInsets.all(headerPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //* Header section
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: .5,
                      color: theme.page.accent,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 14,
                  ),
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    spacing: headerItemsSpacing,
                    runSpacing: headerItemsSpacing,
                    children: <Widget>[
                      //* Description section
                      SizedBox(
                        width: descriptionWidth,
                        child: SingleChildScrollView(
                          child: Text.rich(
                            sandboxEntries.description(theme, theme.page.fore),
                          ),
                        ),
                      ),

                      //* Device details section
                      SizedBox(
                        width: deviceInfoWidth,
                        child: _PackageSandboxDeviceDetails(),
                      ),
                    ],
                  ),
                ),
              ),

              //* Page section
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 500,
                  ),
                  child: SizedBox(
                    child: page,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
