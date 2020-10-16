import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class InterestRemoteDataSource {
  //TODO:implement methods here
}

class InterestRemoteDataSourceImpl implements InterestRemoteDataSource {
  InterestRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
