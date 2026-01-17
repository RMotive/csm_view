import 'package:csm_client_core/csm_client_core.dart';
import 'package:example/mocks/entity_mock.dart';

final class ServiceMock extends ServiceBase implements IServiceEx {
  ServiceMock()
      : super(
          Uri('', ''),
          '',
        );

  @override
  Future<IResponseResolver<ViewOutput<EntityEx>>> view(ViewInput<EntityEx> input, String auth) async {
    return ResponseResolverMock<ViewOutput<EntityEx>>(
      ResponseController(
        200,
        data: <String, Object?>{
          "id": 'mock_id',
          "content": <String, Object?>{
            "page": 1,
            "pages": 1,
            "count": 3,
            "length": 3,
            "timestamp": DateTime.now().toUtc(),
            "entities": <Map<String, Object?>>[
              <String, Object?>{
                "id": 1,
                "discriminator": "",
                "valueOne": "Item 1 Value 1",
                "valueTwo": "Item 1 Value 2",
                "timestamp": DateTime.now().toUtc(),
              },
              <String, Object?>{
                "id": 2,
                "discriminator": "",
                "valueOne": "Item 2 Value 1",
                "valueTwo": "Item 2 Value 2",
                "timestamp": DateTime.now().toUtc(),
              },
              <String, Object?>{
                "id": 3,
                "discriminator": "",
                "valueOne": "Item 3 Value 1",
                "valueTwo": "Item 3 Value 2",
                "timestamp": DateTime.now().toUtc(),
              },
            ],
          },
        },
      ),
    );
  }

  @override
  Future<IResponseResolver<BatchOperationOutput<EntityEx>>> create(List<EntityEx> entities, String auth) {
    throw UnimplementedError();
  }
}

abstract interface class IServiceEx extends ServiceBase implements ICreateService<EntityEx, IResponseResolver<BatchOperationOutput<EntityEx>>>, IViewService<EntityEx, IResponseResolver<ViewOutput<EntityEx>>> {
  /// Creates a new instace.
  IServiceEx(
    super.host,
    super.servicePath,
  );
}

class ResponseResolverMock<TData extends IDecodable> extends ResponseResolverBase<TData> {
  ResponseResolverMock(super.responseController);

  @override
  void resolve(
      {required TData Function() factory, required void Function(SuccessFrame<TData> success) onSuccess, required void Function(FailureFrame failure, int status) onFailure, required void Function(TracedException exception) onException, required void Function() onConnectionFailure, void Function()? onFinally}) {
    responseController.resolve(
      (DataMap data) {
        final SuccessFrame<TData> successFrame = SuccessFrame<TData>(factory);
        successFrame.decode(data);
        onSuccess(successFrame);
      },
      (DataMap data, int statusCode) {
        final FailureFrame failureFrame = FailureFrame();
        failureFrame.decode(data);

        onFailure(failureFrame, statusCode);
      },
      (TracedException exception) {
        if (exception.toString().contains('ClientException')) {
          onConnectionFailure.call();
        } else {
          onException.call(exception);
        }
      },
    );
    onFinally?.call();
  }

  @override
  TData resolveDirect(TData Function() factory) {
    TData? result;
    responseController.resolve(
      (DataMap data) {
        final SuccessFrame<TData> successFrame = SuccessFrame<TData>(factory);
        successFrame.decode(data);

        result = successFrame.content;
      },
      (DataMap data, int statusCode) {
        final FailureFrame failureFrame = FailureFrame();
        failureFrame.decode(data);
        throw TracedException(
          'FailureException: server act resulted in failure $statusCode with (${failureFrame.content})',
          StackTrace.current,
        );
      },
      (TracedException exception) {
        throw exception;
      },
    );

    if (result == null && (null is! TData)) {
      throw TracedException('Unable to resolve response controller', StackTrace.current);
    }

    return result as TData;
  }
}
