import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class FeedbackRemoteDataSource {
  //TODO:implement methods here
}

class FeedbackRemoteDataSourceImpl implements FeedbackRemoteDataSource {
  FeedbackRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
