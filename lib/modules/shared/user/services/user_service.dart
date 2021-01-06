import 'package:mozin/features/favoriteinterests/domain/repositories/favorite_interests_repository.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/user/interfaces/user_interface.dart';
import 'package:mozin/modules/shared/user/repositories/user_repository.dart';

class UserService implements UserInterface {
  final UserRepository userRepository;

  UserService(this.userRepository);

  @override
  Future setTokensPushNotifications(UserAppModel user, String token) {
    return this.userRepository.setTokensPushNotifications(user, token);
  }

  @override
  void addFavoriteInterest(PlaceModel model) {
    var _userWrapper = getItInstance<UserWrapper>();
    var _user = _userWrapper.getUser;

    _user.favoriteInterests.places.add(model);
    _userWrapper.assignment(_user);
  }

  @override
  Future getFavoriteInterests() async {
    var _favoriteInterests = getItInstance<FavoriteInterestsRepository>();
    var _userWrapper = getItInstance<UserWrapper>();
    var _user = _userWrapper.getUser;

    var response = await _favoriteInterests.getFavoriteInterests();

    response.fold((model) {
      _userWrapper.assignment(_user.copyWith(favoriteInterests: model));
    }, (error) {});
  }

  @override
  void removeFavoriteInterest(int index) {
    var _userWrapper = getItInstance<UserWrapper>();
    var _user = _userWrapper.getUser;

    _user.favoriteInterests.places.removeAt(index);
    _userWrapper.assignment(_user);
  }
}
