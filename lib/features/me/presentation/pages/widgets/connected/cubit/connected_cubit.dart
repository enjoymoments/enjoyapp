import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mozin/features/ads/domain/repositories/ads_repository.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'connected_state.dart';

class ConnectedCubit extends Cubit<ConnectedState> {
  ConnectedCubit({
    @required AdsRepository adsRepository,
  })  : assert(adsRepository != null),
        _adsRepository = adsRepository,
        super(ConnectedState.initial());

  final AdsRepository _adsRepository;

  void loadAds() async {
    var response =
        await _adsRepository.getAdsByScreen(Routes.me_authenticated_partial);
    response.fold((ads) {
      return emit(state.copyWith(isLoading: false, ads: ads));
    }, (exception) {
      return emit(state.copyWith(isLoading: false, isError: true));
    });
  }
}
