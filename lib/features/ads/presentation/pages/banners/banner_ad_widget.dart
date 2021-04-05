import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mozin/features/ads/presentation/bloc/ads_cubit.dart';
import 'package:mozin/modules/config/setup.dart';

class BannerAdWidget extends StatefulWidget {
  BannerAdWidget({@required this.screenName});

  final String screenName;

  @override
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  AdsCubit _adsCubit;

  @override
  void initState() {
    _adsCubit = getItInstance<AdsCubit>()..loadBanner(screenName: widget.screenName);
    super.initState();
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
          if(state.ads.length > 0)
          return AdWidget(ad: state.ads[0]);

          return SizedBox.shrink();
        },
      ),
      color: Colors.blueGrey,
    );
  }
}
