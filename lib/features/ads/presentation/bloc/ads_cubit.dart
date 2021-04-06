import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mozin/features/ads/domain/repositories/ads_repository.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit({
    @required AdsRepository adsRepository,
  })  : assert(adsRepository != null),
        _adsRepository = adsRepository,
        super(AdsState.initial());

  final AdsRepository _adsRepository;

  void loadBanner({
    @required String screenName,
    int count = 1,
    bool adsReset = false,
  }) async {
    var response = await _adsRepository.getAdsByScreen(
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
