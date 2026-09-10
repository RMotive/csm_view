import 'package:get_it/get_it.dart' show GetIt;

/// [utils] class implementation for [InjectorUtils].
///
///
/// Provides functions to interact with the dependency injector used natively by [SolutionView] from CSM company
/// interests.
final class InjectorUtils {
  static final GetIt _injector = GetIt.I;

  /// Adds a [singleton] dependency for the injector context of type [T].
  ///
  ///
  /// [T] type of the dependency injected and how will be gathered.
  ///
  /// [instance] the object dependency instance gathered when the dependency is requested.
  static void addSingleton<T extends Object>(T instance) {
    _injector.registerSingleton<T>(instance);
  }

  ///
  static T get<T extends Object>() {
    return _injector.get<T>();
  }
}
