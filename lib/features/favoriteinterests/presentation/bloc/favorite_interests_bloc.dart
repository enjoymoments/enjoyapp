import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:mozin/features/favoriteinterests/domain/repositories/favorite_interests_repository.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_event.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_state.dart';
import 'package:mozin/modules/config/setup.dart';
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
    if (event is ChangeFavoriteInterestEvent) {
      yield* mapChangeFavoriteInterestToState(event);
    } else if (event is SetFavoriteItem) {
      yield state.copyWith(favoriteAdded: event.favoriteAdded);
    }
  }

  Stream<FavoriteInterestsState> mapChangeFavoriteInterestToState(
    ChangeFavoriteInterestEvent event,
  ) async* {
    Either<bool, Exception> response;
    var _userService = getItInstance<UserService>();
    var _userWrapper = getItInstance<UserWrapper>();
    var _user = _userWrapper.getUser;

    var _indexItem = _user.favoriteInterests.places.indexWhere((element) => element.placeId == event.interestId);
    var _favoriteAdded = !(_indexItem != -1);

    yield state.copyWith(favoriteAdded: _favoriteAdded);

    if (_indexItem != -1) {
      response = await _favoriteInterestsRepository.removeFavoriteInterest(
          event.interestId);
      _userService.removeFavoriteInterest(_indexItem);
    } else {
      response = await _favoriteInterestsRepository.addFavoriteInterest(
          event.interestId, event.interestType);
      _userService.addFavoriteInterest(event.data);
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
