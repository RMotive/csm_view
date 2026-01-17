import 'dart:async';

import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:example/mocks/entity_mock.dart';
import 'package:example/mocks/service_mock.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:flutter/material.dart';

/// [EntityTable] business [Widget] package landing entry.
class EntityTableEntry extends PackageLandingEntryBase<ViewPackageThemeBase> {
  /// Creates a new instance.
  EntityTableEntry()
      : super(
          name: 'Entity Table',
          description: (ViewPackageThemeBase theme, Color foreColor) {
            return TextSpan(
              text: 'A business Widget that draws and handles a complex table from a [IEntity] implementation that are {CSN} business entities',
            );
          },
        );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, ViewPackageThemeBase theme) {
    return EntityTable<EntityEx, IResponseResolver<ViewOutput<EntityEx>>, IServiceEx>(
      factory: () => EntityEx(),
      adapter: EntityTableEntryAdapter(),
      columns: <EntityTableColumnData<EntityEx>>[
        EntityTableColumnData<EntityEx>(
          title: 'Property One',
          factory: (EntityEx entity, int index, BuildContext buildContext) => entity.valueOne,
        ),
        EntityTableColumnData<EntityEx>(
          title: 'Property Two',
          factory: (EntityEx entity, int index, BuildContext buildContext) => entity.vlaueTwo,
        ),
      ],
    );
  }
}

class EntityTableEntryAdapter extends EntityTableAdapterBase<EntityEx> {
  @override
  FutureOr<String> composeAuth() => "";

  @override
  Widget composeViewer(BuildContext buildContext, EntityEx entity) {
    return Column(
      spacing: 16,
      children: <Widget>[
        PropertyViewer<String>(
          label: 'Value One',
          value: entity.valueOne,
        ),
        PropertyViewer<String>(
          label: 'Value Two',
          value: entity.vlaueTwo,
        ),
      ],
    );
  }

  @override
  EntityTableAdapterEditor<EntityEx>? composeEditor() {
    return EntityTableAdapterEditor<EntityEx>(
      onUpdate: (BuildContext buildContext, EntityEx entity) {},
      formBuilder: (BuildContext buildContext, EntityEx entity) {
        return Column(
          spacing: 16,
          children: <Widget>[
            TextInput(
              label: 'Value One',
              controller: TextEditingController(
                text: entity.valueOne,
              ),
              onChanged: (String text) => entity.valueOne = text,
            ),
            TextInput(
              label: 'Value Two',
              controller: TextEditingController(
                text: entity.vlaueTwo,
              ),
              onChanged: (String text) => entity.vlaueTwo = text,
            ),
          ],
        );
      },
    );
  }
}
