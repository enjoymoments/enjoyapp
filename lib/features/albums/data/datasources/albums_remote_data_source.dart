import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class AlbumsRemoteDataSource {
  //TODO:implement methods here
}

class AlbumsRemoteDataSourceImpl implements AlbumsRemoteDataSource {
  AlbumsRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
