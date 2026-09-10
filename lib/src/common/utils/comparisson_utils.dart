/// Utility class to provide comparisson utilities methods.
final class ComparissonUtils {
  /// Decides to wheter the given references is equal to one of the given cases.
  ///
  /// [value] - The reference object to compare with.
  ///
  /// [facts] - Cases objects to compare the reference to look for a match.
  static bool isAny<T>(T value, List<T> facts) {
    for (T vcase in facts) {
      if (vcase == value) return true;
    }
    return false;
  }
}
