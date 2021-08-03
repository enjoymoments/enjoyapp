import 'package:mozin/modules/shared/core_migrate/remote_client_repository.dart';

abstract class ConfigurationRemoteDataSource {
  //TODO:implement methods here
}

class ConfigurationRemoteDataSourceImpl implements ConfigurationRemoteDataSource {
  ConfigurationRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
