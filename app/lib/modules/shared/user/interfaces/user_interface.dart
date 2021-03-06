import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';

abstract class UserInterface {
  Future<bool> createUserInFirestore(UserAppModel user);
  Future setTokensPushNotifications(UserAppModel user, String token);
  Future setActionListener();

  void addFavoriteInterest(PlaceModel model);
  void addFavoriteSuggestionInterest(SuggestionsModel model);

  void removeFavoriteInterest({required int indexCategory, required int indexSubCategory, required int indexItem});
  void removeFavoriteSuggestionInterest({required int indexCategory, required int indexSubCategory, required int indexItem});
  void setUserInfo();
}
