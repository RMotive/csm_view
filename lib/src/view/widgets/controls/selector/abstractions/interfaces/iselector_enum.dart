import 'package:csm_view/csm_view.dart';

/// Represents an [Enum] for [Selector] widget usage.
abstract interface class ISelectorEnum implements Enum {
  /// The text name representation of current [Enum] value.
  final String name;

  /// Creates a new instance.
  const ISelectorEnum(this.name);
}
