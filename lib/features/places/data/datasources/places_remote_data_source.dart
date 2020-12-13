import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/data/models/places_model.dart';
import 'package:mozin/modules/shared/filter_choosed/models/filter_choosed_model.dart';
import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class PlacesRemoteDataSource {
  Future<PlacesModel> getPlaces(
    double latitude,
    double longitude,
    FilterChoosedModel filters,
  );

  Future<PlaceModel> getPlaceDetails(
    PlaceModel place,
  );

  Future<String> getPlacePhoto(
    String placeId,
    String photoReference,
  );
}

const List<String> nonStringValuesKeysAccount = <String>[
  'minPrice',
  'maxPrice',
  'minDistance',
  'maxDistance',
  'minTime',
  'maxTime',
];

class PlacesRemoteDataSourceImpl implements PlacesRemoteDataSource {
  PlacesRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;

  @override
  Future<PlacesModel> getPlaces(
    double latitude,
    double longitude,
    FilterChoosedModel filters,
  ) async {
    String formattedParams = _placeParams(latitude, longitude, filters);

    String _query = '''
    query Places {
      places($formattedParams) {
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
    ''';

    var result = await remoteClientRepository.query(_query);
    return PlacesModel.fromJson(result['data']);
  }

  @override
  Future<PlaceModel> getPlaceDetails(
    PlaceModel place,
  ) async {
    String _query = '''
    query PlaceDetails {
       placeDetails(placeId: "${place.placeId}") {
        formattedAddress
        formattedPhoneNumber
        types
        openNow
        photoReferences
        reviews {
          authorName
          relativeTimeDescription
          profilePhotoUrl
          rating
          text
        }
      }
    }
    ''';

    var result = await remoteClientRepository.query(_query);
    return PlaceModel.fromJsonComplement(place, result['data']['placeDetails']);
  }

  @override
  Future<String> getPlacePhoto(String placeId, String photoReference) async {
    String _query = '''
    query placePhotos {
      placePhoto(
        placeId: "$placeId"
        photoReference: "$photoReference")
    }
    ''';

    var result = await remoteClientRepository.query(_query);
    return result['data']['placePhoto'];
  }

  String _placeParams(
    double latitude,
    double longitude,
    FilterChoosedModel filters,
  ) {
    final Map<String, dynamic> params = <String, dynamic>{};

    params['latitude'] = latitude;
    params['longitude'] = longitude;

    if (filters.generalFilters != null) {
      if (filters.generalFilters.minDistance != null) {
        params['minDistance'] = filters.generalFilters.minDistance;
      }

      if (filters.generalFilters.maxDistance != null) {
        params['maxDistance'] = filters.generalFilters.maxDistance;
      }

      if (filters.generalFilters.minPrice != null) {
        params['minPrice'] = filters.generalFilters.minPrice;
      }

      if (filters.generalFilters.maxPrice != null) {
        params['maxPrice'] = filters.generalFilters.maxPrice;
      }

      if (filters.generalFilters.minTime != null) {
        params['minTime'] = filters.generalFilters.minTime;
      }

      if (filters.generalFilters.maxTime != null) {
        params['maxTime'] = filters.generalFilters.maxTime;
      }
    }

    if (filters.categories != null && filters.categories.length > 0) {
      String _concat = '';

      for (var categorie in filters.categories) {
        if(categorie.subCategories == null || categorie.subCategories.length == 0) {
          _concat += '${categorie.id};';
          continue;
        }

        for (var subCategorie in categorie.subCategories) {
          _concat += '${categorie.id}/${subCategorie.id};';
        }
      }

      params['categories'] = _concat;
    }

    return _formatParams(params);
  }

  String _formatParams(Map<String, dynamic> params) {
    return params.entries
        .map((final MapEntry<String, dynamic> e) {
          if (nonStringValuesKeysAccount.contains(e.key)) {
            return '${e.key}: ${e.value}';
          }
          return '${e.key}: "${e.value}"';
        })
        .toList()
        .join(', ');
  }
}
