import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatelessWidget {
  BannerAdWidget({@required this.bannerAd});

  final BannerAd bannerAd;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: AdWidget(ad: bannerAd),
      color: Colors.blueGrey,
    );
  }
}
