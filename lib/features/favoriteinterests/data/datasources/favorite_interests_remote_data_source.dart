import 'package:mozin/features/places/data/models/places_model.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/interest_type.dart';
import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class FavoriteInterestsRemoteDataSource {
  Future<bool> addFavoriteInterest(
    String interestId,
    InterestEnum interestType,
  );

  Future<bool> removeFavoriteInterest(
    String interestId,
  );

  Future<InterestType> getFavoriteInterests();
}

class FavoriteInterestsRemoteDataSourceImpl
    implements FavoriteInterestsRemoteDataSource {
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

  @override
  Future<InterestType> getFavoriteInterests() async {
    String _query = '''
    query getFavoriteInterest {
      getFavoriteInterest {
        places {
          address
          name
          placeId
          rating
          types
          userRatingsTotal
          vicinity
          priceLevel
          icon
          location {
            latitude
            longitude
          }
        }
      }
    }
    ''';

    var result = await remoteClientRepository.query(_query);
    return InterestType(
        places: PlacesModel.fromJson(result['data']['getFavoriteInterest']).places);
  }

  @override
  Future<bool> removeFavoriteInterest(String interestId) async {
    String _query = '''
    mutation removeFavoriteInterest {
       removeFavoriteInterest(interestId: "$interestId")
    }
    ''';

    var result = await remoteClientRepository.query(_query);
    return Future.value(result['data']['removeFavoriteInterest']);
  }
}
