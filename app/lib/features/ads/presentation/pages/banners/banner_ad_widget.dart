import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mozin/features/ads/presentation/bloc/ads_cubit.dart';
import 'package:mozin/modules/config/setup.dart';

class BannerAdWidget extends StatefulWidget {
  BannerAdWidget({
    @required this.screenName,
    this.itemCount,
    this.indexRender,
  });

  final String screenName;

  final int itemCount;
  final int indexRender;

  @override
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  AdsCubit _adsCubit;

  @override
  void initState() {
    _adsCubit = root<AdsCubit>()
      ..loadBanner(screenName: widget.screenName, count: widget.itemCount ?? 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AdSize.banner.width.toDouble(),
      height: AdSize.banner.height.toDouble(),
      child: BlocBuilder<AdsCubit, AdsState>(
        cubit: _adsCubit,
        builder: (context, state) {
          if (state.banners.length > 0)
            return AdWidget(ad: state.banners[widget.indexRender ?? 0]);

          return SizedBox.shrink();
        },
      ),
      color: Colors.blueGrey,
    );
  }
}
