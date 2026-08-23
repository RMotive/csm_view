import 'package:flutter/material.dart';

/// A [Widget] that allows to select single or multiple items along given options.
final class Selector<TElement> extends StatelessWidget {
  /// Available selection items.
  final TElement items;

  /// Creates a new instance.
  const Selector({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
