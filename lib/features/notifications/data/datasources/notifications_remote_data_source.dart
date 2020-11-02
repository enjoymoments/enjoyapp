import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class NotificationsRemoteDataSource {
  //TODO:implement methods here
}

class NotificationsRemoteDataSourceImpl implements NotificationsRemoteDataSource {
  NotificationsRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
