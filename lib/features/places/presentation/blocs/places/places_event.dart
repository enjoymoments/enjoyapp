part of 'places_bloc.dart';

abstract class PlacesEvent extends Equatable {
  const PlacesEvent();
  @override
  List<Object> get props => <Object>[];
}

class GetCurrentPosition extends PlacesEvent {
  final FilterChoosedModel filterChoosed;

  GetCurrentPosition(this.filterChoosed);
}