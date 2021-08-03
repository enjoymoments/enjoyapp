import 'package:mozin/modules/shared/core_migrate/remote_client_repository.dart';

abstract class ScreenManagerRemoteDataSource {
  //TODO:implement methods here
}

class ScreenManagerRemoteDataSourceImpl implements ScreenManagerRemoteDataSource {
  ScreenManagerRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
