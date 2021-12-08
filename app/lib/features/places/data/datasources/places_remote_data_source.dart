import 'package:mozin/features/interest/data/models/sub_categories_model.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/data/models/places_model.dart';
import 'package:mozin/modules/shared/filter_choosed/models/filter_choosed_model.dart';
import 'package:mozin/modules/shared/core_migrate/remote_client_repository.dart';
import 'package:mozin_core/mozin_core.dart';

abstract class PlacesRemoteDataSource {
  Future<PlacesModel> getPlaces(
    double latitude,
    double longitude,
    FilterChoosedModel? filters,
  );

  Future<PlaceModel> getPlaceDetails(
    PlaceModel? place,
  );

  Future<String?> getPlacePhoto(
    String? placeId,
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
  'categories',
];

class PlacesRemoteDataSourceImpl implements PlacesRemoteDataSource {
  PlacesRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository? remoteClientRepository;

  @override
  Future<PlacesModel> getPlaces(
    double latitude,
    double longitude,
    FilterChoosedModel? filters,
  ) async {
    String formattedParams = _placeParams(latitude, longitude, filters!);

    String _query = '''
    query Interests {
      search($formattedParams) {
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
                url
                urlAndroid
                urlIOS
                urlReference
                favoriteAdded
              }
            }
        }
      }
    }
    ''';

    var result = await remoteClientRepository!.query(_query);
    return PlacesModel.fromJson(result['data']['search']);
  }

  @override
  Future<PlaceModel> getPlaceDetails(
    PlaceModel? place,
  ) async {
    String _query = '''
    query PlaceDetails {
       placeDetails(placeId: "${place!.placeId}") {
        favorited
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

    var result = await remoteClientRepository!.query(_query);
    return PlaceModel.fromJsonComplement(place, result['data']['placeDetails']);
  }

  @override
  Future<String?> getPlacePhoto(String? placeId, String photoReference) async {
    String _query = '''
    query placePhotos {
      placePhoto(
        placeId: "$placeId"
        photoReference: "$photoReference")
    }
    ''';

    var result = await remoteClientRepository!.query(_query);
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
      if (filters.generalFilters!.minDistance != null) {
        params['minDistance'] = filters.generalFilters!.minDistance;
      }

      if (filters.generalFilters!.maxDistance != null) {
        params['maxDistance'] = filters.generalFilters!.maxDistance;
      }

      if (filters.generalFilters!.minPrice != null) {
        params['minPrice'] = filters.generalFilters!.minPrice;
      }

      if (filters.generalFilters!.maxPrice != null) {
        params['maxPrice'] = filters.generalFilters!.maxPrice;
      }

      if (filters.generalFilters!.minTime != null) {
        params['minTime'] = filters.generalFilters!.minTime;
      }

      if (filters.generalFilters!.maxTime != null) {
        params['maxTime'] = filters.generalFilters!.maxTime;
      }
    }

    if (filters.categories != null && filters.categories!.length > 0) {
      params['categories'] = _formatCategories(filters);
    }

    return formatParams(params,
        nonStringValuesKeysAccount: nonStringValuesKeysAccount);
  }

  String _formatCategories(FilterChoosedModel filters) {
    List<Map<String, dynamic>> _categories = <Map<String, dynamic>>[];

    for (var categorie in filters.categories!) {
      Map<String?, dynamic> _mapSubCategorie = {};

      for (var subCategorie in categorie.subCategories!) {
        if (subCategorie is SubCategoriesModel) {
          if (subCategorie.selected != null && subCategorie.selected!) {
            _mapSubCategorie[subCategorie.id] = subCategorie.id;
          }
        }
      }

      Map<String, dynamic> _categorie = {};
      _categorie['id'] = '"${categorie.id}"';
      var _subCategoriesFormatted = _mapSubCategorie.entries
          .map((e) => '{id: "${e.value}"}')
          .toList()
          .join(', ');

      _categorie['subCategories'] = '[$_subCategoriesFormatted]';
      _categories.add(_categorie);
    }

    return '[${_categories.toList().join(', ')}]';
  }
}
