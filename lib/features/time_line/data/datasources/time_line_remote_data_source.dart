import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class Time_lineRemoteDataSource {
  //TODO:implement methods here
}

class Time_lineRemoteDataSourceImpl implements Time_lineRemoteDataSource {
  Time_lineRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
