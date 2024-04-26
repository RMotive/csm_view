/// Tool class for [CSMMatcher].
///
/// Defines final behavior for [CSMMatcher] tool instances.
///
/// [CSMMatcher] concept: a tool that can perform decisions along different parameters and selections.
final class CSMMatcher {
  /// Decides to wheter the given references is equal to one of the given cases.
  ///
  /// [reference] - The reference object to compare with.
  ///
  /// [cases] - Cases objects to compare the reference to look for a match.
  static bool isSomeone<T>(T reference, List<T> cases) {
    for (T vcase in cases) {
      if (vcase == reference) return true;
    }
    return false;
  }
}
