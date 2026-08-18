part of 'entity_table.dart';

/// Represents an [EntityTable] refresh request notifier.
final class _EntityTableRefreshNotifier extends ChangeNotifier {
  /// Notify listeners to refresh.
  void refresh() {
    notifyListeners();
  }
}
