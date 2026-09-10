import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';

/// Represents an [IEntity] based { view } page.
///
/// [TEntityTableAdapter] - Type of the inner entity table adapter.
abstract interface class IEntityViewPage<TEntity extends IEntity<TEntity>, TEntityTableAdapter extends IEntityTableAdapter<TEntity>> implements IViewPage {
  /// [EntityTable] adapter configuration.
  final TEntityTableAdapter adapter;

  /// Creates a new instance.
  const IEntityViewPage(this.adapter);
}
