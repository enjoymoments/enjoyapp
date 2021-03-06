import 'package:dartz/dartz.dart';
import 'package:mozin/features/favoriteinterests/domain/repositories/favorite_interests_repository.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_bloc.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_event.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_item/favorite_interests_item_event.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_item/favorite_interests_item_state.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/user/services/user_service.dart';
import 'package:custom_utilities/custom_utilities.dart';

class MapItemFavorite {
  late int indexCategory;
  late int indexSubCategory;
  late int indexItem;
}

class FavoriteInterestsItemBloc
    extends Bloc<FavoriteInterestsItemEvent, FavoriteInterestsItemState> {
  FavoriteInterestsItemBloc(
      {required FavoriteInterestsRepository favoriteInterestsRepository})
      : assert(favoriteInterestsRepository != null),
        _favoriteInterestsRepository = favoriteInterestsRepository,
        super(FavoriteInterestsItemState.initial());

  final FavoriteInterestsRepository _favoriteInterestsRepository;

  @override
  Stream<FavoriteInterestsItemState> mapEventToState(
    FavoriteInterestsItemEvent event,
  ) async* {
    if (event is AddPlaceToFavorite) {
      yield* mapAddPlaceToFavoriteToState(event);
      _reloadFavoriteInterests();
    } else if (event is AddSuggestionToFavorite) {
      yield* mapAddSuggestionToFavoriteToState(event);
      _reloadFavoriteInterests();
    } else if (event is SetFavoriteItem) {
      yield state.copyWith(favoriteAdded: event.favoriteAdded);
    }
  }

  void _reloadFavoriteInterests() {
    getItInstance<FavoriteInterestsBloc>()..add(LoadFavoriteInterests());
  }

  Stream<FavoriteInterestsItemState> mapAddSuggestionToFavoriteToState(
    AddSuggestionToFavorite event,
  ) async* {
    Either<bool, Exception> response;
    UserService? _userService = getItInstance<UserService>();
    var _userWrapper = getItInstance<UserWrapper>();
    var _user = _userWrapper.getUser!;

    MapItemFavorite _mapItemFavorite = MapItemFavorite();
    int _indexItem = _getIndexItemSuggestion(_user, _mapItemFavorite, event);

    if (_indexItem != -1) {
      event.suggestion.favoriteAdded = false;
      yield state.copyWith(favoriteAdded: false);

      response = await _favoriteInterestsRepository
          .removeFavoriteInterest(event.suggestion.id);

      _userService.removeFavoriteSuggestionInterest(
        indexCategory: _mapItemFavorite.indexCategory,
        indexSubCategory: _mapItemFavorite.indexSubCategory,
        indexItem: _mapItemFavorite.indexItem,
      );
    } else {
      event.suggestion.favoriteAdded = true;
      yield state.copyWith(favoriteAdded: true);

      response = await _favoriteInterestsRepository.addFavoriteInterest(
        event.suggestion.id,
        event.suggestion.categoryId,
        event.suggestion.subCategoryId,
        InterestEnum.Place,
      );

      _userService.addFavoriteSuggestionInterest(event.suggestion);
    }

    yield response.fold((model) {
      return state.copyWith(
        isLoading: false,
        isError: false,
        isSuccess: true,
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      );
    }, (error) {
      return state.copyWith(
        isLoading: false,
        isError: true,
        isSuccess: false,
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      );
    });
  }

  Stream<FavoriteInterestsItemState> mapAddPlaceToFavoriteToState(
    AddPlaceToFavorite event,
  ) async* {
    Either<bool, Exception> response;
    UserService? _userService = getItInstance<UserService>();
    var _userWrapper = getItInstance<UserWrapper>();
    var _user = _userWrapper.getUser!;

    MapItemFavorite _mapItemFavorite = MapItemFavorite();
    int _indexItem = _getIndexItem(_user, _mapItemFavorite, event);

    if (_indexItem != -1) {
      response = await _favoriteInterestsRepository
          .removeFavoriteInterest(event.place!.placeId);

      _userService.removeFavoriteInterest(
        indexCategory: _mapItemFavorite.indexCategory,
        indexSubCategory: _mapItemFavorite.indexSubCategory,
        indexItem: _mapItemFavorite.indexItem,
      );
    } else {
      response = await _favoriteInterestsRepository.addFavoriteInterest(
        event.place!.placeId,
        event.place!.categoryId,
        event.place!.subCategoryId,
        InterestEnum.Place,
      );

      _userService.addFavoriteInterest(event.place);
    }

    yield response.fold((model) {
      return state.copyWith(
        isLoading: false,
        isError: false,
        isSuccess: true,
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      );
    }, (error) {
      return state.copyWith(
        isLoading: false,
        isError: true,
        isSuccess: false,
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      );
    });
  }

  int _getIndexItemSuggestion(
    UserAppModel user,
    MapItemFavorite mapItemFavorite,
    AddSuggestionToFavorite event,
  ) {
    for (var indexCategory = 0;
        indexCategory < user.favoriteInterests!.places!.length;
        indexCategory++) {
      var _categoryItem = user.favoriteInterests!.places![indexCategory];

      if (_categoryItem.categoryId == event.suggestion.categoryId) {
        for (var indexSubCategory = 0;
            indexSubCategory < _categoryItem.subCategories!.length;
            indexSubCategory++) {
          var _subCategoryItem = _categoryItem.subCategories![indexSubCategory];

          if (_subCategoryItem.subCategoryId ==
              event.suggestion.subCategoryId) {
            var _indexItem = _subCategoryItem.suggestedByUsers!
                .indexWhere((element) => element.id == event.suggestion.id);

            if (_indexItem != -1) {
              mapItemFavorite.indexCategory = indexCategory;
              mapItemFavorite.indexSubCategory = indexSubCategory;
              mapItemFavorite.indexItem = _indexItem;

              return _indexItem;
            }
          }
        }
      }
    }

    return -1;
  }

  int _getIndexItem(
    UserAppModel user,
    MapItemFavorite mapItemFavorite,
    AddPlaceToFavorite event,
  ) {
    for (var indexCategory = 0;
        indexCategory < user.favoriteInterests!.places!.length;
        indexCategory++) {
      var _categoryItem = user.favoriteInterests!.places![indexCategory];

      if (_categoryItem.categoryId == event.place!.categoryId) {
        for (var indexSubCategory = 0;
            indexSubCategory < _categoryItem.subCategories!.length;
            indexSubCategory++) {
          var _subCategoryItem = _categoryItem.subCategories![indexSubCategory];

          if (_subCategoryItem.subCategoryId == event.place!.subCategoryId) {
            var _indexItem = _subCategoryItem.places!.indexWhere(
                (element) => element!.placeId == event.place!.placeId);

            if (_indexItem != -1) {
              mapItemFavorite.indexCategory = indexCategory;
              mapItemFavorite.indexSubCategory = indexSubCategory;
              mapItemFavorite.indexItem = _indexItem;

              return _indexItem;
            }
          }
        }
      }
    }

    return -1;
  }
}
