import 'package:dartz/dartz.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mozin/features/ads/domain/repositories/ads_repository.dart';

class AdsRepositoryImpl implements AdsRepository {
  Map<String, List<BannerAd>> _adsByScreen = {};

  @override
  Future<Either<List<BannerAd>, Exception>> getAdsByScreen(
      String screenName) async {
    try {
      if (_adsByScreen[screenName] == null) {
        _adsByScreen[screenName] = [
          await _generateBanner(),
        ];
      }

      return Left<List<BannerAd>, Exception>(_adsByScreen[screenName]);
    } on dynamic catch (e) {
      return Right<List<BannerAd>, Exception>(
          (e is Exception) ? e : Exception(e.toString()));
    }
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
