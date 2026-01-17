import 'dart:async';

import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';

export 'entity_table_adapter_deleter.dart';
export 'entity_table_adapter_editor.dart';
export 'entity_table_adapter_viewer.dart';
export 'models/entity_table_column_data.dart';

part '../abstractions/bases/entity_table_adapter_base.dart';
part '_entity_table_refresh_notifier.dart';
part 'widgets/_entity_table_error_indicator.dart';
part 'widgets/_entity_table_header.dart';
part 'widgets/_entity_table_loading_indicator.dart';
part 'widgets/_entity_table_content.dart';
part 'widgets/_entity_table_drawer.dart';
part 'widgets/_entity_table_drawer_action.dart';

/// Default column width.
const double _kColumnWidth = 200;

/// Default details drawer width
const double _kDetailsWidth = 400;

/// {widget} class.
///
/// [TEntity] type of the business [EntityB] implementation the table is based on.
///
/// Draws a complex data table with based on an [EntityB] implementation wich are business entities and part of the {solution}s Data Layer,
/// this tables are being built based on filtering, ordering and consuming {CSM} business scope services based on {view} generation engine.
final class EntityTable<TEntity extends IEntity<TEntity>, TResponseResolver extends IResponseResolver<ViewOutput<TEntity>>, TService extends IViewService<TEntity, TResponseResolver>> extends StatefulWidget {
  /// Table initial page.
  final int page;

  /// Table available ranges selection.
  final List<int> ranges;

  /// [TEntity] factory method for encoding.
  final TEntity Function() factory;

  /// Table adapter.
  final IEntityTableAdapter<TEntity> adapter;

  /// Table columns data.
  final List<EntityTableColumnData<TEntity>> columns;

  /// Overrides the default [IViewService.view] call and result.
  final Future<TResponseResolver> Function(ViewInput<TEntity> input, String auth)? callView;

  /// Composes table filters.
  ///
  /// [entity] - Current filtering [entity]. This value is used to store the filtering data.
  /// The widgets returned from this method must update the [set] propeties in order to apply the
  /// filtering when the search action button is pressed.
  final List<Widget> Function(TEntity entity, ViewDateFilter<TEntity> dateFilter)? composeFiltersView;

  /// Composes the [IViewFilter] data objects based on the composed table filters.
  ///
  /// [entity] Current filtering set. This value is used to extract the filtering data,
  /// storing the input values in [composeFiltersView].
  final List<IViewFilter<TEntity>> Function(TEntity entity, ViewDateFilter<TEntity> dateInterval)? composeFilterDatas;

  /// Creates a new [EntityTable] instance.
  const EntityTable({
    super.key,
    this.page = 1,
    this.ranges = const <int>[
      10,
      20,
      50,
      100,
      200,
    ],
    this.callView,
    required this.adapter,
    required this.columns,
    required this.factory,
    this.composeFiltersView,
    this.composeFilterDatas,
  })  : assert(ranges.length > 0, 'Paging ranges must have at least one configured'),
        assert((composeFiltersView == null && composeFilterDatas == null) || (composeFiltersView != null && composeFilterDatas != null), 'Both filtersSection and filterValues must be provided together.');

  @override
  State<EntityTable<TEntity, TResponseResolver, TService>> createState() => _EntityTableState<TEntity, TResponseResolver, TService>();
}

/// {state} class.
///
/// Defines [State] management class for [EntityTable].
final class _EntityTableState<TEntity extends IEntity<TEntity>, TResponseResolver extends IResponseResolver<ViewOutput<TEntity>>, TService extends IViewService<TEntity, TResponseResolver>> extends State<EntityTable<TEntity, TResponseResolver, TService>> with SingleTickerProviderStateMixin {
  /// {resource} initializes the [Animation] complex controller for the beside drawer table details.
  late final AnimationController drawerAnimationCtrl;

  /// {state} Current [Future] invokation result cached.
  late Future<ViewOutput<TEntity>> asyncInvokation;

  /// {state} [Pagination] widget options.
  late PaginationData paginationData;

  /// {state} Whether the table is loading new data.
  bool isLoading = false;

  /// {state} Current selected index item reference.
  int? selItem;

  /// {state} Current filtering set.
  late TEntity filterSet;

  /// {state} first date filter value.
  /// The date when the date range filter starts.
  /// Default value is DateTime(1), which means no date filter applied.
  late ViewDateFilter<TEntity> dateInterval;

  @override
  void initState() {
    paginationData = PaginationData(
      total: 0,
      pageCount: 0,
      page: widget.page,
      pages: widget.page,
      ranges: widget.ranges,
      range: widget.ranges[0],
    );

    asyncInvokation = _viewInvokation();

    drawerAnimationCtrl = AnimationController(
      vsync: this,
      duration: 200.miliseconds,
      animationBehavior: AnimationBehavior.preserve,
    );

    widget.adapter.listenRefresh(refreshView);
    filterSet = widget.factory();
    dateInterval = ViewDateFilter<TEntity>();
    dateInterval.from = DateTime(1);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EntityTable<TEntity, TResponseResolver, TService> oldWidget) {
    if (oldWidget.adapter != widget.adapter) {
      widget.adapter.listenRefresh(refreshView);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    drawerAnimationCtrl.dispose();
    super.dispose();
  }

  ///
  void refreshView({bool addFilters = false}) {
    if (mounted) {
      setState(() {
        selItem = null;
        drawerAnimationCtrl.reverse();
        asyncInvokation = _viewInvokation(addFilters: addFilters);
      });
    }
  }

  /// {event} triggered when the [EntityTable] pagination options has changed.
  void onPaginationChange(PaginationData newOptions) {
    paginationData = newOptions;
    refreshView(addFilters: true);
  }

  /// {event} triggered when the item selection has changed.
  void onEntitySelectionChange(int? newSelItem) {
    if (newSelItem == selItem) return;
    setState(() {
      selItem = newSelItem;
    });

    if (newSelItem == null) {
      drawerAnimationCtrl.reverse();
    } else {
      drawerAnimationCtrl.forward();
    }
  }

  /// Invokes internally [ViewServiceI.view] service call.
  Future<ViewOutput<TEntity>> _viewInvokation({bool addFilters = false}) async {
    isLoading = true;
    onEntitySelectionChange(null);

    final TService viewService = InjectorUtils.get();

    final String auth = await widget.adapter.composeAuth();

    late final TResponseResolver viewOutputResolver;

    /// Main filtering node.
    List<IViewFilterNode<TEntity>> filtersNode = <IViewFilterNode<TEntity>>[];

    /// Filter configurations
    if (addFilters) {
      List<IViewFilter<TEntity>> tableFiltersNodes = <IViewFilter<TEntity>>[];
      if (widget.composeFilterDatas != null) {
        tableFiltersNodes = widget.composeFilterDatas?.call(filterSet, dateInterval) ?? <IViewFilter<TEntity>>[];
      }

      final List<ViewLogicalFilter<TEntity>> filterPropertyNodes = <ViewLogicalFilter<TEntity>>[];
      final List<ViewDateFilter<TEntity>> filterDateNodes = <ViewDateFilter<TEntity>>[];

      for (IViewFilter<TEntity> tableFilter in tableFiltersNodes) {
        if (tableFilter is ViewLogicalFilter<TEntity>) {
          filterPropertyNodes.add(tableFilter as ViewLogicalFilter<TEntity>);
          continue;
        }
        if (tableFilter is ViewDateFilter<TEntity>) filterDateNodes.add(tableFilter);
      }

      /// Storing valid filters.
      final List<ViewPropertyFilter<TEntity>> validLogicalFilterList = <ViewPropertyFilter<TEntity>>[];

      if (filterPropertyNodes.isNotEmpty) {
        for (ViewLogicalFilter<TEntity> tableNodeFilter in filterPropertyNodes) {
          /// Remove empty filters to avoid unnecessary processing
          for (ViewPropertyFilter<TEntity> filter in tableNodeFilter.filters.cast()) {
            if (filter.value != null) validLogicalFilterList.add(filter);
          }

          if (validLogicalFilterList.isNotEmpty) {
            ViewLogicalFilter<TEntity> logicalFilter = ViewLogicalFilter<TEntity>(
              1,
              tableNodeFilter.operator,
              validLogicalFilterList,
            );

            logicalFilter.discriminator = tableNodeFilter.discriminator;

            /// Assigning logicals filters to the main filter node.
            filtersNode.add(logicalFilter);
          }
        }
      }

      if (filterDateNodes.isNotEmpty) {
        /// Evaluate for date filters ->
        for (ViewDateFilter<TEntity> filter in filterDateNodes) {
          if (dateInterval.from != DateTime(1) || dateInterval.to != null) {
            filter.discriminator = '';
            filtersNode.add(filter);
          }
        }
      }
    }

    if (widget.callView != null) {
      viewOutputResolver = await widget.callView!(
        ViewInput<TEntity>.a(paginationData.range, paginationData.page, <ViewOrdering>[], filtersNode),
        auth,
      );
    } else {
      viewOutputResolver = await viewService.view(
        ViewInput<TEntity>.a(paginationData.range, paginationData.page, <ViewOrdering>[], filtersNode),
        auth,
      );
    }

    final ViewOutput<TEntity> viewOutput = viewOutputResolver.resolveDirect(
      () => ViewOutput<TEntity>(widget.factory),
    );

    setState(() {
      isLoading = false;
      paginationData = paginationData.clone(
        pages: viewOutput.pages,
        total: viewOutput.count,
        pageCount: viewOutput.length,
      );
    });

    return viewOutput;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints boxConstraints) {
        boxConstraints = boxConstraints.boxed();

        final Size boxSize = boxConstraints.biggest;
        final bool fullDrawer = boxSize.width <= (_kDetailsWidth * 2);

        final Animation<double> drawerAnimationTween = Tween<double>(
          begin: 0,
          end: fullDrawer ? boxSize.width : _kDetailsWidth,
        ).animate(drawerAnimationCtrl);

        return AnimatedBuilder(
          animation: drawerAnimationCtrl,
          builder: (_, __) {
            final double drawerAnimationValue = boxSize.width - drawerAnimationTween.value;
            final BoxConstraints drawerAnimationConstraint = BoxConstraints(
              minWidth: drawerAnimationValue,
            );

            return SizedBox.fromSize(
              size: boxSize,
              child: Stack(
                children: <Widget>[
                  /// --> Table Layout
                  SizedBox(
                    width: drawerAnimationValue,
                    height: boxSize.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: <Widget>[
                        /// --> Filters inputs bar
                        if (widget.composeFiltersView != null)
                          ConstrainedBox(
                            constraints: drawerAnimationConstraint,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                border: Border.fromBorderSide(
                                  BorderSide(width: 1, color: Colors.blueGrey),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
                                child: Column(
                                  /// --> Filtering content
                                  spacing: 10,
                                  children: <Widget>[
                                    /// --> Header action buttons
                                    Row(
                                      spacing: 10,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text(
                                            'Advanced Search',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          spacing: 10,
                                          children: <Widget>[
                                            ButtonFlat(
                                              width: 100,
                                              label: 'Clear',
                                              disabled: isLoading,
                                              onClick: () {
                                                filterSet = widget.factory();
                                                dateInterval.from = DateTime(1);
                                                dateInterval.to = null;
                                                refreshView();
                                              },
                                            ),
                                            ButtonFlat(
                                              width: 170,
                                              label: 'Search',
                                              disabled: isLoading,
                                              onClick: () => refreshView(addFilters: true),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    /// --> Filtering widgets section
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: LayoutBuilder(
                                        builder: (BuildContext context, BoxConstraints constraints) {
                                          final bool centerControls = boxConstraints.maxWidth < (448 + 628);
                                          return Visibility(
                                            visible: widget.composeFiltersView != null,
                                            child: Wrap(
                                              alignment: centerControls ? WrapAlignment.center : WrapAlignment.start,
                                              spacing: 12,
                                              runSpacing: 12,
                                              children: widget.composeFiltersView?.call(filterSet, dateInterval) ?? <Widget>[],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        /// --> Table View
                        Expanded(
                          child: SizedBox(
                            width: drawerAnimationValue,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  /// --> Table header (column titles)
                                  ConstrainedBox(
                                    constraints: drawerAnimationConstraint,
                                    child: _EntityTableHeader<TEntity>(
                                      columns: widget.columns,
                                    ),
                                  ),

                                  /// --> Table content
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      child: AsyncWidget<ViewOutput<TEntity>>(
                                        future: asyncInvokation,
                                        loadingBuilder: (BuildContext ctx) => ConstrainedBox(
                                          constraints: drawerAnimationConstraint,
                                          child: _EntityTableLoadingIndicator(),
                                        ),
                                        errorBuilder: (_, Object? error, __) {
                                          ConsoleUtils.warningLog(
                                            error?.toString() ?? '---',
                                          );

                                          return ConstrainedBox(
                                            constraints: drawerAnimationConstraint,
                                            child: _EntityTableErrorIndicator(),
                                          );
                                        },
                                        successBuilder: (BuildContext buildContext, ViewOutput<TEntity> data) {
                                          return ConstrainedBox(
                                            constraints: drawerAnimationConstraint,
                                            child: Visibility(
                                              visible: data.entities.isNotEmpty,
                                              child: _EntityTableContent<TEntity>(
                                                preSelect: selItem,
                                                entities: data.entities,
                                                columns: widget.columns,
                                                onSelection: onEntitySelectionChange,
                                              ),
                                              replacement: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 16,
                                                ),
                                                child: Text(
                                                  'No entities found',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        /// --> Table footer (paging)
                        ConstrainedBox(
                          constraints: drawerAnimationConstraint,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: PaginationHandler(
                              disabled: isLoading,
                              onChange: onPaginationChange,
                              paginationData: paginationData,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// --> Drawer panel Layout.
                  Positioned(
                    left: drawerAnimationValue,
                    width: fullDrawer ? boxSize.width : _kDetailsWidth,
                    height: boxSize.height,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                      ),
                      child: _EntityTableDrawer<TEntity>(
                        selReference: selItem,
                        factory: widget.factory,
                        adapter: widget.adapter,
                        onCloseDrawer: () => onEntitySelectionChange(null),
                        viewInvokation: asyncInvokation,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
