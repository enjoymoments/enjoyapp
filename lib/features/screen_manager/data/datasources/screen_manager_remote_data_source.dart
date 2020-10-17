import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class Screen_managerRemoteDataSource {
  //TODO:implement methods here
}

class Screen_managerRemoteDataSourceImpl implements Screen_managerRemoteDataSource {
  Screen_managerRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
