import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mozin/features/places/domain/enums/place_detail_tabs_enum.dart';
import 'package:mozin/features/places/presentation/blocs/place_details_tab/place_details_tab_event.dart';
import 'package:mozin/features/places/presentation/blocs/place_details_tab/place_details_tab_state.dart';

class PlaceDetailsTabBloc extends Bloc<PlaceDetailsTabEvent, PlaceDetailsTabState> {
  PlaceDetailsTabBloc() : super(PlaceDetailsTabState.initial());

  @override
  Stream<PlaceDetailsTabState> mapEventToState(
    PlaceDetailsTabEvent event,
  ) async* {
    if (event is ChangeTabEvent) {
      yield state.copyWith(currentTab: PlaceDetailTabsEnum.values[event.newTab]);
    }
  }
}
