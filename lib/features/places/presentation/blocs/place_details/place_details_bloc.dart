import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/features/places/domain/enums/place_detail_tabs_enum.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'place_details_event.dart';
part 'place_details_state.dart';

class PlaceDetailsBloc extends Bloc<PlaceDetailsEvent, PlaceDetailsState> {
  PlaceDetailsBloc() : super(PlaceDetailsState.initial());

  @override
  Stream<PlaceDetailsState> mapEventToState(
    PlaceDetailsEvent event,
  ) async* {
    if (event is ChangeTabEvent) {
      yield state.copyWith(currentTab: PlaceDetailTabsEnum.values[event.newTab]);
    }
  }
}
