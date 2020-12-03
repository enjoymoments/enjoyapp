part of 'place_details_bloc.dart';

abstract class PlaceDetailsEvent extends Equatable {
  const PlaceDetailsEvent();

  @override
  List<Object> get props => [];
}

class ChangeTabEvent extends PlaceDetailsEvent {
  final int newTab;

  ChangeTabEvent(this.newTab);
}
