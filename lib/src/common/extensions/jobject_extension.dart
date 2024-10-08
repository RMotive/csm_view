import 'package:csm_view/src/common/common_module.dart';

/// Provides utilities to handle jObjects such read and write.
extension JUtils on JObject {
  /// Binds an specified property into the gathered json.
  ///
  /// [json] The json object to scrap in.
  ///
  /// [fallbacks] The specified keys to search into the json.
  ///   It will be used in the order it is given, if the first key does't found any, then will be used the another one.
  ///
  /// [defaultValue] The specified default value to return if all the fallbacks resulted in a null value.
  ///
  /// [caseSensitive] Specifies if the key searching in the object should consider the specific casing of the words.
  TExpectation _bindProperty<TExpectation>(List<String> fallbacks, TExpectation defaultValue, {bool caseSensitive = false}) {
    TExpectation? gatheredValue;
    for (String key in fallbacks) {
      for (JEntry element in entries) {
        final String currentElementKey = element.key;
        if (caseSensitive && (currentElementKey != key)) continue;
        if (!caseSensitive && (currentElementKey.toLowerCase() != key.toLowerCase())) continue;
        gatheredValue = (element.value as TExpectation);
        break;
      }
      if (gatheredValue != null) break;
    }
    return gatheredValue ?? defaultValue;
  }

  static JObject get empty => <String, dynamic>{};
  T bindProp<T>(String key, T defaultValue) => _bindProperty(<String>[key], defaultValue);
  T bindPropSensitive<T>(String key, T defaultValue) => _bindProperty(<String>[key], defaultValue, caseSensitive: true);
  T bindPropFallback<T>(List<String> fallback, T defaultValue) => _bindProperty(fallback, defaultValue);
  T bindPropFallbackSensitive<T>(List<String> fallback, T defaultValue) => _bindProperty(fallback, defaultValue, caseSensitive: true);
}
