part of '../abstractions/bases/package_sandbox_view_base.dart';

/// [LayoutB] implementation for [_PackageLandingEntryLayout].
///
/// Defines the view for a package landing layout when an entry is selected and succesfuly routed at the application.
final class _PackageLandingEntryLayout<T extends PackageSamdboxThemeBase> extends ViewLayoutBase {
  final IPackageSandboxItem<T> landingEntry;

  /// Creates a new [_PackageLandingEntryLayout] instance.
  const _PackageLandingEntryLayout({
    required super.page,
    required super.routingData,
    required this.landingEntry,
  });

  @override
  Widget compose(BuildContext context, Size windowSize, Size pageSize) {
    final T theme = ThemingUtils.get(context);

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
                            landingEntry.description(theme, theme.page.fore),
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
                          child: _PackageLandingDeviceDetails(),
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
