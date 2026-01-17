import 'package:csm_client_core/csm_client_core.dart';

final class EntityEx extends EntityBase<EntityEx> {
  String valueOne = '';

  String vlaueTwo = '';

  @override
  void decode(DataMap encode) {
    valueOne = encode.get('valueOne');

    vlaueTwo = encode.get('valueTwo');

    super.decode(encode);
  }
}
