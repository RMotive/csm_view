
/* final class WhisperEntry extends PackageLandingEntryB<CSMViewThemeB> {
  static const RouteData whisperRoute = RouteData(
    'whisper_example',
    name: 'Whisper Example',
  );

  ///
  WhisperEntry({
    super.key,
  }) : super(
          name: 'Whisper',
          description: (CSMViewThemeB theme, Color foreColor) {
            return TextSpan(
                text:
                    'Whisper are routed dialogs configured at the Routing Tree to be accessed at a Route calculation location');
          },
        );

  @override
  List<RouteB> composeRoutes(GlobalKey<NavigatorState> navigationLayoutKey, GlobalKey<NavigatorState> entryLayoutKey) {
    return <RouteB>[
      RouteWhisper<Object>(
        whisperRoute,
        parentNavigatorStateKey: entryLayoutKey,
        whisperOptions: RouteWhisperOptions(),
        pageBuilder: (BuildContext ctx, RoutingData routeData) {
          return _WhisperExample();
        },
      )
    ];
  }

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, CSMViewThemeB theme) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          InjectorUtils.get<RouterBase>().go(whisperRoute, logging: true);
        },
        child: Text('Click me to open a Whisper!'),
      ),
    );
  }
}

final class _WhisperExample extends PageB {
  @override
  Widget compose(BuildContext context, Size windowSize, Size pageSize) {
    return ColoredBox(
      color: Colors.deepOrange,
      child: Center(
        child: Text('SUCCESS OPENING THE WHISPER EXAMPLE!!!'),
      ),
    );
  }
} */
