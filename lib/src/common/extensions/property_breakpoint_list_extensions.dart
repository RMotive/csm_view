import 'package:csm_view/csm_view.dart';

/// Extensions for [List] of type [ResponsivenessBreakpointValue].
extension PropertyBreakpointList<T> on List<ResponsivenessBreakpointValue<T>> {
  /// Will order the [List] of [ResponsivePropertyBreakpointOptions] in the correct
  /// logical order, from the lowest to the higher, and will discard the
  /// ilogical breakpoints detected.
  ///
  /// Returns the ordered [List] of [ResponsivePropertyBreakpointOptions].
  ///
  /// Note: Know as ilogical breakpoints, all repeated breakpoint value after the first one found will be removed.
  List<ResponsivenessBreakpointValue<T>> sortBreakpoints() {
    List<ResponsivenessBreakpointValue<T>> orderedList = this;
    orderedList.sort((ResponsivenessBreakpointValue<T> a, ResponsivenessBreakpointValue<T> b) => a.breakpoint.compareTo(b.breakpoint));
    int point = 0;
    while (point < (orderedList.length - 1)) {
      final ResponsivenessBreakpointValue<T> currentItem = orderedList[point];
      final ResponsivenessBreakpointValue<T> nextItem = orderedList[point + 1];
      if (!(currentItem.breakpoint == nextItem.breakpoint)) continue;
      orderedList.removeAt(point + 1);
    }

    return orderedList;
  }
}
