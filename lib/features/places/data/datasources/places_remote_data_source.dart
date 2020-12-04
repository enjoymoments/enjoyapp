import 'package:mozin/features/places/data/models/places_model.dart';
import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class PlacesRemoteDataSource {
  Future<PlacesModel> getPlaces(
    double latitude,
    double longitude,
    int radius,
    String type,
  );
}

class PlacesRemoteDataSourceImpl implements PlacesRemoteDataSource {
  PlacesRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;

  @override
  Future<PlacesModel> getPlaces(
    double latitude,
    double longitude,
    int radius,
    String type,
  ) async {
    String _query = '''
    query Places {
      places(
        latitude: "$latitude"
        longitude: "$longitude"
        radius: $radius
        type: "$type"
      ) {
        address
        name
        placeId
        rating
        types
        userRatingsTotal
        vicinity
        priceLevel
        photoReferences
        icon
        location {
          latitude
          longitude
        }
      }
    }
    ''';

    var result = await remoteClientRepository.query(_query);
    return PlacesModel.fromJson(result['data']);
  }
}
