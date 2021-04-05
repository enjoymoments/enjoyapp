import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mozin/features/ads/domain/repositories/ads_repository.dart';

class AdsRepositoryImpl implements AdsRepository {
  Map<String, List<BannerAd>> _adsByScreen = {};

  @override
  Future<Either<List<BannerAd>, Exception>> getAdsByScreen({
    @required String screenName,
    int count = 1,
    bool reset = false,
  }) async {
    try {
      if (reset) {
        _resetBannerList(screenName);
      }

      if (_adsByScreen[screenName] == null) {
        var _list = await _generateBannerList(count);
        _adsByScreen[screenName] = _list;
      }

      return Left<List<BannerAd>, Exception>(_adsByScreen[screenName]);
    } on dynamic catch (e) {
      return Right<List<BannerAd>, Exception>(
          (e is Exception) ? e : Exception(e.toString()));
    }
  }

  void _resetBannerList(String screenName) {
    if (_adsByScreen[screenName] != null) {
      for (var banner in _adsByScreen[screenName]) {
        banner.dispose();
      }

      _adsByScreen.remove(screenName);
    }
  }

  Future<List<BannerAd>> _generateBannerList(int count) async {
    var _result = List<BannerAd>();

    for (var i = 0; i < count; i++) {
      var _item = await _generateBanner();
      _result.add(_item);
    }

    return _result;
  }

  Future<BannerAd> _generateBanner({AdSize size}) async {
    var _bannerAd = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      request: AdRequest(),
      size: size ?? AdSize.banner,
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
        onApplicationExit: (Ad ad) => print('$BannerAd onApplicationExit.'),
      ),
    );

    await _bannerAd?.load();

    return _bannerAd;
  }
}
