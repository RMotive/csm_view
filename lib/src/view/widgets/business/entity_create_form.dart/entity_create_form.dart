import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

// > Encapsulating [/widgets]
part 'widgets/entity_create_form_record.dart';
part 'widgets/entity_create_form_record_field.dart';

///
typedef RecordDesigner<TEntity extends IEntity<TEntity>> = Widget Function(TEntity entity, bool selected, bool valid);

///
const double _kPadding = 8;

///
const double _kColWidthLimit = 300;

/// {widget} class.
///
/// [_CreateEntityFormRecordsColumn] Section to display the [TModel] item value based on [itemDesigner] method.
final class _CreateEntityFormRecordsColumn<TEntity extends IEntity<TEntity>> extends StatefulWidget {
  /// Section width.
  final double width;

  /// Custom item designer.
  final RecordDesigner<TEntity> recordDesigner;

  /// State values for added items.
  final List<EntityCreateFormRecordReactor<TEntity>> recordReactors;

  /// Callback to add a new item.
  final void Function() onAdd;

  /// Callback to remove the current item.
  final void Function() onRemove;

  /// Callback to select the current item.
  final void Function(EntityCreateFormRecordReactor<TEntity> selected) onSelect;

  /// Creates a new [_CreateEntityFormRecordsColumn] instance.
  const _CreateEntityFormRecordsColumn({
    required this.width,
    required this.recordReactors,
    required this.recordDesigner,
    required this.onAdd,
    required this.onRemove,
    required this.onSelect,
  });

  @override
  State<_CreateEntityFormRecordsColumn<TEntity>> createState() => _CreateEntityFormRecordsColumnState<TEntity>();
}

/// {state} class.
///
/// Handles [State] for [_CreateEntityFormRecordsColumn].
final class _CreateEntityFormRecordsColumnState<TEntity extends IEntity<TEntity>> extends State<_CreateEntityFormRecordsColumn<TEntity>> {
  ///
  late IThemeData themeData = ThemingUtils.get(context);

  ///
  late List<EntityCreateFormRecordReactor<TEntity>> recordReactors = widget.recordReactors;

  /// {state} stores the current selected record.
  int currRecordIdx = 0;

  @override
  void didChangeDependencies() {
    themeData = ThemingUtils.get(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemingData errorTheming = themeData.controlError;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Column(
        spacing: 12,
        children: <Widget>[
          /// --> Actions Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 8,
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Records: (${recordReactors.length})',
                    style: TextStyle(
                      color: themeData.page.fore,
                    ),
                  ),
                ),
                // --> Add item action
                PointerArea(
                  onClick: () {
                    currRecordIdx = recordReactors.length;
                    widget.onAdd();
                  },
                  cursor: SystemMouseCursors.click,
                  child: Icon(
                    Icons.add_circle,
                    size: 24,
                    color: themeData.page.fore,
                  ),
                ),
                // --> Remove selection
                PointerArea(
                  onClick: widget.onRemove,
                  cursor: SystemMouseCursors.click,
                  child: Icon(
                    Icons.remove_circle,
                    size: 24,
                    color: errorTheming.fore,
                  ),
                ),
              ],
            ),
          ),

          /// --> Stack Column
          Expanded(
            child: LayoutBuilder(
              builder: (_, BoxConstraints constrains) {
                final ScrollController ctrl = ScrollController();
                WidgetsBinding.instance.addPostFrameCallback((
                  Duration timestamp,
                ) {
                  ctrl.animateTo(
                    0,
                    duration: 300.miliseconds,
                    curve: Curves.easeOut,
                  );
                });

                return ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 0,
                    maxHeight: constrains.maxHeight,
                  ),
                  child: ListView.builder(
                    itemCount: recordReactors.length,
                    controller: ctrl,
                    itemBuilder: (BuildContext buildContext, int index) {
                      final bool currentActive = currRecordIdx == index;
                      return PointerArea(
                        cursor: currentActive ? MouseCursor.defer : SystemMouseCursors.click,
                        onClick: () {
                          currRecordIdx = index;
                          widget.onSelect(recordReactors[index]);
                        },
                        child: ReactiveWidget<EntityCreateFormRecordReactor<TEntity>>(
                          reactor: recordReactors[index],
                          builder: (BuildContext ctx, EntityCreateFormRecordReactor<TEntity> recordReactor) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: SizedBox(
                                width: widget.width,
                                child: widget.recordDesigner(
                                  recordReactor.entity,
                                  currentActive,
                                  recordReactor.isValid,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// [class] implementation.
///
/// Implements a proxy controller to handle and interact with a [CreateEntityForm] outside the scope.
final class CreateEntityFormController extends ChangeNotifier {
  /// Creates a new [CreateEntityFormController] instance.
  CreateEntityFormController();

  /// Triggers a [create] {event} invokation at the [CreateEntityForm] controlled.
  void create() {
    notifyListeners();
  }
}

/// {reactor} implementation.
///
/// Defines a [ReactorB] implementation for [_EntityCreationFormItem] that works as a dynamic access state simplified object outside its own scope.
final class EntityCreateFormRecordReactor<TEntity extends IEntity<TEntity>> extends ReactorBase {
  /// Item model value.
  late TEntity entity;

  /// validation model status.
  bool isValid = true;

  /// Creates a new [EntityCreateFormRecordReactor] instance.
  EntityCreateFormRecordReactor(this.entity);
}

/// {widget} class.
///
///
/// [TEntity] entity type to be created.
///
///
/// Handles the creation and submit of [TEntity] entites, displaying a custom creation form for items and display a list of added items and it's current values.
final class EntityCreateForm<TEntity extends IEntity<TEntity>, TServiceI extends ICreateService<TEntity, IResponseResolver<BatchOperationOutput<TEntity>>>> extends StatefulWidget {
  /// Handled [TEntity] object factory.
  final TEntity Function() factory;

  /// Whether this form supports multiple records creation.
  final bool isMultiple;

  /// {event} triggered after the form got closed.
  final VoidCallback? onClose;

  /// [TEntity] validation function.
  final bool Function(TEntity entity)? validator;

  /// Form controller.
  final CreateEntityFormController? controller;

  /// Form scroll controller.
  final ScrollController? scrollController;

  /// Function to build the summary [Widget] to show at the created entity stack as summary data.
  final RecordDesigner<TEntity>? recordDesigner;

  /// Inner [FormArea] padding.
  final EdgeInsets formPadding;

  /// Form designer.
  ///
  /// [itemState] - When the creation [isMultiple] is enabled a record stack is used to handle multiple item creation, in that case the item state is proxied to handle the record summary state.
  ///
  /// [scrollController] - Automatically the [EntityCreateForm] handles a vertical [SingleChildScrollView] this proxies the [scrollController].
  final Widget Function(EntityCreateFormRecordReactor<TEntity>? itemState, ScrollController scrollController) formDesigner;

  /// Builds a user-friendly message that identifies the entity that failed during record creation on the {server} side.
  ///
  /// e.g: "Truck - {economic} - {plates} - etc..".
  final String Function(TEntity entity)? errorDesigner;

  /// Builds the authentication token.
  final String Function(BuildContext context) authFactory;

  /// Creates a new instance.
  const EntityCreateForm({
    super.key,
    required this.factory,
    this.controller,
    this.validator,
    this.onClose,
    this.errorDesigner,
    this.recordDesigner,
    this.scrollController,
    this.isMultiple = true,
    this.formPadding = const EdgeInsets.all(16),
    required this.formDesigner,
    required this.authFactory,
  }) : assert(
          (isMultiple && recordDesigner != null) || (!isMultiple && recordDesigner == null),
          'If IsMultiple is enabled the recordDesigner must be provided, otherwise if is disabled, recordDesigner must be null',
        );

  @override
  State<EntityCreateForm<TEntity, TServiceI>> createState() => _EntityCreateFormState<TEntity, TServiceI>();
}

/// {state} class.
///
/// Handles [State] for [EntityCreateForm].
final class _EntityCreateFormState<TEntity extends IEntity<TEntity>, TService extends ICreateService<TEntity, IResponseResolver<BatchOperationOutput<TEntity>>>> extends State<EntityCreateForm<TEntity, TService>> {
  /// Child form scroll controller.
  late final ScrollController scrollController = widget.scrollController ?? ScrollController();

  /// Current application's theme data.
  late IThemeData themeData;

  /// Current record reactor.
  late EntityCreateFormRecordReactor<TEntity> currRecordReactor;

  /// Creation form context records reactors.
  List<EntityCreateFormRecordReactor<TEntity>> recordReactors = <EntityCreateFormRecordReactor<TEntity>>[];

  @override
  void initState() {
    widget.controller?.addListener(performCreate);

    currRecordReactor = EntityCreateFormRecordReactor<TEntity>(
      widget.factory(),
    );

    recordReactors.add(currRecordReactor);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    themeData = ThemingUtils.get(context);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant EntityCreateForm<TEntity, TService> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(performCreate);
      widget.controller?.addListener(performCreate);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(performCreate);
    super.dispose();
  }

  /// Validate the creation content based on [TEntity.evaluation] method.
  ///
  /// Return a boolean with the validation results.
  ///
  /// If any entity not pass the [IEntity.evaluate] method, return a false.
  (List<TEntity>, bool) validateEntities(List<EntityCreateFormRecordReactor<TEntity>> recordReactor) {
    List<TEntity> entities = <TEntity>[];
    int index = 0;
    for (EntityCreateFormRecordReactor<TEntity> record in recordReactors) {
      index++;
      TEntity entity = record.entity;
      entities.add(entity);

      /// Validated the record data.
      bool isValid = widget.validator?.call(entity) ?? true;
      List<EntityErrors<TEntity>> invalidations = entity.evaluate(<EntityErrors<TEntity>>[]);
      record.isValid = isValid && invalidations.isEmpty;

      /// Update the record column when is invalid.
      if (!record.isValid) {
        record.react();

        /// Mark the whole list as invalid.
        if (invalidations.isNotEmpty) {
          showInvalidationDialog(entity, invalidations, index);
          return (entities, false);
        }
      }
    }

    return (entities, true);
  }

  void showInvalidationDialog(TEntity entity, List<EntityErrors<TEntity>> invalidations, int index) {
    showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return EntityErrorsDialog(
          context: context,
          title: 'Wrong or missing information on record',
          header: 'Invalid information in ${widget.errorDesigner?.call(entity)}.',
          errors: invalidations,
        );
      },
    );
  }

  /// Performs the {create} operation for the current managed [TEntity] records.
  void performCreate() async {
    /// Flag for any invalidated entity in entities list.
    late bool isValid;

    /// Stores the entities to create when
    late List<TEntity> entities;

    (entities, isValid) = validateEntities(recordReactors);

    /// Return if any entity is invalid.
    if (!isValid) {
      setState(() {});
      return;
    }

    TService creationService = InjectorUtils.get();
    String authToken = widget.authFactory.call(context);

    IResponseResolver<BatchOperationOutput<TEntity>> resolver = await creationService.create(entities, authToken);

    String errorMessage = "";
    resolver.resolve(
      factory: () => BatchOperationOutput<TEntity>(widget.factory),
      onSuccess: (SuccessFrame<BatchOperationOutput<TEntity>> success) {
        List<EntityOperationError<TEntity>> failures = success.content.failures;
        if (failures.isEmpty) {
          context.pop();
          widget.onClose?.call();
          return;
        }

        showDialog(
          context: context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return DialogView(
              onAccept: context.pop,
              showCancelButton: false,
              title: 'Error Creating records.',
              child: RichText(
                text: TextSpan(
                  text: 'Cannot create some of the items, please verify the data and try again:\n\n',
                  children: widget.errorDesigner != null
                      ? List<InlineSpan>.generate(
                          failures.length,
                          (int index) {
                            return TextSpan(
                              text: "${index + 1}.- ${widget.errorDesigner!(failures[index].entity)}\n",
                              children: <InlineSpan>[
                                TextSpan(
                                  text: 'Error: ${failures[index].message}\n\n',
                                ),
                              ],
                            );
                          },
                        )
                      : null,
                ),
              ),
            );
          },
        );
      },
      onFailure: (FailureFrame failure, int status) {
        errorMessage = failure.content.advise;
      },
      onException: (TracedException exception) {
        errorMessage = ViewMessages.serverError;
      },
      onConnectionFailure: () {
        errorMessage = ViewMessages.connectionError;
      },
      onFinally: () {
        if (errorMessage.isEmpty) return;

        showDialog(
          context: context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return DialogView(
              showCancelButton: false,
              title: 'Error Creating records.',
              child: Text(
                errorMessage,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              themingData: themeData.controlError,
              onAccept: context.pop,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints cts) {
        double calcWidth = ((cts.maxWidth / 2) - _kPadding);

        Size sizeFactor = const BoxConstraints(
          minWidth: _kColWidthLimit,
        ).constrain(
          Size(calcWidth, cts.maxHeight),
        );

        if (sizeFactor.width <= _kColWidthLimit) {
          sizeFactor = Size(cts.maxWidth, sizeFactor.height);
        }

        if (!widget.isMultiple) {
          sizeFactor = Size(cts.maxWidth, sizeFactor.height);
        }

        return Padding(
          padding: const EdgeInsets.all(_kPadding),
          child: Wrap(
            children: <Widget>[
              /// --> Entity edition form
              SizedBox.fromSize(
                size: sizeFactor,
                child: SectionBox(
                  title: 'Properties',
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: widget.formPadding,
                      child: widget.formDesigner(currRecordReactor, scrollController),
                    ),
                  ),
                ),
              ),

              /// --> Records summary stack.
              if (widget.isMultiple)
                SizedBox.fromSize(
                  size: sizeFactor,
                  child: _CreateEntityFormRecordsColumn<TEntity>(
                    width: sizeFactor.width,
                    recordReactors: recordReactors,
                    recordDesigner: widget.recordDesigner!,
                    onAdd: () {
                      setState(() {
                        EntityCreateFormRecordReactor<TEntity> record = EntityCreateFormRecordReactor<TEntity>(
                          widget.factory(),
                        );
                        currRecordReactor = record;
                        recordReactors.add(record);
                      });
                    },
                    onRemove: () {
                      setState(() {
                        recordReactors.remove(currRecordReactor);
                      });
                    },
                    onSelect: (EntityCreateFormRecordReactor<TEntity> selected) {
                      setState(() {
                        currRecordReactor = selected;
                      });
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
