part of '../core/abstractions/bases/view_module_base.dart';

/// A page that displays a welcome to the users when they just opens
/// the view.
final class _ViewModuleWelcome extends StatelessWidget {
  const _ViewModuleWelcome();

  @override
  Widget build(BuildContext context) {
    final String system = !kIsWeb ? Platform.operatingSystemVersion : 'browser';

    return ColoredBox(
      color: Colors.blueGrey,
      child: Column(
        spacing: 24,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Image(
            image: AssetImage(
              'assets/business/business_icon.png',
              package: 'csm_view',
            ),
            width: 124,
            height: 124,
          ),
          const Text('Welcome to your CSM application!'),
          const Text(
            'Checkout documentation at CDN source.',
            style: TextStyle(
              color: Colors.amber,
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Running on: ',
              style: const TextStyle(fontSize: 16),
              children: <InlineSpan>[
                TextSpan(
                  text: '[${defaultTargetPlatform.name} | ($system)]',
                  style: const TextStyle(
                    color: kIsWeb ? Colors.orange : Colors.lightGreen,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
