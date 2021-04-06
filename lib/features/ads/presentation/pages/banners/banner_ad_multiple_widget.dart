import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mozin/features/ads/presentation/bloc/ads_cubit.dart';
import 'package:mozin/modules/config/setup.dart';

class BannerAdMultipleWidget extends StatefulWidget {
  BannerAdMultipleWidget({
    @required this.screenName,
    @required this.generate,
    @required this.indexAds,
    @required this.adsReset,
  });

  final String screenName;
  final int generate;
  final int indexAds;
  final bool adsReset;

  @override
  _BannerAdMultipleWidgetState createState() => _BannerAdMultipleWidgetState();
}

class _BannerAdMultipleWidgetState extends State<BannerAdMultipleWidget> {
  AdsCubit _adsCubit;

  @override
  void initState() {
    super.initState();
    _adsCubit = getItInstance<AdsCubit>()
      ..loadBanner(
        screenName: widget.screenName,
        count: widget.generate,
        adsReset: widget.adsReset,
      );
  }

  @override
  void dispose() {
    _adsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AdSize.banner.width.toDouble(),
      height: AdSize.banner.height.toDouble(),
      child: BlocBuilder<AdsCubit, AdsState>(
        cubit: _adsCubit,
        builder: (context, state) {
          if (state.ads.length > 0)
            return AdWidget(ad: state.ads[widget.indexAds]);

          return SizedBox.shrink();
        },
      ),
      color: Colors.blueGrey,
    );
  }
}
