import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class DayOneRemoteDataSource {
  //TODO:implement methods here
}

class DayOneRemoteDataSourceImpl implements DayOneRemoteDataSource {
  DayOneRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
