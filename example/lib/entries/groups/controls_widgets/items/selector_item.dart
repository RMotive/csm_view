import 'package:csm_view/csm_view.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:flutter/material.dart';

/// Represents the sandbox item for [Selector].
final class SelectorItem extends PackageSandboxItemBase<ViewPackageThemeBase> {
  /// Creates a new instance.
  SelectorItem()
      : super(
          name: 'Selector',
          description: (ViewPackageThemeBase theme, Color foreColor) {
            return TextSpan(
              text: 'A Widget that handles selection along a set of values.',
            );
          },
        );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, ViewPackageThemeBase theme) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: windowSize.width,
        height: windowSize.height,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: <_SelectorContainer>[
        
            /// Multi selection container
            _SelectorContainer(
              title: 'Multi Selection',
              selectorWidget: Selector<String>(
                values: <NamedValue<String>>[
                  NamedValue.fromValue('Hello'),
                  NamedValue.fromValue('These'),
                  NamedValue.fromValue('Are'),
                  NamedValue.fromValue('Options'),
                ],
                cardsConfig: SelectorCardsConfig<String>(
                  onMultiSelection: (List<String> newSelection, List<String> prevSelection, [List<String>? delta]) {},
                  cardSize: WidgetSize(
                    250,
                    null,
                  ),
                ),
              ),
            ),

            /// Single selection container
            _SelectorContainer(
              title: 'Single Selection',
              selectorWidget: Selector<String>(
                values: <NamedValue<String>>[
                  NamedValue.fromValue('Hello'),
                  NamedValue.fromValue('These'),
                  NamedValue.fromValue('Are'),
                  NamedValue.fromValue('Options'),
                ],
                cardsConfig: SelectorCardsConfig<String>(
                  onSingleSelection: (String? newSelected, String? prevSelected) {},
                  cardSize: WidgetSize(
                    250,
                    null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _SelectorContainer extends StatelessWidget {
  final String title;

  final Widget selectorWidget;

  const _SelectorContainer({
    required this.title,
    required this.selectorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Column(
          spacing: 12,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            selectorWidget,
          ],
        ),
      ),
    );
  }
}
