import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mozin/features/ads/presentation/bloc/ads_cubit.dart';
import 'package:mozin/modules/config/setup.dart';

class PublisherBannerAdWidget extends StatefulWidget {
  PublisherBannerAdWidget({
    @required this.screenName,
    this.itemCount,
    this.indexRender,
  });

  final String screenName;
  final int itemCount;
  final int indexRender;

  @override
  _PublisherBannerAdWidgetState createState() =>
      _PublisherBannerAdWidgetState();
}

class _PublisherBannerAdWidgetState extends State<PublisherBannerAdWidget> {
  AdsCubit _adsCubit;

  @override
  void initState() {
    _adsCubit = root<AdsCubit>()
      ..loadPublisherBanner(
          screenName: widget.screenName, count: widget.itemCount ?? 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AdSize.largeBanner.width.toDouble(),
      height: AdSize.largeBanner.height.toDouble(),
      child: BlocBuilder<AdsCubit, AdsState>(
        bloc: _adsCubit,
        builder: (context, state) {
          if (state.publisherBanners.length > 0)
            return AdWidget(
                ad: state.publisherBanners[widget.indexRender ?? 0]);

          return SizedBox.shrink();
        },
      ),
      color: Colors.blueGrey,
    );
  }
}
