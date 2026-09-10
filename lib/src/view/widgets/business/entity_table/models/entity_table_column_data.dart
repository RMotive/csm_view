import 'package:csm_client_core/csm_client_core.dart';
import 'package:flutter/widgets.dart';

/// {model} class.
///
/// Implements a data {model} class to store options to draw correctly an [EntityTable] column.
final class EntityTableColumnData<TEntity extends IEntity<TEntity>> {
  /// Column title.
  final String title;

  /// Column fixed width, when set this value overrides the {minWidth} constraint built-in calculation for header and column content.
  final double? width;

  /// Column content factory, builds how at each entity row the column content value.
  final String? Function(TEntity entity, int index, BuildContext buildContext)? factory;

  /// Column content factory with a custom [Widget] to put into the cell content.
  final Widget Function(TEntity entity, int index, BuildContext buildContext)? customFactory;

  /// Creates a new [EntityTableColumnData] instance.
  const EntityTableColumnData({
    this.width,
    this.factory,
    this.customFactory,
    required this.title,
  }) : assert(
          (factory != null) != (customFactory != null),
          'factory or customFactory must be provided, both can\'t be provided, only one',
        );
}
