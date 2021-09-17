import 'package:flutter/material.dart';

enum AdsBannerType { banner, publisherBanner }

class AdsBannerConfig {
  AdsBannerConfig({
    required this.skipAt,
    required this.initialIndex,
    required this.type,
    this.lastIndex,
  });

  final AdsBannerType type;
  final int skipAt;
  final int initialIndex;
  int? lastIndex;
}

abstract class AdsBase {
  Map<AdsBannerType, AdsBannerConfig> ads = {};

  void init();
  List<Widget> buildBanner();
  List<Widget> buildPublisherBanner();

  List<Widget> showAd(AdsBannerType type, int currentIndex, Widget childDefault) {
    switch (type) {
      case AdsBannerType.banner:
        AdsBannerConfig _config = ads[AdsBannerType.banner]!;
        if (_config.initialIndex == currentIndex ||
            _config.lastIndex != null &&
                ((_config.lastIndex == currentIndex) ||
                    ((_config.lastIndex! + _config.skipAt) == currentIndex))) {
          _config.lastIndex = currentIndex;
          return buildBanner();
        }
        break;
      case AdsBannerType.publisherBanner:
        AdsBannerConfig _config = ads[AdsBannerType.publisherBanner]!;

        if (_config.initialIndex == currentIndex ||
            _config.lastIndex != null &&
                ((_config.lastIndex == currentIndex) ||
                    ((_config.lastIndex! + _config.skipAt) == currentIndex))) {
          _config.lastIndex = currentIndex;
          return buildPublisherBanner();
        }
        break;
      default:
        return [childDefault];
    }

    return [childDefault];
  }
}