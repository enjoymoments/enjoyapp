import 'package:mozin/modules/shared/core_migrate/remote_client_repository.dart';
import 'package:mozin/modules/shared/user/models/user_info_model.dart';

abstract class UserRemoteDataSource {
  Future<UserInfoModel> setUserInfo();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository? remoteClientRepository;

  @override
  Future<UserInfoModel> setUserInfo() async {
    String _mutation = '''
    mutation userInfo {
      userInfo {
        coupleId
        userInternalId
        timelines {
          id
          type
        }
      }
    }
    ''';

    var result = await remoteClientRepository!.query(_mutation);
    return UserInfoModel.fromJson(result['data']['userInfo']);
  }
}
