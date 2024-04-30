import 'package:flutter/material.dart';

final class CSMConsumerAgent extends ChangeNotifier {
  void refresh() {
    notifyListeners();
  }
}
