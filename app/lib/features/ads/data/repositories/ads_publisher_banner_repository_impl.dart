import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mozin/features/ads/domain/repositories/ads_publisher_banner_repository.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/logger/enums/logger_type_enum.dart';
import 'package:mozin/modules/shared/logger/models/logger_model.dart';
import 'package:mozin/modules/shared/logger/service/logger_service.dart';

class AdsPublisherBannerRepositoryImpl implements AdsPublisherBannerRepository {
  Map<String, List<PublisherBannerAd>> _adsByScreen = {};

  @override
  Future<Either<List<PublisherBannerAd>, Exception>> getAdsByScreen({
    @required String screenName,
    int count = 1,
    bool reset = false,
  }) async {
    try {
      if (reset) {
        _resetPublisherBannerList(screenName);
      }

      if (_adsByScreen[screenName] == null) {
        var _list = await _generatePublisherBannerList(count);
        _adsByScreen[screenName] = _list;
      }

      return Left<List<PublisherBannerAd>, Exception>(_adsByScreen[screenName]);
    } on dynamic catch (e) {
      _logger(e, null);
      return Right<List<PublisherBannerAd>, Exception>(
          (e is Exception) ? e : Exception(e.toString()));
    }
  }

  void _resetPublisherBannerList(String screenName) {
    if (_adsByScreen[screenName] != null) {
      for (var publisherBanner in _adsByScreen[screenName]) {
        publisherBanner.dispose();
      }

      _adsByScreen.remove(screenName);
    }
  }

  Future<List<PublisherBannerAd>> _generatePublisherBannerList(int count) async {
    var _result = List<PublisherBannerAd>();

    for (var i = 0; i < count; i++) {
      var _item = await _generatePublisherBanner();
      _result.add(_item);
    }

    return _result;
  }

  Future<PublisherBannerAd> _generatePublisherBanner({AdSize size}) async {
    var _publisherBannerAd = PublisherBannerAd(
      adUnitId: '/6499/example/banner',
      request: PublisherAdRequest(nonPersonalizedAds: true),
      sizes: [AdSize.largeBanner],
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('$PublisherBannerAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$PublisherBannerAd failedToLoad: $error');
          _logger(Exception('$error'), null);
        },
        onAdOpened: (Ad ad) => print('$PublisherBannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$PublisherBannerAd onAdClosed.'),
        onApplicationExit: (Ad ad) => print('$PublisherBannerAd onApplicationExit.'),
      ),
    );

    await _publisherBannerAd?.load();

    return _publisherBannerAd;
  }

  // String _getAdUnitId() {
  //   // if (isInDebugMode) {
  //   //   return BannerAd.testAdUnitId;
  //   // }

  //   //TODO:remote config in here ?
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-5039935894572150/4110356931';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-5039935894572150/1152090839';
  //   }

  //   return null;
  // }

  void _logger(dynamic onError, Map<String, dynamic> jsonMap) {
    getItInstance<LoggerService>()..addLogAsync(
      LoggerModel(
        typeError: LoggerTypeEnum.Error,
        // ignore: always_specify_types
        error: {
          'body': onError?.toString(),
        },
        message: onError?.message,
        // ignore: always_specify_types
        extraInfo: {
          'query': jsonMap,
        },
      ),
    );
  }
}
