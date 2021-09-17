import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class PublisherBannerAdWidget extends StatefulWidget {
  PublisherBannerAdWidget(this.size);

  final AdSize size;

  @override
  State<StatefulWidget> createState() => PublisherBannerAdState();
}

class PublisherBannerAdState extends State<PublisherBannerAdWidget> {
  BannerAd _bannerAd;
  final Completer<BannerAd> bannerCompleter =
      Completer<BannerAd>();

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: '/6499/example/banner',
      request: AdRequest(nonPersonalizedAds: true),
      size: widget.size,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          bannerCompleter.complete(ad as BannerAd);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          bannerCompleter.completeError(null);
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    Future<void>.delayed(Duration(seconds: 1), () => _bannerAd?.load());
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BannerAd>(
      future: bannerCompleter.future,
      builder:
          (BuildContext context, AsyncSnapshot<BannerAd> snapshot) {
        Widget child;

        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            child = Container();
            break;
          case ConnectionState.done:
            if (snapshot.hasData) {
              child = AdWidget(ad: _bannerAd);
            } else {
              child = Text('Error loading $BannerAd');
            }
        }

        return Container(
          width: _bannerAd.size.width.toDouble(),
          height: _bannerAd.size.height.toDouble(),
          child: child,
          color: Colors.blueGrey,
        );
      },
    );
  }
}