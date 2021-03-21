import 'package:dartz/dartz.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class AdsRepository {
  Future<Either<List<BannerAd>, Exception>> getAdsByScreen(String screenName);
}
