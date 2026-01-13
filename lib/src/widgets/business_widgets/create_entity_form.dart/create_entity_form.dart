
import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart' hide Router, Dialog;
import 'package:go_router/go_router.dart';

export 'create_entity_form_controller.dart';
export 'create_entity_form_record.dart';
export 'create_entity_form_record_field.dart';
export 'create_entity_form_record_reactor.dart';

part '_create_entity_form_records_column.dart';

///
typedef RecordDesigner<TEntity extends IEntity<TEntity>> = Widget Function(TEntity entity, bool selected, bool valid);

///
const double _kPadding = 8;

///
const double _kColWidthLimit = 300;

/// {widget} class.
///
///
/// [TEntity] entity type to be created.
///
///
/// Handles the creation and submit of [TEntity] entites, displaying a custom creation form for items and display a list of added items and it's current values.
final class CreateEntityForm<TEntity extends IEntity<TEntity>, TServiceI extends ICreateService<TEntity, IResponseResolver<BatchOperationOutput<TEntity>>>> extends StatefulWidget {
  /// [TEntity] default object factory.
  final TEntity Function() entityFactory;

  /// Whether this form supports multiple records creation.
  final bool isMultiple;

  /// {event} triggered after the form got closed.
  final VoidCallback? onClose;

  /// [TEntity] validation function.
  final bool Function(TEntity entity)? validator;

  /// Controller.
  final CreateEntityFormController? controller;

  /// Function to build the summary [Widget] to show at the created entity stack as summary data.
  final RecordDesigner<TEntity>? recordDesigner;

  /// Form designer.
  final Widget Function(CreateEntityFormRecordReactor<TEntity>? itemState) formDesigner;

  /// Builds a user-friendly message that identifies the entity that failed during record creation on the {server} side.
  ///
  /// e.g: "Truck - {economic} - {plates} - etc..".
  final String Function(TEntity entity)? buildEntityTag;

  /// Builds the authentication token.
  final String Function(BuildContext context) authFactory;

  /// Creates a new [CreateEntityForm] instance.
  const CreateEntityForm({
    super.key,
    required this.entityFactory,
    this.isMultiple = true,
    this.controller,
    this.validator,
    this.onClose,
    this.recordDesigner,
    this.buildEntityTag,
    required this.formDesigner,
    required this.authFactory,
  }) : assert(
          (isMultiple && recordDesigner != null) || (!isMultiple && recordDesigner == null),
          'If IsMultiple is enabled the recordDesigner must be provided, otherwise if is disabled, recordDesigner must be null',
        );

  @override
  State<CreateEntityForm<TEntity, TServiceI>> createState() => _CreateEntityFormState<TEntity, TServiceI>();
}

/// {state} class.
///
/// Handles [State] for [CreateEntityForm].
final class _CreateEntityFormState<TEntity extends IEntity<TEntity>, TService extends ICreateService<TEntity, IResponseResolver<BatchOperationOutput<TEntity>>>> extends State<CreateEntityForm<TEntity, TService>> {
  /// Current application's theme data.
  late IThemeData themeData;

  /// Current record reactor.
  late CreateEntityFormRecordReactor<TEntity> currRecordReactor;

  /// Creation form context records reactors.
  List<CreateEntityFormRecordReactor<TEntity>> recordReactors = <CreateEntityFormRecordReactor<TEntity>>[];

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(performCreate);

    currRecordReactor = CreateEntityFormRecordReactor<TEntity>(
      widget.entityFactory(),
    );

    recordReactors.add(currRecordReactor);
  }

  @override
  void didChangeDependencies() {
    themeData = ThemingUtils.get(context);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CreateEntityForm<TEntity, TService> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      widget.controller?.addListener(performCreate);
    }
  }

  /// Validate the creation content based on [TEntity.evaluation] method.
  ///
  /// Return a boolean with the validation results.
  ///
  /// If any entity not pass the [IEntity.evaluate] method, return a false.
  (List<TEntity>, bool) validateEntities(List<CreateEntityFormRecordReactor<TEntity>> recordReactor) {
    List<TEntity> entities = <TEntity>[];
    int index = 0;
    for (CreateEntityFormRecordReactor<TEntity> record in recordReactors) {
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
          header: 'Invalid information in ${widget.buildEntityTag?.call(entity)}.',
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
      factory: () => BatchOperationOutput<TEntity>(widget.entityFactory),
      onSuccess: (SuccessFrame<BatchOperationOutput<TEntity>> success) {
        List<EntityOperationError<TEntity>> failures = success.content.failures;
        if (failures.isEmpty) return;

        showDialog(
          context: context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              onAccept: context.pop,
              showCancelButton: false,
              title: 'Error Creating records.',
              richContent: RichText(
                text: TextSpan(
                  text: 'Cannot create some of the items, please verify the data and try again:\n\n',
                  children: widget.buildEntityTag != null
                      ? List<InlineSpan>.generate(
                          failures.length,
                          (int index) {
                            return TextSpan(
                              text: "${index + 1}.- ${widget.buildEntityTag!(failures[index].entity)}\n",
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
        errorMessage = CoreViewMessages.serverError;
      },
      onConnectionFailure: () {
        errorMessage = CoreViewMessages.connectionError;
      },
      onFinally: () {
        if (errorMessage.isEmpty) return;

        showDialog(
          context: context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              showCancelButton: false,
              title: 'Error Creating records.',
              content: Text(
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
                  child: widget.formDesigner(currRecordReactor),
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
                        CreateEntityFormRecordReactor<TEntity> record = CreateEntityFormRecordReactor<TEntity>(
                          widget.entityFactory(),
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
                    onSelect: (CreateEntityFormRecordReactor<TEntity> selected) {
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
