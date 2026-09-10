import 'package:flutter/material.dart';

/// Extensions for [BoxConstraints] type.
extension BoxConstraintsExtension on BoxConstraints {
  /// Boxes the constraints to match when unlimited [maxHeight] and(or) [maxWidth] are unbound.
  BoxConstraints boxed() {
    BoxConstraints boxedConstraints = this;

    if (!hasBoundedHeight) {
      boxedConstraints = tighten(
        height: minHeight,
      );
    }

    if (!hasBoundedWidth) {
      boxedConstraints = boxedConstraints.tighten(
        width: minWidth,
      );
    }

    return boxedConstraints;
  }
}
