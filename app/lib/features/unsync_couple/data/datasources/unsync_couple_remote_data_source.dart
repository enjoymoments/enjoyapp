import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class UnsyncCoupleRemoteDataSource {
  //TODO:implement methods here
}

class UnsyncCoupleRemoteDataSourceImpl implements UnsyncCoupleRemoteDataSource {
  UnsyncCoupleRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
