import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class AdsPublisherBannerRepository {
  Future<Either<List<PublisherBannerAd>, Exception>> getAdsByScreen({
    @required String screenName,
    int count = 1,
    bool reset = false,
  });
}
