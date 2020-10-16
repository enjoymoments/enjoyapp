import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class PlacesRemoteDataSource {
  //TODO:implement methods here
}

class PlacesRemoteDataSourceImpl implements PlacesRemoteDataSource {
  PlacesRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
