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
    final ThemeBase theme = ThemingUtils.get(context);

    final double paddedBox = pageSize.width - 32;
    double sectionWidth = (paddedBox) * .5;
    if (sectionWidth < 300) {
      sectionWidth = paddedBox;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 450,
      ),
      child: SizedBox.fromSize(
        size: pageSize,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                    children: <Widget>[
                      SizedBox(
                        width: sectionWidth,
                        child: SingleChildScrollView(
                          child: Text.rich(
                            sandboxEntries.description(theme, theme.page.fore),
                            style: TextStyle(
                              inherit: true,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: sectionWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _PackageSandboxDeviceDetails(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
