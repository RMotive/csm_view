/// Represents an object to set a text readable name to a [TValue].
///
/// [TValue] type of named value.
final class NamedValue<TValue> {
  /// Value name representation.
  final String name;

  /// Value data.
  final TValue value;

  /// Creates a new instance.
  const NamedValue(this.name, this.value);

  /// Creates a new instance. Based on given [value] as its [name].
  static NamedValue<String> fromValue(String value) {
    return NamedValue<String>(value, value);
  }
}
