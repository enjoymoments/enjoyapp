import 'package:mozin/modules/shared/core_migrate/remote_client_repository.dart';

abstract class HomeRemoteDataSource {
  //TODO:implement methods here
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
