import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class UserRemoteDataSource {
  Future<String> setUserInfo();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;

  @override
  Future<String> setUserInfo() async {
    String _mutation = '''
    mutation userInfo {
      userInfo
    }
    ''';

    var result = await remoteClientRepository.query(_mutation);
    return result['data']['userInfo'];
  }
}
