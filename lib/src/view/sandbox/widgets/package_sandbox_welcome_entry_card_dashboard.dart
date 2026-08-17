import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';

final class PackageSandboxWelcomeEntryCardDashboard extends StatelessWidget {
  final Map<RouteData, IPackageSandboxEntry<PackageSandboxThemeBase>> sandboxEntries;

  const PackageSandboxWelcomeEntryCardDashboard({
    super.key,
    required this.sandboxEntries,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox.expand(
        child: LayoutBuilder(
          builder: (BuildContext viewContext, BoxConstraints cardsContainerConstraints) {
            const BoxConstraints cardConstraints = BoxConstraints(
              maxWidth: 425,
              minWidth: 225,
            );
            cardsContainerConstraints = cardsContainerConstraints.normalize();
            double widthSpace = cardsContainerConstraints.biggest.width;
            double cardWidth = widthSpace / 4;

            return SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: sandboxEntries.entries.map<Widget>(
                  (MapEntry<RouteData, IPackageSandboxEntry<PackageSandboxThemeBase>> sandboxRoutedEntry) {
                    return ConstrainedBox(
                      constraints: cardConstraints,
                      child: AspectRatio(
                        aspectRatio: 2 / 1,
                        child: SizedBox(
                          width: cardWidth,
                          child: PackageSandboxWelcomeEntryCard<PackageSandboxThemeBase>(
                            routeData: sandboxRoutedEntry.key,
                            sandboxItem: sandboxRoutedEntry.value,
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
