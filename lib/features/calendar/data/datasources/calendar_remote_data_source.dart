import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class CalendarRemoteDataSource {
  //TODO:implement methods here
}

class CalendarRemoteDataSourceImpl implements CalendarRemoteDataSource {
  CalendarRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
