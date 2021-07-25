import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mozin/features/ads/domain/repositories/ads_banner_repository.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit({
    @required AdsBannerRepository adsBannerRepository,
  })  : assert(adsBannerRepository != null),
        _adsBannerRepository = adsBannerRepository,
        super(AdsState.initial());

  final AdsBannerRepository _adsBannerRepository;

  void loadBanner({
    @required String screenName,
    int count = 1,
    bool adsReset = false,
  }) async {
    var response = await _adsBannerRepository.getAdsByScreen(
      screenName: screenName,
      count: count,
      reset: adsReset,
    );

    response.fold((ads) {
      return emit(state.copyWith(isLoading: false, ads: ads));
    }, (exception) {
      return emit(state.copyWith(isLoading: false, isError: true));
    });
  }
}
