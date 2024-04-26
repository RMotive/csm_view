import 'package:csm_foundation_view/src/common/common_module.dart';

/// Extension class.
/// Creates an extension from a list of specific class object.
///
/// We are creating an extension right here to create a method that will order
/// the current breakpoints list to be used anywhere.
extension BreakpointsList<T> on List<CSMPropertyBreakRecord<T>> {
  /// Will order the [List] of [ResponsivePropertyBreakpointOptions] in the correct
  /// logical order, from the lowest to the higher, and will discard the
  /// ilogical breakpoints detected.
  ///
  /// Returns the ordered [List] of [ResponsivePropertyBreakpointOptions].
  ///
  /// Note: Know as ilogical breakpoints, all repeated breakpoint value after the first one found will be removed.
  List<CSMPropertyBreakRecord<T>> sortBreakpoints() {
    List<CSMPropertyBreakRecord<T>> orderedList = this;
    orderedList.sort((CSMPropertyBreakRecord<T> a, CSMPropertyBreakRecord<T> b) => a.breakpoint.compareTo(b.breakpoint));
    int point = 0;
    while (point < (orderedList.length - 1)) {
      final CSMPropertyBreakRecord<T> currentItem = orderedList[point];
      final CSMPropertyBreakRecord<T> nextItem = orderedList[point + 1];
      if (!(currentItem.breakpoint == nextItem.breakpoint)) continue;
      orderedList.removeAt(point + 1);
    }

    return orderedList;
  }
}
