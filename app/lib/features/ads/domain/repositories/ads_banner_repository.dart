import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class AdsBannerRepository {
  Future<Either<List<BannerAd>?, Exception>> getAdsByScreen({
    required String screenName,
    int count = 1,
    bool reset = false,
  });
}
