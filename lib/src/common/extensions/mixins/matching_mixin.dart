import 'package:csm_view/src/common/utils/comparisson_utils.dart';

/// Provides comparisson methods.
mixin MatchingMixin {
  /// Decides to wheter the given references is equal to one of the given cases.
  ///
  /// [value] - The reference object to compare with.
  ///
  /// [facts] - Cases objects to compare the reference to look for a match.
  bool isAny<T>(T value, List<T> facts) => ComparissonUtils.isAny(value, facts);
}
