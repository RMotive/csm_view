import 'package:csm_view/csm_view.dart';
import 'package:example/mocks/entity_mock.dart';
import 'package:example/mocks/service_mock.dart';
import 'package:example/theme/view_package_theme_base.dart';
import 'package:flutter/material.dart' hide Route;

final RouteData securityRouteData = RouteData('security');

final RouteData businessRouteData = RouteData('business');

final RouteData homeRouteData = RouteData('showcase_root');

///
final class NavigationLayoutEntry extends PackageSandboxItemBase<ViewPackageThemeBase> with ThemingMixin {
  ///
  final List<IThemeData> themes;

  @override
  List<IRoutingGraphData> composeRoutes(GlobalKey<NavigatorState> navLayoutKey, GlobalKey<NavigatorState> entryLayoutKey) {
    return <IRoutingGraphData>[
      RoutingGraphNode(
        businessRouteData,
        pageBuilder: (BuildContext ctx, RoutingData routeData) => EXPage(),
      ),
      RoutingGraphNode(
        securityRouteData,
        pageBuilder: (BuildContext ctx, RoutingData routeData) => EXPage(),
      ),
    ];
  }

  /// Creates a new [NavigationLayoutEntry] instance.
  NavigationLayoutEntry({
    super.key,
    required this.themes,
  }) : super(
          name: 'Navigation Layout',
          description: (ViewPackageThemeBase themeData, Color foreColor) {
            return TextSpan();
          },
        );

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, ViewPackageThemeBase theme) {
    return NavigationLayout(
      userData: NavigationLayoutHeaderUserData(
        name: 'Package',
        email: 'package_landing@csm.com',
        lastName: 'Landing',
      ),
      routingData: RoutingData(
        targetRoute: businessRouteData,
        absolutePath: '',
      ),
      homeRouteData: homeRouteData,
      page: SizedBox(
        child: CreateEntityForm<EntityEx, IServiceEx>(
          factory: () => EntityEx(),
          authFactory: (BuildContext context) => '',
          recordDesigner: (EntityEx entity, bool selected, bool valid) {
            return CreateEntityFormRecord(
              selected: selected,
              fields: <CreateEntityFormRecordField<Object>>[
                CreateEntityFormRecordField<String>(
                  label: 'Value One',
                  value: entity.valueOne,
                ),
                CreateEntityFormRecordField<String>(
                  label: 'Value Two',
                  value: entity.vlaueTwo,
                ),
              ],
            );
          },
          formDesigner: (CreateEntityFormRecordReactor<EntityEx>? itemState, ScrollController scrollController) {
            return Column(
              children: <Widget>[
                /// properties.
                FormInputGroup(
                  children: <Widget>[
                    TextInput(
                      label: 'Input 1',
                      controller: TextEditingController(text: itemState?.entity.valueOne),
                      onChanged: (String text) {
                        if (itemState == null) return;

                        itemState.entity.valueOne = text;
                        itemState.react();
                      },
                    ),
                    TextInput(
                      label: 'Input 2',
                      controller: TextEditingController(text: itemState?.entity.vlaueTwo),
                      onChanged: (String text) {
                        if (itemState == null) return;

                        itemState.entity.vlaueTwo = text;
                        itemState.react();
                      },
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
      navigationNodes: <INavigationLayoutNode>[
        NavigationLayoutNode(
          title: 'Business',
          routeData: businessRouteData,
          icon: Icons.business,
        ),
        NavigationLayoutNode(
          title: 'Security',
          routeData: securityRouteData,
          icon: Icons.security,
        )
      ],
    );
  }
}

final class EXPage extends ViewPageBase {
  @override
  Widget compose(BuildContext context, Size windowSize, Size pageSize) {
    return Container(
      color: Colors.orange,
    );
  }
}
