import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class ScreenManagerRemoteDataSource {
  //TODO:implement methods here
}

class ScreenManagerRemoteDataSourceImpl implements ScreenManagerRemoteDataSource {
  ScreenManagerRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
