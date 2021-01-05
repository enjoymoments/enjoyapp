import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';

abstract class UserInterface {
  Future setTokensPushNotifications(UserAppModel user, String token);

  Future getFavoriteInterests();
  void addFavoriteInterest(PlaceModel model);
  void removeFavoriteInterest(int index);
}
