import 'package:mozin/modules/shared/enums.dart';
import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class FavoriteInterestsRemoteDataSource {
  Future<bool> addFavoriteInterest(
    String interestId,
    InterestEnum interestType,
  );
}

class FavoriteInterestsRemoteDataSourceImpl implements FavoriteInterestsRemoteDataSource {
  FavoriteInterestsRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;

  @override
  Future<bool> addFavoriteInterest(
    String interestId,
    InterestEnum interestType,
  ) async {
    String _query = '''
    mutation addFavoriteInterest {
       addFavoriteInterest(interest: {interestType: PLACE, interestId: "$interestId" })
    }
    ''';

    var result = await remoteClientRepository.query(_query);
    return Future.value(result['data']['addFavoriteInterest']);
  }
}
