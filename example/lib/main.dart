import 'package:csm_foundation_view/csm_foundation_view.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    const ExampleApplication(),
  );
}

class ExampleApplication extends StatelessWidget {
  const ExampleApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return const CSMApplication();
  }
}
