import 'package:mozin/modules/shared/core_migrate/remote_client_repository.dart';

abstract class MonitoringRemoteDataSource {
  //TODO:implement methods here
}

class MonitoringRemoteDataSourceImpl implements MonitoringRemoteDataSource {
  MonitoringRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
