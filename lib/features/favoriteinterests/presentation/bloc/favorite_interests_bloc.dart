import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:mozin/features/favoriteinterests/domain/repositories/favorite_interests_repository.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_event.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_state.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/user/services/user_service.dart';
import 'package:mozin/package_view/utils.dart';

class FavoriteInterestsBloc
    extends Bloc<FavoriteInterestsEvent, FavoriteInterestsState> {
  FavoriteInterestsBloc(
      {@required FavoriteInterestsRepository favoriteInterestsRepository})
      : assert(favoriteInterestsRepository != null),
        _favoriteInterestsRepository = favoriteInterestsRepository,
        super(FavoriteInterestsState.initial());

  final FavoriteInterestsRepository _favoriteInterestsRepository;

  @override
  Stream<FavoriteInterestsState> mapEventToState(
    FavoriteInterestsEvent event,
  ) async* {
    if (event is AddPlaceToFavorite) {
      yield* mapAddPlaceToFavoriteToState(event);
    } else if (event is SetFavoriteItem) {
      yield state.copyWith(favoriteAdded: event.favoriteAdded);
    } else if (event is LoadFavoriteInterests) {
      yield* loadFavoriteInterests();
    }
  }

  Stream<FavoriteInterestsState> loadFavoriteInterests() async* {
    var _userWrapper = getItInstance<UserWrapper>();
    var _user = _userWrapper.getUser;

    yield state.copyWith(
      favoriteInterests: _user.favoriteInterests,
      isLoading: false,
    );
  }

  Stream<FavoriteInterestsState> mapAddPlaceToFavoriteToState(
    AddPlaceToFavorite event,
  ) async* {
    Either<bool, Exception> response;
    var _userService = getItInstance<UserService>();
    var _userWrapper = getItInstance<UserWrapper>();
    var _user = _userWrapper.getUser;
    int _indexItem = -1;

    for (var indexCategory = 0;
        indexCategory < _user.favoriteInterests.places.length;
        indexCategory++) {
      var _categoryItem = _user.favoriteInterests.places[indexCategory];

      if (_categoryItem.categoryId == event.place.categoryId) {
        for (var indexSubCategory = 0;
            indexSubCategory < _categoryItem.subCategories.length;
            indexSubCategory++) {
          var _subCategoryItem = _categoryItem.subCategories[indexSubCategory];

          if (_subCategoryItem.subCategoryId == event.place.subCategoryId) {
            _indexItem = _subCategoryItem.data.indexWhere(
                (element) => element.placeId == event.place.placeId);
          }
        }
      }
    }

    // var _indexItem = _user.favoriteInterests.places.indexWhere((element) =>
    //     element.categoryId == event.place.categoryId &&
    //     element.subCategories.any((subCategogy) =>
    //         subCategogy.subCategoryId == event.place.subCategoryId));

    var _favoriteAdded = !(_indexItem != -1);

    yield state.copyWith(favoriteAdded: _favoriteAdded);

    if (_indexItem != -1) {
      response = await _favoriteInterestsRepository
          .removeFavoriteInterest(event.place.placeId);

      _userService.removeFavoriteInterest(_indexItem);
    } else {
      response = await _favoriteInterestsRepository.addFavoriteInterest(
        event.place.placeId,
        event.place.categoryId,
        event.place.subCategoryId,
        InterestEnum.Place,
      );

      _userService.addFavoriteInterest(event.place);
    }

    yield response.fold((model) {
      return state.copyWith(
        isLoading: false,
        isError: false,
        isSuccess: true,
        forceRefresh: StateUtils.generateRandomNumber(),
      );
    }, (error) {
      return state.copyWith(
        isLoading: false,
        isError: true,
        isSuccess: false,
        forceRefresh: StateUtils.generateRandomNumber(),
      );
    });
  }
}
