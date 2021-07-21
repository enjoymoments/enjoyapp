import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class SuggestionsRemoteDataSource {
  //TODO:implement methods here
}

class SuggestionsRemoteDataSourceImpl implements SuggestionsRemoteDataSource {
  SuggestionsRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;
}
