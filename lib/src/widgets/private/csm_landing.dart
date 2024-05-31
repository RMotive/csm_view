import 'dart:io';

import 'package:csm_foundation_view/csm_foundation_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CSMLanding extends StatelessWidget {
  const CSMLanding({super.key});

  @override
  Widget build(BuildContext context) {
    final String system = !kIsWeb ? Platform.operatingSystemVersion : 'browser';

    return ColoredBox(
      color: Colors.blueGrey,
      child: CSMSpacingColumn(
        spacing: 24,
        mainAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Image(
            image: AssetImage(
              'assets/business/business_icon.png',
              package: 'csm_foundation_view',
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
