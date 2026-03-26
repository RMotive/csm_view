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

  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(<String, Object?>{
      "valueOne": valueOne,
      "valueTwo": vlaueTwo,
    });
  }
  
  @override
  List<ObjectDifference> compare(EntityEx ref, [List<ObjectDifference>? aggregated]) {
     aggregated = super.compare(ref, aggregated);

    if(valueOne != ref.valueOne){
      aggregated.add(
        ObjectDifference(
          PropertyInfo('valueOne', String, valueOne),
          valueOne,
          ref.valueOne,
          null,
        ),
      );
    }

    if(vlaueTwo != ref.vlaueTwo){
      aggregated.add(
        ObjectDifference(
          PropertyInfo('vlaueTwo', String, vlaueTwo),
          vlaueTwo,
          ref.vlaueTwo,
          null,
        ),
      );
    }

    return aggregated;
  }
}
