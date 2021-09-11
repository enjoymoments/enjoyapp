import 'package:mozin/features/places/data/models/places_model.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/interest_type.dart';
import 'package:mozin/modules/shared/core_migrate/remote_client_repository.dart';

abstract class FavoriteInterestsRemoteDataSource {
  Future<bool> addFavoriteInterest(
    String interestId,
    String categoryId,
    String subCategoryId,
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
    String categoryId,
    String subCategoryId,
    InterestEnum interestType,
  ) async {
    //TODO:review this
    String _query = '''
    mutation addFavoriteInterest {
       addFavoriteInterest(interest: 
        {
          interestId: "$interestId"
          interestType: SUGGESTION
          categoryId: "$categoryId"
          subCategoryId:"$subCategoryId"
        }
      )
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
          categoryId
          categoryName
          subCategories {
            subCategoryId
            subCategoryName
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
              suggestedByUsers {
                id
                title
                description
                like
                moreOptionsEnable
              }
            }
        }
      }
    }
    ''';

    var result = await remoteClientRepository.query(_query);
    return InterestType(
        places:
            PlacesModel.fromJson(result['data']['getFavoriteInterest']).places);
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
