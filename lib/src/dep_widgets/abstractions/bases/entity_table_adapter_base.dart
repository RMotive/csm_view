part of '../../entity_table/entity_table.dart';

/// Represents an [IEntity] based table adapter configuration.
abstract class EntityTableAdapterBase<TEntity extends IEntity<TEntity>> implements IEntityTableAdapter<TEntity> {
  /// Internal reference for [refresh] notification to listeners.
  final _EntityTableRefreshNotifier _refreshNotifier = _EntityTableRefreshNotifier();

  /// Creates a new [EntityTableAdapterBase] instance.
  EntityTableAdapterBase();

  @override
  @mustCallSuper
  void listenRefresh(VoidCallback callback) {
    _refreshNotifier.addListener(callback);
  }

  @override
  @mustCallSuper
  void dispose() {
    _refreshNotifier.dispose();
  }

  @override
  void refresh() {
    _refreshNotifier.refresh();
  }

  @override
  FutureOr<String> composeAuth();

  /// Composes the conifgurations adapted for {Edition} [EntityTable] behavior.
  @override
  EntityTableAdapterEditor<TEntity>? composeEditor() => null;

  /// Composes the conifgurations adapted for {Deeltion} [EntityTable] behavior.
  @override
  EntityTableAdapterDeleter<TEntity>? composeDeleter() => null;
}
