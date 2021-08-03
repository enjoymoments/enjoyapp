import 'package:mozin/modules/shared/core_migrate/remote_client_repository.dart';

abstract class MeRemoteDataSource {
  //TODO:implement methods here
}

class MeRemoteDataSourceImpl implements MeRemoteDataSource {
  MeRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
