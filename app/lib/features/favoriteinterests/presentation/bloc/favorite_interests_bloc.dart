import 'package:bloc/bloc.dart';
import 'package:mozin/features/favoriteinterests/domain/repositories/favorite_interests_repository.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_event.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_state.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:custom_utilities/custom_utilities.dart';

class FavoriteInterestsBloc
    extends Bloc<FavoriteInterestsEvent, FavoriteInterestsState> {
  FavoriteInterestsBloc() : super(FavoriteInterestsState.initial());

  @override
  Stream<FavoriteInterestsState> mapEventToState(
    FavoriteInterestsEvent event,
  ) async* {
    if (event is LoadFavoriteInterests) {
      yield* loadFavoriteInterests();
    }
  }

  Stream<FavoriteInterestsState> loadFavoriteInterests() async* {
    var _userWrapper = getItInstance<UserWrapper>();
    var _user = _userWrapper.getUser!;

    if (_user.favoriteInterests!.places!.length == 0) {
      yield state.copyWith(isLoading: true);

      var _favoriteInterests = getItInstance<FavoriteInterestsRepository>();
      var response = await _favoriteInterests.getFavoriteInterests();

      yield response.fold((model) {
        _userWrapper.assignment(_user.copyWith(favoriteInterests: model));

        return state.copyWith(
          isLoading: false,
          isError: false,
          isSuccess: true,
          forceRefresh: StateUtils.generateRandomNumber() as int?,
          favoriteInterests: model,
        );
      }, (error) {
        return state.copyWith(
          isLoading: false,
          isError: true,
          isSuccess: false,
          forceRefresh: StateUtils.generateRandomNumber() as int?,
        );
      });
    } else {
      yield state.copyWith(
        favoriteInterests: _user.favoriteInterests,
        forceRefresh: StateUtils.generateRandomNumber() as int?,
        isLoading: false,
      );
    }
  }
}
