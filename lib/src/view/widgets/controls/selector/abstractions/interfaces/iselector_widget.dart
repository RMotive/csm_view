import 'package:flutter/material.dart';

/// Represents a selector control [Widget] that provides
/// user interaction with options to be selected depending on configuration.
///
/// [TValue] is the type of elements to be handled as options.
abstract interface class ISelectorWidget<TValue> implements Widget {
  /// Event callback when [SelectorCards] value selection has changed. Will provide
  /// the new selected value [newSelected] and [prevSelected] value.
  final Function(TValue? newSelected, TValue? prevSelected)? onSingleSelection;

  /// Event callback when [SelectorCards] values selection has changed. Will provide
  /// the new selected values [newSelection], the previous selection values [prevSelection] and
  /// the difference between the [newSelection] and [prevSelection] as [delta].
  final Function(List<TValue> newSelection, List<TValue> prevSelection, [List<TValue>? delta])? onMultiSelection;

  /// Creates a new instance.
  const ISelectorWidget(this.onSingleSelection, this.onMultiSelection)
      : assert(
          onSingleSelection != onMultiSelection,
          'At least one callback event must be provided to handle values selection',
        );
}
