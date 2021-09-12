import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/general/models/key_value.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/services/local_storage_service.dart';

class UserWrapper {
  UserWrapper({@required LocalStorageService localStorageService})
      : assert(localStorageService != null),
        _localStorageService = localStorageService;

  final LocalStorageService _localStorageService;
  UserAppModel _user;

  UserAppModel get getUser => _user;
  bool get authenticated => _user != UserAppModel.empty();
  
  static String _internalId = "internal_id";
  static String _shareUrl = "share_url";
  static String _coupleId = "couple_id";

  void assignment(UserAppModel newUser, {bool copyWith = false}) {
    if(copyWith) {
      _user = newUser.copyWith(timelines: _user.timelines, timelineSelected: _user.timelineSelected, favoriteInterests: _user.favoriteInterests);
    } else  {
      _user = newUser;
    }
  }

  void setInternalId(String internalId) {
    _localStorageService.put(
      KeyValue<String, String>(key: _internalId, value: internalId),
    );
  }

  Future<String> getInternalId() {
    return _localStorageService.get<String, String>(_internalId);
  }

  void setShareUrl(String shareUrl) {
    _localStorageService.put(
      KeyValue<String, String>(key: _shareUrl, value: shareUrl),
    );
  }

  Future<String> getShareUrl() {
    return _localStorageService.get<String, String>(_shareUrl);
  }

  void setCoupleId(String coupleId) {
    _localStorageService.put(
      KeyValue<String, String>(key: _coupleId, value: coupleId),
    );
  }

  Future<String> getCoupleId() {
    return _localStorageService.get<String, String>(_coupleId);
  }
}
