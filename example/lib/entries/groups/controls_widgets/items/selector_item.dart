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
    return Wrap(
      children: <_SelectorContainer>[
        _SelectorContainer(
          title: 'Cards Selector',
          selectorWidget: Selector<String>(
            cardSize: WidgetSize(
              250,
              null,
            ),
            values: <NamedValue<String>>[
              NamedValue.fromValue('Hello'),
              NamedValue.fromValue('These'),
              NamedValue.fromValue('Are'),
              NamedValue.fromValue('Options'),
            ],
          ),
        )
      ],
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
    return SizedBox(
      child: Column(
        children: <Widget>[
          Text(title),
          selectorWidget,
        ],
      ),
    );
  }
}
