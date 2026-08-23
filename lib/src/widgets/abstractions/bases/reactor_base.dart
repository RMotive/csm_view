import 'package:csm_view/src/widgets/abstractions/interfaces/ireactor.dart';
import 'package:flutter/foundation.dart';

/// Represents a [ReactorWidget]'s reactor to manage inner states.
abstract class ReactorBase extends ChangeNotifier implements IReactor {
  @override
  @Deprecated('Wrong lexical CSM use, better use effect()')
  void notifyListeners() => react();

  @override
  void react() {
    super.notifyListeners();
  }
}
