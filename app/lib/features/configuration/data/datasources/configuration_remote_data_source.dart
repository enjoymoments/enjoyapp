import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class ConfigurationRemoteDataSource {
  //TODO:implement methods here
}

class ConfigurationRemoteDataSourceImpl implements ConfigurationRemoteDataSource {
  ConfigurationRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
