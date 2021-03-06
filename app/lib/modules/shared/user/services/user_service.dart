import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/listener_manager/presentation/bloc/listener_manager_cubit.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/data/models/places_category_model.dart';
import 'package:mozin/features/places/data/models/places_sub_category_model.dart';
import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/user/interfaces/user_interface.dart';
import 'package:mozin/modules/shared/user/models/user_info_model.dart';
import 'package:mozin/modules/shared/user/repositories/user_repository.dart';

class UserService implements UserInterface {
  final UserRepository? userRepository;

  UserService(this.userRepository);

  @override
  Future setTokensPushNotifications(UserAppModel user, String? token) {
    return this.userRepository!.setTokensPushNotifications(user, token);
  }

  @override
  void addFavoriteSuggestionInterest(SuggestionsModel model) {
    var _userWrapper = getItInstance<UserWrapper>();
    var _user = _userWrapper.getUser!;

    var _categoryExist = _user.favoriteInterests!.places!
        .indexWhere((element) => element.categoryId == model.categoryId);

    if (_categoryExist != -1) {
      var _subCategoryExist = _user
          .favoriteInterests!.places![_categoryExist].subCategories!
          .indexWhere(
              (element) => element.subCategoryId == model.subCategoryId);
      if (_subCategoryExist != -1) {
        _user.favoriteInterests!.places![_categoryExist].subCategories![_subCategoryExist].suggestedByUsers!.add(model);
      } else {
        _user.favoriteInterests!.places![_categoryExist].subCategories!.add(
          PlacesSubCategoryModel(
            subCategoryId: model.subCategoryId,
            subCategoryName: model.subCategoryName,
            suggestedByUsers: List<SuggestionsModel>.from([model]),
          ),
        );
      }
    } else {
      _user.favoriteInterests!.places!.add(
        PlacesCategoryModel(
          categoryId: model.categoryId,
          categoryName: model.categoryName,
          subCategories: List<PlacesSubCategoryModel>.from(
            [
              PlacesSubCategoryModel(
                subCategoryId: model.subCategoryId,
                subCategoryName: model.subCategoryName,
                suggestedByUsers: List<SuggestionsModel>.from([model]),
              ),
            ],
          ),
        ),
      );
    }

    _userWrapper.assignment(_user);
  }

  @override
  void addFavoriteInterest(PlaceModel? model) {
    var _userWrapper = getItInstance<UserWrapper>();
    var _user = _userWrapper.getUser!;

    var _categoryExist = _user.favoriteInterests!.places!
        .indexWhere((element) => element.categoryId == model!.categoryId);

    if (_categoryExist != -1) {
      var _subCategoryExist = _user
          .favoriteInterests!.places![_categoryExist].subCategories!
          .indexWhere(
              (element) => element.subCategoryId == model!.subCategoryId);
      if (_subCategoryExist != -1) {
        _user.favoriteInterests!.places![_categoryExist].subCategories![_subCategoryExist].places!.add(model);
      } else {
        _user.favoriteInterests!.places![_categoryExist].subCategories!.add(
          PlacesSubCategoryModel(
            subCategoryId: model!.subCategoryId,
            subCategoryName: model.subCategoryName,
            places: List<PlaceModel>.from([model]),
          ),
        );
      }
    } else {
      _user.favoriteInterests!.places!.add(
        PlacesCategoryModel(
          categoryId: model!.categoryId,
          categoryName: model.categoryName,
          subCategories: List<PlacesSubCategoryModel>.from(
            [
              PlacesSubCategoryModel(
                subCategoryId: model.subCategoryId,
                subCategoryName: model.subCategoryName,
                places: List<PlaceModel>.from([model]),
              ),
            ],
          ),
        ),
      );
    }

    _userWrapper.assignment(_user);
  }

  @override
  void removeFavoriteSuggestionInterest({required int indexCategory, required int indexSubCategory, required int indexItem}) {
    var _userWrapper = getItInstance<UserWrapper>();
    var _user = _userWrapper.getUser!;

    _user.favoriteInterests!.places![indexCategory].subCategories![indexSubCategory].suggestedByUsers!.removeAt(indexItem);

    if(_user.favoriteInterests!.places![indexCategory].subCategories![indexSubCategory].suggestedByUsers!.length == 0) {
      _user.favoriteInterests!.places![indexCategory].subCategories!.removeAt(indexSubCategory);
    }

    if(_user.favoriteInterests!.places![indexCategory].subCategories!.length == 0) { 
      _user.favoriteInterests!.places!.removeAt(indexCategory);
    }

    _userWrapper.assignment(_user);
  }

  @override
  void removeFavoriteInterest({required int indexCategory, required int indexSubCategory, required int indexItem}) {
    var _userWrapper = getItInstance<UserWrapper>();
    var _user = _userWrapper.getUser!;

    _user.favoriteInterests!.places![indexCategory].subCategories![indexSubCategory].places!.removeAt(indexItem);

    if(_user.favoriteInterests!.places![indexCategory].subCategories![indexSubCategory].places!.length == 0) {
      _user.favoriteInterests!.places![indexCategory].subCategories!.removeAt(indexSubCategory);
    }

    if(_user.favoriteInterests!.places![indexCategory].subCategories!.length == 0) { 
      _user.favoriteInterests!.places!.removeAt(indexCategory);
    }

    _userWrapper.assignment(_user);
  }

  @override
  Future<Either<UserInfoModel, Exception>> setUserInfo() {
    return userRepository!.setUserInfo();
  }

  @override
  Future setActionListener() {
    root<ListenerManagerCubit>().subscribeActionListener();
    return Future.value(true);
  }

  bool notAuthenticated() {
    if (getItInstance.isRegistered<UserWrapper>() &&
        (getItInstance<UserWrapper>().getUser == UserAppModel.empty())) {
      return true;
    }

    return false;
  }

  @override
  Future<bool> createUserInFirestore(UserAppModel user) {
    return this.userRepository!.createUserInFirestore(user);
  }
}
