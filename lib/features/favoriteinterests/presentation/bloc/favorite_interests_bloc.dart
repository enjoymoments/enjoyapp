import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:mozin/features/favoriteinterests/domain/repositories/favorite_interests_repository.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_event.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_state.dart';
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
    if (event is AddFavoriteInterestEvent) {
      yield* mapAddFavoriteInterestToState(event);
    }
  }

  Stream<FavoriteInterestsState> mapAddFavoriteInterestToState(
    AddFavoriteInterestEvent event,
  ) async* {
    Either<bool, Exception> response = await _favoriteInterestsRepository
        .addFavoriteInterest(event.interestId, event.interestType);

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
