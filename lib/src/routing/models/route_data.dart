/// [Model] for [RouteData].
///
/// Defines a data model for a [RouteData] information, like naming and calculated url path.
final class RouteData {
  /// Route name.
  final String? _name;

  /// Raw path.
  final String _path;

  /// Path initialized.
  ///
  /// May be different that the generated at creating the object because the initialized
  /// path is being parsed to a validated [path] handling.
  String get path {
    /// --> The raw path should start with '/' if not, then it will be parsed.
    if (_path.startsWith('/')) return _path;
    return '/$_path';
  }

  /// Name initialized.
  ///
  /// May be different that the generated at creating the object because the initialized
  /// [name] is being parsed to a validated [name] handling.
  String get name {
    final String parsedPath = path.substring(1);

    if ((_name == null || _name.isEmpty) && parsedPath.isEmpty) return 'Home';

    if (_name != null) {
      if (_name.startsWith('/')) {
        return _name.substring(1);
      }

      return _name;
    }

    return hashCode.toString();
  }

  /// Generates a new [RouteData] object.
  const RouteData(String path, {String? name})
      : _path = path,
        _name = name;

  @override
  String toString() {
    return '$_path | $hashCode';
  }
}
