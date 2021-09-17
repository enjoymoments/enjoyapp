import 'package:mozin/features/user_action/data/models/user_action_model.dart';
import 'package:mozin/modules/shared/general/models/response_default_model.dart';
import 'package:mozin/modules/shared/core_migrate/remote_client_repository.dart';

abstract class UserActionRemoteDataSource {
  Future<ResponseDefaultModel> addUserAction(UserActionModel? model);
}

class UserActionRemoteDataSourceImpl implements UserActionRemoteDataSource {
  UserActionRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository? remoteClientRepository;

  @override
  Future<ResponseDefaultModel> addUserAction(
    UserActionModel? model,
  ) async {
    String _query = '''
    mutation userAction {
      userAction(action:{
        notificationType: ${model!.notificationType.toString()}
        data: "${model.data ?? ''}"
      }) {
          isSuccess
          data
          message
      }
    }
    ''';

    var result = await remoteClientRepository!.query(_query);
    return ResponseDefaultModel.fromJson(result['data']['userAction']);
  }
}
