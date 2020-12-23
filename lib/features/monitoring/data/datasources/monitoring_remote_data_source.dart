import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class MonitoringRemoteDataSource {
  //TODO:implement methods here
}

class MonitoringRemoteDataSourceImpl implements MonitoringRemoteDataSource {
  MonitoringRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
