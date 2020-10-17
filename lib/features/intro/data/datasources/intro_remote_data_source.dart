import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class IntroRemoteDataSource {
  //TODO:implement methods here
}

class IntroRemoteDataSourceImpl implements IntroRemoteDataSource {
  IntroRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
