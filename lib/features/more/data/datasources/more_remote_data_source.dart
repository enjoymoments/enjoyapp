import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class MoreRemoteDataSource {
  //TODO:implement methods here
}

class MoreRemoteDataSourceImpl implements MoreRemoteDataSource {
  MoreRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
